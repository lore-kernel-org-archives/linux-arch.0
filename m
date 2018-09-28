From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V6 26/33] MAINTAINERS: Add csky
Date: Fri, 28 Sep 2018 08:51:23 +0800
Message-ID: <64738b50aea8b964e36550ec62fad0139ac5f0d7.1538058840.git.ren_guo@c-sky.com>
References: <62098e7d0a7fbdd09f44d7e23333dad258a01bd2.1538058840.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <62098e7d0a7fbdd09f44d7e23333dad258a01bd2.1538058840.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1538058840.git.ren_guo@c-sky.com>
References: <cover.1538058840.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, green.hu@gmail.com, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

Add a maintainer information for the csky(C-SKY) architecture.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 MAINTAINERS | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d870cb5..6b7c1be 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3211,6 +3211,22 @@ T:	git git://git.alsa-project.org/alsa-kernel.git
 S:	Maintained
 F:	sound/pci/oxygen/
 
+C-SKY ARCHITECTURE
+M:	Guo Ren <ren_guo@c-sky.com>
+T:	git https://github.com/c-sky/csky-linux.git
+S:	Supported
+F:	arch/csky/
+F:	Documentation/devicetree/bindings/interrupt-controller/csky,mpintc.txt
+F:	drivers/irqchip/irq-csky-mpintc.c
+F:	Documentation/devicetree/bindings/interrupt-controller/csky,apb-intc.txt
+F:	drivers/irqchip/irq-csky-apb-intc.c
+F:	Documentation/devicetree/bindings/timer/csky,mptimer.txt
+F:	drivers/clocksource/csky_mptimer.c
+F:	Documentation/devicetree/bindings/timer/csky,gx6605s-timer.txt
+F:	drivers/clocksource/timer-gx6605s.c
+K:	csky
+N:	csky
+
 C6X ARCHITECTURE
 M:	Mark Salter <msalter@redhat.com>
 M:	Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
-- 
2.7.4
