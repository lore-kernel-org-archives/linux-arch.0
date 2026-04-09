Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CE63B4EAA
	for <linux-arch@vger.kernel.org>; Thu,  9 Apr 2026 09:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775728065; cv=none; b=UBQfoZfZUCRA9QJa6N+J8fLW8yf36abkuLv13Ax3cOl8eh/nP5LZf4tz6Ne3soSF3XGIHcqhL4ZymbQGRAY25o0iJpJ/lAjdl4K4uhBZbu5KTI4I2phLCaZKKJKg9sduEaQP8WFy7QFOFBass7nQoI1ewkqoXq7w8hXApaDWxcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775728065; c=relaxed/simple;
	bh=54is0oMS0GkWO2wIBITumaiGry+fIR3a6jixHOrGhVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cgNkAkrCrQWbxB/Rtv2Y7fa3mVgVlcH0xqB7RbK/waunLa4tuomaEKHQJviNq9Err5+o7YMw9Q//ErxJkb+knM5GMWC3oOG85TAmxtTRCINJpp6JQlSoCgqtL3zt257Ia0fsLg8WkyvEcNoPFZBBPyLek+tIbCyS32rIsUjws1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FhhPr3Wd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FhhPr3Wd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775728062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AMJ8yTqXhB6GZdnLCeiTiJGnstUnb+3axkKWVN6VMQc=;
	b=FhhPr3WdfQQxhGwW4aGy41y4vS4hjAVyX9Cw6/QecmJqjFCWZNMjlhhoq/g6hT71P/PKYN
	l260bj546th0hlJ4Gx3BZ9xVTITzAQqMS8XTj+L8W16aHzISTCUnDU8nFgisvQtd6hxxFq
	UlZLLbQt7guEj0JTIcBfwJ3HDPvpajs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-Bj71LVZdM0CXS1RjBxJdqw-1; Thu,
 09 Apr 2026 05:47:38 -0400
X-MC-Unique: Bj71LVZdM0CXS1RjBxJdqw-1
X-Mimecast-MFC-AGG-ID: Bj71LVZdM0CXS1RjBxJdqw_1775728057
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 811291800365;
	Thu,  9 Apr 2026 09:47:37 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.48.155])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 978A830001BE;
	Thu,  9 Apr 2026 09:47:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Thomas Huth <thuth@redhat.com>,
	linux-hexagon@vger.kernel.org,
	Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v5 4/8] hexagon: Replace __ASSEMBLY__ with __ASSEMBLER__ in non-uapi headers
Date: Thu,  9 Apr 2026 11:47:04 +0200
Message-ID: <20260409094708.1687376-5-thuth@redhat.com>
In-Reply-To: <20260409094708.1687376-1-thuth@redhat.com>
References: <20260409094708.1687376-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Thomas Huth <thuth@redhat.com>

While the GCC and Clang compilers already define __ASSEMBLER__
automatically when compiling assembly code, __ASSEMBLY__ is a
macro that only gets defined by the Makefiles in the kernel.
This can be very confusing when switching between userspace
and kernelspace coding, or when dealing with uapi headers that
rather should use __ASSEMBLER__ instead. So let's standardize now
on the __ASSEMBLER__ macro that is provided by the compilers.

This is a completely mechanical patch (done with a simple "sed -i"
statement).

Cc: linux-hexagon@vger.kernel.org
Acked-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/hexagon/include/asm/hexagon_vm.h  |  4 ++--
 arch/hexagon/include/asm/mem-layout.h  |  6 +++---
 arch/hexagon/include/asm/page.h        |  4 ++--
 arch/hexagon/include/asm/processor.h   |  4 ++--
 arch/hexagon/include/asm/thread_info.h | 12 ++++++------
 5 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/hexagon/include/asm/hexagon_vm.h b/arch/hexagon/include/asm/hexagon_vm.h
