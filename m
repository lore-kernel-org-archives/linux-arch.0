Received: from outbound.ms.icloud.com (ms-2002i-snip4-11.eps.apple.com [57.103.74.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B084D344044
	for <linux-arch@vger.kernel.org>; Fri,  1 May 2026 05:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.74.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777614968; cv=none; b=qKlmv4HP85eAvjufD86+QcEHv6uFuHxTw5W6nRRh3I4uxWtnydbLtg+OpIuMqsLhmXWvSRVtNGeG8pb0bHn3Q1zmB22HPIxho2f/+RTcaiBiFd4nxlsLWg/SBCGPFQOesmaotAm1PhQJ7WrAJ5PeqxCbyG9yNThY/amKiU7tTsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777614968; c=relaxed/simple;
	bh=mSldpHJai9REeX+vx+yWlHrvE7oYWFwfDYJjROuxIwo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TxqSZFumy7K7frY9Zj5bL40lXoFqQHEmNgZ9OMb2XLvpstoYgUzKC/A0+XBzB/U9ePKNYQTDH2TCseWY2Ydlifj3xgcv+PHqcfvHL4ZQ3lfq4+VnMesd8BQaNHOgaS+j/h1MR/4zeRH5Am7W8eqF1puha/e3WxaAaGtb1pLHczs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=RL3aQBbh; arc=none smtp.client-ip=57.103.74.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="RL3aQBbh"
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-8 (Postfix) with ESMTPS id 3D2811800135;
	Fri, 01 May 2026 05:56:02 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQhAA0MFWgFeAUEdXwFLVxQEFEYGVg1dE0wLcwRUB10FXVZQAlpLVBQEFEYGVg1dE0wLcwRUB10FXVZQAlpLQBMESgZNXw5eHwQXRhlVBEceXVZeHhkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4EVAddBV1WUAJaS18ZXUUPXwdZBEAMSAJAQwNCL1oXREBBWh9BFEgDWARcBUQBSwReDytGFVcbVgNDRVEfVEYTGU4bV01QG18CQg8=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1777614966; x=1780206966; bh=IbSC559/qUR/nGvKKtd8DwOnbSEiDUOtMZLyC6A/T58=; h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:x-icloud-hme; b=RL3aQBbhZdMkY8FTaKdyZGveHZXnOv6ZLP26suA8fTGUYOk3urCFrdNIe0Tn5iES4B4VTwx1r1n94cM9XQmexmpy6rLqkhTVEn/0BVms3MFkCrFqmJe7FAa3Nfy/fs0WoSyNeghTmc1SLnSpgfiiA+EIReefMukb/BvRQRCUytyPRryOarMtJa7iD+h+hC2VQTt62wPo4K0FMQD2/AQityTg4VO4NmB4TmwvEJp+imhFmRtTHtbpKbw4uUvNN5pjUZCw6Z87LG33TzSfMFN/DlcCmM5HbErYW/m/gMRjVHEovSp5YkkkikaGB5a+EWZL8MtJkF2a7xQ/K3Aj1vX93A==
Received: from [127.0.0.1] (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-8 (Postfix) with ESMTPSA id 6E12E1800130;
	Fri, 01 May 2026 05:55:56 +0000 (UTC)
From: Luka Bai <lukafocus@icloud.com>
Date: Fri, 01 May 2026 13:55:42 +0800
Subject: [PATCH 1/5] mm: add basic madvise helpers and branch for THP setup
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-thp_cow-v1-1-005377483738@tencent.com>
References: <20260501-thp_cow-v1-0-005377483738@tencent.com>
In-Reply-To: <20260501-thp_cow-v1-0-005377483738@tencent.com>
To: linux-mm@kvack.org
Cc: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <npache@redhat.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Kairui Song <kasong@tencent.com>, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
 Luka Bai <lukabai@tencent.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777614950; l=6033;
 i=lukabai@tencent.com; s=20260501; h=from:subject:message-id;
 bh=qeYKGarfhCPQLyYwYSEdCT8XEQEucOGNFQFPA0gbSHc=;
 b=vX/BzBp7mBvxyfV6EAf9h1WJBBeiBTb9N1fh3Z29aoa6VlsaOOSphrrjZUqA1Ru2SsrPkYhUK
 BRGfhLLarZLBSghUt30uCias75yVmtIYgkRukCiZ9MsLeIWXIsKFzcA
X-Developer-Key: i=lukabai@tencent.com; a=ed25519;
 pk=KeaVteSWd00GIAjFyWZnuFsKAKixjga1ZkLMcI66nPM=
X-Authority-Info-Out: v=2.4 cv=YZywJgRf c=1 sm=1 tr=0 ts=69f44073
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10 a=UaoJkeuwEpQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=GvQkQWPkAAAA:8 a=WA886SfcoAClic5TCSgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDA1MyBTYWx0ZWRfX3XzkaOJxZwyt
 ZPI9TRSWqREvmUiF2QpMg0FtW4xDNgmIjP7bbw2W8mJKYpvI3V4pjS2ExPFtko5MfdxK2++bcaq
 p8nF3yEOysfKP25GQaL/1m5SuZemGq6XoptcaRxHxp6DcKrydTtEfmlpKzDhWnH3EnJhOvt2qYY
 RY7/hWluhGUafrxKhKyiB9ST2d9qGbwd+klWTFG+01cP7DFffrf2hS9dKAhdlwtwt+REFDgEun/
 KI0wGGIri4J5rYDKGFQv2YPGNTVh1RXR9GilC8QA0bcQBc9ZBjpZgDmTcGYgD+lrVFg6bpvysYJ
 uL6dhA7JgpM0/CUxzy54bqdUSPxP9T4CBAdmh72Lgm9pOb48mEbb9VvDs8tzIA=
X-Proofpoint-ORIG-GUID: 0D-T28gQiBVQg_2gi_am4Sqyi3f_sm_4
X-Proofpoint-GUID: 0D-T28gQiBVQg_2gi_am4Sqyi3f_sm_4

From: Luka Bai <lukabai@tencent.com>

Transparent huge page is now properly working with most of the mm
framework, and well fused with the folio concept that can be
reclaimed or allocated with a large order. However, its deed is not
very "estimable". For example, a THP is easily split in many path like
partially mapped, swap out or fork + COW(for child processes).

In some cases, we may want it to have some concluded result. Since
some workloads expect a relatively "stable" THP, while others may want
to save memory more rather than the performance benifits.

This patch adds some basic helpers and branch in madvise path so that
we can add madvise choices on THP to conduct what we do on different
types of operations like COW or swap that may split THP, on the level
of vma.

We transfer the type of configuration using parameters of madvise,
analyze it and save the result in vma->vm_flags for later use.

Currently the only operation in the list is COW. It decides whether
we want to use hugepages for the child process when it writes a spot
on the shared anonymous pmd so that we can make sure the THP not
being split after writing. This patch only adds the basic setup
helpers, the real usage will be added in the later patches.

Signed-off-by: Luka Bai <lukabai@tencent.com>
---
 include/linux/huge_mm.h                |  6 ++++++
 include/linux/mm.h                     | 19 +++++++++++++++++++
 include/uapi/asm-generic/mman-common.h |  9 +++++++++
 mm/madvise.c                           | 25 +++++++++++++++++++++++++
 4 files changed, 59 insertions(+)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 48496f09909b..a0ce8c0b81f5 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -6,6 +6,7 @@
 
 #include <linux/fs.h> /* only for vma_is_dax() */
 #include <linux/kobject.h>
+#include <uapi/asm-generic/mman-common.h>
 
 vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf);
 int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
@@ -363,6 +364,11 @@ static inline bool thp_disabled_by_hw(void)
 	return transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_UNSUPPORTED);
 }
 
