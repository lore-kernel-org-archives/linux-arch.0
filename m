Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2on0136.outbound.protection.outlook.com ([207.46.100.136]:33204
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759816AbaEMJGe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 13 May 2014 05:06:34 -0400
From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH 20/25] score: Add 32 bit time_t and clock_t
Date: Tue, 13 May 2014 17:06:23 +0800
Message-ID: <1399971983-4707-1-git-send-email-lftan@altera.com>
In-Reply-To: <1399971456-3941-1-git-send-email-lftan@altera.com>
References: <1399971456-3941-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com, Chen Liqin <liqin.linux@gmail.com>, Lennox Wu <lennox.wu@gmail.com>
Message-ID: <20140513090623.X-kbVQ38AtHgBSXOtfjK7-QAvJ0jy8mTfuHjXX3w9Jo@z>

Override time_t and clock_t in include/uapi/asm-generic.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 arch/score/include/uapi/asm/posix_types.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/score/include/uapi/asm/posix_types.h b/arch/score/include/uapi/asm/posix_types.h
index b88acf8..4c3843a 100644
--- a/arch/score/include/uapi/asm/posix_types.h
+++ b/arch/score/include/uapi/asm/posix_types.h
@@ -1,6 +1,12 @@
 #ifndef _ASM_SCORE_POSIX_TYPES_H
 #define _ASM_SCORE_POSIX_TYPES_H
 
+typedef long	__kernel_time_t;
+#define __kernel_time_t __kernel_time_t
+
+typedef long	__kernel_clock_t;
+#define __kernel_clock_t __kernel_clock_t
+
 #include <asm-generic/posix_types.h>
 
 #endif /* _ASM_SCORE_POSIX_TYPES_H */
-- 
1.8.2.1

