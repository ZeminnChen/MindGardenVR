#define NUM_TEX_COORD_INTERPOLATORS 1
#define NUM_MATERIAL_TEXCOORDS_VERTEX 1
#define NUM_CUSTOM_VERTEX_INTERPOLATORS 0

struct Input
{
	//float3 Normal;
	float2 uv_MainTex : TEXCOORD0;
	float2 uv2_Material_Texture2D_0 : TEXCOORD1;
	float4 color : COLOR;
	float4 tangent;
	//float4 normal;
	float3 viewDir;
	float4 screenPos;
	float3 worldPos;
	//float3 worldNormal;
	float3 normal2;
};
struct SurfaceOutputStandard
{
	float3 Albedo;		// base (diffuse or specular) color
	float3 Normal;		// tangent space normal, if written
	half3 Emission;
	half Metallic;		// 0=non-metal, 1=metal
	// Smoothness is the user facing name, it should be perceptual smoothness but user should not have to deal with it.
	// Everywhere in the code you meet smoothness it is perceptual smoothness
	half Smoothness;	// 0=rough, 1=smooth
	half Occlusion;		// occlusion (default 1)
	float Alpha;		// alpha for transparencies
};

//#define HDRP 1
#define URP 1
#define UE5
//#define HAS_CUSTOMIZED_UVS 1
#define MATERIAL_TANGENTSPACENORMAL 1
//struct Material
//{
	//samplers start
SAMPLER( SamplerState_Linear_Repeat );
SAMPLER( SamplerState_Linear_Clamp );
TEXTURE2D(       Material_Texture2D_0 );
SAMPLER(  samplerMaterial_Texture2D_0 );
float4 Material_Texture2D_0_TexelSize;
float4 Material_Texture2D_0_ST;
TEXTURE2D(       Material_Texture2D_1 );
SAMPLER(  samplerMaterial_Texture2D_1 );
float4 Material_Texture2D_1_TexelSize;
float4 Material_Texture2D_1_ST;
TEXTURE2D(       Material_Texture2D_2 );
SAMPLER(  samplerMaterial_Texture2D_2 );
float4 Material_Texture2D_2_TexelSize;
float4 Material_Texture2D_2_ST;
TEXTURE2D(       Material_Texture2D_3 );
SAMPLER(  samplerMaterial_Texture2D_3 );
float4 Material_Texture2D_3_TexelSize;
float4 Material_Texture2D_3_ST;
TEXTURE2D(       Material_Texture2D_4 );
SAMPLER(  samplerMaterial_Texture2D_4 );
float4 Material_Texture2D_4_TexelSize;
float4 Material_Texture2D_4_ST;
TEXTURE2D(       Material_Texture2D_5 );
SAMPLER(  samplerMaterial_Texture2D_5 );
float4 Material_Texture2D_5_TexelSize;
float4 Material_Texture2D_5_ST;
TEXTURE2D(       Material_Texture2D_6 );
SAMPLER(  samplerMaterial_Texture2D_6 );
float4 Material_Texture2D_6_TexelSize;
float4 Material_Texture2D_6_ST;

//};

#ifdef UE5
	#define UE_LWC_RENDER_TILE_SIZE			2097152.0
	#define UE_LWC_RENDER_TILE_SIZE_SQRT	1448.15466
	#define UE_LWC_RENDER_TILE_SIZE_RSQRT	0.000690533954
	#define UE_LWC_RENDER_TILE_SIZE_RCP		4.76837158e-07
	#define UE_LWC_RENDER_TILE_SIZE_FMOD_PI		0.673652053
	#define UE_LWC_RENDER_TILE_SIZE_FMOD_2PI	0.673652053
	#define INVARIANT(X) X
	#define PI 					(3.1415926535897932)

	#include "LargeWorldCoordinates.hlsl"
#endif
struct MaterialStruct
{
	float4 PreshaderBuffer[12];
	float4 ScalarExpressions[1];
	float VTPackedPageTableUniform[2];
	float VTPackedUniform[1];
};
static SamplerState View_MaterialTextureBilinearWrapedSampler;
static SamplerState View_MaterialTextureBilinearClampedSampler;
struct ViewStruct
{
	float GameTime;
	float RealTime;
	float DeltaTime;
	float PrevFrameGameTime;
	float PrevFrameRealTime;
	float MaterialTextureMipBias;	
	float4 PrimitiveSceneData[ 40 ];
	float4 TemporalAAParams;
	float2 ViewRectMin;
	float4 ViewSizeAndInvSize;
	float MaterialTextureDerivativeMultiply;
	uint StateFrameIndexMod8;
	float FrameNumber;
	float2 FieldOfViewWideAngles;
	float4 RuntimeVirtualTextureMipLevel;
	float PreExposure;
	float4 BufferBilinearUVMinMax;
};
struct ResolvedViewStruct
{
	#ifdef UE5
		FLWCVector3 WorldCameraOrigin;
		FLWCVector3 PrevWorldCameraOrigin;
		FLWCVector3 PreViewTranslation;
		FLWCVector3 WorldViewOrigin;
	#else
		float3 WorldCameraOrigin;
		float3 PrevWorldCameraOrigin;
		float3 PreViewTranslation;
		float3 WorldViewOrigin;
	#endif
	float4 ScreenPositionScaleBias;
	float4x4 TranslatedWorldToView;
	float4x4 TranslatedWorldToCameraView;
	float4x4 TranslatedWorldToClip;
	float4x4 ViewToTranslatedWorld;
	float4x4 PrevViewToTranslatedWorld;
	float4x4 CameraViewToTranslatedWorld;
	float4 BufferBilinearUVMinMax;
	float4 XRPassthroughCameraUVs[ 2 ];
};
struct PrimitiveStruct
{
	float4x4 WorldToLocal;
	float4x4 LocalToWorld;
};

