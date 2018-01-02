From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v5 33/39] dt-bindings: nds32 SoC Bindings
Date: Tue,  2 Jan 2018 16:25:05 +0800
Message-ID: <51d9e9f0a85437742ed8e6770a9e91defd92e5d0.1514874858.git.green.hu@gmail.com>
References: <cover.1514874857.git.green.hu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1514874857.git.green.hu@gmail.com>
In-Reply-To: <cover.1514874857.git.green.hu@gmail.com>
References: <cover.1514874857.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, rdunlap@infradead.org, davem@davemloft.net, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com
Cc: green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

From: Greentime Hu <greentime@andestech.com>

This patch adds nds32 SoC(AE3XX and AG101P) binding documents.

Signed-off-by: Greentime Hu <greentime@andestech.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/nds32/andestech-boards     |   40 ++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nds32/andestech-boards

diff --git a/Documentation/devicetree/bindings/nds32/andestech-boards b/Documentation/devicetree/bindings/nds32/andestech-boards
new file mode 100644
index 0000000..f5d7569
--- /dev/null
+++ b/Documentation/devicetree/bindings/nds32/andestech-boards
@@ -0,0 +1,40 @@
+Andestech(nds32) AE3XX Platform
+-----------------------------------------------------------------------------
+The AE3XX prototype demonstrates the AE3XX example platform on the FPGA. It
+is composed of one Andestech(nds32) processor and AE3XX.
+
+Required properties (in root node):
+- compatible = "andestech,ae3xx";
+
+Example:
+/dts-v1/;
+/ {
+	compatible = "andestech,ae3xx";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&intc>;
+};
+
+Andestech(nds32) AG101P Platform
+-----------------------------------------------------------------------------
+AG101P is a generic SoC Platform IP that works with any of Andestech(nds32)
+processors to provide a cost-effective and high performance solution for
+majority of embedded systems in variety of application domains. Users may
+simply attach their IP on one of the system buses together with certain glue
+logics to complete a SoC solution for a specific application. With
+comprehensive simulation and design environments, users may evaluate the
+system performance of their applications and track bugs of their designs
+efficiently. The optional hardware development platform further provides real
+system environment for early prototyping and software/hardware co-development.
+
+Required properties (in root node):
+	compatible = "andestech,ag101p";
+
+Example:
+/dts-v1/;
+/ {
+	compatible = "andestech,ag101p";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&intc>;
+};
-- 
1.7.9.5
