Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792738214;
	b=XWQXo7vMJJgyLO1NjKViAjZcX10hiD5GNY7Nt3Nh53LvsAWvxOfRUbbW7/aLLJOV+hFQ
	 HurZFbxBTl9vFjJvs5He4g53+kgJNrPcHe7Dntc59co+eiTHmfWg37G0DGD8cZtkO0p33
	 QWIV49iRiptgYXLFwxWmXLcD0AtvH56vi7brNtJT6tqZJr+oCRoibQ6vW/bc4MH/GrlLz
	 cDBDR1HBWA2AvyvOhCm71yyXudk+gMGiboN4JWKRD5pUsq9laZ8dsHfMVw/IwnfedQVky
	 jQtcJxwmuXy/Ie2aHHvPrVc+ZwuEg4JZvqfg/4wRUN4XokrdDeLOeKsmgJYpSK9PT+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792738214;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=Z641pHU/TL767Lgshu5uv+TKwfXbtAaHhrBzBTUMnh4=;
	b=EOqI6+dM3Ya4oxo0xdUg+anK6P32uwWCBHG7hLP1j6zX19h6TWO2Kk/bOTSNa05pGLLS
	 zCS2EQIaTBLIMgLHgR7wPduxVmTLAiCAeMK/WJbiLgy4oOfQi7vlLor7ngILU2FWNS/gF
	 JVP3AdtZ/jAp+HgLNyo+XA70OVWSY2/xuAfg0wyETEGp4fmaDixMnySPVqei+ohssMEwu
	 y/x/kp8HzdQ55yQjLzLgus/yBgL7O7Fa+fMOlowcptTTlwN4z3/EE2Arx7yfxYROtgcgi
	 burROTcVoPNmwQ/fdMi28X6BmumQksXAmLWnmi6qTrfP79wwwWuZOFGS/rLr+ZsBuCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GDJAbEy1;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEF8606A333
	for <linux-arch@vger.kernel.org>; Fri, 23 Oct 2026 06:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FEF8606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GDJAbEy1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792738212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z641pHU/TL767Lgshu5uv+TKwfXbtAaHhrBzBTUMnh4=;
	b=GDJAbEy17TK+DbBehWOBGi4lNMdoGLLjoioSDA2+ini4OtNOAEtFft2omMzJ1krbT8tcGQ
	aDXzcy7z9o6Na565rWk06naE2sNmhgiOgFZIxpKxvTexE7YEx/EpFCly8wRjgXRti52U8U
	fyBIwKVk+FaV5M4nJzRqAca0/lhIIVQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-NjHFXYQsMW2RjGlRu4EJnw-1; Fri,
 23 Oct 2026 02:50:08 -0400
X-MC-Unique: NjHFXYQsMW2RjGlRu4EJnw-1
X-Mimecast-MFC-AGG-ID: NjHFXYQsMW2RjGlRu4EJnw_1792738206
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E7BF19560BE;
	Fri, 23 Oct 2026 06:50:06 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.42])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 185DF1956095;
	Fri, 23 Oct 2026 06:50:03 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>
Cc: soc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	linux-arch@vger.kernel.org
Subject: [PATCH v5 09/13] asm-generic: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
Date: Fri, 23 Oct 2026 08:48:46 +0200
Message-ID: <20261023064908.66707-10-thuth@redhat.com>
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

__ASSEMBLY__ is only defined by the Makefile of the kernel, so
this is not really useful for uapi headers (unless the userspace
Makefile defines it, too). Let's switch to __ASSEMBLER__ which
gets set automatically by the compiler when compiling assembly
code.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/uapi/asm-generic/int-l64.h     | 4 ++--
 include/uapi/asm-generic/int-ll64.h    | 4 ++--
 include/uapi/asm-generic/signal-defs.h | 2 +-
 include/uapi/asm-generic/signal.h      | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/uapi/asm-generic/int-l64.h b/include/uapi/asm-generic/int-l64.h
index ed8bcd99c34d7..f840806bbe7e9 100644
--- a/include/uapi/asm-generic/int-l64.h
+++ b/include/uapi/asm-generic/int-l64.h
@@ -11,7 +11,7 @@
 
 #include <asm/bitsperlong.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /*
  * __xx is ok: it doesn't pollute the POSIX namespace. Use these in the
  * header files exported to user space
@@ -29,7 +29,7 @@ typedef unsigned int __u32;
 typedef __signed__ long __s64;
 typedef unsigned long __u64;
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 
 #endif /* _UAPI_ASM_GENERIC_INT_L64_H */
diff --git a/include/uapi/asm-generic/int-ll64.h b/include/uapi/asm-generic/int-ll64.h
index 1ed06964257c3..4fc3e882bcff9 100644
--- a/include/uapi/asm-generic/int-ll64.h
+++ b/include/uapi/asm-generic/int-ll64.h
@@ -11,7 +11,7 @@
 
 #include <asm/bitsperlong.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /*
  * __xx is ok: it doesn't pollute the POSIX namespace. Use these in the
  * header files exported to user space
@@ -34,7 +34,7 @@ typedef __signed__ long long __s64;
 typedef unsigned long long __u64;
 #endif
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 
 #endif /* _UAPI_ASM_GENERIC_INT_LL64_H */
diff --git a/include/uapi/asm-generic/signal-defs.h b/include/uapi/asm-generic/signal-defs.h
index 7572f2f46ee89..4073143fa3dae 100644
--- a/include/uapi/asm-generic/signal-defs.h
+++ b/include/uapi/asm-generic/signal-defs.h
@@ -78,7 +78,7 @@
 #define SIG_SETMASK        2	/* for setting the signal mask */
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 typedef void __signalfn_t(int);
 typedef __signalfn_t __user *__sighandler_t;
 
diff --git a/include/uapi/asm-generic/signal.h b/include/uapi/asm-generic/signal.h
index 0eb69dc8e5722..6b089d4b2965b 100644
--- a/include/uapi/asm-generic/signal.h
+++ b/include/uapi/asm-generic/signal.h
@@ -57,7 +57,7 @@
 #define SIGSTKSZ	8192
 #endif
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 typedef struct {
 	unsigned long sig[_NSIG_WORDS];
 } sigset_t;
@@ -88,6 +88,6 @@ typedef struct sigaltstack {
 	__kernel_size_t ss_size;
 } stack_t;
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _UAPI__ASM_GENERIC_SIGNAL_H */
-- 
2.56.0

