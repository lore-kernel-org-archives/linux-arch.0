Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4B4483BFB;
	Mon, 21 Sep 2026 10:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789988228; cv=none; b=Y9RjA4akB+v9lGYafI660aqm0SQ1SxdZ0ivxLKDQlUZ2C1bECvbFes0z9In/6yRzb2czaG84+WmvvHVfs8frhLkktXTfQ8ctkE2V69Y3WZcp7WjCE/S8syvKOxIYG/67YsVWEc3W9/VA+ALYnQnBtObcbOI+XW4HckMsF2/uMUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789988228; c=relaxed/simple;
	bh=t0SkgFkvYDykWTdwPClx+wiQRsFxgewU3m4qBQArb9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H7YNXHR7Z2BcBtu+RMGc/EQHojr5smX68yqDNei1/k33qahouulzGHdo8rA4Eo4UCARG4+GXbN48Gz56c+BDje8QIzlAUl65SYDj9Ro1J2n2H0/YvzgtgUuYk5468RzElVJXl2h0Yfs8ji3Aayw0E+Ni2sjcc0lyIuc1G6KugwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OBFz6Z+R; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OBFz6Z+R"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E62EB1570;
	Mon, 21 Sep 2026 03:57:02 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 563473F86C;
	Mon, 21 Sep 2026 03:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789988226; bh=t0SkgFkvYDykWTdwPClx+wiQRsFxgewU3m4qBQArb9Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OBFz6Z+Raz7I8ibgsDiaiNLTnQsX4oLEoKjZPRodWantEpoXhmxG8yAOCFS64FQx6
	 TnSa1uoOW4JI3vs3idHKAZLQrb2k4cp73AJbVjUGApg0VIpLWNjF8iXjbLwLCJOMOP
	 KH6BsKk5W9konyiN3h+HCCs6a4q5K9z2QxYNfnPk=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Mon, 21 Sep 2026 11:55:27 +0100
Subject: [PATCH 05/21] MIPS: mm: define pud_leaf() only when PUD exists
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-dummy_ptxp3-v1-5-cd40cf68242e@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=952; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=yLp6pLFkEq1XlBsrO8HJPn9OYitILCqfI5l0JaR3PzY=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqsQ1NTZ/a+wId/oXop6nBRx7GoTqL9a7Er/mVm
 I4zdOrs16GJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCarENTQAKCRBt1cPRWsUx
 M7A5C/9647RRGO+Rm053IZPrkfpK1qoCf6h7h++dBQM7iWcjgmIysinuJZ/9flN7m3N7/8s0k1F
 Qg8UBSKcYxAPzyP7KMXSKbC6blVlpHWz3kExm+/5ZAnSr3JetwJGEw0WoHg0g85dvAd2y+KV0nj
 fcMLKAxYW9EKQIqMG7nuATB+F1lWeLPWUKEeZ5Xr3zYvC2diB9VgvhinADx3ajrN78j7ASV1xes
 7//vZ8p602dtxNE82CTR6O3KYyUFHq7mNoysyRhtRvpNYl2Ts3NfvwNVO6vCLxhNLIIYu7s2mAc
 n2FreTnlSvWWzFZQfZrm8tZrPteyXRjmWvqXceNsbR4SJYTafBHwQjLRLGhy8+k1iRjDqguBSwy
 LsoRrK1Q0udKYrD3CKiy34mvfTgVS17T60Z0/lwKClICrmLYbw/pQoCMDwpPvb9abrZB8uyEsZG
 4+DpL7SndbO4XS1cejsKbd6M7jig6sw/xhWPdMK/bJQQY3QqubKCQrarXnjeyHzIhJkqw=
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
index fa7b935f947ca..151f4d15bd12b 100644
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

