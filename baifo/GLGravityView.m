#import <QuartzCore/QuartzCore.h>
#import <OpenGLES/EAGLDrawable.h>

#import "GLGravityView.h"
#import "MotionDetection.h"
#import "SoundManager.h"
#import "ModelManager.h"

// CONSTANTS
#define kTeapotScale				3.0

// MACROS
#define DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) / 180.0 * M_PI)
#define PI 3.1415926

// A class extension to declare private methods
@interface GLGravityView (private)

- (BOOL)createFramebuffer;
- (void)destroyFramebuffer;
- (void)setupView;

@end

@implementation GLGravityView

@synthesize animating;
@dynamic animationFrameInterval;
@synthesize accel;

// Implement this to override the default layer class (which is [CALayer class]).
// We do this so that our view will be backed by a layer that is capable of OpenGL ES rendering.
+ (Class) layerClass
{
	return [CAEAGLLayer class];
}


// The GL view is stored in the nib file. When it's unarchived it's sent -initWithCoder:
- (id)initWithCoder:(NSCoder*)coder {
    
    if ((self = [super initWithCoder:coder])) {
		CAEAGLLayer *eaglLayer = (CAEAGLLayer *)self.layer;
	
		eaglLayer.opaque = YES;
		eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:
									[NSNumber numberWithBool:NO], kEAGLDrawablePropertyRetainedBacking, kEAGLColorFormatRGBA8, kEAGLDrawablePropertyColorFormat, nil];
	
		context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
	
		if (!context || ![EAGLContext setCurrentContext:context]) {
			[self release];
			return nil;
		}
	
		animating = FALSE;
		displayLinkSupported = FALSE;
		animationFrameInterval = 3;
		displayLink = nil;
		animationTimer = nil;
	
		// A system version of 3.1 or greater is required to use CADisplayLink. The NSTimer
		// class is used as fallback when it isn't available.
		NSString *reqSysVer = @"3.1";
		NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
		if ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending)
			displayLinkSupported = TRUE;
		
		accel = calloc(3, sizeof(UIAccelerationValue));
		mm = [[CMMotionManager alloc]init];
        lm = [[CLLocationManager alloc]init];
        
        [mm startDeviceMotionUpdates];
        [lm startUpdatingHeading];
		[self setupView];
	}
	
	return self;
}