static ViewStruct View;
static ResolvedViewStruct ResolvedView;
static PrimitiveStruct Primitive;
uniform float4 View_BufferSizeAndInvSize;
uniform float4 LocalObjectBoundsMin;
uniform float4 LocalObjectBoundsMax;
static SamplerState Material_Wrap_WorldGroupSettings;
static SamplerState Material_Clamp_WorldGroupSettings;

#include "UnrealCommon.cginc"

static MaterialStruct Material;
void InitializeExpressions()
{
	Material.PreshaderBuffer[0] = float4(1.000000,0.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[1] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[2] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[3] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[4] = float4(1.000000,0.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[5] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[6] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[7] = float4(1.000000,0.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[8] = float4(1.000000,1.000000,0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[9] = float4(0.000000,1.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[10] = float4(0.000000,0.300000,0.000200,0.000000);//(Unknown)
	Material.PreshaderBuffer[11] = float4(1.000000,1.000000,0.000000,0.000000);//(Unknown)
}struct MaterialCollection0Type
{
	float4 Vectors[2];
};
//MPC_WindBasic
MaterialCollection0Type MaterialCollection0;
void Initialize_MaterialCollection0()
{
	MaterialCollection0.Vectors[0] = float4(4.000000,0.000000,0.000000,1.000000);//Wind_Intensity,,,
	MaterialCollection0.Vectors[1] = float4(0.000000,1.000000,0.000000,0.000000);//Wind_Direction
}
float3 GetMaterialWorldPositionOffset(FMaterialVertexParameters Parameters)
{
	MaterialFloat Local52 = (View.GameTime * Material.PreshaderBuffer[9].z);
	MaterialFloat Local53 = (Local52 * -0.50000000);
	MaterialFloat3 Local54 = (normalize(MaterialFloat4(0.00000000,1.00000000,0.00000000,1.00000000).rgba.rgb) * ((MaterialFloat3)Local53));
	FWSVector3 Local55 = GetWorldPosition(Parameters);
	FWSVector3 Local56 = MakeWSVector(WSGetX(DERIV_BASE_VALUE(Local55)), WSGetY(DERIV_BASE_VALUE(Local55)), WSGetZ(DERIV_BASE_VALUE(Local55)));
	FWSVector3 Local57 = WSDivideByPow2(DERIV_BASE_VALUE(Local56), ((MaterialFloat3)1024.00000000));
	FWSVector3 Local58 = WSAdd(Local54, DERIV_BASE_VALUE(Local57));
	FWSVector3 Local59 = WSAdd(DERIV_BASE_VALUE(Local58), ((MaterialFloat3)0.50000000));
	MaterialFloat3 Local60 = WSFracDemote(DERIV_BASE_VALUE(Local59));
	MaterialFloat3 Local61 = (DERIV_BASE_VALUE(Local60) * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local62 = (DERIV_BASE_VALUE(Local61) + ((MaterialFloat3)-1.00000000));
	MaterialFloat3 Local63 = abs(DERIV_BASE_VALUE(Local62));
	MaterialFloat3 Local64 = (DERIV_BASE_VALUE(Local63) * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local65 = (((MaterialFloat3)3.00000000) - DERIV_BASE_VALUE(Local64));
	MaterialFloat3 Local66 = (DERIV_BASE_VALUE(Local65) * DERIV_BASE_VALUE(Local63));
	MaterialFloat3 Local67 = (DERIV_BASE_VALUE(Local66) * DERIV_BASE_VALUE(Local63));
	MaterialFloat Local68 = dot(normalize(MaterialFloat4(0.00000000,1.00000000,0.00000000,1.00000000).rgba.rgb),DERIV_BASE_VALUE(Local67));
	FWSVector3 Local69 = WSDivide(DERIV_BASE_VALUE(Local56), ((MaterialFloat3)200.00000000));
	FWSVector3 Local70 = WSAdd(((MaterialFloat3)Local53), DERIV_BASE_VALUE(Local69));
	FWSVector3 Local71 = WSAdd(DERIV_BASE_VALUE(Local70), ((MaterialFloat3)0.50000000));
	MaterialFloat3 Local72 = WSFracDemote(DERIV_BASE_VALUE(Local71));
	MaterialFloat3 Local73 = (DERIV_BASE_VALUE(Local72) * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local74 = (DERIV_BASE_VALUE(Local73) + ((MaterialFloat3)-1.00000000));
	MaterialFloat3 Local75 = abs(DERIV_BASE_VALUE(Local74));
	MaterialFloat3 Local76 = (DERIV_BASE_VALUE(Local75) * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local77 = (((MaterialFloat3)3.00000000) - DERIV_BASE_VALUE(Local76));
	MaterialFloat3 Local78 = (DERIV_BASE_VALUE(Local77) * DERIV_BASE_VALUE(Local75));
	MaterialFloat3 Local79 = (DERIV_BASE_VALUE(Local78) * DERIV_BASE_VALUE(Local75));
	MaterialFloat3 Local80 = (DERIV_BASE_VALUE(Local79) - ((MaterialFloat3)0.00000000));
	MaterialFloat Local81 = length(DERIV_BASE_VALUE(Local80));
	MaterialFloat Local82 = (DERIV_BASE_VALUE(Local68) + DERIV_BASE_VALUE(Local81));
	MaterialFloat Local83 = (DERIV_BASE_VALUE(Local82) * 6.28318548);
	MaterialFloat4 Local84 = MaterialFloat4(cross(normalize(MaterialFloat4(0.00000000,1.00000000,0.00000000,1.00000000).rgba.rgb),MaterialFloat3(0.00000000,0.00000000,1.00000000).rgb),DERIV_BASE_VALUE(Local83));
	MaterialFloat4 Local85 = MaterialCollection0.Vectors[0];
	MaterialFloat4 Local86 = MaterialCollection0.Vectors[1];
	MaterialFloat4 Local87 = normalize(Local86.rgba);
	MaterialFloat4 Local88 = (((MaterialFloat4)Local85.r) * DERIV_BASE_VALUE(Local87));
	MaterialFloat2 Local89 = DERIV_BASE_VALUE(Local88).xy;
	MaterialFloat Local90 = DERIV_BASE_VALUE(Local89).r;
	MaterialFloat Local91 = DERIV_BASE_VALUE(Local89).g;
	MaterialFloat2 Local92 = MaterialFloat2(DERIV_BASE_VALUE(Local90),DERIV_BASE_VALUE(Local91));
	MaterialFloat3 Local93 = MaterialFloat3(DERIV_BASE_VALUE(Local92),Local85.r);
	MaterialFloat3 Local94 = (DERIV_BASE_VALUE(Local93) + MaterialFloat3(0.00000000,0.00000000,-10.00000000).rgb);
	MaterialFloat3 Local95 = RotateAboutAxis(DERIV_BASE_VALUE(Local84),DERIV_BASE_VALUE(Local94),DERIV_BASE_VALUE(Local93));
	MaterialFloat3 Local96 = (Local95 * ((MaterialFloat3)Material.PreshaderBuffer[9].w));
	MaterialFloat Local97 = (Material.PreshaderBuffer[10].x * Local85.r);
	MaterialFloat3 Local98 = (Local96 * ((MaterialFloat3)Local97));
	MaterialFloat3 Local99 = (Local98 + DERIV_BASE_VALUE(Local93));
	MaterialFloat4 Local100 = Parameters.VertexColor;
	MaterialFloat Local101 = DERIV_BASE_VALUE(Local100).r;
	MaterialFloat3 Local102 = (Local99 * ((MaterialFloat3)DERIV_BASE_VALUE(Local101)));
	FWSVector3 Local103 = WSMultiply(MaterialFloat3(0.00000000,0.00000000,0.00000000).rgb, GetInstanceToWorld(Parameters));
	FWSScalar Local104 = WSDot(Local103, WSPromote(MaterialFloat3(0.00000000,1.00000000,0.00000000).rgb));
	FWSScalar Local105 = WSDivideByPow2(Local104, 4.00000000);
	FWSScalar Local106 = WSAdd(Local105, View.GameTime);
	FWSScalar Local107 = WSMultiply(Local106, Material.PreshaderBuffer[10].y);
	FWSScalar Local108 = WSAdd(Local107, DERIV_BASE_VALUE(Local101));
	FWSScalar Local109 = WSMultiply(DERIV_BASE_VALUE(Local108), 6.28318548);
	MaterialFloat Local110 = WSSin(DERIV_BASE_VALUE(Local109));
	MaterialFloat Local111 = (DERIV_BASE_VALUE(Local110) + 2.00000000);
	MaterialFloat Local112 = (DERIV_BASE_VALUE(Local111) / 4.00000000);
	MaterialFloat Local113 = (Local85.r * Material.PreshaderBuffer[10].z);
	MaterialFloat Local114 = (DERIV_BASE_VALUE(Local112) * Local113);
	MaterialFloat Local115 = (DERIV_BASE_VALUE(Local114) * 6.28318548);
	MaterialFloat3 Local116 = DERIV_BASE_VALUE(Local87).xyz;
	MaterialFloat4 Local117 = MaterialFloat4(DERIV_BASE_VALUE(Local116),DERIV_BASE_VALUE(Local115));
	MaterialFloat3 Local118 = RotateAboutAxis(DERIV_BASE_VALUE(Local117),Local103,DERIV_BASE_VALUE(Local56));
	FWSScalar Local119 = WSGetZ(DERIV_BASE_VALUE(Local56));
	FWSScalar Local120 = WSSubtract(DERIV_BASE_VALUE(Local119), WSGetZ(Local103));
	MaterialFloat Local121 = WSDemote(DERIV_BASE_VALUE(Local120));
	MaterialFloat Local122 = (DERIV_BASE_VALUE(Local121) / 100.00000000);
	MaterialFloat3 Local123 = (Local118 * ((MaterialFloat3)DERIV_BASE_VALUE(Local122)));
	MaterialFloat3 Local124 = (Local102 + Local123);
	return Local124;;
}
void CalcPixelMaterialInputs(in out FMaterialPixelParameters Parameters, in out FPixelMaterialInputs PixelMaterialInputs)
{
	//WorldAligned texturing & others use normals & stuff that think Z is up
	Parameters.TangentToWorld[0] = Parameters.TangentToWorld[0].xzy;
	Parameters.TangentToWorld[1] = Parameters.TangentToWorld[1].xzy;
	Parameters.TangentToWorld[2] = Parameters.TangentToWorld[2].xzy;

	float3 WorldNormalCopy = Parameters.WorldNormal;

	// Initial calculations (required for Normal)
	MaterialFloat2 Local0 = Parameters.TexCoords[0].xy;
	MaterialFloat Local1 = DERIV_BASE_VALUE(Local0).r;
	MaterialFloat Local2 = (Material.PreshaderBuffer[0].x * DERIV_BASE_VALUE(Local1));
	MaterialFloat Local3 = (DERIV_BASE_VALUE(Local2) + Material.PreshaderBuffer[0].y);
	MaterialFloat Local4 = DERIV_BASE_VALUE(Local0).g;
	MaterialFloat Local5 = (DERIV_BASE_VALUE(Local4) * Material.PreshaderBuffer[0].z);
	MaterialFloat Local6 = (Material.PreshaderBuffer[0].w + DERIV_BASE_VALUE(Local5));
	MaterialFloat2 Local7 = MaterialFloat2(DERIV_BASE_VALUE(Local3),DERIV_BASE_VALUE(Local6));
	MaterialFloat Local8 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local7), 1);
	MaterialFloat4 Local9 = UnpackNormalMap(Texture2DSampleBias(Material_Texture2D_0,samplerMaterial_Texture2D_0,DERIV_BASE_VALUE(Local7),View.MaterialTextureMipBias));
	MaterialFloat Local10 = MaterialStoreTexSample(Parameters, Local9, 1);
	MaterialFloat3 Local11 = (Material.PreshaderBuffer[1].xyz * Local9.rgb);
	MaterialFloat3 Local12 = (Local11 * Material.PreshaderBuffer[2].xyz);
	MaterialFloat3 Local13 = lerp(Local12,MaterialFloat3(0.00000000,0.00000000,1.00000000).rgb,Material.PreshaderBuffer[2].w);

	// The Normal is a special case as it might have its own expressions and also be used to calculate other inputs, so perform the assignment here
	PixelMaterialInputs.Normal = Local13;


#if TEMPLATE_USES_SUBSTRATE
	Parameters.SubstratePixelFootprint = SubstrateGetPixelFootprint(Parameters.WorldPosition_CamRelative, GetRoughnessFromNormalCurvature(Parameters));
	Parameters.SharedLocalBases = SubstrateInitialiseSharedLocalBases();
	Parameters.SubstrateTree = GetInitialisedSubstrateTree();
#if SUBSTRATE_USE_FULLYSIMPLIFIED_MATERIAL == 1
	Parameters.SharedLocalBasesFullySimplified = SubstrateInitialiseSharedLocalBases();
	Parameters.SubstrateTreeFullySimplified = GetInitialisedSubstrateTree();
#endif
#endif

	// Note that here MaterialNormal can be in world space or tangent space
	float3 MaterialNormal = GetMaterialNormal(Parameters, PixelMaterialInputs);

#if MATERIAL_TANGENTSPACENORMAL

#if FEATURE_LEVEL >= FEATURE_LEVEL_SM4
	// Mobile will rely on only the final normalize for performance
	MaterialNormal = normalize(MaterialNormal);
#endif

	// normalizing after the tangent space to world space conversion improves quality with sheared bases (UV layout to WS causes shrearing)
	// use full precision normalize to avoid overflows
	Parameters.WorldNormal = TransformTangentNormalToWorld(Parameters.TangentToWorld, MaterialNormal);

#else //MATERIAL_TANGENTSPACENORMAL

	Parameters.WorldNormal = normalize(MaterialNormal);

#endif //MATERIAL_TANGENTSPACENORMAL

#if MATERIAL_TANGENTSPACENORMAL || TWO_SIDED_WORLD_SPACE_SINGLELAYERWATER_NORMAL
	// flip the normal for backfaces being rendered with a two-sided material
	Parameters.WorldNormal *= Parameters.TwoSidedSign;
#endif

	Parameters.ReflectionVector = ReflectionAboutCustomWorldNormal(Parameters, Parameters.WorldNormal, false);

#if !PARTICLE_SPRITE_FACTORY
	Parameters.Particle.MotionBlurFade = 1.0f;
#endif // !PARTICLE_SPRITE_FACTORY

	// Now the rest of the inputs
	MaterialFloat3 Local14 = lerp(MaterialFloat3(0.00000000,0.00000000,0.00000000),Material.PreshaderBuffer[3].yzw,Material.PreshaderBuffer[3].x);
	MaterialFloat Local15 = (Material.PreshaderBuffer[4].x * DERIV_BASE_VALUE(Local1));
	MaterialFloat Local16 = (DERIV_BASE_VALUE(Local15) + Material.PreshaderBuffer[4].y);
	MaterialFloat Local17 = (DERIV_BASE_VALUE(Local4) * Material.PreshaderBuffer[4].z);
	MaterialFloat Local18 = (Material.PreshaderBuffer[4].w + DERIV_BASE_VALUE(Local17));
	MaterialFloat2 Local19 = MaterialFloat2(DERIV_BASE_VALUE(Local16),DERIV_BASE_VALUE(Local18));
	MaterialFloat Local20 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local19), 0);
	MaterialFloat4 Local21 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_1,samplerMaterial_Texture2D_1,DERIV_BASE_VALUE(Local19),View.MaterialTextureMipBias));
	MaterialFloat Local22 = MaterialStoreTexSample(Parameters, Local21, 0);
	MaterialFloat3 Local23 = (Local21.rgb * ((MaterialFloat3)Material.PreshaderBuffer[5].x));
	MaterialFloat Local24 = saturate(Parameters.TwoSidedSign);
	MaterialFloat3 Local25 = lerp(Local23,Local21.rgb,DERIV_BASE_VALUE(Local24));
	MaterialFloat3 Local26 = (Local25 * ((MaterialFloat3)Material.PreshaderBuffer[5].y));
	MaterialFloat3 Local27 = lerp(((MaterialFloat3)1.00000000),Local26,Material.PreshaderBuffer[5].z);
	MaterialFloat3 Local28 = (Local27 * Material.PreshaderBuffer[6].xyz);
	MaterialFloat Local29 = dot(Local28,MaterialFloat3(0.30000001,0.58999997,0.11000000));
	MaterialFloat3 Local30 = lerp(Local28,((MaterialFloat3)Local29),Material.PreshaderBuffer[6].w);
	MaterialFloat Local31 = (Material.PreshaderBuffer[7].x * DERIV_BASE_VALUE(Local1));
	MaterialFloat Local32 = (DERIV_BASE_VALUE(Local31) + Material.PreshaderBuffer[7].y);
	MaterialFloat Local33 = (DERIV_BASE_VALUE(Local4) * Material.PreshaderBuffer[7].z);
	MaterialFloat Local34 = (Material.PreshaderBuffer[7].w + DERIV_BASE_VALUE(Local33));
	MaterialFloat2 Local35 = MaterialFloat2(DERIV_BASE_VALUE(Local32),DERIV_BASE_VALUE(Local34));
	MaterialFloat Local36 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local35), 3);
	MaterialFloat4 Local37 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_2,samplerMaterial_Texture2D_2,DERIV_BASE_VALUE(Local35),View.MaterialTextureMipBias));
	MaterialFloat Local38 = MaterialStoreTexSample(Parameters, Local37, 3);
	MaterialFloat Local39 = (Local37.rgb.x * Material.PreshaderBuffer[8].x);
	MaterialFloat Local40 = (Material.PreshaderBuffer[8].y * DERIV_BASE_VALUE(Local1));
	MaterialFloat Local41 = (DERIV_BASE_VALUE(Local40) + Material.PreshaderBuffer[8].z);
	MaterialFloat Local42 = (DERIV_BASE_VALUE(Local4) * Material.PreshaderBuffer[8].w);
	MaterialFloat Local43 = (Material.PreshaderBuffer[9].x + DERIV_BASE_VALUE(Local42));
	MaterialFloat2 Local44 = MaterialFloat2(DERIV_BASE_VALUE(Local41),DERIV_BASE_VALUE(Local43));
	MaterialFloat Local45 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local44), 2);
	MaterialFloat4 Local46 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_3,samplerMaterial_Texture2D_3,DERIV_BASE_VALUE(Local44),View.MaterialTextureMipBias));
	MaterialFloat Local47 = MaterialStoreTexSample(Parameters, Local46, 2);
	MaterialFloat Local48 = (Local46.rgb.x * Material.PreshaderBuffer[9].y);
	MaterialFloat Local49 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local0), 0);
	MaterialFloat4 Local50 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_4,samplerMaterial_Texture2D_4,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias));
	MaterialFloat Local51 = MaterialStoreTexSample(Parameters, Local50, 0);
	MaterialFloat4 Local125 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_5,samplerMaterial_Texture2D_5,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias));
	MaterialFloat Local126 = MaterialStoreTexSample(Parameters, Local125, 0);
	MaterialFloat4 Local127 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_6,samplerMaterial_Texture2D_6,DERIV_BASE_VALUE(Local0),View.MaterialTextureMipBias));
	MaterialFloat Local128 = MaterialStoreTexSample(Parameters, Local127, 0);
	MaterialFloat Local129 = (Local127.rgb.x * Material.PreshaderBuffer[11].x);
	MaterialFloat Local130 = lerp(1.00000000,Local129,Material.PreshaderBuffer[11].y);

	PixelMaterialInputs.EmissiveColor = Local14;
	PixelMaterialInputs.Opacity = 1.00000000;
	PixelMaterialInputs.OpacityMask = Local50.rgb;
	PixelMaterialInputs.BaseColor = Local30;
	PixelMaterialInputs.Metallic = Local39;
	PixelMaterialInputs.Specular = 0.50000000;
	PixelMaterialInputs.Roughness = Local48;
	PixelMaterialInputs.Anisotropy = 0.00000000;
	PixelMaterialInputs.Normal = Local13;
	PixelMaterialInputs.Tangent = MaterialFloat3(1.00000000,0.00000000,0.00000000);
	PixelMaterialInputs.Subsurface = MaterialFloat4(Local125.rgb,Material.PreshaderBuffer[10].w);
	PixelMaterialInputs.AmbientOcclusion = Local130;
	PixelMaterialInputs.Refraction = 0;
	PixelMaterialInputs.PixelDepthOffset = 0.00000000;
	PixelMaterialInputs.ShadingModel = 6;
	PixelMaterialInputs.FrontMaterial = GetInitialisedSubstrateData();
	PixelMaterialInputs.SurfaceThickness = 0.01000000;
	PixelMaterialInputs.Displacement = 0.50000000;


