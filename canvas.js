// Canvas.js
// requireNativeComponent automatically resolves this to "RCTMapManager"
import React, {
  PropTypes,
  Component,
  requireNativeComponent,
  View
} from 'react-native';
// var NativeModules = require('');

import NativeModules from 'NativeModules';

var CanvasManager = NativeModules.CanvasManager;

import findNodeHandle from 'findNodeHandle';


class VirtualCanvas {
  constructor(){
    this.style = {
      get width(){
        return 320
      },
      get height(){
        return 300
      },
      set width(val){

      },
      set height(val){

      }
    }
    this.parentNode = {

    }
  }
}

export default class CanvasContext2D extends Component {

  constructor(props) {
    super(props)
    this.canvas = new VirtualCanvas()
  }

  render() {
    return (<RCTCanvas {...this.props} />);
  }

  set fillStyle(value) {
    CanvasManager.setFillStyle(findNodeHandle(this), value)
  }

  set strokeStyle(value) {
    CanvasManager.setStrokeStyle(findNodeHandle(this), value)
    // console.warn("test")
  }

  set globalAlpha(value) {
    CanvasManager.setGlobalAlpha(findNodeHandle(this), value)
    // console.warn("test")
  }

  set lineWidth(value) {
    CanvasManager.setLineWidth(findNodeHandle(this), value)
    // console.warn("test")
  }

  set miterLimit(value) {
    CanvasManager.setMiterLimit(findNodeHandle(this), value)
    // console.warn("test")
  }

  set font(value) {
    CanvasManager.setFont(findNodeHandle(this), value)
    // console.warn("test")
  }

  set imageSmoothingEnabled(value) {
    CanvasManager.setImageSmoothingEnabled(findNodeHandle(this), value)
    // console.warn("test")
  }

  set globalCompositeOperation(value) {
    CanvasManager.setGlobalCompositeOperation(findNodeHandle(this), value)
    // console.warn("test")
  }

  set lineCap(value) {
    CanvasManager.setLineCap(findNodeHandle(this), value)
    // console.warn("test")
  }

  set lineJoin(value) {
    CanvasManager.setLineJoin(findNodeHandle(this), value)
    // console.warn("test")
  }

  set textAlign(value) {
    CanvasManager.setTextAlign(findNodeHandle(this), value)
    // console.warn("test")
  }

  set textBaseline(value) {
    CanvasManager.setTextBaseline(findNodeHandle(this), value)
    // console.warn("test")
  }

