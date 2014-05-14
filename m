Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2on0147.outbound.protection.outlook.com ([207.46.100.147]:37062
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752983AbaENDgZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 13 May 2014 23:36:25 -0400
From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH 24/25] x86: Add 32 bit time_t and clock_t
Date: Wed, 14 May 2014 11:36:16 +0800
Message-ID: <1400038576-6027-1-git-send-email-lftan@altera.com>
In-Reply-To: <1399971456-3941-1-git-send-email-lftan@altera.com>
References: <1399971456-3941-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Message-ID: <20140514033616.o96TUNZrpYgD19-9jk2vK37gxBk9r6FOgWyOtptVHl8@z>

Override time_t and clock_t in include/uapi/asm-generic.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 arch/x86/include/uapi/asm/posix_types_32.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/uapi/asm/posix_types_32.h b/arch/x86/include/uapi/asm/posix_types_32.h
index 8e52505..b6b7e3b 100644
--- a/arch/x86/include/uapi/asm/posix_types_32.h
+++ b/arch/x86/include/uapi/asm/posix_types_32.h
@@ -20,6 +20,12 @@ typedef unsigned short	__kernel_gid_t;
 typedef unsigned short	__kernel_old_dev_t;
 #define __kernel_old_dev_t __kernel_old_dev_t
 
+typedef long	__kernel_time_t;
+#define __kernel_time_t __kernel_time_t
+
+typedef long	__kernel_clock_t;
+#define __kernel_clock_t __kernel_clock_t
+
 #include <asm-generic/posix_types.h>
 
 #endif /* _ASM_X86_POSIX_TYPES_32_H */
-- 
1.8.2.1

