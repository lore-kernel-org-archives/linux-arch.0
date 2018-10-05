From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH V7 20/20] MAINTAINERS: Add csky
Date: Fri,  5 Oct 2018 16:33:16 +0800
Message-ID: <1f700f59aeec8d1e09b967bc3fe7271c00a9a3e9.1538715563.git.ren_guo@c-sky.com>
References: <994158389acaf01d065bf1460eb51b3b7249bd07.1538715563.git.ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <994158389acaf01d065bf1460eb51b3b7249bd07.1538715563.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1538715563.git.ren_guo@c-sky.com>
References: <cover.1538715563.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org, arnd@arndb.de, daniel.lezcano@linaro.org, davem@davemloft.net, gregkh@linuxfoundation.org, jason@lakedaemon.net, marc.zyngier@arm.com, mark.rutland@arm.com, mchehab+samsung@kernel.org, peterz@infradead.org, robh@kernel.org, robh+dt@kernel.org, tglx@linutronix.de
Cc: green.hu@gmail.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, devicetree@vger.kernel.org, c-sky_gcc_upstream@c-sky.com, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

Add a maintainer information for the csky(C-SKY) architecture.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d870cb5..9dac20e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3211,6 +3211,15 @@ T:	git git://git.alsa-project.org/alsa-kernel.git
 S:	Maintained
 F:	sound/pci/oxygen/
 
+C-SKY ARCHITECTURE
+M:	Guo Ren <ren_guo@c-sky.com>
+T:	git https://github.com/c-sky/csky-linux.git
+S:	Supported
+F:	arch/csky/
+F:	Documentation/devicetree/bindings/csky/
+K:	csky
+N:	csky
+
 C6X ARCHITECTURE
 M:	Mark Salter <msalter@redhat.com>
 M:	Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
-- 
2.7.4
