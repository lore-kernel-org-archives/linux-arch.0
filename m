From: Will Deacon <will@kernel.org>
Subject: [RFC PATCH 1/8] compiler/gcc: Emit build-time warning for GCC prior to version 4.8
Date: Fri, 10 Jan 2020 16:56:29 +0000
Message-ID: <20200110165636.28035-2-will@kernel.org>
References: <20200110165636.28035-1-will@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728258AbgAJQ4p (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 Jan 2020 11:56:45 -0500
In-Reply-To: <20200110165636.28035-1-will@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, kernel-team@android.com, Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Peter Zijlstra <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Segher Boessenkool <segher@kernel.crashing.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Arnd Bergmann <arnd@arndb.de>

Prior to version 4.8, GCC may miscompile READ_ONCE() by erroneously
discarding the 'volatile' qualifier:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145

We've been working around this using some nasty hacks which make
READ_ONCE() both horribly complicated and also prevent us from enforcing
that it is only used on scalar types. Since GCC 4.8 is pretty old for
kernel builds now, emit a warning if we detect it during the build.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 include/linux/compiler-gcc.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index d7ee4c6bad48..62afe874073e 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -14,6 +14,10 @@
 # error Sorry, your compiler is too old - please upgrade it.
 #endif
 
+#if GCC_VERSION < 40800
+# warning Your compiler is old and may miscompile the kernel due to https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145 - please upgrade it.
+#endif
+
 /* Optimization barrier */
 
 /* The "volatile" is due to gcc bugs */
-- 
2.25.0.rc1.283.g88dfdc4193-goog
