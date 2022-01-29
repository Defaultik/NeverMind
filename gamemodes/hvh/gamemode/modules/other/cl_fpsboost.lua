commands = {
    ["gmod_mcore_test"] = 1,
    ["studio_queue_mode"] = 1,
    ["dsp_slow_cpu"] = 1,
    ["muzzleflash_light"] = 0,
    ["snd_mix_async"] = 1,

    ["rate"] = 40000,
    ["cl_lagcompensation"] = 1,
    ["cl_interp"] = 0.116700,
    ["cl_interp_ratio"] = 2,
    ["cl_cmdrate"] = 66,
    ["cl_updaterate"] = 66,
    ["cl_threaded_bone_setup"] = 1,
    ["cl_threaded_client_leaf_system"] = 1,
    ["cl_phys_props_enable"] = 0,
    ["cl_phys_props_max"] = 0,
    ["cl_forcepreload"] = 1,
    ["cl_detaildist"] = 0,
    ["cl_ejectbrass"] = 0,
    ["cl_show_splashes"] = 0,

    ["mat_reducefillrate"] = 1,
    ["mat_specular"] = 0,
    ["mat_fastspecular"] = 1,
    ["mat_queue_mode"] = 2,
    ["mat_disable_lightwarp"] = 1,
    ["mat_disable_bloom"] = 1,
    ["mat_bloomscale"] = 0,
    ["mat_hdr_enabled"] = 0,
    ["mat_hdr_level"] = 0,
    ["mat_wateroverlaysize"] = 1,
    ["mat_shadowstate"] = 0,

    ["r_eyemove"] = 0,
    ["r_drawvgui"] = 1,
    ["r_fastzreject"] = -1,
    ["r_threaded_client_shadow_manager"] = 1,
    ["r_threaded_particles"] = 1,
    ["r_threaded_renderables"] = 1,
    ["r_worldlights"] = 0,
    ["r_drawmodeldecals"] = 0,
    ["r_maxmodeldecal"] = 0,
    ["r_decals"] = 55,
    ["r_drawflecks"] = 0,
    ["r_dynamic"] = 0,
    ["r_shadowrendertotexture"] = 0,
    ["r_shadowmaxrendered"] = 0,
    ["r_lod"] = 1,
    ["r_rootlod"] = 1,
    ["r_propsmaxdist"] = 5,
    ["r_drawdetailprops"] = 0,

    ["net_maxfilesize"] = 64,
    ["net_compressvoice"] = 1
}

hooks = {
    ["RenderScreenspaceEffects"] = "RenderBloom",
    ["RenderScreenspaceEffects"] = "RenderBokeh",
    ["RenderScreenspaceEffects"] = "RenderMaterialOverlay",
    ["RenderScreenspaceEffects"] = "RenderSharpen",
    ["RenderScreenspaceEffects"] = "RenderSobel",
    ["RenderScreenspaceEffects"] = "RenderStereoscopy",
    ["RenderScreenspaceEffects"] = "RenderSunbeams",
    ["RenderScreenspaceEffects"] = "RenderTexturize",
    ["RenderScreenspaceEffects"] = "RenderToyTown",
    ["PreDrawHalos"] = "PropertiesHover",
    ["RenderScene"] = "RenderSuperDoF",
    ["RenderScene"] = "RenderStereoscopy",
    ["PreRender"] = "PreRenderFlameBlend",
    ["PostRender"] = "RenderFrameBlend",
    ["PostRender"] = "PreRenderFrameBlend",
    ["PostDrawEffects"] = "RenderWidgets",
    ["PostDrawEffects"] = "RenderHalos",
    ["GUIMousePressed"] = "SuperDOFMouseDown",
    ["GUIMousePressed"] = "SuperDOFMouseUp",
    ["Think"] = "DOFThink",
    ["PlayerTick"] = "TickWidgets",
    ["PlayerBindPress"] = "PlayerOptionInput",
    ["NeedsDepthPass"] = "NeedsDepthPass_Bokeh",
    ["OnGamemodeLoaded"] = "CreateMenuBar",
}

hook.Add("InitPostEntity", "FPSBoost", function()
    for k, v in pairs(commands) do
        if (GetConVarNumber(k) ~= v) then
            RunConsoleCommand(k, v)
        end
    end

    for k, v in pairs(hooks) do
        hook.Remove(k, v)
    end
end)

timer.Create("CleanDecals", 45, 0, function()
    RunConsoleCommand("r_cleardecals")
    for _, v in ipairs(ents.FindByClass("class C_ClientRagdoll")) do
        v:Remove()
    end
end)