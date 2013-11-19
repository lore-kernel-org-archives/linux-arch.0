From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 6/9] mips: Remove unused dt_setup_arch()
Date: Tue, 19 Nov 2013 12:12:31 +0100
Message-ID: <1384859554-27268-6-git-send-email-geert@linux-m68k.org>
References: <5283A000.8090007@gmail.com>
 <1384859554-27268-1-git-send-email-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1384859554-27268-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <rob.herring@calxeda.com>
Cc: devicetree@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Ralf Baechle <ralf@linux-mips.org>, John Crispin <blogic@openwrt.org>, linux-mips@linux-mips.org
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: John Crispin <blogic@openwrt.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/prom.h |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/mips/include/asm/prom.h b/arch/mips/include/asm/prom.h
index ccd2b75f152c..7e2ee8301c06 100644
--- a/arch/mips/include/asm/prom.h
+++ b/arch/mips/include/asm/prom.h
@@ -23,13 +23,6 @@ struct boot_param_header;
 
 extern void __dt_setup_arch(struct boot_param_header *bph);
 
-#define dt_setup_arch(sym)						\
-({									\
-	extern struct boot_param_header __dtb_##sym##_begin;		\
-									\
-	__dt_setup_arch(&__dtb_##sym##_begin);				\
-})
-
 #else /* CONFIG_OF */
 static inline void device_tree_init(void) { }
 #endif /* CONFIG_OF */
-- 
1.7.9.5
