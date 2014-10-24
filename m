Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn1on0061.outbound.protection.outlook.com ([157.56.110.61]:16155
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752292AbaJXIZq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 24 Oct 2014 04:25:46 -0400
From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH v5 15/29] Add ELF machine define for Nios2
Date: Fri, 24 Oct 2014 16:24:17 +0800
Message-ID: <1414139071-3818-16-git-send-email-lftan@altera.com>
In-Reply-To: <1414139071-3818-1-git-send-email-lftan@altera.com>
References: <1414139071-3818-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com
Message-ID: <20141024082417.SfDXN71Bpv2Awu8Ig1_G8L21jT0woabwVB85uLxbZQE@z>

Signed-off-by: Ley Foon Tan <lftan@altera.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/linux/elf-em.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/elf-em.h b/include/uapi/linux/elf-em.h
index aa90bc9..ae99f77 100644
--- a/include/uapi/linux/elf-em.h
+++ b/include/uapi/linux/elf-em.h
@@ -34,6 +34,7 @@
 #define EM_MN10300	89	/* Panasonic/MEI MN10300, AM33 */
 #define EM_OPENRISC     92     /* OpenRISC 32-bit embedded processor */
 #define EM_BLACKFIN     106     /* ADI Blackfin Processor */
+#define EM_ALTERA_NIOS2	113	/* Altera Nios II soft-core processor */
 #define EM_TI_C6000	140	/* TI C6X DSPs */
 #define EM_AARCH64	183	/* ARM 64 bit */
 #define EM_FRV		0x5441	/* Fujitsu FR-V */
-- 
1.8.2.1