+static inline bool madv_thp_cow(int behavior)
+{
+	return behavior & MADV_THP_COW;
+}
+
 unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags);
 unsigned long thp_get_unmapped_area_vmflags(struct file *filp, unsigned long addr,
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1d76da6e0791..8a800819cfa2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -391,6 +391,10 @@ enum {
 #else
 	DECLARE_VMA_BIT_ALIAS(STACK, GROWSDOWN),
 #endif
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+	DECLARE_VMA_BIT(THP_SETUP_1, 43),
+	DECLARE_VMA_BIT_ALIAS(THP_COW, THP_SETUP_1),
+#endif
 };
 #undef DECLARE_VMA_BIT
 #undef DECLARE_VMA_BIT_ALIAS
@@ -510,6 +514,9 @@ enum {
 #define VM_DROPPABLE		VM_NONE
 #define VMA_DROPPABLE		EMPTY_VMA_FLAGS
 #endif
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define VM_THP_COW	INIT_VM_FLAG(THP_COW)
+#endif
 
 /* Bits set in the VMA until the stack is in its final location */
 #define VM_STACK_INCOMPLETE_SETUP (VM_RAND_READ | VM_SEQ_READ | VM_STACK_EARLY)
@@ -4128,6 +4135,18 @@ extern int do_munmap(struct mm_struct *, unsigned long, size_t,
 		     struct list_head *uf);
 extern int do_madvise(struct mm_struct *mm, unsigned long start, size_t len_in, int behavior);
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static inline bool madv_thp_behavior(int behavior)
+{
+	return behavior >= MADV_THP_SETUP_BASE && behavior < MADV_THP_SETUP_END;
+}
+#else
+static inline bool madv_thp_behavior(int behavior)
+{
+	return false;
+}
+#endif
+
 #ifdef CONFIG_MMU
 extern int __mm_populate(unsigned long addr, unsigned long len,
 			 int ignore_errors);
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index ef1c27fa3c57..1617ed374503 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -82,6 +82,15 @@
 #define MADV_GUARD_INSTALL 102		/* fatal signal on access to range */
 #define MADV_GUARD_REMOVE 103		/* unguard range */
 
+/* for THP setup */
+#define MADV_THP_SETUP_BASE 256
+enum {
+	MADV_THP_COW_BIT,
+	MADV_THP_SETUP_MAX_BIT,
+};
+#define MADV_THP_COW        (MADV_THP_SETUP_BASE + (1 << MADV_THP_COW_BIT))
+#define MADV_THP_SETUP_END	(MADV_THP_SETUP_BASE + (1 << MADV_THP_SETUP_MAX_BIT))
+
 /* compatibility flags */
 #define MAP_FILE	0
 
diff --git a/mm/madvise.c b/mm/madvise.c
index 69708e953cf5..5dbfc89682d7 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1331,6 +1331,25 @@ static bool can_madvise_modify(struct madvise_behavior *madv_behavior)
 }
 #endif
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static vm_flags_t madvise_thp_setup(struct madvise_behavior *madv_behavior)
+{
+	int thp_behavior = madv_behavior->behavior - MADV_THP_SETUP_BASE;
+	struct vm_area_struct *vma = madv_behavior->vma;
+	vm_flags_t new_flags = vma->vm_flags;
+
+	if (madv_thp_cow(thp_behavior))
+		new_flags |= VM_THP_COW;
+
+	return new_flags;
+}
+#else
+static vm_flags_t madvise_thp_setup(struct madvise_behavior *madv_behavior)
+{
+	return madv_behavior->vma->vm_flags;
+}
+#endif
+
 /*
  * Apply an madvise behavior to a region of a vma.  madvise_update_vma
  * will handle splitting a vm area into separate areas, each area with its own
@@ -1427,6 +1446,10 @@ static int madvise_vma_behavior(struct madvise_behavior *madv_behavior)
 		break;
 	}
 
+	/* Handle THP behaviors */
+	if (madv_thp_behavior(behavior))
+		new_flags = madvise_thp_setup(madv_behavior);
+
 	/* This is a write operation.*/
 	VM_WARN_ON_ONCE(madv_behavior->lock_mode != MADVISE_MMAP_WRITE_LOCK);
 
@@ -1555,6 +1578,8 @@ madvise_behavior_valid(int behavior)
 		return true;
 
 	default:
+		if (madv_thp_behavior(behavior))
+			return true;
 		return false;
 	}
 }

-- 
2.52.0