GLuint spriteTexture;

	
-(void)setupView
{
	const GLfloat			lightAmbient[] = {0.2, 0.2, 0.2, 1.0};
	const GLfloat			lightDiffuse[] = {1.0, 0.6, 0.0, 1.0};
	const GLfloat			matAmbient[] = {0.6, 0.6, 0.6, 1.0};
	const GLfloat			matDiffuse[] = {1.0, 1.0, 1.0, 1.0};	
	const GLfloat			matSpecular[] = {1.0, 1.0, 1.0, 1.0};
	const GLfloat			lightPosition[] = {0.0, 0.0, 5.0, 0.0};
	const GLfloat			lightShininess = 100.0,
							zNear = 0.1,
							zFar = 1000.0,
							fieldOfView = 60.0;
	GLfloat					size;
	
	//Configure OpenGL lighting
	glEnable(GL_LIGHTING);
	glEnable(GL_LIGHT0);
	glMaterialfv(GL_FRONT_AND_BACK, GL_AMBIENT, matAmbient);
	glMaterialfv(GL_FRONT_AND_BACK, GL_DIFFUSE, matDiffuse);
	glMaterialfv(GL_FRONT_AND_BACK, GL_SPECULAR, matSpecular);
	glMaterialf(GL_FRONT_AND_BACK, GL_SHININESS, lightShininess);
	glLightfv(GL_LIGHT0, GL_AMBIENT, lightAmbient);
	glLightfv(GL_LIGHT0, GL_DIFFUSE, lightDiffuse);
	glLightfv(GL_LIGHT0, GL_POSITION, lightPosition); 			
	glShadeModel(GL_SMOOTH);
	glEnable(GL_DEPTH_TEST);
		
	//Configure OpenGL arrays
	glEnableClientState(GL_VERTEX_ARRAY);
	glEnableClientState(GL_NORMAL_ARRAY);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	//glVertexPointer(3 ,GL_FLOAT, 0, fo_vertices);
	//glNormalPointer(GL_FLOAT, 0, fo_normals);
	glEnable(GL_NORMALIZE);
    glEnable(GL_TEXTURE_2D);
    // Set a blending function to use
    glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
    // Enable blending
    glEnable(GL_BLEND);
    
	//Set the OpenGL projection matrix
	glMatrixMode(GL_PROJECTION);
	size = zNear * tanf(DEGREES_TO_RADIANS(fieldOfView) / 2.0);
	CGRect rect = self.bounds;
	glFrustumf(-size, size, -size / (rect.size.width / rect.size.height), size / (rect.size.width / rect.size.height), zNear, zFar);
	glViewport(0, 0, rect.size.width, rect.size.height);
	
	//Make the OpenGL modelview matrix the default
	glMatrixMode(GL_MODELVIEW);
    
    
    CGImageRef spriteImage;
	CGContextRef spriteContext;
	GLubyte *spriteData;
    size_t	width, height;
    // Sets up matrices and transforms for OpenGL ES
	//glViewport(0, 0, backingWidth, backingHeight);
	//glMatrixMode(GL_PROJECTION);
	//glLoadIdentity();
	//glOrthof(-1.0f, 1.0f, -1.5f, 1.5f, -1.0f, 1.0f);
	//glMatrixMode(GL_MODELVIEW);
	
	// Clears the view with black
	//glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
	
    // Creates a Core Graphics image from an image file
	spriteImage = [UIImage imageNamed:@"background.jpg"].CGImage;
    width = CGImageGetWidth(spriteImage);
	height = CGImageGetHeight(spriteImage);
    if(spriteImage) {
		// Allocated memory needed for the bitmap context
		spriteData = (GLubyte *) calloc(width * height * 4, sizeof(GLubyte));
		// Uses the bitmap creation function provided by the Core Graphics framework.
		spriteContext = CGBitmapContextCreate(spriteData, width, height, 8, width * 4, CGImageGetColorSpace(spriteImage), kCGImageAlphaPremultipliedLast);
		// After you create the context, you can draw the sprite image to the context.
		CGContextDrawImage(spriteContext, CGRectMake(0.0, 0.0, (CGFloat)width, (CGFloat)height), spriteImage);
		// You don't need the context at this point, so you need to release it to avoid memory leaks.
		CGContextRelease(spriteContext);
        
		// Use OpenGL ES to generate a name for the texture.
		glGenTextures(1, &spriteTexture);
		// Bind the texture name.
		glBindTexture(GL_TEXTURE_2D, spriteTexture);
		// Set the texture parameters to use a minifying filter and a linear filer (weighted average)
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
		// Specify a 2D texture image, providing the a pointer to the image data in memory
		glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, spriteData);
		// Release the image data
		free(spriteData);
		
		// Enable use of the texture
		glEnable(GL_TEXTURE_2D);
	}
}


float t = 0;
int flash = 0;
const GLfloat xBG = 1.16;
const GLfloat yBG = 1.68;

const GLfloat squareVertices[] = {
    -xBG, -yBG, -2.0f,
    xBG, -yBG, -2.0f,
    -xBG, yBG, -2.0f,
    xBG, yBG, -2.0f,
};
const GLfloat squareNormals[] = {
    0.0f, 0.0f, +1.0f,
    0.0f, 0.0f, +1.0f,
    0.0f, 0.0f, +1.0f,
    0.0f, 0.0f, +1.0f,
};
const GLfloat squareTextures[] = {
    0.0f, 1.0f,
    1.0f, 1.0f,
    0.0f, 0.0f,
    1.0f, 0.0f,
};

