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
TEXTURE2D(       Material_Texture2D_7 );
SAMPLER(  samplerMaterial_Texture2D_7 );
float4 Material_Texture2D_7_TexelSize;
float4 Material_Texture2D_7_ST;
TEXTURE2D(       Material_Texture2D_8 );
SAMPLER(  samplerMaterial_Texture2D_8 );
float4 Material_Texture2D_8_TexelSize;
float4 Material_Texture2D_8_ST;
TEXTURE2D(       Material_Texture2D_9 );
SAMPLER(  samplerMaterial_Texture2D_9 );
float4 Material_Texture2D_9_TexelSize;
float4 Material_Texture2D_9_ST;
TEXTURE2D(       Material_Texture2D_10 );
SAMPLER(  samplerMaterial_Texture2D_10 );
float4 Material_Texture2D_10_TexelSize;
float4 Material_Texture2D_10_ST;
TEXTURE2D(       Material_Texture2D_11 );
SAMPLER(  samplerMaterial_Texture2D_11 );
float4 Material_Texture2D_11_TexelSize;
float4 Material_Texture2D_11_ST;
TEXTURE2D(       Material_Texture2D_12 );
SAMPLER(  samplerMaterial_Texture2D_12 );
float4 Material_Texture2D_12_TexelSize;
float4 Material_Texture2D_12_ST;
TEXTURE2D(       Material_Texture2D_13 );
SAMPLER(  samplerMaterial_Texture2D_13 );
float4 Material_Texture2D_13_TexelSize;
float4 Material_Texture2D_13_ST;

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
	Material.PreshaderBuffer[0] = float4(1.000000,2041.000000,2041.000000,0.150000);//(Unknown)
	Material.PreshaderBuffer[1] = float4(0.100000,0.001000,2.000000,0.300000);//(Unknown)
	Material.PreshaderBuffer[2] = float4(0.200000,0.030000,-2000.000000,0.000050);//(Unknown)
	Material.PreshaderBuffer[3] = float4(0.001000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[4] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[5] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[6] = float4(1.000000,1.000000,1.000000,0.500000);//(Unknown)
	Material.PreshaderBuffer[7] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[8] = float4(1.000000,1.000000,1.000000,0.500000);//(Unknown)
	Material.PreshaderBuffer[9] = float4(0.520680,0.454276,0.537923,0.000000);//(Unknown)
	Material.PreshaderBuffer[10] = float4(0.479320,0.545724,0.462077,0.500000);//(Unknown)
	Material.PreshaderBuffer[11] = float4(1.000000,2.000000,0.000000,0.000000);//(Unknown)
}
MaterialFloat3 CustomExpression3(FMaterialPixelParameters Parameters,MaterialFloat GroundWeight,MaterialFloat GrassWeight,MaterialFloat ForestWeight,MaterialFloat Ground,MaterialFloat Grass,MaterialFloat Forest)
{
float  lerpres;
float  Local0;



float  AllWeightsAndHeights = GroundWeight.r + GrassWeight.r + ForestWeight.r + 0.0;
float  Divider = ( 1.0 / AllWeightsAndHeights );
float3  Layer0Contribution = float3(Divider,Divider,Divider) * float3(GroundWeight,GroundWeight,GroundWeight) * Ground;
float3  Layer1Contribution = float3(Divider,Divider,Divider) * float3(GrassWeight,GrassWeight,GrassWeight) * Grass;
float3  Layer3Contribution = float3(Divider,Divider,Divider) * float3(ForestWeight,ForestWeight,ForestWeight) * Forest;
float3  Result = Layer0Contribution + Layer1Contribution + Layer3Contribution + float3(0,0,0);
return Result;
}

