From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: [PATCH] bug: Recursion avoidance for WARN_ONCE() and friends
Date: Wed, 18 Mar 2015 16:51:27 +0000
Message-ID: <1426697487-2515-1-git-send-email-daniel.thompson@linaro.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f176.google.com ([74.125.82.176]:35977 "EHLO
	mail-we0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964962AbbCRQvo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 18 Mar 2015 12:51:44 -0400
Received: by wetk59 with SMTP id k59so37121454wet.3
        for <linux-arch@vger.kernel.org>; Wed, 18 Mar 2015 09:51:43 -0700 (PDT)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, patches@linaro.org, linaro-kernel@lists.linaro.org, John Stultz <john.stultz@linaro.org>, Sumit Semwal <sumit.semwal@linaro.org>

Currently WARN_ONCE() and similar macros set __warned *after* calling
the underlying macro. This risks infinite recursion if WARN_ONCE() is
used to implement sanity tests in any code that can be called by printk.

This can be fixed by restructuring the macros to set __warned before
calling further macros.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---

Notes:
    I discovered this problem when I temporarily added sanity tests to the
    irqflags macros during some of my development work but I suspect the
    scope is a little wider. I admit I was tempted to throw this change
    away after I had finished debugging but for two things prompted me to
    post it.
    
     1. It did cost me a few minutes head scratching and I'd like to spare
        others the pain.
    
     2. I realized the new code is potentially (and very fractionally) more
        efficient: the register containing address of __warned can be reused
        and a cache hit is a near certainty for the write.
    
    Don't get too excited about the efficiency gains though they are
    extremely modest. Measures as code size benefit and using v4.0-rc4 the
    results are:
    
    Kernel                  GCC version             Code size reduction
    
    arm multi_v7_defconfig  Linaro 4.8-2014.01      224 bytes
    arm64 defconfig         Linaro 4.9-2014.09       32 bytes
    i386_defconfig          Redhat 4.9.2-6           62 bytes
    x86_64_defconfig        Redhat 4.9.2-6          380 bytes
    

 include/asm-generic/bug.h | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 630dd2372238..f8c8a819c563 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -110,9 +110,10 @@ extern void warn_slowpath_null(const char *file, const int line);
 	static bool __section(.data.unlikely) __warned;		\
 	int __ret_warn_once = !!(condition);			\
 								\
-	if (unlikely(__ret_warn_once))				\
-		if (WARN_ON(!__warned)) 			\
-			__warned = true;			\
+	if (unlikely(__ret_warn_once) && !__warned) {		\
+		__warned = true;				\
+		WARN_ON(true);					\
+	}							\
 	unlikely(__ret_warn_once);				\
 })

@@ -120,9 +121,10 @@ extern void warn_slowpath_null(const char *file, const int line);
 	static bool __section(.data.unlikely) __warned;		\
 	int __ret_warn_once = !!(condition);			\
 								\
-	if (unlikely(__ret_warn_once))				\
-		if (WARN(!__warned, format)) 			\
-			__warned = true;			\
+	if (unlikely(__ret_warn_once) && !__warned) {		\
+		__warned = true;				\
+		WARN(true, format);				\
+	}							\
 	unlikely(__ret_warn_once);				\
 })

@@ -130,9 +132,10 @@ extern void warn_slowpath_null(const char *file, const int line);
 	static bool __section(.data.unlikely) __warned;		\
 	int __ret_warn_once = !!(condition);			\
 								\
-	if (unlikely(__ret_warn_once))				\
-		if (WARN_TAINT(!__warned, taint, format))	\
-			__warned = true;			\
+	if (unlikely(__ret_warn_once) && !__warned) {		\
+		__warned = true;				\
+		WARN_TAINT(true, taint, format);		\
+	}							\
 	unlikely(__ret_warn_once);				\
 })

--
2.1.0
