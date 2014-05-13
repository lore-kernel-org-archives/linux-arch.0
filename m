Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2on0140.outbound.protection.outlook.com ([207.46.100.140]:48260
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759323AbaEMJFd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 13 May 2014 05:05:33 -0400
From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH 13/25] microblaze: Add 32 bit time_t and clock_t
Date: Tue, 13 May 2014 17:05:19 +0800
Message-ID: <1399971919-4450-1-git-send-email-lftan@altera.com>
In-Reply-To: <1399971456-3941-1-git-send-email-lftan@altera.com>
References: <1399971456-3941-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com, Michal Simek <monstr@monstr.eu>
Message-ID: <20140513090519.hpqRJH9C6pjmFql2yZQIo9jrgh2A-fW7egIOj9hGWaA@z>

Override time_t and clock_t in include/uapi/asm-generic.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 arch/microblaze/include/uapi/asm/posix_types.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/microblaze/include/uapi/asm/posix_types.h b/arch/microblaze/include/uapi/asm/posix_types.h
index 0e15039..20e5d98 100644
--- a/arch/microblaze/include/uapi/asm/posix_types.h
+++ b/arch/microblaze/include/uapi/asm/posix_types.h
@@ -4,6 +4,12 @@
 typedef unsigned short	__kernel_mode_t;
 #define __kernel_mode_t __kernel_mode_t
 
+typedef long	__kernel_time_t;
+#define __kernel_time_t __kernel_time_t
+
+typedef long	__kernel_clock_t;
+#define __kernel_clock_t __kernel_clock_t
+
 #include <asm-generic/posix_types.h>
 
 #endif /* _ASM_MICROBLAZE_POSIX_TYPES_H */
-- 
1.8.2.1

