Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41BB233927
	for <linux-arch@vger.kernel.org>; Fri, 19 Jun 2026 10:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781863571; cv=none; b=UR7p0aLxMJQjFu0KaWhePCxaT7o62nIfcp2rgHOdZ+AeOk4GAM/7CTFs1tpDyMJo76ARwKI+s/KEoWCHYwE3E7z1sLR9/3YBPNDQNCpZ+j0Vvcc78mUvK1yLarWOg+RTveZKwhmEptubCMEaUZyS7YSYqAsJD2DfbfNyMF3zKuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781863571; c=relaxed/simple;
	bh=7mH5fSE3wAHUp8AwVz5/+K9k44DC7qLn/TS4X0q18ok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qNIrJXaM62fX3bb4MmhF3WPXDxgIo/BAxhv1lw+p2sq3qEsOkcVnwEMkQHfm89+TxVe9v8zeNWrRHsoQieRbxgqGJT5N3YWZ2pMQnLFznH+rme8rwMHKDC4NTKKClilM65Jl611qiQjcikjb8z7uqFplAdKHU7L1VkryoZjfI38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EMxBLZlm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMxBLZlm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781863566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QAzbOgca5S8x4gEFRxZAOWickdRgJxv32szacvx2uNM=;
	b=EMxBLZlmTzM8TqUAgBO4O5gnUowjc4GeUCm47l5uJPmLLJtEweaVw5qYFgqspWtX1oZBX7
	2a91OTV9bmB7MmKsmrXwRJdIiQxH5r/L68+YDSXWMykfik8ZgxcO61Vx2xxI/2vs1nSn+U
	GNHceFMDy4wsiuWkBs7bbQye7TJ/0aA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-557-8jjY0dj8PiiDNP7qLsNBYw-1; Fri,
 19 Jun 2026 06:06:05 -0400
X-MC-Unique: 8jjY0dj8PiiDNP7qLsNBYw-1
X-Mimecast-MFC-AGG-ID: 8jjY0dj8PiiDNP7qLsNBYw_1781863564
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DCDB31955DD1;
	Fri, 19 Jun 2026 10:06:03 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D64A0195608A;
	Fri, 19 Jun 2026 10:06:01 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Subject: [PATCH] vdso: Replace __ASSEMBLY__ with __ASSEMBLER__ in header files
Date: Fri, 19 Jun 2026 12:06:00 +0200
Message-ID: <20260619100600.121042-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

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

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Note: This patch has been split from an earlier bigger patch of mine
       to ease reviewing.

 include/asm-generic/vdso/vsyscall.h | 4 ++--
 include/vdso/datapage.h             | 6 +++---
 include/vdso/helpers.h              | 4 ++--
 include/vdso/processor.h            | 4 ++--
 include/vdso/vsyscall.h             | 4 ++--
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/vsyscall.h
index 5c6d9799f4e74..a6b03cfba0e24 100644
--- a/include/asm-generic/vdso/vsyscall.h
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_GENERIC_VSYSCALL_H
 #define __ASM_GENERIC_VSYSCALL_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #ifndef __arch_get_vdso_u_time_data
 static __always_inline const struct vdso_time_data *__arch_get_vdso_u_time_data(void)
@@ -30,6 +30,6 @@ static __always_inline void __arch_sync_vdso_time_data(struct vdso_time_data *vd
 }
 #endif /* __arch_sync_vdso_time_data */
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* __ASM_GENERIC_VSYSCALL_H */
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 5977723fb3b5d..09897f76ae07a 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -2,7 +2,7 @@
 #ifndef __VDSO_DATAPAGE_H
 #define __VDSO_DATAPAGE_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/types.h>
 
@@ -176,7 +176,7 @@ enum vdso_pages {
 	VDSO_NR_PAGES
 };
 
-#else /* !__ASSEMBLY__ */
+#else /* !__ASSEMBLER__ */
 
 #ifdef CONFIG_VDSO_GETRANDOM
 #define __vdso_u_rng_data	PROVIDE(vdso_u_rng_data = vdso_u_data + 2 * PAGE_SIZE);
@@ -197,6 +197,6 @@ enum vdso_pages {
 	__vdso_u_arch_data					\
 
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* __VDSO_DATAPAGE_H */
diff --git a/include/vdso/helpers.h b/include/vdso/helpers.h
index a3bf4f1c0d37d..65151b681c4f5 100644
--- a/include/vdso/helpers.h
+++ b/include/vdso/helpers.h
@@ -2,7 +2,7 @@
 #ifndef __VDSO_HELPERS_H
 #define __VDSO_HELPERS_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/barrier.h>
 #include <vdso/datapage.h>
@@ -111,6 +111,6 @@ static __always_inline void vdso_write_end(struct vdso_time_data *vd)
 	vdso_write_seq_end(&vc[CS_RAW]);
 }
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* __VDSO_HELPERS_H */
diff --git a/include/vdso/processor.h b/include/vdso/processor.h
index fbe8265ea3c49..cc781912a696e 100644
--- a/include/vdso/processor.h
+++ b/include/vdso/processor.h
@@ -5,10 +5,10 @@
 #ifndef __VDSO_PROCESSOR_H
 #define __VDSO_PROCESSOR_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/vdso/processor.h>
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* __VDSO_PROCESSOR_H */
diff --git a/include/vdso/vsyscall.h b/include/vdso/vsyscall.h
index b0fdc9c6bf439..c5c2a2c078571 100644
--- a/include/vdso/vsyscall.h
+++ b/include/vdso/vsyscall.h
@@ -2,13 +2,13 @@
 #ifndef __VDSO_VSYSCALL_H
 #define __VDSO_VSYSCALL_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm/vdso/vsyscall.h>
 
 unsigned long vdso_update_begin(void);
 void vdso_update_end(unsigned long flags);
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #endif /* __VDSO_VSYSCALL_H */
-- 
2.54.0

