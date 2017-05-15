/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */

import React, {
  AppRegistry,
  Component,
  StyleSheet,
  Text,
  View
} from 'react-native';

import Canvas from './canvas'
import Chart from 'chart.js';


class RNCanvas extends Component {

  draw(){

    var ctx = this.refs.myCanvasContext;

    var myChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
            datasets: [{
                label: '# of Votes',
                data: [12, 19, 3, 5, 2, 3],
                backgroundColor: [
                    'rgba(255, 99, 132, 0.2)',
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)',
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(153, 102, 255, 0.2)',
                    'rgba(255, 159, 64, 0.2)'
                ],
                borderColor: [
                    'rgba(255,99,132,1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)',
                    'rgba(255, 159, 64, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero:true
                    }
                }]
            }
        }
    });

    // var w = 320;
    // var h = 300;
    // var scale = 3;
    // var w2 = w/2;
    // var h2 = h/2;
    //
    // ctx.scale(scale, scale);
    //
    // var curves = [];
    // for( var i = 0; i < 200; i++ ) {
    // 	curves.push({
    // 		current: Math.random() * 1000,
    // 		inc: Math.random() * 0.005 + 0.002,
    // 		color: '#'+(Math.random()*0xFFFFFF<<0).toString(16) // Random color
    // 	});
    // }
    //
    // var p = [0,0, 0,0, 0,0, 0,0];
    // var animate = function() {
    //
    //
    //
    // 	// Clear the screen - note that .globalAlpha is still honored,
    // 	// so this will only "darken" the sceen a bit
    // 	// ctx.globalCompositeOperation = 'source-over';
    // 	ctx.fillRect(0,0,w,h);
    //
    // 	// Use the additive blend mode to draw the bezier curves
    // 	// ctx.globalCompositeOperation = 'lighter';
    //
    // 	// Calculate curve positions and draw
    // 	for( var i = 0; i < maxCurves; i++ ) {
    // 		var curve = curves[i];
    // 		curve.current += curve.inc;
    // 		for( var j = 0; j < p.length; j+=2 ) {
    // 			var a = Math.sin( curve.current * (j+3) * 373 * 0.0001 );
    // 			var b = Math.sin( curve.current * (j+5) * 927 * 0.0002 );
    // 			var c = Math.sin( curve.current * (j+5) * 573 * 0.0001 );
    // 			p[j] = (a * a * b + c * a + b) * w * c + w2;
    // 			p[j+1] = (a * b * b + c - a * b *c) * h2 + h2;
    // 		}
    //
    // 		ctx.beginPath();
    // 		ctx.moveTo( p[0], p[1] );
    // 		ctx.bezierCurveTo( p[2], p[3], p[4], p[5], p[6], p[7] );
    // 		ctx.strokeStyle = curve.color;
    // 		ctx.stroke();
    // 	}
    // };
    //
    //
    // // The vertical touch position controls the number of curves;
    // // horizontal controls the line width
    // var maxCurves = 70;
    // // document.addEventListener( 'touchmove', function( ev ) {
    // // 	ctx.lineWidth = (ev.touches[0].pageX/w) * 20;
    // // 	maxCurves = Math.floor((ev.touches[0].pageY/h) * curves.length);
    // // }, false );
    //
    //
    //
    // ctx.fillStyle = '#000000';
    // ctx.fillRect( 0, 0, w, h );
    //
    // ctx.globalAlpha = 0.05;
    // ctx.lineWidth = 2;
    // setInterval( animate, 16 );
  }

  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          React Native Canvas
        </Text>
        <Text onPress={this.draw.bind(this)} style={styles.instructions}>
          Vissaresaspeedalutionary
        </Text>
        <Canvas ref="myCanvasContext" style={{width:350, height:300}} contextType="2d"/>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

AppRegistry.registerComponent('RNCanvas', () => RNCanvas);
