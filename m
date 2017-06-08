From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v2] refcount: Create unchecked atomic_t implementation
Date: Wed, 7 Jun 2017 19:58:31 -0700
Message-ID: <20170608025831.GA43608@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:36792 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751441AbdFHC6e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Jun 2017 22:58:34 -0400
Received: by mail-pg0-f43.google.com with SMTP id a70so11274337pge.3
        for <linux-arch@vger.kernel.org>; Wed, 07 Jun 2017 19:58:34 -0700 (PDT)
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>, Peter Zijlstra <peterz@infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jannh@google.com>, Eric Biggers <ebiggers3@gmail.com>, Elena Reshetova <elena.reshetova@intel.com>, Hans Liljestrand <ishkamiel@gmail.com>, David Windsor <dwindsor@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>, arozansk@redhat.com, Davidlohr Bueso <dave@stgolabs.net>, Manfred Spraul <manfred@colorfullife.com>, "axboe@kernel.dk" <axboe@kernel.dk>, James Bottomley <James.Bottomley@hansenpartnership.com>"x86@kernel.org" <x>

Many subsystems will not use refcount_t unless there is a way to build the
kernel so that there is no regression in speed compared to atomic_t. This
adds CONFIG_REFCOUNT_FULL to enable the full refcount_t implementation
which has the validation but is slightly slower. When not enabled,
refcount_t uses the basic unchecked atomic_t routines, which results in
no code changes compared to just using atomic_t directly.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
This is v2 of this patch, which I've split from the arch-specific
alternative implementation for x86. Getting this patch in will unblock
atomic_t -> refcount_t conversion, and the x86 alternative implementation
can be developed in parallel. Changes from v1: use better atomic ops,
thanks to Elena and Peter.
---
 arch/Kconfig             |  9 +++++++++
 include/linux/refcount.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
 lib/refcount.c           |  3 +++
 3 files changed, 56 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 6c00e5b00f8b..fba3bf186728 100644
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
+	  implementation, which can be slower but provides protections
+	  against various use-after-free conditions that can be used in
+	  security flaw exploits.
+
 source "kernel/gcov/Kconfig"
diff --git a/include/linux/refcount.h b/include/linux/refcount.h
index b34aa649d204..099c32bd07b2 100644
--- a/include/linux/refcount.h
+++ b/include/linux/refcount.h
@@ -41,6 +41,7 @@ static inline unsigned int refcount_read(const refcount_t *r)
 	return atomic_read(&r->refs);
 }
 
+#ifdef CONFIG_REFCOUNT_FULL
 extern __must_check bool refcount_add_not_zero(unsigned int i, refcount_t *r);
 extern void refcount_add(unsigned int i, refcount_t *r);
 
@@ -52,6 +53,49 @@ extern void refcount_sub(unsigned int i, refcount_t *r);
 
 extern __must_check bool refcount_dec_and_test(refcount_t *r);
 extern void refcount_dec(refcount_t *r);
+#else
+static inline __must_check bool refcount_add_not_zero(unsigned int i,
+						      refcount_t *r)
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
+static inline __must_check bool refcount_sub_and_test(unsigned int i,
+						      refcount_t *r)
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
index 9f906783987e..5d0582a9480c 100644
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
-- 
2.7.4


-- 
Kees Cook
Pixel Security