// Updates the OpenGL view
- (void)drawView
{

    double x,y,z;
    double r;
    if (mm.deviceMotionActive)
    {
        // on real device
        CMAttitude* attitude = mm.deviceMotion.attitude;
        x = attitude.pitch;
        y = attitude.roll;
        z = attitude.yaw;
        if (lm.headingAvailable)
        {
            CLHeading* heading = lm.heading;
            r = heading.trueHeading;
            NSLog(@"%f", r);
        }
        
    }
    else
    {
        // in simulator or on real device but motion is disabled
        x = sin(t);
        y = 2.78*cos(t/2.78);
        z = t;
        r = 0;
    }
    t+=0.02;
    
    float colorR = 0, colorG = 0, colorB = 0;
    
    MDProcess(x,y,z);

    int motion = MDCurrentMotion();
    if (motion!=0)
    {
        colorR = 1;
        colorG = 0;
        colorB = 0;    
        if (MDMotionCompleted())
        {
            Sound* sound = [SoundManager getSound:soundIndexCurrent];
            if(nil!=sound)
            {
                [sound play];
            }
            flash = 6;
        }
    }
    
    if(flash)
    {
        if(flash%2==1)
        {
            colorR = 1;
            colorG = 1;
            colorB = 1;
        }
        flash--;
    }
    
    // Make sure that you are drawing to the current context
	[EAGLContext setCurrentContext:context];
    
	glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
	glClearColor(colorR, colorG, colorB, 1.0f);
	glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    
    //draw background
    glLoadIdentity();
    
	glScalef(kTeapotScale, kTeapotScale, kTeapotScale);
    // Here's where the data is now
    glVertexPointer(3, GL_FLOAT,0, squareVertices);
    glNormalPointer(GL_FLOAT, 0, squareNormals);
    glTexCoordPointer(2, GL_FLOAT, 0, squareTextures);
    glBindTexture(GL_TEXTURE_2D, spriteTexture);
    glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
    
	//Setup model view matrix
	glLoadIdentity();
    
	glTranslatef(0.0, -0.0, -3.0);
	glScalef(kTeapotScale, kTeapotScale, kTeapotScale);
		
	
		//Finally load matrix
		//glMultMatrixf((GLfloat*)matrix);
    glRotatef(y*180/PI,0,-1,0);
    glRotatef(x*180/PI,-1,0,0);
    glRotatef(z*180/PI,0,0,-1);
    glTranslatef(0,0,0.1);
    //glRotatef(-90,-1,0,0);
    Model*currentModel = [ModelManager getModel:modelIndexCurrent];
    if(nil!=currentModel)
    {
        // Here's where the data is now
        glVertexPointer(3, GL_FLOAT,0, currentModel->vVerts);
        glNormalPointer(GL_FLOAT, 0, currentModel->vNorms);
        glTexCoordPointer(2, GL_FLOAT, 0, currentModel->vText);
        glBindTexture(GL_TEXTURE_2D, 2);
        // Draw them
        glDrawElements(GL_TRIANGLES, currentModel->cIndexes, GL_UNSIGNED_SHORT, currentModel->uiIndexes);
    }
	glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
	[context presentRenderbuffer:GL_RENDERBUFFER_OES];
}

// If our view is resized, we'll be asked to layout subviews.
// This is the perfect opportunity to also update the framebuffer so that it is
// the same size as our display area.
-(void)layoutSubviews
{
	[EAGLContext setCurrentContext:context];
	[self destroyFramebuffer];
	[self createFramebuffer];
	[self drawView];
}