MaterialFloat3 CustomExpression2(FMaterialPixelParameters Parameters,MaterialFloat GroundWeight,MaterialFloat GrassWeight,MaterialFloat ForestWeight,MaterialFloat Ground,MaterialFloat Grass,MaterialFloat Forest)
{
float  lerpres;
float  Local0;



float  AllWeightsAndHeights = GroundWeight.r + GrassWeight.r + ForestWeight.r + 0.0;
float  Divider = ( 1.0 / AllWeightsAndHeights );
float3  Layer0Contribution = float3(Divider,Divider,Divider) * float3(GroundWeight,GroundWeight,GroundWeight) * Ground;
float3  Layer1Contribution = float3(Divider,Divider,Divider) * float3(GrassWeight,GrassWeight,GrassWeight) * Grass;
float3  Layer3Contribution = float3(Divider,Divider,Divider) * float3(ForestWeight,ForestWeight,ForestWeight) * Forest;
float3  Result = Layer0Contribution + Layer1Contribution + Layer3Contribution + float3(0,0,0);
return Result;
}

MaterialFloat3 CustomExpression1(FMaterialPixelParameters Parameters,MaterialFloat GroundWeight,MaterialFloat GrassWeight,MaterialFloat ForestWeight,MaterialFloat3 Ground,MaterialFloat3 Grass,MaterialFloat3 Forest)
{
float  lerpres;
float  Local0;



float  AllWeightsAndHeights = GroundWeight.r + GrassWeight.r + ForestWeight.r + 0.0;
float  Divider = ( 1.0 / AllWeightsAndHeights );
float3  Layer0Contribution = float3(Divider,Divider,Divider) * float3(GroundWeight,GroundWeight,GroundWeight) * Ground;
float3  Layer1Contribution = float3(Divider,Divider,Divider) * float3(GrassWeight,GrassWeight,GrassWeight) * Grass;
float3  Layer3Contribution = float3(Divider,Divider,Divider) * float3(ForestWeight,ForestWeight,ForestWeight) * Forest;
float3  Result = Layer0Contribution + Layer1Contribution + Layer3Contribution + float3(0,0,0);
return Result;
}

