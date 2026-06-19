Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC20383326
	for <linux-arch@vger.kernel.org>; Fri, 19 Jun 2026 13:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781875128; cv=none; b=acLH5jfmzIGbVKfDaiqI/XNo1pl6XzESFwpAGMPA4F5UgN//aZDNqw5x+sL/2XcJE7vTdnIksXKfdydKgjr4RdP9KLdIp3lcj6/kwa0YPf2HClH9hA9cKnahfOlX6OVkHl4oecRCR63+QQAJDRs/PN6LEq92L7x8K88Gwi5X5co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781875128; c=relaxed/simple;
	bh=MDbG+S/Z8krXJJlFw1gQodf6WnUzXmv53kfvXlef/7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RbhE3ybAi3visHGzA6HOYToWzsIZ1ng5T1S+Y7pYRtykxeU31yEHlc6wqO9npsVEnGCpBi2X1UN44Nv9HJJWxPj4rs6uhGWIZkkFFU3FTFA2Vfbm7m5nAGIVx0F6o9rNnlEWzGqjEyLnlQKenQ8pNlkEhrOUtDE3hbPZVSxGI90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P89VnKXU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P89VnKXU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781875125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7ZOAURrVgzN4GYE60PJpH05TuPRu7UAg7NhtgxSvWXw=;
	b=P89VnKXUrvc4a6JqWwiXUKBzQTokVWxjAD4cLCwvIJk4ewHvAudFd7BfMaQtWZ/68fxkPX
	SO4IgAhPG8yzsErxuNhieNnaYv3vM1jcoG0Kvlcc28ltSiX+0lWRwH0p/85MN60IAMh+jO
	UKnwExEKWirvmt2M2muPw8h3AKszUyA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-TcR5sl3SO3Cs4Oz-SAz1Kg-1; Fri,
 19 Jun 2026 09:18:41 -0400
X-MC-Unique: TcR5sl3SO3Cs4Oz-SAz1Kg-1
X-Mimecast-MFC-AGG-ID: TcR5sl3SO3Cs4Oz-SAz1Kg_1781875119
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 878031806D37;
	Fri, 19 Jun 2026 13:18:38 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 762F71800599;
	Fri, 19 Jun 2026 13:18:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Kairui Song <kasong@tencent.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Wei Xu <weixugc@google.com>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm: Replace __ASSEMBLY__ with __ASSEMBLER__ in memory management header files
Date: Fri, 19 Jun 2026 15:18:30 +0200
Message-ID: <20260619131830.229804-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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
 Note: This patch has been split from an earlier patch of mine
 to ease reviewing.

 include/asm-generic/fixmap.h        | 4 ++--
 include/asm-generic/getorder.h      | 4 ++--
 include/asm-generic/memory_model.h  | 4 ++--
 include/asm-generic/mmu.h           | 2 +-
 include/asm-generic/pgtable-nop4d.h | 4 ++--
 include/asm-generic/pgtable-nopmd.h | 4 ++--
 include/asm-generic/pgtable-nopud.h | 4 ++--
 include/linux/mmzone.h              | 4 ++--
 include/linux/pfn.h                 | 2 +-
 include/linux/pgtable.h             | 4 ++--
 10 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/asm-generic/fixmap.h b/include/asm-generic/fixmap.h
index 29cab7947980a..3ff832ebcea50 100644
--- a/include/asm-generic/fixmap.h
+++ b/include/asm-generic/fixmap.h
@@ -21,7 +21,7 @@
 #define __fix_to_virt(x)	(FIXADDR_TOP - ((x) << PAGE_SHIFT))
 #define __virt_to_fix(x)	((FIXADDR_TOP - ((x)&PAGE_MASK)) >> PAGE_SHIFT)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 /*
  * 'index to address' translation. If anyone tries to use the idx
  * directly without translation, we catch the bug with a NULL-deference
@@ -97,5 +97,5 @@ static inline unsigned long virt_to_fix(const unsigned long vaddr)
 #define set_fixmap_io(idx, phys) \
 	__set_fixmap(idx, phys, FIXMAP_PAGE_IO)
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* __ASM_GENERIC_FIXMAP_H */
diff --git a/include/asm-generic/getorder.h b/include/asm-generic/getorder.h
index f2979e3a96b60..875ccae196832 100644
--- a/include/asm-generic/getorder.h
+++ b/include/asm-generic/getorder.h
@@ -2,7 +2,7 @@
 #ifndef __ASM_GENERIC_GETORDER_H
 #define __ASM_GENERIC_GETORDER_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <linux/compiler.h>
 #include <linux/log2.h>
@@ -47,6 +47,6 @@ static __always_inline __attribute_const__ int get_order(unsigned long size)
 #endif
 }
 
-#endif	/* __ASSEMBLY__ */
+#endif	/* __ASSEMBLER__ */
 
 #endif	/* __ASM_GENERIC_GETORDER_H */