- (BOOL)createFramebuffer
{
	// Generate IDs for a framebuffer object and a color renderbuffer
	glGenFramebuffersOES(1, &viewFramebuffer);
	glGenRenderbuffersOES(1, &viewRenderbuffer);
	
	glBindFramebufferOES(GL_FRAMEBUFFER_OES, viewFramebuffer);
	glBindRenderbufferOES(GL_RENDERBUFFER_OES, viewRenderbuffer);
	// This call associates the storage for the current render buffer with the EAGLDrawable (our CAEAGLLayer)
	// allowing us to draw into a buffer that will later be rendered to screen wherever the layer is (which corresponds with our view).
	[context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:(id<EAGLDrawable>)self.layer];
	glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, viewRenderbuffer);
	
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);
	
	// For this sample, we also need a depth buffer, so we'll create and attach one via another renderbuffer.
	glGenRenderbuffersOES(1, &depthRenderbuffer);
	glBindRenderbufferOES(GL_RENDERBUFFER_OES, depthRenderbuffer);
	glRenderbufferStorageOES(GL_RENDERBUFFER_OES, GL_DEPTH_COMPONENT16_OES, backingWidth, backingHeight);
	glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_DEPTH_ATTACHMENT_OES, GL_RENDERBUFFER_OES, depthRenderbuffer);

	if(glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES)
	{
		NSLog(@"failed to make complete framebuffer object %x", glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES));
		return NO;
	}
	
	return YES;
}

// Clean up any buffers we have allocated.
- (void)destroyFramebuffer
{
	glDeleteFramebuffersOES(1, &viewFramebuffer);
	viewFramebuffer = 0;
	glDeleteRenderbuffersOES(1, &viewRenderbuffer);
	viewRenderbuffer = 0;
	
	if(depthRenderbuffer)
	{
		glDeleteRenderbuffersOES(1, &depthRenderbuffer);
		depthRenderbuffer = 0;
	}
}

- (NSInteger) animationFrameInterval
{
	return animationFrameInterval;
}

- (void) setAnimationFrameInterval:(NSInteger)frameInterval
{
	// Frame interval defines how many display frames must pass between each time the
	// display link fires. The display link will only fire 30 times a second when the
	// frame internal is two on a display that refreshes 60 times a second. The default
	// frame interval setting of one will fire 60 times a second when the display refreshes
	// at 60 times a second. A frame interval setting of less than one results in undefined
	// behavior.
	if (frameInterval >= 1)
	{
		animationFrameInterval = frameInterval;
		
		if (animating)
		{
			[self stopAnimation];
			[self startAnimation];
		}
	}
}

- (void) startAnimation
{
	if (!animating)
	{
		if (displayLinkSupported)
		{
			// CADisplayLink is API new to iPhone SDK 3.1. Compiling against earlier versions will result in a warning, but can be dismissed
			// if the system version runtime check for CADisplayLink exists in -initWithCoder:. The runtime check ensures this code will
			// not be called in system versions earlier than 3.1.
			
			displayLink = [NSClassFromString(@"CADisplayLink") displayLinkWithTarget:self selector:@selector(drawView)];
			[displayLink setFrameInterval:animationFrameInterval];
			[displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
		}
		else
			animationTimer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)((1.0 / 60.0) * animationFrameInterval) target:self selector:@selector(drawView) userInfo:nil repeats:TRUE];
		MDInit();
		animating = TRUE;
	}
}

- (void)stopAnimation
{
	if (animating)
	{
		if (displayLinkSupported)
		{
			[displayLink invalidate];
			displayLink = nil;
		}
		else
		{
			[animationTimer invalidate];
			animationTimer = nil;
		}
		
		animating = FALSE;
	}
}

-(void)switchModel:(int)index
{
    modelIndexCurrent = index;
}

-(void)switchSound:(int)index
{
    soundIndexCurrent = index;
}

- (void)dealloc
{
    [mm stopDeviceMotionUpdates];
	free(accel);
	
	if([EAGLContext currentContext] == context)
	{
		[EAGLContext setCurrentContext:nil];
	}
	
	[context release];
	[super dealloc];
}

@end
