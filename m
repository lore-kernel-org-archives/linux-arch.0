Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD97A47AF66
	for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2026 10:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787308494; cv=none; b=sE2I0iyMbaGrW2ideuJ1ZY7oNi60j7LXpr5jfSQYTJ/29TLsedyvp858T2LTly3bT6RaINdOuVICJQ4QIWa+G7xfDGOHgDWPfECK1F1T/JrAEjQQNfnN4jvtVqa7tF/8WmPu/g4DJaIr7EO9WgNYiDwLhUyMpFqZa1lr57TFtgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787308494; c=relaxed/simple;
	bh=nJ9ZdMVZUq6xpa2HjhVFobdnS/YOu1VKKff88UhZT6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pHg1QgHVGO+t4jp9gFaynwDlWKE3jBlhEfuObDf4/Amb6OHXFIs18CGnVMsixu6m7/wJ67Wvp2fy8+cNEC7LoAupd2jO5KEcWc0BoOB9mMJsK64hmJT9cwutblW5zycHJ6MVU0/mpRJFiFx3dO6jRMLRTcKK1vkWEWpy4pzIn04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OiPrnqED; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OiPrnqED"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787308479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SVmdgHIqpepTo9tw9rpgU8IF5BoPiJVVG+7cU4oMJss=;
	b=OiPrnqEDMEkMkI5whYsfSinbf5mRoUfoPbMYix1qpLr+VspjrQKAhpT13majIfpYEwisjD
	ylCVS1HA8219gXyf7dtH/GKF9N9KxyZYy9/QEUTGn4wbfhUDwsYos2cjJosSUePZ82Cxoa
	Jfuomx1p6GZ+lKp2m+N3BOMbh4KG/js=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-DLJP01uDMxi4ZQXlCADAQA-1; Fri,
 21 Aug 2026 06:34:30 -0400
X-MC-Unique: DLJP01uDMxi4ZQXlCADAQA-1
X-Mimecast-MFC-AGG-ID: DLJP01uDMxi4ZQXlCADAQA_1787308469
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 027A21955BEE;
	Fri, 21 Aug 2026 10:34:29 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.162])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D793A3002D26;
	Fri, 21 Aug 2026 10:34:26 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] asm-generic: Replace __ASSEMBLY__ with __ASSEMBLER__ in uapi headers
Date: Fri, 21 Aug 2026 12:34:25 +0200
Message-ID: <20260821103425.246901-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

__ASSEMBLY__ is only defined by the Makefile of the kernel, so
this is not really useful for uapi headers (unless the userspace
Makefile defines it, too). Let's switch to __ASSEMBLER__ which
gets set automatically by the compiler when compiling assembly
code.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Note: This has been split from an earlier bigger patch of mine into
       this separate patch to ease reviewing

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
2.55.0