#if MATERIAL_USES_ANISOTROPY
	Parameters.WorldTangent = CalculateAnisotropyTangent(Parameters, PixelMaterialInputs);
#else
	Parameters.WorldTangent = 0;
#endif
}

#define UnityObjectToWorldDir TransformObjectToWorld

void SetupCommonData( int Parameters_PrimitiveId )
{
	View_MaterialTextureBilinearWrapedSampler = SamplerState_Linear_Repeat;
	View_MaterialTextureBilinearClampedSampler = SamplerState_Linear_Clamp;

	Material_Wrap_WorldGroupSettings = SamplerState_Linear_Repeat;
	Material_Clamp_WorldGroupSettings = SamplerState_Linear_Clamp;

	View.GameTime = View.RealTime = _Time.y;// _Time is (t/20, t, t*2, t*3)
	View.PrevFrameGameTime = View.GameTime - unity_DeltaTime.x;//(dt, 1/dt, smoothDt, 1/smoothDt)
	View.PrevFrameRealTime = View.RealTime;
	View.DeltaTime = unity_DeltaTime.x;
	View.MaterialTextureMipBias = 0.0;
	View.TemporalAAParams = float4( 0, 0, 0, 0 );
	View.ViewRectMin = float2( 0, 0 );
	View.ViewSizeAndInvSize = View_BufferSizeAndInvSize;
	View.MaterialTextureDerivativeMultiply = 1.0f;
	View.StateFrameIndexMod8 = 0;
	View.FrameNumber = (int)_Time.y;
	View.FieldOfViewWideAngles = float2( PI * 0.42f, PI * 0.42f );//75degrees, default unity
	View.RuntimeVirtualTextureMipLevel = float4( 0, 0, 0, 0 );
	View.PreExposure = 0;
	View.BufferBilinearUVMinMax = float4(
		View_BufferSizeAndInvSize.z * ( 0 + 0.5 ),//EffectiveViewRect.Min.X
		View_BufferSizeAndInvSize.w * ( 0 + 0.5 ),//EffectiveViewRect.Min.Y
		View_BufferSizeAndInvSize.z * ( View_BufferSizeAndInvSize.x - 0.5 ),//EffectiveViewRect.Max.X
		View_BufferSizeAndInvSize.w * ( View_BufferSizeAndInvSize.y - 0.5 ) );//EffectiveViewRect.Max.Y

	for( int i2 = 0; i2 < 40; i2++ )
		View.PrimitiveSceneData[ i2 ] = float4( 0, 0, 0, 0 );

	float4x4 LocalToWorld = transpose( UNITY_MATRIX_M );
    LocalToWorld[3] = float4(ToUnrealPos(LocalToWorld[3]), LocalToWorld[3].w);
	float4x4 WorldToLocal = transpose( UNITY_MATRIX_I_M );
	float4x4 ViewMatrix = transpose( UNITY_MATRIX_V );
	float4x4 InverseViewMatrix = transpose( UNITY_MATRIX_I_V );
	float4x4 ViewProjectionMatrix = transpose( UNITY_MATRIX_VP );
	uint PrimitiveBaseOffset = Parameters_PrimitiveId * PRIMITIVE_SCENE_DATA_STRIDE;
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 0 ] = LocalToWorld[ 0 ];//LocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 1 ] = LocalToWorld[ 1 ];//LocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 2 ] = LocalToWorld[ 2 ];//LocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 3 ] = LocalToWorld[ 3 ];//LocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 5 ] = float4( ToUnrealPos( SHADERGRAPH_OBJECT_POSITION ), 100.0 );//ObjectWorldPosition
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 6 ] = WorldToLocal[ 0 ];//WorldToLocal
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 7 ] = WorldToLocal[ 1 ];//WorldToLocal
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 8 ] = WorldToLocal[ 2 ];//WorldToLocal
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 9 ] = WorldToLocal[ 3 ];//WorldToLocal
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 10 ] = LocalToWorld[ 0 ];//PreviousLocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 11 ] = LocalToWorld[ 1 ];//PreviousLocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 12 ] = LocalToWorld[ 2 ];//PreviousLocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 13 ] = LocalToWorld[ 3 ];//PreviousLocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 18 ] = float4( ToUnrealPos( SHADERGRAPH_OBJECT_POSITION ), 0 );//ActorWorldPosition
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 19 ] = LocalObjectBoundsMax - LocalObjectBoundsMin;//ObjectBounds
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 21 ] = mul( LocalToWorld, float3( 1, 0, 0 ) );
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 23 ] = LocalObjectBoundsMin;//LocalObjectBoundsMin 
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 24 ] = LocalObjectBoundsMax;//LocalObjectBoundsMax

