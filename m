From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 03/17] xtensa: fix build warning from gcc-4.7.2
Date: Thu, 17 Oct 2013 02:42:14 +0400
Message-ID: <1381963348-29448-4-git-send-email-jcmvbkbc@gmail.com>
References: <1381963348-29448-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:61191 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758776Ab3JPWmv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 Oct 2013 18:42:51 -0400
Received: by mail-lb0-f177.google.com with SMTP id w7so1183159lbi.22
        for <linux-arch@vger.kernel.org>; Wed, 16 Oct 2013 15:42:49 -0700 (PDT)
In-Reply-To: <1381963348-29448-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Marc Gauthier <marc@tensilica.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>

This fixes the following build warning:

arch/xtensa/include/asm/vectors.h:70:5: warning: "XCHAL_HAVE_VECBASE" is not defined [-Wundef]

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/vectors.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/xtensa/include/asm/vectors.h b/arch/xtensa/include/asm/vectors.h
index c52b656..6e0efa1 100644
--- a/arch/xtensa/include/asm/vectors.h
+++ b/arch/xtensa/include/asm/vectors.h
@@ -67,6 +67,10 @@
 						VECBASE_RESET_VADDR)
 #define RESET_VECTOR1_VADDR		XC_VADDR(RESET_VECTOR1_VECOFS)
 
+#ifndef XCHAL_HAVE_VECBASE
+#define XCHAL_HAVE_VECBASE 0
+#endif
+
 #if XCHAL_HAVE_VECBASE
 
 #define USER_VECTOR_VADDR		XC_VADDR(XCHAL_USER_VECOFS)
-- 
1.8.1.4