MaterialFloat3 CustomExpression0(FMaterialPixelParameters Parameters,MaterialFloat GroundWeight,MaterialFloat GrassWeight,MaterialFloat ForestWeight,MaterialFloat3 Ground,MaterialFloat3 Grass,MaterialFloat3 Forest)
{
float  lerpres;
float  Local0;



float  AllWeightsAndHeights = GroundWeight.r + GrassWeight.r + ForestWeight.r + 0.0;
float  Divider = ( 1.0 / AllWeightsAndHeights );
float3  Layer0Contribution = float3(Divider,Divider,Divider) * float3(GroundWeight,GroundWeight,GroundWeight) * Ground;
float3  Layer1Contribution = float3(Divider,Divider,Divider) * float3(GrassWeight,GrassWeight,GrassWeight) * Grass;
float3  Layer3Contribution = float3(Divider,Divider,Divider) * float3(ForestWeight,ForestWeight,ForestWeight) * Forest;
float3  Result = Layer0Contribution + Layer1Contribution + Layer3Contribution + float3(0,0,0);
return Result;
}
float3 GetMaterialWorldPositionOffset(FMaterialVertexParameters Parameters)
{
	return MaterialFloat3(0.00000000,0.00000000,0.00000000);;
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
	MaterialFloat2 Local1 = (DERIV_BASE_VALUE(Local0) * ((MaterialFloat2)Material.PreshaderBuffer[0].x));
	MaterialFloat Local2 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local1), 15);
	MaterialFloat4 Local3 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_0,GetMaterialSharedSampler(samplerMaterial_Texture2D_0,View_MaterialTextureBilinearClampedSampler),DERIV_BASE_VALUE(Local1)));
	MaterialFloat Local4 = MaterialStoreTexSample(Parameters, Local3, 15);
	MaterialFloat4 Local5 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_1,GetMaterialSharedSampler(samplerMaterial_Texture2D_1,View_MaterialTextureBilinearClampedSampler),DERIV_BASE_VALUE(Local1)));
	MaterialFloat Local6 = MaterialStoreTexSample(Parameters, Local5, 15);
	MaterialFloat4 Local7 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(samplerMaterial_Texture2D_2,View_MaterialTextureBilinearClampedSampler),DERIV_BASE_VALUE(Local1)));
	MaterialFloat Local8 = MaterialStoreTexSample(Parameters, Local7, 15);
	MaterialFloat2 Local9 = (DERIV_BASE_VALUE(Local0) + MaterialFloat4(0.00097991,0.00097991,0.00097991,0.00097991).rgba.rg);
	MaterialFloat2 Local10 = (DERIV_BASE_VALUE(Local9) * Material.PreshaderBuffer[0].yz);
	MaterialFloat2 Local11 = (DERIV_BASE_VALUE(Local10) * ((MaterialFloat2)Material.PreshaderBuffer[0].w));
	MaterialFloat Local12 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local11), 4);
	MaterialFloat4 Local13 = UnpackNormalMap(Texture2DSample(Material_Texture2D_3,GetMaterialSharedSampler(samplerMaterial_Texture2D_3,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local11)));
	MaterialFloat Local14 = MaterialStoreTexSample(Parameters, Local13, 4);
	MaterialFloat2 Local15 = (DERIV_BASE_VALUE(Local10) * ((MaterialFloat2)Material.PreshaderBuffer[1].x));
	MaterialFloat Local16 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local15), 6);
	MaterialFloat4 Local17 = UnpackNormalMap(Texture2DSampleBias(Material_Texture2D_4,samplerMaterial_Texture2D_4,DERIV_BASE_VALUE(Local15),View.MaterialTextureMipBias));
	MaterialFloat Local18 = MaterialStoreTexSample(Parameters, Local17, 6);
	MaterialFloat2 Local19 = (DERIV_BASE_VALUE(Local10) * ((MaterialFloat2)Material.PreshaderBuffer[1].y));
	MaterialFloat Local20 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local19), 14);
	MaterialFloat4 Local21 = Texture2DSampleBias(Material_Texture2D_5,samplerMaterial_Texture2D_5,DERIV_BASE_VALUE(Local19),View.MaterialTextureMipBias);
	MaterialFloat Local22 = MaterialStoreTexSample(Parameters, Local21, 14);
	MaterialFloat3 Local23 = (Local21.rgb * ((MaterialFloat3)Material.PreshaderBuffer[1].z));
	MaterialFloat3 Local24 = PositiveClampedPow(Local23,((MaterialFloat3)Material.PreshaderBuffer[1].w));
	MaterialFloat3 Local25 = saturate(Local24);
	MaterialFloat3 Local26 = lerp(Local13.rgb,Local17.rgb,Local25);
	MaterialFloat2 Local27 = (DERIV_BASE_VALUE(Local10) * ((MaterialFloat2)Material.PreshaderBuffer[2].x));
	MaterialFloat Local28 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local27), 12);
	MaterialFloat4 Local29 = UnpackNormalMap(Texture2DSampleBias(Material_Texture2D_6,samplerMaterial_Texture2D_6,DERIV_BASE_VALUE(Local27),View.MaterialTextureMipBias));
	MaterialFloat Local30 = MaterialStoreTexSample(Parameters, Local29, 12);
	MaterialFloat2 Local31 = (DERIV_BASE_VALUE(Local10) * ((MaterialFloat2)Material.PreshaderBuffer[2].y));
	MaterialFloat Local32 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local31), 12);
	MaterialFloat4 Local33 = UnpackNormalMap(Texture2DSampleBias(Material_Texture2D_6,samplerMaterial_Texture2D_6,DERIV_BASE_VALUE(Local31),View.MaterialTextureMipBias));
	MaterialFloat Local34 = MaterialStoreTexSample(Parameters, Local33, 12);
	MaterialFloat Local35 = GetPixelDepth(Parameters);
	MaterialFloat Local36 = DERIV_BASE_VALUE(Local35).r;
	MaterialFloat Local37 = (DERIV_BASE_VALUE(Local36) + Material.PreshaderBuffer[2].z);
	MaterialFloat Local38 = (DERIV_BASE_VALUE(Local37) * Material.PreshaderBuffer[2].w);
	MaterialFloat Local39 = saturate(DERIV_BASE_VALUE(Local38));
	MaterialFloat3 Local40 = lerp(Local29.rgb,Local33.rgb,DERIV_BASE_VALUE(Local39));
	MaterialFloat2 Local41 = (DERIV_BASE_VALUE(Local10) * ((MaterialFloat2)Material.PreshaderBuffer[3].x));
	MaterialFloat Local42 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local41), 14);
	MaterialFloat4 Local43 = Texture2DSampleBias(Material_Texture2D_5,samplerMaterial_Texture2D_5,DERIV_BASE_VALUE(Local41),View.MaterialTextureMipBias);
	MaterialFloat Local44 = MaterialStoreTexSample(Parameters, Local43, 14);
	MaterialFloat3 Local45 = (Local43.rgb * ((MaterialFloat3)Material.PreshaderBuffer[1].z));
	MaterialFloat3 Local46 = PositiveClampedPow(Local45,((MaterialFloat3)Material.PreshaderBuffer[1].w));
	MaterialFloat3 Local47 = saturate(Local46);
	MaterialFloat3 Local48 = lerp(Local17.rgb,Local40,Local47);
	MaterialFloat3 Local49 = CustomExpression0(Parameters,Local3.r,Local5.r,Local7.r,Local13.rgb.rgb,Local26.rgb,Local48.rgb);

	// The Normal is a special case as it might have its own expressions and also be used to calculate other inputs, so perform the assignment here
	PixelMaterialInputs.Normal = Local49.rgb;


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
	MaterialFloat3 Local50 = lerp(MaterialFloat3(0.00000000,0.00000000,0.00000000),Material.PreshaderBuffer[4].xyz,Material.PreshaderBuffer[3].y);
	MaterialFloat2 Local51 = (DERIV_BASE_VALUE(Local10) * ((MaterialFloat2)0.21340001));
	MaterialFloat Local52 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local51), 13);
	MaterialFloat4 Local53 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_7,samplerMaterial_Texture2D_7,DERIV_BASE_VALUE(Local51),View.MaterialTextureMipBias));
	MaterialFloat Local54 = MaterialStoreTexSample(Parameters, Local53, 13);
	MaterialFloat Local55 = (Local53.r + 0.50000000);
	MaterialFloat2 Local56 = (DERIV_BASE_VALUE(Local10) * ((MaterialFloat2)0.05341000));
	MaterialFloat Local57 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local56), 13);
	MaterialFloat4 Local58 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_7,samplerMaterial_Texture2D_7,DERIV_BASE_VALUE(Local56),View.MaterialTextureMipBias));
	MaterialFloat Local59 = MaterialStoreTexSample(Parameters, Local58, 13);
	MaterialFloat Local60 = (Local58.r + 0.50000000);
	MaterialFloat2 Local61 = (DERIV_BASE_VALUE(Local10) * ((MaterialFloat2)0.00200000));
	MaterialFloat Local62 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local61), 13);
	MaterialFloat4 Local63 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_7,samplerMaterial_Texture2D_7,DERIV_BASE_VALUE(Local61),View.MaterialTextureMipBias));
	MaterialFloat Local64 = MaterialStoreTexSample(Parameters, Local63, 13);
	MaterialFloat Local65 = (Local63.r + 0.50000000);
	MaterialFloat Local66 = (Local60 * Local65);
	MaterialFloat Local67 = (Local55 * Local66);
	MaterialFloat3 Local68 = lerp(MaterialFloat3(0.50000000,0.50000000,0.50000000).rgb,((MaterialFloat3)1.00000000),Local67);
	MaterialFloat Local69 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local11), 3);
	MaterialFloat4 Local70 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_8,GetMaterialSharedSampler(samplerMaterial_Texture2D_8,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local11)));
	MaterialFloat Local71 = MaterialStoreTexSample(Parameters, Local70, 3);
	MaterialFloat3 Local72 = (((MaterialFloat3)1.00000000) - Local70.rgb);
	MaterialFloat3 Local73 = (Local72 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local74 = (Local73 * Material.PreshaderBuffer[5].xyz);
	MaterialFloat3 Local75 = (((MaterialFloat3)1.00000000) - Local74);
	MaterialFloat3 Local76 = (Local70.rgb * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local77 = (Local76 * Material.PreshaderBuffer[6].xyz);
	MaterialFloat Local78 = select((Local70.rgb.r >= 0.50000000), Local75.r, Local77.r);
	MaterialFloat Local79 = select((Local70.rgb.g >= 0.50000000), Local75.g, Local77.g);
	MaterialFloat Local80 = select((Local70.rgb.b >= 0.50000000), Local75.b, Local77.b);
	MaterialFloat3 Local81 = (MaterialFloat3(MaterialFloat2(Local78,Local79),Local80) * ((MaterialFloat3)Material.PreshaderBuffer[6].w));
	MaterialFloat Local82 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local15), 2);
	MaterialFloat4 Local83 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_9,samplerMaterial_Texture2D_9,DERIV_BASE_VALUE(Local15),View.MaterialTextureMipBias));
	MaterialFloat Local84 = MaterialStoreTexSample(Parameters, Local83, 2);
	MaterialFloat3 Local85 = (((MaterialFloat3)1.00000000) - Local83.rgb);
	MaterialFloat3 Local86 = (Local85 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local87 = (Local86 * Material.PreshaderBuffer[7].xyz);
	MaterialFloat3 Local88 = (((MaterialFloat3)1.00000000) - Local87);
	MaterialFloat3 Local89 = (Local83.rgb * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local90 = (Local89 * Material.PreshaderBuffer[8].xyz);
	MaterialFloat Local91 = select((Local83.rgb.r >= 0.50000000), Local88.r, Local90.r);
	MaterialFloat Local92 = select((Local83.rgb.g >= 0.50000000), Local88.g, Local90.g);
	MaterialFloat Local93 = select((Local83.rgb.b >= 0.50000000), Local88.b, Local90.b);
	MaterialFloat3 Local94 = (MaterialFloat3(MaterialFloat2(Local91,Local92),Local93) * ((MaterialFloat3)Material.PreshaderBuffer[8].w));
	MaterialFloat3 Local95 = lerp(Local81,Local94,Local25);
	MaterialFloat Local96 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local27), 10);
	MaterialFloat4 Local97 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_10,samplerMaterial_Texture2D_10,DERIV_BASE_VALUE(Local27),View.MaterialTextureMipBias));
	MaterialFloat Local98 = MaterialStoreTexSample(Parameters, Local97, 10);
	MaterialFloat Local99 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local31), 10);
	MaterialFloat4 Local100 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_10,samplerMaterial_Texture2D_10,DERIV_BASE_VALUE(Local31),View.MaterialTextureMipBias));
	MaterialFloat Local101 = MaterialStoreTexSample(Parameters, Local100, 10);
	MaterialFloat3 Local102 = lerp(Local97.rgb,Local100.rgb,DERIV_BASE_VALUE(Local39));
	MaterialFloat3 Local103 = (((MaterialFloat3)1.00000000) - Local102);
	MaterialFloat3 Local104 = (Local103 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local105 = (Local104 * Material.PreshaderBuffer[9].xyz);
	MaterialFloat3 Local106 = (((MaterialFloat3)1.00000000) - Local105);
	MaterialFloat3 Local107 = (Local102 * ((MaterialFloat3)2.00000000));
	MaterialFloat3 Local108 = (Local107 * Material.PreshaderBuffer[10].xyz);
	MaterialFloat Local109 = select((Local102.r >= 0.50000000), Local106.r, Local108.r);
	MaterialFloat Local110 = select((Local102.g >= 0.50000000), Local106.g, Local108.g);
	MaterialFloat Local111 = select((Local102.b >= 0.50000000), Local106.b, Local108.b);
	MaterialFloat3 Local112 = (MaterialFloat3(MaterialFloat2(Local109,Local110),Local111) * ((MaterialFloat3)Material.PreshaderBuffer[10].w));
	MaterialFloat3 Local113 = lerp(Local94,Local112,Local47);
	MaterialFloat3 Local114 = CustomExpression1(Parameters,Local3.r,Local5.r,Local7.r,Local81.rgb,Local95.rgb,Local113.rgb);
	MaterialFloat3 Local115 = (Local68 * Local114.rgb);
	MaterialFloat Local116 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local11), 9);
	MaterialFloat4 Local117 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_11,GetMaterialSharedSampler(samplerMaterial_Texture2D_11,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local11)));
	MaterialFloat Local118 = MaterialStoreTexSample(Parameters, Local117, 9);
	MaterialFloat Local119 = (Local117.g * Material.PreshaderBuffer[11].x);
	MaterialFloat Local120 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local15), 5);
	MaterialFloat4 Local121 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_12,samplerMaterial_Texture2D_12,DERIV_BASE_VALUE(Local15),View.MaterialTextureMipBias));
	MaterialFloat Local122 = MaterialStoreTexSample(Parameters, Local121, 5);
	MaterialFloat Local123 = lerp(Local119,Local121.g,Local25.x);
	MaterialFloat Local124 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local27), 11);
	MaterialFloat4 Local125 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_13,samplerMaterial_Texture2D_13,DERIV_BASE_VALUE(Local27),View.MaterialTextureMipBias));
	MaterialFloat Local126 = MaterialStoreTexSample(Parameters, Local125, 11);
	MaterialFloat Local127 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local31), 11);
	MaterialFloat4 Local128 = ProcessMaterialColorTextureLookup(Texture2DSampleBias(Material_Texture2D_13,samplerMaterial_Texture2D_13,DERIV_BASE_VALUE(Local31),View.MaterialTextureMipBias));
	MaterialFloat Local129 = MaterialStoreTexSample(Parameters, Local128, 11);
	MaterialFloat3 Local130 = lerp(Local125.rgb,Local128.rgb,DERIV_BASE_VALUE(Local39));
	MaterialFloat3 Local131 = (Local130 * ((MaterialFloat3)Material.PreshaderBuffer[11].y));
	MaterialFloat3 Local132 = lerp(((MaterialFloat3)Local121.g),Local131,Local47);
	MaterialFloat3 Local133 = CustomExpression2(Parameters,Local3.r,Local5.r,Local7.r,Local119.r,Local123.r,Local132.r);
	MaterialFloat Local134 = lerp(Local117.r,Local121.r,Local25.x);
	MaterialFloat Local135 = lerp(Local121.r,1.00000000,Local47.x);
	MaterialFloat3 Local136 = CustomExpression3(Parameters,Local3.r,Local5.r,Local7.r,Local117.r.r,Local134.r,Local135.r);

	PixelMaterialInputs.EmissiveColor = Local50;
	PixelMaterialInputs.Opacity = 1.00000000;
	PixelMaterialInputs.OpacityMask = 1.00000000;
	PixelMaterialInputs.BaseColor = Local115;
	PixelMaterialInputs.Metallic = 0.00000000;
	PixelMaterialInputs.Specular = 0.50000000;
	PixelMaterialInputs.Roughness = Local133.r;
	PixelMaterialInputs.Anisotropy = 0.00000000;
	PixelMaterialInputs.Normal = Local49.rgb;
	PixelMaterialInputs.Tangent = MaterialFloat3(1.00000000,0.00000000,0.00000000);
	PixelMaterialInputs.Subsurface = 0;
	PixelMaterialInputs.AmbientOcclusion = Local136.r;
	PixelMaterialInputs.Refraction = 0;
	PixelMaterialInputs.PixelDepthOffset = 0.00000000;
	PixelMaterialInputs.ShadingModel = 1;
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
	//if( PixelMaterialInputs.OpacityMask < 0.333 ) discard;

	o.Metallic = PixelMaterialInputs.Metallic;
	o.Smoothness = 1.0 - PixelMaterialInputs.Roughness;
	o.Normal = normalize( PixelMaterialInputs.Normal );
	o.Emission = PixelMaterialInputs.EmissiveColor.rgb;
	o.Occlusion = PixelMaterialInputs.AmbientOcclusion;

	//BLEND_ADDITIVE o.Alpha = ( o.Emission.r + o.Emission.g + o.Emission.b ) / 3;
}