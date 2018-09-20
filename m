Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:53450 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726994AbeITLVg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Sep 2018 07:21:36 -0400
From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V8 4/6] dt-bindings: interrupt-controller: C-SKY SMP intc
Date: Thu, 20 Sep 2018 13:39:30 +0800
Message-ID: <57888913907d6c22b23425ed9d4e5a79be5b2eff.1537417413.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1537417413.git.ren_guo@c-sky.com>
References: <cover.1537417413.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1537417413.git.ren_guo@c-sky.com>
References: <cover.1537417413.git.ren_guo@c-sky.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com, arnd@arndb.de, robh@kernel.org, sfr@canb.auug.org.au
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, green.hu@gmail.com, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20180920053930.UmwbDykBEgizGF7rZ9SPg1wJCeIdOEMYKnz0V4miO5s@z>

 - Dt-bindings doc about C-SKY Multi-processors interrupt controller.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 .../bindings/interrupt-controller/csky,mpintc.txt  | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt

diff --git a/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
new file mode 100644
index 0000000..9cdad74
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
@@ -0,0 +1,40 @@
+===========================================
+C-SKY Multi-processors Interrupt Controller
+===========================================
+
+C-SKY Multi-processors Interrupt Controller is designed for ck807/ck810/ck860
+SMP soc, and it also could be used in non-SMP system.
+
+Interrupt number definition:
+
+  0-15  : software irq, and we use 15 as our IPI_IRQ.
+ 16-31  : private  irq, and we use 16 as the co-processor timer.
+ 31-1024: common irq for soc ip.
+
+=============================
+intc node bindings definition
+=============================
+
+	Description: Describes SMP interrupt controller
+
+	PROPERTIES
+
+	- compatible
+		Usage: required
+		Value type: <string>
+		Definition: must be "csky,mpintc"
+	- interrupt-cells
+		Usage: required
+		Value type: <u32>
+		Definition: must be <1>
+	- interrupt-controller:
+		Usage: required
+
+Examples:
+---------
+
+	intc: interrupt-controller {
+		compatible = "csky,mpintc";
+		#interrupt-cells = <1>;
+		interrupt-controller;
+	};
-- 
2.7.4