#ifdef UE5
	ResolvedView.WorldCameraOrigin = LWCPromote( ToUnrealPos( _WorldSpaceCameraPos.xyz ) );
	ResolvedView.PreViewTranslation = LWCPromote( float3( 0, 0, 0 ) );
	ResolvedView.WorldViewOrigin = LWCPromote( float3( 0, 0, 0 ) );
#else
	ResolvedView.WorldCameraOrigin = ToUnrealPos( _WorldSpaceCameraPos.xyz );
	ResolvedView.PreViewTranslation = float3( 0, 0, 0 );
	ResolvedView.WorldViewOrigin = float3( 0, 0, 0 );
#endif
	ResolvedView.PrevWorldCameraOrigin = ResolvedView.WorldCameraOrigin;
	ResolvedView.ScreenPositionScaleBias = float4( 1, 1, 0, 0 );
	ResolvedView.TranslatedWorldToView		 = ViewMatrix;
	ResolvedView.TranslatedWorldToCameraView = ViewMatrix;
	ResolvedView.TranslatedWorldToClip		 = ViewProjectionMatrix;
	ResolvedView.ViewToTranslatedWorld		 = InverseViewMatrix;
	ResolvedView.PrevViewToTranslatedWorld = ResolvedView.ViewToTranslatedWorld;
	ResolvedView.CameraViewToTranslatedWorld = InverseViewMatrix;
	ResolvedView.BufferBilinearUVMinMax = View.BufferBilinearUVMinMax;
	Primitive.WorldToLocal = WorldToLocal;
	Primitive.LocalToWorld = LocalToWorld;
}
#define VS_USES_UNREAL_SPACE 1
float3 PrepareAndGetWPO( float4 VertexColor, float3 UnrealWorldPos, float3 UnrealNormal, float4 InTangent,
						 float4 UV0, float4 UV1 )
{
	InitializeExpressions();
	Initialize_MaterialCollection0();

	FMaterialVertexParameters Parameters = (FMaterialVertexParameters)0;

	float3 InWorldNormal = UnrealNormal;
	float4 tangentWorld = InTangent;
	tangentWorld.xyz = normalize( tangentWorld.xyz );
	//float3x3 tangentToWorld = CreateTangentToWorldPerVertex( InWorldNormal, tangentWorld.xyz, tangentWorld.w );
	Parameters.TangentToWorld = float3x3( normalize( cross( InWorldNormal, tangentWorld.xyz ) * tangentWorld.w ), tangentWorld.xyz, InWorldNormal );

	
	#ifdef VS_USES_UNREAL_SPACE
		UnrealWorldPos = ToUnrealPos( UnrealWorldPos );
	#endif
	Parameters.WorldPosition = UnrealWorldPos;
	#ifdef VS_USES_UNREAL_SPACE
		Parameters.TangentToWorld[ 0 ] = Parameters.TangentToWorld[ 0 ].xzy;
		Parameters.TangentToWorld[ 1 ] = Parameters.TangentToWorld[ 1 ].xzy;
		Parameters.TangentToWorld[ 2 ] = Parameters.TangentToWorld[ 2 ].xzy;//WorldAligned texturing uses normals that think Z is up
	#endif

	Parameters.VertexColor = VertexColor;

#if NUM_MATERIAL_TEXCOORDS_VERTEX > 0			
	Parameters.TexCoords[ 0 ] = float2( UV0.x, UV0.y );
#endif
#if NUM_MATERIAL_TEXCOORDS_VERTEX > 1
	Parameters.TexCoords[ 1 ] = float2( UV1.x, UV1.y );
#endif
#if NUM_MATERIAL_TEXCOORDS_VERTEX > 2
	for( int i = 2; i < NUM_TEX_COORD_INTERPOLATORS; i++ )
	{
		Parameters.TexCoords[ i ] = float2( UV0.x, UV0.y );
	}
#endif

	Parameters.PrimitiveId = 0;

	SetupCommonData( Parameters.PrimitiveId );

#ifdef UE5
	Parameters.PrevFrameLocalToWorld = MakeLWCMatrix( float3( 0, 0, 0 ), Primitive.LocalToWorld );
#else
	Parameters.PrevFrameLocalToWorld = Primitive.LocalToWorld;
#endif
	
	float3 Offset = float3( 0, 0, 0 );
	Offset = GetMaterialWorldPositionOffset( Parameters );
	#ifdef VS_USES_UNREAL_SPACE
		//Convert from unreal units to unity
		Offset /= float3( 100, 100, 100 );
		Offset = Offset.xzy;
	#endif
	return Offset;
}

