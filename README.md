# Unity-003

# Unity之万丈高楼第三砖

简单接触了下Unity Shader，初步了解了渲染流水线的流程阶段

不过在写了几个简单的shader之后感觉也就是顶点着色器跟片元着色器需要自定义式的编程，其他的阶段目前还没有大刀阔斧的改动。。

第一个渲染器诶，虽然只是染了个七彩的颜色。。(具体代码看Assets/Shader/.shader文件吧)

![image](https://github.com/HighwayWu/Unity-003/raw/master/Screenshot/图片1.png)

几个不同的漫反射光照模型，正面看起来不是那么明显。。

左中右: 逐顶点漫反射、逐像素漫反射、半兰伯特模型

![image](https://github.com/HighwayWu/Unity-003/raw/master/Screenshot/图片2.png)

从背面看还是半兰伯特模型能比较好的处理背光区的模型细节，其余两个仿佛受到了降维打击。。

![image](https://github.com/HighwayWu/Unity-003/raw/master/Screenshot/图片3.png)

几个不同的高光反射光照模型:

左中右: 高光逐顶点光照、高光逐像素光照、高光Blinn-Phong光照模型 (反正我是看不出来有啥大的区别。。)

![image](https://github.com/HighwayWu/Unity-003/raw/master/Screenshot/图片4.png)

![image](https://github.com/HighwayWu/Unity-003/raw/master/Screenshot/图片5.png)

凹凸纹理&映射:

左中右: 单张纹理、切线空间(Bump Scale = -1, 凸起来了)、世界空间(Bump Scale = 1, 凹下去了) (都好难看。。)

![image](https://github.com/HighwayWu/Unity-003/raw/master/Screenshot/图片6.png)

几个不同的渐变纹理控制漫反射光照: 

![image](https://github.com/HighwayWu/Unity-003/raw/master/Screenshot/图片7.png)

啊感觉好多地方一知半解的。。估计下次还是要重新复习一遍。。

Reference:  《Unity Shader 入门精要》
