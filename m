From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 01/11] xtensa: kernel: add "asm/ftrace.h" for pass compiling
Date: Fri, 30 Aug 2013 19:34:53 +0400
Message-ID: <1377876903-27860-2-git-send-email-jcmvbkbc@gmail.com>
References: <1377876903-27860-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f52.google.com ([209.85.215.52]:57755 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756563Ab3H3PfO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 Aug 2013 11:35:14 -0400
Received: by mail-la0-f52.google.com with SMTP id ev20so1606007lab.25
        for <linux-arch@vger.kernel.org>; Fri, 30 Aug 2013 08:35:13 -0700 (PDT)
In-Reply-To: <1377876903-27860-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Marc Gauthier <marc@tensilica.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Chen Gang <gang.chen@asianux.com>, Max Filippov <jcmvbkbc@gmail.com>

From: Chen Gang <gang.chen@asianux.com>

Need add "asm/ftrace.h" for pass compiling.

Cross-compiler is compiled from binutils-2.23.2 and gcc-4.9.0 source.

The related error (with allmodconfig for fsf processor):

  arch/xtensa/kernel/xtensa_ksyms.c:129:15: error: '_mcount' undeclared here (not in a function)

Signed-off-by: Chen Gang <gang.chen@asianux.com>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/xtensa_ksyms.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/xtensa/kernel/xtensa_ksyms.c b/arch/xtensa/kernel/xtensa_ksyms.c
index d8507f8..316f008 100644
--- a/arch/xtensa/kernel/xtensa_ksyms.c
+++ b/arch/xtensa/kernel/xtensa_ksyms.c
@@ -32,6 +32,9 @@
 #include <net/checksum.h>
 #endif /* CONFIG_NET */
 
+#ifdef CONFIG_FUNCTION_TRACER
+#include <asm/ftrace.h>
+#endif /* CONFIG_FUNCTION_TRACER */
 
 /*
  * String functions
-- 
1.7.7.6
