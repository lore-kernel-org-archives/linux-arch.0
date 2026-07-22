Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1BF4DB57D;
	Wed, 22 Jul 2026 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734278; cv=none; b=A8IWnOIxcpy4yqtNYaB1hhAwZk1dAigJHafHKibSt0lQY1MfnTtgobp8GmIv4E8Z2m/YLSAgENwTT8KxTrNPkdyx9JkXctSyVtpRL38BGbjiULS6KrRLclBImSgdg36IIo1WO/dPGN35LVOxX+KduBanubM33JXPnTsRTcvtzdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734278; c=relaxed/simple;
	bh=hiWrXKZl3HSQimA2aMCTib+KVKF++dHLJJBYh+lph9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WuPt3cd0Hx8SWKS7W+d7Qyz1y0qT4ZucDJFF8hf6mfuChc27uOphMLXfA6NHE0Xd0Iw5TJ2DjcpSiyrx7b0R1oSHsROtVVEFgA7Maf48SWt81Lb0ufT4SOFTN29zDQWGbO7gwjjhW93Ux8cCrfaAppVqA4PFQDQIKK1R4rtenG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MPNrLQ+Y; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MPNrLQ+Y"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF1B51691;
	Wed, 22 Jul 2026 08:31:11 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 43CC43F66F;
	Wed, 22 Jul 2026 08:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784734276; bh=hiWrXKZl3HSQimA2aMCTib+KVKF++dHLJJBYh+lph9o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MPNrLQ+YsrzFiOpSP9SWG7N/+MHgnknKNZkXq4aPF58fJCxXjdRe8DHJBZU1yH/gb
	 Hz/yrfkTsAkIA/ai9FsVtwg3y7MKal7n0Ve6mdFNF8PditHoNSpER1jfZuPa1LaR0O
	 RKS15ZaEJK8eMHTb91p12+ZneLnHBLh7wAv66T/M=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Wed, 22 Jul 2026 16:30:13 +0100
Subject: [PATCH RFC v2 05/20] MIPS: mm: define pud_leaf() only when PUD
 exists
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-dummy_ptxp3-v2-5-d9e4bad31e0a@arm.com>
References: <20260722-dummy_ptxp3-v2-0-d9e4bad31e0a@arm.com>
In-Reply-To: <20260722-dummy_ptxp3-v2-0-d9e4bad31e0a@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=954; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=H+H/wmu4330VwmFZtb9J1sA2hSnEoaKRqGEvxUP6qx4=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqYOIRWk1b7HFDPY1VFchgF5Cds4RBwgntIkDQd
 5jEN4eIWxmJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCamDiEQAKCRBt1cPRWsUx
 M6wGDAC2lHq5x8fgh5N3V0oN64yuI0v5l4DrbkPQqL3r9rW2b0FNVBd8zIJiTJmI0CpqtAOemH4
 07Hnd7BkZnZpKDbHohJSPnUdu086S156nZ5ujv4kOhoHf8KmNwkqeHp18R78FvRHCex06Ri81uu
 vfeUTcJSNH5iNsf9kMiwUlTIsfEcXZA4/xSPo54Qe2vfVKC28/Y9VXC4xeiT92Sx0XyUgD5cQdu
 5sGaCdBzlMbyiAdTA4BA0bjCbVvtvdaz0mihbWktNtc5Ep0aa57zWF54tpr7+vdIp3Hl7AFudJz
 bf3BBQPe4rLdeg2tMCLgcXy2dUxCbFZJRH/oGKD8u59MwaVyGN5z4J01wLxQap/KzJi5ux9/KiP
 Mf4bjM2FpSXqbhPa479cy4ItfK3JCYLe+rXwrUEmg9zfiY2DG7BfXN3hY99ee4pjgVHIswn26Gy
 LkGQcigk9fzVC8V+gFi2TGvn5JttPDqyJr8QzSiXoSgwRxNuqZEx+nlFB5lY+w/pxZ7YA=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

From: "David Hildenbrand (Arm)" <david@kernel.org>

In include/asm-generic/pgtable-nopmd.h, we do have a hard-coded
pud_leaf()=false inline function, but we miss the "define pud_leaf
pud_leaf" part.

 To prepare for fixing that, define pud_leaf() only if we don't have
 __PAGETABLE_PMD_FOLDED.

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

