Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2on0125.outbound.protection.outlook.com ([207.46.100.125]:29627
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1759732AbaEMJDc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 13 May 2014 05:03:32 -0400
From: Ley Foon Tan <lftan@altera.com>
Subject: [PATCH 08/25] frv: Add 32 bit time_t and clock_t
Date: Tue, 13 May 2014 17:03:07 +0800
Message-ID: <1399971787-4263-1-git-send-email-lftan@altera.com>
In-Reply-To: <1399971456-3941-1-git-send-email-lftan@altera.com>
References: <1399971456-3941-1-git-send-email-lftan@altera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ley Foon Tan <lftan@altera.com>, lftan.linux@gmail.com, cltang@codesourcery.com, David Howells <dhowells@redhat.com>
Message-ID: <20140513090307.KrPydE_Hnge6muxycEg8txgD7ua7S1GixSgrgBCNI8Q@z>

Override time_t and clock_t in include/uapi/asm-generic.

Signed-off-by: Ley Foon Tan <lftan@altera.com>
---
 arch/frv/include/uapi/asm/posix_types.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/frv/include/uapi/asm/posix_types.h b/arch/frv/include/uapi/asm/posix_types.h
index fe512af..0a837e6 100644
--- a/arch/frv/include/uapi/asm/posix_types.h
+++ b/arch/frv/include/uapi/asm/posix_types.h
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

