From: Jessica <jeyu@redhat.com>
Subject: [PATCH] vmlinux.lds: add missing VMLINUX_SYMBOL macros
Date: Mon,  3 Apr 2017 15:43:07 -0700
Message-ID: <1491259387-15869-1-git-send-email-jeyu@redhat.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33470 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751384AbdDCWnW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 3 Apr 2017 18:43:22 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>
Cc: Eddie Kovsky <ewk@edkovsky.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jessica Yu <jeyu@redhat.com>

From: Jessica Yu <jeyu@redhat.com>

When __{start,end}_ro_after_init is referenced from C code, we run into the
following build errors on blackfin:

  kernel/extable.c:169: undefined reference to `__start_ro_after_init'
  kernel/extable.c:169: undefined reference to `__end_ro_after_init'

The build error is due to the fact that blackfin is one of the few arches
that prepends an underscore '_' to all symbols defined in C. Fix this by
wrapping __{start,end}_ro_after_init in vmlinux.lds.h with VMLINUX_SYMBOL(),
which adds the necessary prefix for arches that have HAVE_UNDERSCORE_SYMBOL_PREFIX.

Signed-off-by: Jessica Yu <jeyu@redhat.com>
---
This patch is based on next-20170403.

 include/asm-generic/vmlinux.lds.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 979b573..54918ae 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -261,9 +261,9 @@
  */
 #ifndef RO_AFTER_INIT_DATA
 #define RO_AFTER_INIT_DATA						\
-	__start_ro_after_init = .;					\
+	VMLINUX_SYMBOL(__start_ro_after_init) = .;			\
 	*(.data..ro_after_init)						\
-	__end_ro_after_init = .;
+	VMLINUX_SYMBOL(__end_ro_after_init) = .;
 #endif
 
 /*
-- 
2.5.5