  save() {
    CanvasManager.save(findNodeHandle(this))
  }
  // - (void)restore;
  restore() {
    CanvasManager.restore(findNodeHandle(this))
  }
  // - (void)rotate:(float)angle;
  rotate(angle) {
    CanvasManager.rotate(findNodeHandle(this), angle)
  }
  // - (void)translateX:(float)x y:(float)y;
  translate(x, y) {
    CanvasManager.translate(findNodeHandle(this), x, y)
  }
  // - (void)scaleX:(float)x y:(float)y;
  scale(x, y) {
    CanvasManager.scale(findNodeHandle(this), x, y)
  }
  // - (void)transformM11:(float)m11 m12:(float)m12 m21:(float)m21 m22:(float)m2 dx:(float)dx dy:(float)dy;
  transform(m11, m12, m21, m22, dx, dy) {
    CanvasManager.transform(findNodeHandle(this), m11, m12, m21, m22, dx, dy)
  }
  // - (void)setTransformM11:(float)m11 m12:(float)m12 m21:(float)m21 m22:(float)m2 dx:(float)dx dy:(float)dy;
  setTransform(m11, m12, m21, m22, dx, dy) {
    CanvasManager.setTransform(findNodeHandle(this), m11, m12, m21, m22, dx, dy)
  }
  // - (void)drawImage:(EJTexture *)image sx:(float)sx sy:(float)sy sw:(float)sw sh:(float)sh dx:(float)dx dy:(float)dy dw:(float)dw dh:(float)dh;
  drawImage(image, sx, sy, sw, sh, dx, dy, dw, dh) {
    console.warn("drawImage::Now implemented.");
    // CanvasManager.rotate(findNodeHandle(this), m11, m12, m21, m22, dx, dy)
  }
  // - (void)fillRectX:(float)x y:(float)y w:(float)w h:(float)h;
  fillRect(x, y, w, h) {
    CanvasManager.fillRect(findNodeHandle(this), x, y, w, h)
  }
  // - (void)strokeRectX:(float)x y:(float)y w:(float)w h:(float)h;
  strokeRect(x, y, w, h) {
    CanvasManager.strokeRect(findNodeHandle(this), x, y, w, h)
  }
  // - (void)clearRectX:(float)x y:(float)y w:(float)w h:(float)h;
  clearRect(x, y, w, h) {
    CanvasManager.clearRect(findNodeHandle(this), x, y, w, h)
  }
  // - (EJImageData*)getImageDataSx:(short)sx sy:(short)sy sw:(short)sw sh:(short)sh;
  getImageData(sx, sy, sw, sh) {
    console.warn("getImageData::Now implemented.");
    CanvasManager.getImageData(findNodeHandle(this), sx, sy, sw, sh)
  }
  // - (void)putImageData:(EJImageData*)imageData dx:(float)dx dy:(float)dy;
  putImageData(imageData, dx, dy) {
    console.warn("putImageData::Now implemented.");
    // CanvasManager.putImageData(findNodeHandle(this), imageData, dx, dy)
  }
  // - (void)beginPath;
  beginPath() {
    CanvasManager.beginPath(findNodeHandle(this))
  }
  // - (void)closePath;
  closePath() {
    CanvasManager.closePath(findNodeHandle(this))
  }
  // - (void)fill:(EJPathFillRule)fillRule;
  fill(fillRule) {
    CanvasManager.fill(findNodeHandle(this), fillRule)
  }
  // - (void)stroke;
  stroke() {
    CanvasManager.stroke(findNodeHandle(this))
  }
  // - (void)moveToX:(float)x y:(float)y;
  moveTo(x, y) {
    CanvasManager.moveTo(findNodeHandle(this), x, y)
  }
  // - (void)lineToX:(float)x y:(float)y;
  lineTo(x, y) {
    CanvasManager.lineTo(findNodeHandle(this), x, y)
  }
  // - (void)rectX:(float)x y:(float)y w:(float)w h:(float)h;
  rect(x, y, w, h) {
    CanvasManager.rect(findNodeHandle(this), x, y, w, h)
  }
  // - (void)bezierCurveToCpx1:(float)cpx1 cpy1:(float)cpy1 cpx2:(float)cpx2 cpx2:(float)cpy2 x:(float)x y:(float)y;
  bezierCurveTo(cpx1, cpy1, cpx2, cpy2, x, y) {
    CanvasManager.bezierCurveTo(findNodeHandle(this), cpx1, cpy1, cpx2, cpy2, x, y)
  }
  // - (void)quadraticCurveToCpx:(float)cpx cpy:(float)cpy x:(float)x y:(float)y;
  quadraticCurveTo(cpx, cpy, x, y) {
    CanvasManager.quadraticCurveTo(findNodeHandle(this), cpx, cpy, x, y)
  }
  // - (void)arcToX1:(float)x1 y1:(float)y1 x2:(float)x2 y2:(float)y2 radius:(float)radius;
  arcTo(x1, y1, x2, y2, radius) {
    CanvasManager.arcTo(findNodeHandle(this), x1, y1, x2, y2, radius)
  }
  // - (void)arcX:(float)x y:(float)y radius:(float)radius startAngle:(float)startAngle endAngle:(float)endAngle antiClockwise:(BOOL)antiClockwise;
  arc(x, y, radius, startAngle, endAngle, antiClockwise) {
    CanvasManager.arcTo(findNodeHandle(this), x, y, radius, startAngle, endAngle, antiClockwise)
  }
  // - (void)fillText:(NSString *)text x:(float)x y:(float)y;
  fillText(text, x, y) {
    CanvasManager.fillText(findNodeHandle(this), text, x, y)
  }
  // - (void)strokeText:(NSString *)text x:(float)x y:(float)y;
  strokeText(text, x, y) {
    CanvasManager.strokeText(findNodeHandle(this), text, x, y)
  }
  // - (EJTextMetrics)measureText:(NSString *)text;
  async measureText(text) {

    try {
      console.warn("Measuring size of:" + text)
      var metrics = await CanvasManager.measureText(findNodeHandle(this), text)
      console.warn(metrics);
      return metrics;
    } catch (e) {
      console.error(e);
    }

  }
  // - (void)clip:(EJPathFillRule)fillRule;
  clip(fillRule) {
    CanvasManager.clip(findNodeHandle(this), fillRule)
  }
  // - (void)resetClip;
  resetClip() {
    CanvasManager.resetClip(findNodeHandle(this))
  }

  scale(x,y) {
    CanvasManager.scale(findNodeHandle(this),x,y)
  }
  // - (void)resetClip;
  test() {
    console.log("test::", findNodeHandle(this))
    CanvasManager.test(findNodeHandle(this))
  }
}

CanvasContext2D.propTypes = {
  contextType: PropTypes.oneOf(['2d', 'webgl']).isRequired,
};


var RCTCanvas = requireNativeComponent('RCTCanvas', CanvasContext2D);
