import SwiftUI
import ARKit

struct Scan: View {
    @State private var debugText: String = ""
    
    var body: some View {
        ZStack {
            ARViewContainer(debugText: $debugText)
            .overlay(
                VStack {
                    HStack {
                        VStack {
                            Rectangle()
                                .fill(Color.black)
                                .frame(width: 600, height: 500)
                                .opacity(0.5)
                                .overlay(
                                    VStack{
                                        Text(debugText)
                                            .font(.caption)
                                            .padding(5)
                                            .foregroundColor(Color.white)
                                        Spacer()
                                    }
                                )
                                .cornerRadius(10)
                                .padding(5)
                            Spacer()
                        }
                        Spacer()
                        VStack {
                            Button(
                                action: {exit(0)},
                                label: {
                                    Text("Quitter")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.red)
                                        .cornerRadius(10)
                            })
                            .padding(5)
                            Spacer()
                        }
                    }
                    Spacer()
                }
            )
        }
    }
}

/*
func captureImage() {
    capturedFrame = arView.session.currentFrame

    let image = CIImage(cvPixelBuffer: capturedFrame.capturedImage)
    let context = CIContext()
    let cgImage = context.createCGImage(image, from: image.extent)
    let uiImage = UIImage(cgImage: cgImage!)
    UIImageWriteToSavedPhotosAlbum(uiImage, nil, nil, nil)
}
*/
struct ARViewContainer: UIViewRepresentable {
    @Binding var debugText: String

    func makeUIView(context: Context) -> ARSCNView {
        let arView = ARSCNView()
        arView.session.delegate = context.coordinator
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        arView.session.run(config)
        return arView
    }

    func updateUIView(_ uiView: ARSCNView, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }

    class Coordinator: NSObject, ARSessionDelegate {
        var parent: ARViewContainer

        init(parent: ARViewContainer) {
            self.parent = parent
        }

        func session(_ session: ARSession, didUpdate frame: ARFrame) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                
                let cameraIntrinsecMatrix = frame.camera.intrinsics
                let cameraResolution = frame.camera.imageResolution
                let cameraPosition = frame.camera.transform
                let cameraOrientation = frame.camera.eulerAngles
                let trackingState = frame.camera.trackingState
                let _timestamp = frame.timestamp
                let _capturedImage = frame.capturedImage
                
                self.parent.debugText = """
                    Camera resolution: \(cameraResolution)
                    Camera tracking state: \(trackingState)
                    Camera intrinsec matrix: \(cameraIntrinsecMatrix)
                    Camera position: \(cameraPosition)
                    Camera orientation: \(cameraOrientation)
                    """
            }
        }
    }
}

struct Scan_Previews: PreviewProvider {
    static var previews: some View {
        Scan()
    }
}

