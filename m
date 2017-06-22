From: tip-bot for Kees Cook <tipbot@zytor.com>
Subject: [tip:locking/core] locking/refcount: Create unchecked atomic_t
 implementation
Date: Thu, 22 Jun 2017 04:07:33 -0700
Message-ID: <tip-87f7583e9205fe5220677d0775f3a4d2b8fe8827@git.kernel.org>
References: <20170621200026.GA115679@beast>
Reply-To: davem@davemloft.net, akpm@linux-foundation.org,
          tglx@linutronix.de, adobriyan@gmail.com,
          gregkh@linuxfoundation.org, ebiederm@xmission.com,
          James.Bottomley@hansenpartnership.com, jannh@google.com,
          jpoimboe@redhat.com, peterz@infradead.org, ebiggers3@gmail.com,
          elena.reshetova@intel.com, linux-kernel@vger.kernel.org,
          manfred@colorfullife.com, torvalds@linux-foundation.org,
          arnd@arndb.de, keescook@chromium.org, dave@stgolabs.net,
          linux-arch@vger.kernel.org, hch@infradead.org,
          dwindsor@gmail.com, mingo@kernel.org, serge@hallyn.com,
          hpa@zytor.com, ishkamiel@gmail.com, riel@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([65.50.211.136]:41147 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752827AbdFVLQU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 22 Jun 2017 07:16:20 -0400
In-Reply-To: <20170621200026.GA115679@beast>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: elena.reshetova@intel.com, ebiggers3@gmail.com, jpoimboe@redhat.com, jannh@google.com, peterz@infradead.org, ebiederm@xmission.com, gregkh@linuxfoundation.org, James.Bottomley@hansenpartnership.com, davem@davemloft.net, adobriyan@gmail.com, tglx@linutronix.de, akpm@linux-foundation.org, ishkamiel@gmail.com, hpa@zytor.com, mingo@kernel.org, serge@hallyn.com, riel@redhat.com, linux-arch@vger.kernel.org, dwindsor@gmail.com, hch@infradead.org, keescook@chromium.org, arnd@arndb.de, torvalds@linux-foundation.org, dave@stgolabs.net, linux-kernel@vger.kernel.org, manfred@colorfullife.com

Commit-ID:  87f7583e9205fe5220677d0775f3a4d2b8fe8827
Gitweb:     http://git.kernel.org/tip/87f7583e9205fe5220677d0775f3a4d2b8fe8827
Author:     Kees Cook <keescook@chromium.org>
AuthorDate: Wed, 21 Jun 2017 13:00:26 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Thu, 22 Jun 2017 10:36:25 +0200

locking/refcount: Create unchecked atomic_t implementation

Many subsystems will not use refcount_t unless there is a way to build the
kernel so that there is no regression in speed compared to atomic_t. This
adds CONFIG_REFCOUNT_FULL to enable the full refcount_t implementation
which has the validation but is slightly slower. When not enabled,
refcount_t uses the basic unchecked atomic_t routines, which results in
no code changes compared to just using atomic_t directly.

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: David Windsor <dwindsor@gmail.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Elena Reshetova <elena.reshetova@intel.com>
Cc: Eric Biggers <ebiggers3@gmail.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Hans Liljestrand <ishkamiel@gmail.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Jann Horn <jannh@google.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Manfred Spraul <manfred@colorfullife.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Serge E. Hallyn <serge@hallyn.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: arozansk@redhat.com
Cc: axboe@kernel.dk
Cc: linux-arch <linux-arch@vger.kernel.org>
Link: http://lkml.kernel.org/r/20170621200026.GA115679@beast
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/Kconfig             |  9 +++++++++
 include/linux/refcount.h | 42 ++++++++++++++++++++++++++++++++++++++++++
 lib/refcount.c           |  3 +++
 3 files changed, 54 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 6c00e5b..f76b214 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -867,4 +867,13 @@ config STRICT_MODULE_RWX
 config ARCH_WANT_RELAX_ORDER
 	bool
 
+config REFCOUNT_FULL
+	bool "Perform full reference count validation at the expense of speed"
+	help
+	  Enabling this switches the refcounting infrastructure from a fast
+	  unchecked atomic_t implementation to a fully state checked
+	  implementation, which can be (slightly) slower but provides protections
+	  against various use-after-free conditions that can be used in
+	  security flaw exploits.
+
 source "kernel/gcov/Kconfig"
diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index b34aa64..bb71f28 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -41,6 +41,7 @@ static inline unsigned int refcount_read(const refcount_t *r)
 	return atomic_read(&r->refs);
 }
 
+#ifdef CONFIG_REFCOUNT_FULL
 extern __must_check bool refcount_add_not_zero(unsigned int i, refcount_t *r);
 extern void refcount_add(unsigned int i, refcount_t *r);
 
@@ -52,6 +53,47 @@ extern void refcount_sub(unsigned int i, refcount_t *r);
 
 extern __must_check bool refcount_dec_and_test(refcount_t *r);
 extern void refcount_dec(refcount_t *r);
+#else
+static inline __must_check bool refcount_add_not_zero(unsigned int i, refcount_t *r)
+{
+	return atomic_add_unless(&r->refs, i, 0);
+}
+
+static inline void refcount_add(unsigned int i, refcount_t *r)
+{
+	atomic_add(i, &r->refs);
+}
+
+static inline __must_check bool refcount_inc_not_zero(refcount_t *r)
+{
+	return atomic_add_unless(&r->refs, 1, 0);
+}
+
+static inline void refcount_inc(refcount_t *r)
+{
+	atomic_inc(&r->refs);
+}
+
+static inline __must_check bool refcount_sub_and_test(unsigned int i, refcount_t *r)
+{
+	return atomic_sub_and_test(i, &r->refs);
+}
+
+static inline void refcount_sub(unsigned int i, refcount_t *r)
+{
+	atomic_sub(i, &r->refs);
+}
+
+static inline __must_check bool refcount_dec_and_test(refcount_t *r)
+{
+	return atomic_dec_and_test(&r->refs);
+}
+
+static inline void refcount_dec(refcount_t *r)
+{
+	atomic_dec(&r->refs);
+}
+#endif /* CONFIG_REFCOUNT_FULL */
 
 extern __must_check bool refcount_dec_if_one(refcount_t *r);
 extern __must_check bool refcount_dec_not_one(refcount_t *r);
diff --git a/lib/refcount.c b/lib/refcount.c
index 9f90678..5d0582a 100644
--- a/lib/refcount.c
+++ b/lib/refcount.c
@@ -37,6 +37,8 @@
 #include <linux/refcount.h>
 #include <linux/bug.h>
 
+#ifdef CONFIG_REFCOUNT_FULL
+
 /**
  * refcount_add_not_zero - add a value to a refcount unless it is 0
  * @i: the value to add to the refcount
@@ -225,6 +227,7 @@ void refcount_dec(refcount_t *r)
 	WARN_ONCE(refcount_dec_and_test(r), "refcount_t: decrement hit 0; leaking memory.\n");
 }
 EXPORT_SYMBOL(refcount_dec);
+#endif /* CONFIG_REFCOUNT_FULL */
 
 /**
  * refcount_dec_if_one - decrement a refcount if it is 1
