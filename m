Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io1-f68.google.com ([209.85.166.68]:40909 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388840AbfGSEUD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Jul 2019 00:20:03 -0400
Received: by mail-io1-f68.google.com with SMTP id h6so55661645iom.7
        for <linux-arch@vger.kernel.org>; Thu, 18 Jul 2019 21:20:03 -0700 (PDT)
Date: Thu, 18 Jul 2019 21:20:01 -0700 (PDT)
From: Paul Walmsley <paul.walmsley@sifive.com>
Subject: [PATCH] riscv: enable sys_clone3 syscall for rv64
Message-ID: <alpine.DEB.2.21.9999.1907182118500.7083@viisi.sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, christian@brauner.io
Message-ID: <20190719042001.i-ZbEmSa3JzGZM3hZm9gaqofjr4p9iFlHyAt4-h4O8g@z>


Enable the sys_clone3 syscall for RV64.  We simply include the generic
version.

Tested by running the program from

   https://lore.kernel.org/lkml/20190716130631.tohj4ub54md25dys@brauner.io/

and verifying that it completes successfully.

Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Christian Brauner <christian@brauner.io>
---
 arch/riscv/include/uapi/asm/unistd.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/include/uapi/asm/unistd.h b/arch/riscv/include/uapi/asm/unistd.h
index 0e2eeeb1fd27..13ce76cc5aff 100644
--- a/arch/riscv/include/uapi/asm/unistd.h
+++ b/arch/riscv/include/uapi/asm/unistd.h
@@ -18,6 +18,7 @@
 #ifdef __LP64__
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_SET_GET_RLIMIT
+#define __ARCH_WANT_SYS_CLONE3
 #endif /* __LP64__ */
 
 #include <asm-generic/unistd.h>
-- 
2.22.0
