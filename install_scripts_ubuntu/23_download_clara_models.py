import subprocess

if __name__ == '__main__':
    print('downloading clara models from nvidia/med')
    models = ['classification_chestxray', 'clara_ct_seg_spleen_no_amp', 'clara_ct_seg_liver_and_tumor_no_amp',
              'clara_mri_seg_brain_tumors_br16_full_no_amp', 'clara_xray_classification_chest_no_amp',
              'clara_mri_annotation_brain_tumors_t1ce_tc_no_amp', 'clara_ct_annotation_spleen_no_amp',
              'clara_mri_fed_learning_seg_brain_tumors_br16_t1c2tc_no_amp', 'clara_mri_seg_brain_tumors_br16_t1c2tc_no_amp',
              'clara_train_mri_prostate_cg_and_pz_automl', 'clara_train_deepgrow_aiaa_inference_only',
              'clara_train_covid19_annotation_ct_lung', 'clara_train_covid19_ct_lung_seg',
              'clara_train_covid19_3d_ct_classification']
    for model in models:
        try:
            print('downloading %s.' % (model))
            subprocess.call(['ngc', 'registry', 'model', 'download-version',
                             'nvidia/med/'+model+':1', '--dest', '/workspace/clara-experiments/nv-models'])
            print('%s. is successfully downloaded.' % (model))
        except:
            print('failed to download %s.'%(model))

