import glob
import pathlib
import os
import json
def data_split(data_path):
    datacreate=["train.json","val.json","trainval.json"]
    file = glob.glob(data_path + "/pdfs/*")
    l=[]
    # resplit data by 8/2
    split = 80*len(file)/100

    for item in file:
        f = pathlib.Path(item).stem
        l.append(f)
    with open (os.path.join(data_path,"trainval.json"),"w") as f:
        f.write(json.dumps(l,ensure_ascii=False))
    with open (os.path.join(data_path,"train.json"),"w") as f:
        f.write(json.dumps(l[:int(split)],ensure_ascii=False))
    with open (os.path.join(data_path,"val.json"),"w") as f:
        f.write(json.dumps(l[-(len(file)-int(split)):],ensure_ascii=False))
    
data_split("/home/tip2k4/docile/data/docile/data/docile")
