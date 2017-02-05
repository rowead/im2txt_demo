#!/usr/bin/env bash
if [ $# -eq 0 ]
then 
  echo "give path to image is misssing"
  echo "example: ./process_image.sh imgs/bikes.jpg"
  exit 3
fi
convert imgs/${1} JPG:- > imgs/${1}.jpg
# Run inference to generate captions.¬
im2txt/bazel-bin/im2txt/run_inference --checkpoint_path="/root/im2txt_pretrained/model.ckpt-2000000" --vocab_file="/root/im2txt_pretrained/word_counts.txt" --input_files="imgs/${1}.jpg" 2>/dev/null
rm imgs/${1}*
