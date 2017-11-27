From: Greentime Hu <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 26/35] dt-bindings: interrupt-controller: Andestech Internal Vector Interrupt Controller
Date: Mon, 27 Nov 2017 20:28:13 +0800
Message-ID: <d2539a0128f8c1cf0b32fd5151fd2f8775e5c511.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1511785528.git.green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
In-Reply-To: <cover.1511785528.git.green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
References: <cover.1511785528.git.green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, deanbo422-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org, dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Rick Chen <rick-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

From: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>

This patch adds an irqchip driver document for the Andestech Internal Vector
Interrupt Controller.

Signed-off-by: Rick Chen <rick-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
Signed-off-by: Greentime Hu <greentime-MUIXKm3Oiri1Z/+hSey0Gg@public.gmane.org>
---
 .../interrupt-controller/andestech,ativic32.txt    |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt b/Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt
new file mode 100644
index 0000000..f4b4193
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt
@@ -0,0 +1,19 @@
+* Andestech Internal Vector Interrupt Controller
+
+The Internal Vector Interrupt Controller (IVIC) is a basic interrupt controller
+suitable for a simpler SoC platform not requiring a more sophisticated and
+bigger External Vector Interrupt Controller.
+
+
+Main node required properties:
+
+- compatible : should at least contain  "andestech,ativic32".
+- interrupt-controller : Identifies the node as an interrupt controller
+- #interrupt-cells: 1 cells and refer to interrupt-controller/interrupts
+
+Examples:
+	intc: interrupt-controller {
+		compatible = "andestech,ativic32";
+		#interrupt-cells = <1>;
+		interrupt-controller;
+	};
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
