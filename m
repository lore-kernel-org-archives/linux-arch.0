Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607EF48AE17;
	Mon, 21 Sep 2026 10:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988311; cv=none; b=gm1N8JE0E7/6aookkBJYG+XQc+75KpvNd6N4sde81ZIFL6ULC8SYMFdT/GJgCcKqcHup/cQ0Q/0Pz2JdCqUcT32dtwpMhGI0XQ+Oc1f8LvSF0LxDEv9eDMvCLANRC9HbodauT/eWIeQcZejOzXCXu4hf+dh20DnH7Hl59cEmvqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988311; c=relaxed/simple;
	bh=fSF1q0uZ2D6D7eSotmHP8T3BZdnaiPG7UdplRIp/5/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VhAHokSqnxZw7KmxOW8AR3vCPX4355Q803aryuBAAP7t9RvcTJXXN0ULM1LgunUpdQLwyYw5wi/4gctyXPqtl9wJtoH0Ebd/YXVtALGc2kDdrIHzrDpokx/2yZvg3OPFBr3mHKq3pNFaUoueH3v8qkMZHflHeAZtZqkIykJczKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=X3s/HhVM; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="X3s/HhVM"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D1441CE0;
	Mon, 21 Sep 2026 03:58:26 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD2943F9AB;
	Mon, 21 Sep 2026 03:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789988309; bh=fSF1q0uZ2D6D7eSotmHP8T3BZdnaiPG7UdplRIp/5/4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=X3s/HhVMmwzSQHhqq9MFWj0m6FUOVQG5sixXBNURROyV6ePF/1f5WSnJzpvwZBNK1
	 QqsYNRvkgifOqK8lofwytBap6NlT+LrwggMFa6+2446aU5pOoBTY1kIi1cGTtqCZTN
	 uHkua1WMDV/dmcg1aD+uOrvLGLVf0dKrwSWDm1Ag=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Mon, 21 Sep 2026 11:55:38 +0100
Subject: [PATCH 16/21] openrisc/pgtable: drop __pmd_offset()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-dummy_ptxp3-v1-16-cd40cf68242e@arm.com>
References: <20260921-dummy_ptxp3-v1-0-cd40cf68242e@arm.com>
In-Reply-To: <20260921-dummy_ptxp3-v1-0-cd40cf68242e@arm.com>
To: Russell King <linux@armlinux.org.uk>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>, 
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>, 
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
 Wei Xu <weixugc@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, Tianrui Zhao <zhaotianrui@loongson.cn>, 
 Bibo Mao <maobibo@loongson.cn>, Anup Patel <anup@brainfault.org>, 
 Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Dave Hansen <dave.hansen@linux.intel.com>, 
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Jonas Bonn <jonas@southpole.se>, 
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
 Stafford Horne <shorne@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
 linux-openrisc@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=883; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=HHmjFCiPkfuAa6Yg+gCAN1VqpmgkbnXOKSW8+pCvqDs=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqsQ1SPbcNzmztqXWyqwma14L9CzqkX4tJ7x7vo
 vWbJ/HD30CJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCarENUgAKCRBt1cPRWsUx
 M4PADAC4wQdqV+mgxWbIBoHOjsRsIdJ4n1uUYYBv3wqYHNgh5+2Lk0XLqzv6zPlZye8658zEGXj
 vgxv0IMjozo9kMQmRzUvCUgqElgfOwU8DUeEQsA3jlvHIGAwe+qRaQ0TO2J/59o6qpcHgJbdXh+
 z/NlcJc72jKMSnH9rNqp4ajPHyXuddYrsjENQBZPndlr23wfYGGcWekO6uC2NH2OLbvRUOOySX9
 FdxnXJVw3frabk+zVNtsYakl4/mWXZrhXG/zWh3Jnvq+4m6Dv0K4EUAtlRwizkYXph78QlNH4I1
 R63HWezZlORLk45PXkp9zwMCQmssS+rzDgQf5tMm3+uvh8QGnqinH/0+s+zCmR4NZSeFg0JYM/9
 Y2NbE8DNZ95kpUtUWkPyYG/9VYQNEejRP8eCknF95Fy7xSmh1ANcZfr515q2JunHbDNQJBtNjpr
 g4qJObrzFSR+5ZGT/ylRR9xgwQuj6B6Ug3pDRerJOBlq011A/stSkRMHiOCGWaN60k+y8=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

From: "David Hildenbrand (Arm)" <david@kernel.org>

The macro is unused, and will collide with a folded page table helper.
Let's just remove it.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/openrisc/include/asm/pgtable.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/openrisc/include/asm/pgtable.h b/arch/openrisc/include/asm/pgtable.h
index 13afcc0bd8631..7fceed641610c 100644
--- a/arch/openrisc/include/asm/pgtable.h
+++ b/arch/openrisc/include/asm/pgtable.h
@@ -331,9 +331,6 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
 	return ((unsigned long) __va(pmd_val(pmd) & PAGE_MASK));
 }
 
-#define __pmd_offset(address) \
-	(((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
-
 #define PFN_PTE_SHIFT		PAGE_SHIFT
 #define pte_pfn(x)		((unsigned long)(((x).pte)) >> PAGE_SHIFT)
 #define pfn_pte(pfn, prot)  __pte((((pfn) << PAGE_SHIFT)) | pgprot_val(prot))

-- 
2.43.0

