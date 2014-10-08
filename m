Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn1on0096.outbound.protection.outlook.com ([157.56.110.96]:4544
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755780AbaJHJbS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 8 Oct 2014 05:31:18 -0400
From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH v4 15/29] Add ELF machine define for Nios2
Date: Wed, 8 Oct 2014 17:29:41 +0800
Message-ID: <1412760595-3935-16-git-send-email-lftan@altera.com>
In-Reply-To: <1412760595-3935-1-git-send-email-lftan@altera.com>
References: <1412760595-3935-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com
Message-ID: <20141008092941.XUg8usvn0WzP1ViHF64KgHMWfEvH_rLGJ1wTnPAnOx0@z>

Signed-off-by: Ley Foon Tan <lftan@altera.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/linux/elf-em.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

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
1.7.7.4

