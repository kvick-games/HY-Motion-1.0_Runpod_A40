#!/bin/bash
export HF_HOME=/workspace/hf_cache
export HF_DATASETS_CACHE=/workspace/hf_cache/datasets
export HUGGINGFACE_HUB_CACHE=/workspace/hf_cache/hub
export TMPDIR=/workspace/tmp
export XDG_CACHE_HOME=/workspace/cache
export DISABLE_PROMPT_ENGINEERING=1
mkdir -p $HF_HOME $TMPDIR $XDG_CACHE_HOME
cd /workspace/HY-Motion-1.0
python3 -c "
import sys
sys.path.insert(0, '.')
from gradio_app import create_demo, try_to_download_model
final_model_path = try_to_download_model()
demo = create_demo(final_model_path)
demo.launch(server_name='0.0.0.0', server_port=7860, share=True)
"
