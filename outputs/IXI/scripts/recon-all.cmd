

#---------------------------------
# New invocation of recon-all Wed Sep  9 17:47:31 EDT 2020 
#--------------------------------------
#@# Merge ASeg Wed Sep  9 17:47:32 EDT 2020

 cp aseg.auto.mgz aseg.presurf.mgz 

#--------------------------------------------
#@# Intensity Normalization2 Wed Sep  9 17:47:32 EDT 2020

 mri_normalize -mprage -aseg aseg.presurf.mgz -mask brainmask.mgz norm.mgz brain.mgz 

#--------------------------------------------
#@# Mask BFS Wed Sep  9 17:49:23 EDT 2020

 mri_mask -T 5 brain.mgz brainmask.mgz brain.finalsurfs.mgz 

#--------------------------------------------
#@# WM Segmentation Wed Sep  9 17:49:24 EDT 2020

 mri_segment -mprage brain.mgz wm.seg.mgz 


 mri_edit_wm_with_aseg -keep-in wm.seg.mgz brain.mgz aseg.presurf.mgz wm.asegedit.mgz 


 mri_pretess wm.asegedit.mgz wm norm.mgz wm.mgz 

#--------------------------------------------
#@# Fill Wed Sep  9 17:50:45 EDT 2020

 mri_fill -a ../scripts/ponscc.cut.log -xform transforms/talairach.lta -segmentation aseg.auto_noCCseg.mgz wm.mgz filled.mgz 



#---------------------------------
# New invocation of recon-all Wed Sep  9 17:51:14 EDT 2020 
#--------------------------------------------
#@# Inflation1 lh Wed Sep  9 17:51:14 EDT 2020

 mris_inflate -no-save-sulc ../surf/lh.smoothwm.nofix ../surf/lh.inflated.nofix 



#---------------------------------
# New invocation of recon-all Wed Sep  9 17:51:38 EDT 2020 
#--------------------------------------------
#@# Fix Topology Copy lh Wed Sep  9 17:51:38 EDT 2020

 cp ../surf/lh.orig.nofix ../surf/lh.orig 


 cp ../surf/lh.inflated.nofix ../surf/lh.inflated 

#@# Fix Topology lh Wed Sep  9 17:51:38 EDT 2020

 mris_fix_topology -rusage /home/vinny/Tools/FastSurfer-git/outputs/IXI/touch/rusage.mris_fix_topology.lh.dat -mgz -sphere qsphere.nofix -ga -seed 1234 IXI lh 


 mris_euler_number ../surf/lh.orig 


 mris_remove_intersection ../surf/lh.orig ../surf/lh.orig 


 rm ../surf/lh.inflated 



#---------------------------------
# New invocation of recon-all Wed Sep  9 17:58:23 EDT 2020 
#--------------------------------------------
#@# Smooth2 lh Wed Sep  9 17:58:23 EDT 2020

 mris_smooth -n 3 -nw -seed 1234 ../surf/lh.white.preaparc ../surf/lh.smoothwm 

#--------------------------------------------
#@# Inflation2 lh Wed Sep  9 17:58:26 EDT 2020

 mris_inflate -rusage /home/vinny/Tools/FastSurfer-git/outputs/IXI/touch/rusage.mris_inflate.lh.dat ../surf/lh.smoothwm ../surf/lh.inflated 

#--------------------------------------------
#@# Curv .H and .K lh Wed Sep  9 17:58:43 EDT 2020

 mris_curvature -w lh.white.preaparc 


 mris_curvature -thresh .999 -n -a 5 -w -distances 10 10 lh.inflated 


#-----------------------------------------
#@# Curvature Stats lh Wed Sep  9 17:59:25 EDT 2020

 mris_curvature_stats -m --writeCurvatureFiles -G -o ../stats/lh.curv.stats -F smoothwm IXI lh curv sulc 

