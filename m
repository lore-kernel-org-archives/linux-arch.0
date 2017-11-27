From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v2 28/35] MAINTAINERS: Add nds32
Date: Mon, 27 Nov 2017 20:28:15 +0800
Message-ID: <6413bcf43bec6b1c033400331aa8dfbc66970ba1.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <cover.1511785528.git.green.hu@gmail.com>
In-Reply-To: <cover.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org
Cc: green.hu@gmail.com
List-Id: linux-arch.vger.kernel.org

From: Greentime Hu <greentime@andestech.com>

Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 MAINTAINERS |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2f4e462..20284c8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -857,6 +857,17 @@ X:	drivers/iio/*/adjd*
 F:	drivers/staging/iio/*/ad*
 F:	drivers/staging/iio/trigger/iio-trig-bfin-timer.c
 
+ANDES ARCHITECTURE
+M:	Greentime Hu <green.hu@gmail.com>
+M:	Vincent Chen <deanbo422@gmail.com>
+T:	git https://github.com/andestech/linux.git
+S:	Supported
+F:	arch/nds32
+F:	Documentation/devicetree/bindings/interrupt-controller/andestech,ativic32.txt
+F:	Documentation/devicetree/bindings/nds32
+K:	nds32
+N:	nds32
+
 ANDROID CONFIG FRAGMENTS
 M:	Rob Herring <robh@kernel.org>
 S:	Supported
-- 
1.7.9.5