index 9aa2493fe7863..e1e702eb9e12a 100644
--- a/arch/hexagon/include/asm/hexagon_vm.h
+++ b/arch/hexagon/include/asm/hexagon_vm.h
@@ -39,7 +39,7 @@
 #define HVM_TRAP1_VMGETREGS		22
 #define HVM_TRAP1_VMTIMEROP		24
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 enum VM_CACHE_OPS {
 	hvmc_ickill,
@@ -178,7 +178,7 @@ static inline long __vmintop_clear(long i)
 
 #else /* Only assembly code should reference these */
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * Constants for virtual instruction parameters and return values
diff --git a/arch/hexagon/include/asm/mem-layout.h b/arch/hexagon/include/asm/mem-layout.h
index e2f99413fe56e..8bad920d8928a 100644
--- a/arch/hexagon/include/asm/mem-layout.h
+++ b/arch/hexagon/include/asm/mem-layout.h
@@ -25,7 +25,7 @@
  */
 
 #ifdef CONFIG_HEXAGON_PHYS_OFFSET
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 extern unsigned long	__phys_offset;
 #endif
 #define PHYS_OFFSET	__phys_offset
@@ -44,7 +44,7 @@ extern unsigned long	__phys_offset;
 #define STACK_TOP			TASK_SIZE
 #define STACK_TOP_MAX			TASK_SIZE
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 enum fixed_addresses {
 	FIX_KMAP_BEGIN,
 	FIX_KMAP_END,  /*  check for per-cpuism  */
@@ -101,7 +101,7 @@ extern int max_kernel_seg;
  * and pkmap_base begins.
  */
 #define VMALLOC_END (PKMAP_BASE-PAGE_SIZE*2)
-#endif /*  !__ASSEMBLY__  */
+#endif /*  !__ASSEMBLER__  */
 
 
 #endif /* _ASM_HEXAGON_MEM_LAYOUT_H */
diff --git a/arch/hexagon/include/asm/page.h b/arch/hexagon/include/asm/page.h
index f0aed3ed812b9..3ef447f10b47d 100644
--- a/arch/hexagon/include/asm/page.h
+++ b/arch/hexagon/include/asm/page.h
@@ -48,7 +48,7 @@
 #include <vdso/page.h>
 
 #ifdef __KERNEL__
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * This is for PFN_DOWN, which mm.h needs.  Seems the right place to pull it in.
@@ -127,7 +127,7 @@ static inline unsigned long virt_to_pfn(const void *kaddr)
 /* XXX Todo: implement assembly-optimized version of getorder. */
 #include <asm-generic/getorder.h>
 
-#endif /* ifdef __ASSEMBLY__ */
+#endif /* ifdef __ASSEMBLER__ */
 #endif /* ifdef __KERNEL__ */
 
 #endif
diff --git a/arch/hexagon/include/asm/processor.h b/arch/hexagon/include/asm/processor.h
index 0cd39c2cdf8f7..b93c2cc4be22e 100644
--- a/arch/hexagon/include/asm/processor.h
+++ b/arch/hexagon/include/asm/processor.h
@@ -8,7 +8,7 @@
 #ifndef _ASM_PROCESSOR_H
 #define _ASM_PROCESSOR_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/mem-layout.h>
 #include <asm/registers.h>
@@ -124,6 +124,6 @@ struct hexagon_switch_stack {
 	unsigned long		lr;
 };
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif
diff --git a/arch/hexagon/include/asm/thread_info.h b/arch/hexagon/include/asm/thread_info.h
index e90f280b9ce3e..a0da6c694c87b 100644
--- a/arch/hexagon/include/asm/thread_info.h
+++ b/arch/hexagon/include/asm/thread_info.h
@@ -10,7 +10,7 @@
 
 #ifdef __KERNEL__
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <asm/processor.h>
 #include <asm/registers.h>
 #include <asm/page.h>
@@ -20,7 +20,7 @@
 #define THREAD_SIZE		(1<<THREAD_SHIFT)
 #define THREAD_SIZE_ORDER	(THREAD_SHIFT - PAGE_SHIFT)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * This is union'd with the "bottom" of the kernel stack.
@@ -47,13 +47,13 @@ struct thread_info {
 	unsigned long		sp;
 };
 
-#else /* !__ASSEMBLY__ */
+#else /* !__ASSEMBLER__ */
 
 #include <asm/asm-offsets.h>
 
-#endif  /* __ASSEMBLY__  */
+#endif  /* __ASSEMBLER__  */
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define INIT_THREAD_INFO(tsk)                   \
 {                                               \
@@ -73,7 +73,7 @@ struct thread_info {
 register struct thread_info *__current_thread_info asm(QUOTED_THREADINFO_REG);
 #define current_thread_info()  __current_thread_info
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 /*
  * thread information flags
-- 
2.53.0

