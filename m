Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:39286 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753711AbdLHJjk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Dec 2017 04:39:40 -0500
From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v3 28/33] MAINTAINERS: Add nds32
Date: Fri,  8 Dec 2017 17:12:11 +0800
Message-ID: <9643f00263a3e590d4cf046ebfcb326513226dad.1512723245.git.green.hu@gmail.com>
In-Reply-To: <cover.1512723245.git.green.hu@gmail.com>
References: <cover.1512723245.git.green.hu@gmail.com>
In-Reply-To: <cover.1512723245.git.green.hu@gmail.com>
References: <cover.1512723245.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com
Cc: green.hu@gmail.com
Message-ID: <20171208091211.Luiu2BoGMwpTeJqC5lZx2CSwMQws_ylsjiXJRwZZsSo@z>

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
