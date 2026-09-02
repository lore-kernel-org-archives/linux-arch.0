Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70057488207;
	Wed,  2 Sep 2026 11:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788350248; cv=none; b=djURdvz5pSgdjf5d++3JU8EOeN61jejcYJ8E5/ZyQsNOhR7canO9hRt5S4Fa/ekYrv64GLDsi03/KgWDBPCS18BHPX3abXHZBsrC2W5m7L+C4i2oBdoVWwoHLwlDE7G9U2mJZUw4Lg7WKnybJCYKr/nZgestvPc6MwSU2WJO+Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788350248; c=relaxed/simple;
	bh=Wt0Z/oRBkZT86NkETNbvCPFl/jDrFm+0ICRcmx2Gpw4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r8nl0YCJ1TJclJ6rMhZ2u4hrvadYEcT3mgXP7mZoBCvXwuqAmsfrybcKxbQZjHDGrgQ2pZN4urAjX+AbY4L/l0pq9hpuyjFt1aUjo+bP2vidqV0UydW0jKv7fYkOqvNrtPaS1OuDiVa+LL6X/zsxfWlzRzJki7XC4mtgcVlCiSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QlfFMcIg; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QlfFMcIg"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F91A1684;
	Wed,  2 Sep 2026 04:57:09 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AFCC3F85F;
	Wed,  2 Sep 2026 04:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788350233; bh=Wt0Z/oRBkZT86NkETNbvCPFl/jDrFm+0ICRcmx2Gpw4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QlfFMcIgpV3JYZhXIz3ZKax54n1D+5p68jpTNDA5ds52moiQkyj5mRrWZ8+El2QFC
	 ZYc598eW0tD/p3pw7LWjrSJnCEErawQmBKD5wWOQ8mCEinmi6VGrTVN6m+aN/4bVG4
	 iTzY66nzYxKk2Z4nlAfCZ32Tz9TAvUrC2JoDv03o=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Wed, 02 Sep 2026 12:56:07 +0100
Subject: [PATCH RFC v3 05/21] MIPS: mm: define pud_leaf() only when PUD
 exists
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-dummy_ptxp3-v3-5-5d8f5b17c25c@arm.com>
References: <20260902-dummy_ptxp3-v3-0-5d8f5b17c25c@arm.com>
In-Reply-To: <20260902-dummy_ptxp3-v3-0-5d8f5b17c25c@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=950; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=r6k/TjEKlLvF6QYrAiLexU7+JoLa9iezYFCnVRD7jlk=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqmA7k1BasbENs7scYH6YCwuMubOtsGe1c3+4m6
 SOomUSWrtuJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCapgO5AAKCRBt1cPRWsUx
 M3hGC/4t647eElOpB391p80tv3+7NgML6I6J4DGdbsBSvNkUpOdiEDJxWt6dXvZJprZIM65I9gL
 pzwDOktDu7P0q/H2ealDT27R5xiLJiMSYQJD6LtqjzaTOUCJqcBBsdwvvfz6exPz8jg/3s6owof
 z8kanGk2RTw/R2pBX7mz7baBXd/kXIAh+VtdG/yriBIJvw54oV1NawZ3QLH8cT0V++vjSvtx+6I
 U305Jn8DD42q1uSiiXgWq6uoWhAFuydp1y6fNV0XPcX+OG4n/bLcApPCVxGhNfqD+h1dlYA5xUC
 3o3jHz8nXtffVSV1y2NX3+3BoAGkTj4JNftFb2oWfopLzLA8/jyqMEbV4QfTRMUcaPy94LAC9cb
 Je+vi6FqOCznR7ehsyiVNSUNOjyc2vcdlWDc8a3Efj7eElfAPuFNaiYMc7XIK+Qbpa8CgPR7Wqs
 gDblJRw0/WUPCu6jYlUuWd5gIEIzWHCbXriyTy4PEaG9XfbRg8ExE6mc4ZXlJ2wNcj26A=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

From: "David Hildenbrand (Arm)" <david@kernel.org>

In include/asm-generic/pgtable-nopmd.h, pud_leaf() has hardcoded
to return false as inline function, but it misses the "define pud_leaf"
part.

To prepare for fixing that, define pud_leaf() only when
__PAGETABLE_PMD_FOLDED isn't defined.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 arch/mips/include/asm/pgtable.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index fa7b935f947c..151f4d15bd12 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -745,8 +745,10 @@ static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
 
 #ifdef _PAGE_HUGE
 #define pmd_leaf(pmd)	((pmd_val(pmd) & _PAGE_HUGE) != 0)
+#ifndef __PAGETABLE_PMD_FOLDED
 #define pud_leaf(pud)	((pud_val(pud) & _PAGE_HUGE) != 0)
 #endif
+#endif
 
 #define gup_fast_permitted(start, end)	(!cpu_has_dc_aliases)
 

-- 
2.43.0

