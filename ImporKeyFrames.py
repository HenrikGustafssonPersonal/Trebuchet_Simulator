import bpy
import math
from pathlib import Path

path = "C:/tmp/xy_keyframes.txt" # Blender relative path
path2 = "C:/tmp/theta_keyframes.txt"  # Blender relative path

proj = bpy.data.objects["Projectile"]
arm = bpy.data.objects["Arm"]

x = []
y = []

xfiles = open(path)
counter = 0
for line in xfiles.readlines():
    bab = line.split("#")
    x.append(bab[0])
    y.append(bab[1])

    proj.location.x = 0 + float(x[counter])
    proj.location.z = 0 + float(y[counter])
    proj.keyframe_insert(data_path="location", frame=counter)
    counter+=1
xfiles.close()

tfiles = open(path2)
t = []
counter2 = 0

for line2 in tfiles.readlines():
    t.append(line2)
    angle = float(t[counter2])
    arm.rotation_euler = (0,-angle,0)
    arm.keyframe_insert(data_path="rotation_euler", frame=counter2)
    counter2 += 1
tfiles.close()