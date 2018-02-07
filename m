From: Jia He <hejianet@gmail.com>
Subject: [PATCH] ACPI/IORT: Remove linker section for IORT entries again
Date: Tue,  6 Feb 2018 20:11:34 -0800
Message-ID: <1517976694-2004-1-git-send-email-hejianet@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jia He <hejianet@gmail.com>
List-Id: linux-arch.vger.kernel.org

In commit 316ca8804ea8 ("ACPI/IORT: Remove linker section for IORT entries
probing"), iort entries was removed in vmlinux.lds.h. But in
commit 2fcc112af37f ("clocksource/drivers: Rename clksrc table to timer"),
this line was back incorrectly.

It does no harm except for adding some useless symbols, so fix it.

Signed-off-by: Jia He <hejianet@gmail.com>
---
 include/asm-generic/vmlinux.lds.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 1ab0e52..58b1dab 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -589,7 +589,6 @@
 	IRQCHIP_OF_MATCH_TABLE()					\
 	ACPI_PROBE_TABLE(irqchip)					\
 	ACPI_PROBE_TABLE(timer)						\
-	ACPI_PROBE_TABLE(iort)						\
 	EARLYCON_TABLE()
 
 #define INIT_TEXT							\
-- 
2.7.4