void SurfaceReplacement( Input In, out SurfaceOutputStandard o )
{
	InitializeExpressions();
	Initialize_MaterialCollection0();


	float3 Z3 = float3( 0, 0, 0 );
	float4 Z4 = float4( 0, 0, 0, 0 );

	float3 UnrealWorldPos = float3( In.worldPos.x, In.worldPos.y, In.worldPos.z );

	float3 UnrealNormal = In.normal2;	

	FMaterialPixelParameters Parameters = (FMaterialPixelParameters)0;
#if NUM_TEX_COORD_INTERPOLATORS > 0			
	Parameters.TexCoords[ 0 ] = float2( In.uv_MainTex.x, 1.0 - In.uv_MainTex.y );
#endif
#if NUM_TEX_COORD_INTERPOLATORS > 1
	Parameters.TexCoords[ 1 ] = float2( In.uv2_Material_Texture2D_0.x, 1.0 - In.uv2_Material_Texture2D_0.y );
#endif
#if NUM_TEX_COORD_INTERPOLATORS > 2
	for( int i = 2; i < NUM_TEX_COORD_INTERPOLATORS; i++ )
	{
		Parameters.TexCoords[ i ] = float2( In.uv_MainTex.x, 1.0 - In.uv_MainTex.y );
	}
#endif
	Parameters.VertexColor = In.color;
	Parameters.WorldNormal = UnrealNormal;
	Parameters.ReflectionVector = half3( 0, 0, 1 );
	Parameters.CameraVector = normalize( _WorldSpaceCameraPos.xyz - UnrealWorldPos.xyz );
	//Parameters.CameraVector = mul( ( float3x3 )unity_CameraToWorld, float3( 0, 0, 1 ) ) * -1;
	Parameters.LightVector = half3( 0, 0, 0 );
	//float4 screenpos = In.screenPos;
	//screenpos /= screenpos.w;
	Parameters.SvPosition = In.screenPos;
	Parameters.ScreenPosition = Parameters.SvPosition;

	Parameters.UnMirrored = 1;

	Parameters.TwoSidedSign = 1;


	float3 InWorldNormal = UnrealNormal;	
	float4 tangentWorld = In.tangent;
	tangentWorld.xyz = normalize( tangentWorld.xyz );
	//float3x3 tangentToWorld = CreateTangentToWorldPerVertex( InWorldNormal, tangentWorld.xyz, tangentWorld.w );
	Parameters.TangentToWorld = float3x3( normalize( cross( InWorldNormal, tangentWorld.xyz ) * tangentWorld.w ), tangentWorld.xyz, InWorldNormal );

	//WorldAlignedTexturing in UE relies on the fact that coords there are 100x larger, prepare values for that
	//but watch out for any computation that might get skewed as a side effect
	UnrealWorldPos = ToUnrealPos( UnrealWorldPos );
	
	Parameters.AbsoluteWorldPosition = UnrealWorldPos;
	Parameters.WorldPosition_CamRelative = UnrealWorldPos;
	Parameters.WorldPosition_NoOffsets = UnrealWorldPos;

	Parameters.WorldPosition_NoOffsets_CamRelative = Parameters.WorldPosition_CamRelative;
	Parameters.LightingPositionOffset = float3( 0, 0, 0 );

	Parameters.AOMaterialMask = 0;

	Parameters.Particle.RelativeTime = 0;
	Parameters.Particle.MotionBlurFade;
	Parameters.Particle.Random = 0;
	Parameters.Particle.Velocity = half4( 1, 1, 1, 1 );
	Parameters.Particle.Color = half4( 1, 1, 1, 1 );
	Parameters.Particle.TranslatedWorldPositionAndSize = float4( UnrealWorldPos, 0 );
	Parameters.Particle.MacroUV = half4( 0, 0, 1, 1 );
	Parameters.Particle.DynamicParameter = half4( 0, 0, 0, 0 );
	Parameters.Particle.LocalToWorld = float4x4( Z4, Z4, Z4, Z4 );
	Parameters.Particle.Size = float2( 1, 1 );
	Parameters.Particle.SubUVCoords[ 0 ] = Parameters.Particle.SubUVCoords[ 1 ] = float2( 0, 0 );
	Parameters.Particle.SubUVLerp = 0.0;
	Parameters.TexCoordScalesParams = float2( 0, 0 );
	Parameters.PrimitiveId = 0;
	Parameters.VirtualTextureFeedback = 0;

	FPixelMaterialInputs PixelMaterialInputs = (FPixelMaterialInputs)0;
	PixelMaterialInputs.Normal = float3( 0, 0, 1 );
	PixelMaterialInputs.ShadingModel = 0;
	PixelMaterialInputs.FrontMaterial = 0;

	SetupCommonData( Parameters.PrimitiveId );
	//CustomizedUVs
	#if NUM_TEX_COORD_INTERPOLATORS > 0 && HAS_CUSTOMIZED_UVS
		float2 OutTexCoords[ NUM_TEX_COORD_INTERPOLATORS ];
		//Prevent uninitialized reads
		for( int i = 0; i < NUM_TEX_COORD_INTERPOLATORS; i++ )
		{
			OutTexCoords[ i ] = float2( 0, 0 );
		}
		GetMaterialCustomizedUVs( Parameters, OutTexCoords );
		for( int i = 0; i < NUM_TEX_COORD_INTERPOLATORS; i++ )
		{
			Parameters.TexCoords[ i ] = OutTexCoords[ i ];
		}
	#endif
	//<-
	CalcPixelMaterialInputs( Parameters, PixelMaterialInputs );

	#define HAS_WORLDSPACE_NORMAL 0
	#if HAS_WORLDSPACE_NORMAL
		PixelMaterialInputs.Normal = mul( PixelMaterialInputs.Normal, (MaterialFloat3x3)( transpose( Parameters.TangentToWorld ) ) );
	#endif

	o.Albedo = PixelMaterialInputs.BaseColor.rgb;
	o.Alpha = PixelMaterialInputs.Opacity;
	if( PixelMaterialInputs.OpacityMask < 0.333 ) discard;

	o.Metallic = PixelMaterialInputs.Metallic;
	o.Smoothness = 1.0 - PixelMaterialInputs.Roughness;
	o.Normal = normalize( PixelMaterialInputs.Normal );
	o.Emission = PixelMaterialInputs.EmissiveColor.rgb;
	o.Occlusion = PixelMaterialInputs.AmbientOcclusion;

	//BLEND_ADDITIVE o.Alpha = ( o.Emission.r + o.Emission.g + o.Emission.b ) / 3;
}