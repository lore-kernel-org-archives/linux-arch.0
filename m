From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH 26/28] Add ELF machine define for Nios2
Date: Fri, 18 Apr 2014 20:27:09 +0800
Message-ID: <1397824031-4892-23-git-send-email-lftan@altera.com>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1397824031-4892-1-git-send-email-lftan@altera.com>
Sender: linux-doc-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com
List-Id: linux-arch.vger.kernel.org

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 include/uapi/linux/elf-em.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/elf-em.h b/include/uapi/linux/elf-em.h
index 01529bd..7f06c0d 100644
--- a/include/uapi/linux/elf-em.h
+++ b/include/uapi/linux/elf-em.h
@@ -33,6 +33,7 @@
 #define EM_M32R		88	/* Renesas M32R */
 #define EM_MN10300	89	/* Panasonic/MEI MN10300, AM33 */
 #define EM_BLACKFIN     106     /* ADI Blackfin Processor */
+#define EM_ALTERA_NIOS2	113	/* Altera Nios II soft-core processor */
 #define EM_TI_C6000	140	/* TI C6X DSPs */
 #define EM_AARCH64	183	/* ARM 64 bit */
 #define EM_FRV		0x5441	/* Fujitsu FR-V */
-- 
1.8.3.2

