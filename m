Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-bn1on0111.outbound.protection.outlook.com ([157.56.110.111]:40262
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759653AbaEMJC7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 13 May 2014 05:02:59 -0400
From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH 04/25] avr32: Add 32 bit time_t and clock_t
Date: Tue, 13 May 2014 17:02:49 +0800
Message-ID: <1399971769-4116-1-git-send-email-lftan@altera.com>
In-Reply-To: <1399971456-3941-1-git-send-email-lftan@altera.com>
References: <1399971456-3941-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>
Message-ID: <20140513090249.lPSJql9gZudKuPZtxTzI2CNO50YENve6htvvDWpGcKI@z>

Override time_t and clock_t in include/uapi/asm-generic.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 arch/avr32/include/uapi/asm/posix_types.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/avr32/include/uapi/asm/posix_types.h b/arch/avr32/include/uapi/asm/posix_types.h
index 5b813a8..47d5146 100644
--- a/arch/avr32/include/uapi/asm/posix_types.h
+++ b/arch/avr32/include/uapi/asm/posix_types.h
@@ -32,6 +32,12 @@ typedef unsigned short  __kernel_old_gid_t;
 typedef unsigned short  __kernel_old_dev_t;
 #define __kernel_old_dev_t __kernel_old_dev_t
 
+typedef long __kernel_time_t;
+#define __kernel_time_t __kernel_time_t
+
+typedef long __kernel_clock_t;
+#define __kernel_clock_t __kernel_clock_t
+
 #include <asm-generic/posix_types.h>
 
 #endif /* _UAPI__ASM_AVR32_POSIX_TYPES_H */
-- 
1.8.2.1

