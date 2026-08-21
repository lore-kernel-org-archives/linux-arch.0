Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EAC3C9ED6
	for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2026 08:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302341; cv=none; b=aKMpgZ3bBKS1IjbkwTPSdCVUjeJxWV4GqIaHegDXh1AAkBiS1VyErbSTC7+QNTRwEl1AVkkql9LsADY+98O0jEH5kFWYQ2vZ9P3FfVW9WSA4prdzx6v3fl7L0zD7GaBBzEfOq1wik+mIwrYiXkV0AtltR9gmRTz7rUjqeligAWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302341; c=relaxed/simple;
	bh=ptOk5rNbwDdxCLoLTdf9BJZGjgL3VJQl95mTEcxKkHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SX7xq4uoALoJ2vhstR15ag4lqlrK8i5bV3gffZ5orVrLQLJUiaTezvGKsUoa/O8yuGnr8tnc1I3vQ2M80EBRAobBUw8iLBMckUEcU418s63rFf+UMDjzkoMeIy5FGc20baEW7c9HntseNj6SY60IjD+FuEwl0RO5SLfG1FrJJQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sz1IhHX5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sz1IhHX5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787302339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pa0NEa3jPJe1eRqI1se7jpHEMtXxLfmGRHLYNYTWV1s=;
	b=Sz1IhHX5Mg7xDbYRVF8H+5QY52C4n4eHGA24GW+DJ+lF+SIFdwrCKjGM3JGoCueuB7d875
	O5anBhOJk9dsdy+5AYD9r7pSj/1dqQkdiMSyuhDmahInZl9D0h6JTyXkHttwU6YDHxW2U4
	IlmxTpHqmwq6l+yrbJxiXVfRluZ1phk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-kCTcbK9xOECpBClb-PC7dw-1; Fri,
 21 Aug 2026 04:52:05 -0400
X-MC-Unique: kCTcbK9xOECpBClb-PC7dw-1
X-Mimecast-MFC-AGG-ID: kCTcbK9xOECpBClb-PC7dw_1787302324
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 41B3818001E2;
	Fri, 21 Aug 2026 08:52:04 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.129])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A01697D8;
	Fri, 21 Aug 2026 08:52:02 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] asm-generic: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
Date: Fri, 21 Aug 2026 10:52:01 +0200
Message-ID: <20260821085201.226650-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

While the GCC and Clang compilers already define __ASSEMBLER__ auto-
matically when compiling assembly code, __ASSEMBLY__ is a macro that
only gets defined by the Makefiles in the kernel. This can be very
confusing when switching between userspace and kernelspace coding, or
when dealing with uapi headers that rather should use __ASSEMBLER__
instead. Let's standardize now on the __ASSEMBLER__ macro to avoid
this confusion.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Note: This has been split from an earlier bigger patch of mine into
       this separate patch to ease reviewing

 include/asm-generic/barrier.h         | 4 ++--
 include/asm-generic/bug.h             | 4 ++--
 include/asm-generic/current.h         | 2 +-
 include/asm-generic/error-injection.h | 2 +-
 include/asm-generic/int-ll64.h        | 6 +++---
 include/asm-generic/rwonce.h          | 4 ++--
 include/asm-generic/signal.h          | 4 ++--
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index b99cb57dfcccc..c029b1e1854c4 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -11,7 +11,7 @@
 #ifndef __ASM_GENERIC_BARRIER_H
 #define __ASM_GENERIC_BARRIER_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/compiler.h>
 #include <linux/kcsan-checks.h>
@@ -302,5 +302,5 @@ do {									\
 # define smp_mb__after_switch_mm()	smp_mb()
 #endif
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 #endif /* __ASM_GENERIC_BARRIER_H */
diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 09e8eccee8ed9..044ebc96f373c 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -26,7 +26,7 @@
 #endif
 #endif /* WARN_CONDITION_STR */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/panic.h>
 #include <linux/printk.h>
 
@@ -258,6 +258,6 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 # define WARN_ON_SMP(x)			({0;})
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif
diff --git a/include/asm-generic/current.h b/include/asm-generic/current.h
index 9c2aeecbd05a6..8e7d8f019377f 100644
--- a/include/asm-generic/current.h
+++ b/include/asm-generic/current.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_GENERIC_CURRENT_H
 #define __ASM_GENERIC_CURRENT_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/thread_info.h>
 
 #define get_current() (current_thread_info()->task)
diff --git a/include/asm-generic/error-injection.h b/include/asm-generic/error-injection.h
index b05253f68eaa5..0a9ec33fa8f20 100644
--- a/include/asm-generic/error-injection.h
+++ b/include/asm-generic/error-injection.h
@@ -2,7 +2,7 @@
 #ifndef _ASM_GENERIC_ERROR_INJECTION_H
 #define _ASM_GENERIC_ERROR_INJECTION_H
 
-#if defined(__KERNEL__) && !defined(__ASSEMBLY__)
+#if defined(__KERNEL__) && !defined(__ASSEMBLER__)
 enum {
 	EI_ETYPE_NULL,		/* Return NULL if failure */
 	EI_ETYPE_ERRNO,		/* Return -ERRNO if failure */
diff --git a/include/asm-generic/int-ll64.h b/include/asm-generic/int-ll64.h
index a248545f1e18c..58974e8abbfae 100644
--- a/include/asm-generic/int-ll64.h
+++ b/include/asm-generic/int-ll64.h
@@ -11,7 +11,7 @@
 #include <uapi/asm-generic/int-ll64.h>
 
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 typedef __s8  s8;
 typedef __u8  u8;
@@ -31,7 +31,7 @@ typedef __u64 u64;
 #define S64_C(x) x ## LL
 #define U64_C(x) x ## ULL
 
-#else /* __ASSEMBLY__ */
+#else /* __ASSEMBLER__ */
 
 #define S8_C(x)  x
 #define U8_C(x)  x
@@ -42,6 +42,6 @@ typedef __u64 u64;
 #define S64_C(x) x
 #define U64_C(x) x
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _ASM_GENERIC_INT_LL64_H */
diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
index 52b969c7cef93..c35b262ee4223 100644
--- a/include/asm-generic/rwonce.h
+++ b/include/asm-generic/rwonce.h
@@ -20,7 +20,7 @@
 #ifndef __ASM_GENERIC_RWONCE_H
 #define __ASM_GENERIC_RWONCE_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/compiler_types.h>
 #include <linux/kasan-checks.h>
@@ -94,5 +94,5 @@ unsigned long read_word_at_a_time(const void *addr)
 	return *(unsigned long *)addr;
 }
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif	/* __ASM_GENERIC_RWONCE_H */
diff --git a/include/asm-generic/signal.h b/include/asm-generic/signal.h
index 663dd6d0795dc..392e59fd3d8b9 100644
--- a/include/asm-generic/signal.h
+++ b/include/asm-generic/signal.h
@@ -4,10 +4,10 @@
 
 #include <uapi/asm-generic/signal.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/sigcontext.h>
 #undef __HAVE_ARCH_SIG_BITOPS
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_GENERIC_SIGNAL_H */
-- 
2.55.0

