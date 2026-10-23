Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792738224;
	b=HTL4xbOAiZzLiH8YBPPgXSZ6XJMztEVA9ae2GqZj7aTtyxkOnfKXF2ou2XlX/U3jvwOu
	 kIaJZx7rg/hRMQ7EP3CKleAvXuaMiGptbqNGYR3aPWgIt7zLomk1bsdOVsQDXLFlGpOcq
	 G6rQmA2PX4IKi37NXiu4gqQHIeFBEyBxpHvbGjG4n3iGyzSFCkA9hD/+Ridpobs/mlu45
	 EhtnCgmMpUL+B0RBUwBSN0odziBwGBluEIutQNtG+10TBBi9/q24U3NypTw5bvtSR4Mcd
	 aFd94qIN92AWxQSCvkGiTTGJOKhBeSQTyu7T57CHLaesCmb22GM6ZpWSLxpeRUz2pQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792738224;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=zOPcyFbcw1UU/rJPmKSSRntH9qu/8Cc9l655f2GYy5w=;
	b=TQQntV2cNOL8N/tmOhW96EgaRZT5Rd8kKU2A0rEKUsB10GsiSAPzBcT/Jys7AE5fxa/T
	 gROupcyfjNn1+uHM/UcMzFu28K2gXiOSDpNyOHTFlVVvUcApiFLUOUYY7m0xvKtOj+ehF
	 uGUtuRAlDnAApS3tD9WJ5WV65+DHnWrcFpGx0r3W/mE27KhhpC0pjmRO6j0hadaKq2X7B
	 Zk7gbbmFsltfKm2fVNW/4uws22BpR4KBEEf50g6Wi08ihsJv7tkbfwbxfrYFV7lxWtlb1
	 9gh+99DheQWZB65JmPObjV4UsSi4TTGHWJlO0eDCe6iI/3gL+ysEuWYjTOrcHxrYYqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hkwIq7yc;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F271560A2602
	for <linux-arch@vger.kernel.org>; Fri, 23 Oct 2026 06:50:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F271560A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hkwIq7yc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792738223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zOPcyFbcw1UU/rJPmKSSRntH9qu/8Cc9l655f2GYy5w=;
	b=hkwIq7ycHYlmM6BZV63RP8VFa2vW2RJF2kx6r7nzgKn/Yy8KyXqA/11IoFsMxWqv/NCBEJ
	py1w66s4aV6oJrMFX4QPFCbnTuZKh3M+uq2q32eeeilNed9lCUAtr6to/p4gITydLug6wQ
	pzBNPZql2MjfG7fLnC7D/MBjuBNtpJg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-EVBzjS2wMNS-cpFfn82bVA-1; Fri,
 23 Oct 2026 02:50:18 -0400
X-MC-Unique: EVBzjS2wMNS-cpFfn82bVA-1
X-Mimecast-MFC-AGG-ID: EVBzjS2wMNS-cpFfn82bVA_1792738216
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9BACC195609D;
	Fri, 23 Oct 2026 06:50:16 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.42])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 332471956095;
	Fri, 23 Oct 2026 06:50:12 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>
Cc: soc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-arch@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v5 11/13] asm-generic: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
Date: Fri, 23 Oct 2026 08:48:48 +0200
Message-ID: <20261023064908.66707-12-thuth@redhat.com>
In-Reply-To: <20261023064908.66707-1-thuth@redhat.com>
References: <20261023064908.66707-1-thuth@redhat.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

While the GCC and Clang compilers already define __ASSEMBLER__ auto-
matically when compiling assembly code, __ASSEMBLY__ is a macro that
only gets defined by the Makefiles in the kernel. This can be very
confusing when switching between userspace and kernelspace coding, or
when dealing with uapi headers that rather should use __ASSEMBLER__
instead. Let's standardize now on the __ASSEMBLER__ macro to avoid
this confusion.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
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
2.56.0

