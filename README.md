# InSAR 地灾形变可视化系统

> 本地运行，无需安装数据库或后端服务。适合初学者学习和使用。

## 快速开始

### 方法一：双击 start.bat（最简单）

双击 `start.bat`，然后浏览器打开：**http://localhost:8080**

### 方法二：Python 命令

```powershell
cd e:\cursor\Git\test\insar-gis
python -m http.server 8080
```

然后浏览器打开：**http://localhost:8080**

---

## 功能说明

| 功能 | 说明 |
|------|------|
| 数据导入 | 表格(.txt/.csv/.xlsx)、Shapefile(.shp/.zip)、GeoPackage(.gpkg)、GeoJSON、QGIS工程(.qgz) |
| 地图展示 | 卫星/街道底图切换，监测点按形变量着色 |
| 时序分析 | 点击任意监测点，右侧显示形变时间序列折线图 |
| 速率筛选 | 按形变速率范围过滤显示 |
| 框选工具 | 在地图上拖拽矩形，选取区域内所有点 |
| 风险评级 | 自动根据形变速率判断高/中/低风险 |
| 数据导出 | 导出 GeoJSON 格式（可被 QGIS、ArcGIS 打开） |

---

## 数据格式要求

第一行必须是**表头**，至少包含经度和纬度列：

```
ID,经度,纬度,形变速率,2020-01,2020-02,2020-03,...
P001,104.0612,30.5734,-8.5,-0.7,-1.4,-2.1,...
P002,104.0635,30.5748,-15.2,-1.3,-2.6,-3.9,...
```

### 支持的表头名称

| 字段 | 可识别的表头名 |
|------|--------------|
| 编号 | id、点号、编号、point、name、名称、测点 |
| 经度 | lon、lng、longitude、经度、x |
| 纬度 | lat、latitude、纬度、y |
| 速率 | vel、velocity、rate、速率、形变速率、速度 |
| 时序 | 2020-01、202001、2020/01/01、T1、T2 等日期格式 |

> 如果没有「形变速率」列，系统会自动用时序数据估算。

### GIS 格式导入

| 格式 | 上传方式 | 说明 |
|------|---------|------|
| **Shapefile** | `.zip`（推荐）或同时选 `.shp`+`.dbf` | 把 shp/dbf/shx 打包成 zip |
| **GeoPackage** | 直接上传 `.gpkg` | QGIS 默认格式，右键图层→导出 |
| **GeoJSON** | 直接上传 `.geojson` | QGIS 可导出为此格式 |
| **QGIS 工程** | 上传 `.qgz` | 自动解压并读取内含的数据层 |

> **坐标要求**：须为 WGS84 经纬度 (EPSG:4326)。若为投影坐标，在 QGIS 中：
> 右键图层 → 导出 → 保存要素为 → CRS 选 EPSG:4326

---

## 项目结构

```
insar-gis/
├── index.html          ← 主页面（入口）
├── css/style.css       ← 界面样式
├── js/
│   ├── parser.js       ← 数据解析（表格 + GeoJSON 属性识别）
│   ├── gis-formats.js  ← GIS 格式解析（SHP / GPKG / QGZ）
│   ├── gis.js          ← GIS 地图功能（Leaflet）
│   └── app.js          ← 主程序（串联各模块）
└── sample/
    └── sample_data.csv ← 示例数据（25 个模拟监测点）
```
