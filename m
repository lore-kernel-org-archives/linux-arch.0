From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V4 19/27] dt-bindings: timer: gx6605s SOC timer
Date: Wed, 12 Sep 2018 22:52:01 +0800
Message-ID: <e70d9055806db229a07d02fc80d45b3cc5d12ef3.1536758961.git.ren_guo@c-sky.com>
References: <93e8b592e429c156ad4d4ca5d85ef48fd0ab8b70.1536758961.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <93e8b592e429c156ad4d4ca5d85ef48fd0ab8b70.1536758961.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1536758961.git.ren_guo@c-sky.com>
References: <cover.1536758961.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, jason@lakedaemon.net, arnd@arndb.de, devicetree@vger.kernel.org, andrea.parri@amarulasolutions.com, peterz@infradead.org
Cc: c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org, ren_guo@c-sky.com, green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 .../bindings/timer/csky,gx6605s-timer.txt          | 42 ++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt b/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
new file mode 100644
index 0000000..230a9ce
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
@@ -0,0 +1,42 @@
+=================
+gx6605s SOC Timer
+=================
+
+The timer is used in gx6605s soc as system timer and the driver
+contain clk event and clk source.
+
+==============================
+timer node bindings definition
+==============================
+
+        Description: Describes gx6605s SOC timer
+
+        PROPERTIES
+
+        - compatible
+                Usage: required
+                Value type: <string>
+                Definition: must be "csky,gx6605s-timer"
+	- reg
+		Usage: required
+		Value type: <u32 u32>
+		Definition: <phyaddr size> in soc from cpu view
+	- clocks
+		Usage: required
+		Value type: phandle + clock specifier cells
+		Definition: must be input clk node
+        - interrupt
+                Usage: required
+                Value type: <u32>
+                Definition: must be timer irq num defined by soc
+
+Examples:
+---------
+
+	timer0: timer@20a000 {
+		compatible = "csky,gx6605s-timer";
+		reg = <0x0020a000 0x400>;
+		clocks = <&dummy_apb_clk>;
+		interrupts = <10>;
+		interrupt-parent = <&intc>;
+	};
-- 
2.7.4
