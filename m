Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2on0120.outbound.protection.outlook.com ([207.46.100.120]:55757
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759791AbaEMJEt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 13 May 2014 05:04:49 -0400
From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH 11/25] m68k: Add 32 bit time_t and clock_t
Date: Tue, 13 May 2014 17:03:50 +0800
Message-ID: <1399971830-4375-1-git-send-email-lftan@altera.com>
In-Reply-To: <1399971456-3941-1-git-send-email-lftan@altera.com>
References: <1399971456-3941-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org
Message-ID: <20140513090350.L9dAaZSp-dygG5zFaIcZpkzRMsQa17d11mpA7ZvaNlw@z>

Override time_t and clock_t in include/uapi/asm-generic.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 arch/m68k/include/uapi/asm/posix_types.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/m68k/include/uapi/asm/posix_types.h b/arch/m68k/include/uapi/asm/posix_types.h
index cf4dbf7..01e39fe 100644
--- a/arch/m68k/include/uapi/asm/posix_types.h
+++ b/arch/m68k/include/uapi/asm/posix_types.h
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
 
 #endif
-- 
1.8.2.1

