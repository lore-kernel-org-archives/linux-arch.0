From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v3] refcount: Create unchecked atomic_t implementation
Date: Wed, 21 Jun 2017 13:00:26 -0700
Message-ID: <20170621200026.GA115679@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:36190 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751883AbdFUUA3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jun 2017 16:00:29 -0400
Received: by mail-pf0-f174.google.com with SMTP id q86so5728368pfl.3
        for <linux-arch@vger.kernel.org>; Wed, 21 Jun 2017 13:00:28 -0700 (PDT)
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, Peter Zijlstra <peterz@infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jann Horn <jannh@google.com>, Eric Biggers <ebiggers3@gmail.com>, Elena Reshetova <elena.reshetova@intel.com>, Hans Liljestrand <ishkamiel@gmail.com>, David Windsor <dwindsor@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Alexey Dobriyan <adobriyan@gmail.com>, "Serge E. Hallyn" <serge@hallyn.com>, arozansk@redhat.com, Davidlohr Bueso <dave@stgolabs.net>, Manfred Spraul <manfred@colorfullife.com>, "axboe@kernel.dk" <axboe@kernel.dk>, James Bottomley <James.Bottomley@hansenpartner>

Many subsystems will not use refcount_t unless there is a way to build the
kernel so that there is no regression in speed compared to atomic_t. This
adds CONFIG_REFCOUNT_FULL to enable the full refcount_t implementation
which has the validation but is slightly slower. When not enabled,
refcount_t uses the basic unchecked atomic_t routines, which results in
no code changes compared to just using atomic_t directly.

Signed-off-by: Kees Cook <keescook@chromium.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v3: unbreak slightly long lines; Ingo. Add Greg's Ack.
v2: use better atomic ops; Elena and Peter.
---
 arch/Kconfig             |  9 +++++++++
 include/linux/refcount.h | 42 ++++++++++++++++++++++++++++++++++++++++++
 lib/refcount.c           |  3 +++
 3 files changed, 54 insertions(+)

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
index b34aa649d204..bb71f2871dac 100644
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
