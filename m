From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V5 26/30] MAINTAINERS: Add csky
Date: Tue, 25 Sep 2018 07:39:29 +0800
Message-ID: <24efe235323e3841a4850629998d46b1ebebbf5a.1537789737.git.ren_guo@c-sky.com>
References: <a23b652c2ab55b129f729a57ec765550da1d2c16.1537789737.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a23b652c2ab55b129f729a57ec765550da1d2c16.1537789737.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1537789736.git.ren_guo@c-sky.com>
References: <cover.1537789736.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, green.hu@gmail.com, palmer@sifive.com, Guo Ren <ren_guo@c-sky.com>
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