diff --git a/include/asm-generic/memory_model.h b/include/asm-generic/memory_model.h
index efa6610acbc79..fd74de50b0540 100644
--- a/include/asm-generic/memory_model.h
+++ b/include/asm-generic/memory_model.h
@@ -4,7 +4,7 @@
 
 #include <linux/pfn.h>
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 /*
  * supports 3 memory models.
@@ -86,6 +86,6 @@ static inline int pfn_valid(unsigned long pfn)
 #endif /* CONFIG_DEBUG_VIRTUAL */
 #define phys_to_page(phys)	pfn_to_page(PHYS_PFN(phys))
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif
diff --git a/include/asm-generic/mmu.h b/include/asm-generic/mmu.h
index 0618380375429..5f78971e3ac2c 100644
--- a/include/asm-generic/mmu.h
+++ b/include/asm-generic/mmu.h
@@ -6,7 +6,7 @@
  * This is the mmu.h header for nommu implementations.
  * Architectures with an MMU need something more complex.
  */
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 typedef struct {
 	unsigned long		end_brk;
 
diff --git a/include/asm-generic/pgtable-nop4d.h b/include/asm-generic/pgtable-nop4d.h
index 03b7dae47dd43..89c21f84cffbe 100644
--- a/include/asm-generic/pgtable-nop4d.h
+++ b/include/asm-generic/pgtable-nop4d.h
@@ -2,7 +2,7 @@
 #ifndef _PGTABLE_NOP4D_H
 #define _PGTABLE_NOP4D_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #define __PAGETABLE_P4D_FOLDED 1
 
@@ -54,5 +54,5 @@ static inline p4d_t *p4d_offset(pgd_t *pgd, unsigned long address)
 #undef  p4d_addr_end
 #define p4d_addr_end(addr, end)			(end)
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _PGTABLE_NOP4D_H */
diff --git a/include/asm-generic/pgtable-nopmd.h b/include/asm-generic/pgtable-nopmd.h
index 8ffd64e7a24cb..36b6490ed1808 100644
--- a/include/asm-generic/pgtable-nopmd.h
+++ b/include/asm-generic/pgtable-nopmd.h
@@ -2,7 +2,7 @@
 #ifndef _PGTABLE_NOPMD_H
 #define _PGTABLE_NOPMD_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm-generic/pgtable-nopud.h>
 
@@ -68,6 +68,6 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 #undef  pmd_addr_end
 #define pmd_addr_end(addr, end)			(end)
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 
 #endif /* _PGTABLE_NOPMD_H */
diff --git a/include/asm-generic/pgtable-nopud.h b/include/asm-generic/pgtable-nopud.h
index eb70c6d7ceff2..356cbfbaab247 100644
--- a/include/asm-generic/pgtable-nopud.h
+++ b/include/asm-generic/pgtable-nopud.h
@@ -2,7 +2,7 @@
 #ifndef _PGTABLE_NOPUD_H
 #define _PGTABLE_NOPUD_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 
 #include <asm-generic/pgtable-nop4d.h>
 
@@ -62,5 +62,5 @@ static inline pud_t *pud_offset(p4d_t *p4d, unsigned long address)
 #undef  pud_addr_end
 #define pud_addr_end(addr, end)			(end)
 
-#endif /* __ASSEMBLY__ */
+#endif /* __ASSEMBLER__ */
 #endif /* _PGTABLE_NOPUD_H */
diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 9adb2ad21da59..d0cf5c697548d 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_MMZONE_H
 #define _LINUX_MMZONE_H
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #ifndef __GENERATING_BOUNDS_H
 
 #include <linux/spinlock.h>
@@ -2400,5 +2400,5 @@ static inline unsigned long next_present_section_nr(unsigned long section_nr)
 #endif
 
 #endif /* !__GENERATING_BOUNDS.H */
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 #endif /* _LINUX_MMZONE_H */
diff --git a/include/linux/pfn.h b/include/linux/pfn.h
index b90ca0b6c331e..cfedf0f61bb3c 100644
--- a/include/linux/pfn.h
+++ b/include/linux/pfn.h
@@ -2,7 +2,7 @@
 #ifndef _LINUX_PFN_H_
 #define _LINUX_PFN_H_
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #include <linux/types.h>
 #endif
 
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 2981e386da7b3..dc804296d78f7 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -8,7 +8,7 @@
 #define PMD_ORDER	(PMD_SHIFT - PAGE_SHIFT)
 #define PUD_ORDER	(PUD_SHIFT - PAGE_SHIFT)
 
-#ifndef __ASSEMBLY__
+#ifndef __ASSEMBLER__
 #ifdef CONFIG_MMU
 
 #include <linux/mm_types.h>
@@ -2320,7 +2320,7 @@ static inline const char *pgtable_level_to_str(enum pgtable_level level)
 	}
 }
 
-#endif /* !__ASSEMBLY__ */
+#endif /* !__ASSEMBLER__ */
 
 #if !defined(MAX_POSSIBLE_PHYSMEM_BITS) && !defined(CONFIG_64BIT)
 #ifdef CONFIG_PHYS_ADDR_T_64BIT
-- 
2.54.0

