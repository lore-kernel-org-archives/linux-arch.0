Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3042E3D0914;
	Wed, 22 Jul 2026 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734299; cv=none; b=Eu/d4Bfps3SLJh9ZnmlfBrVLzAfhvfVeDAwzK+moZo9r/7QzdmgU9Swa4+202iqlVluk8ZMqhOuuI7C0eo5oo+QMspNF+d9pUHdrv/89ttLT/4pCGU9AcSrwo8UvUvpELXyOf4wKy03eoe+1ias1qG6es0/ea2u07lXvdLB4x28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734299; c=relaxed/simple;
	bh=YcD0jzoOahG6x/x7befgYnktlqrNhCa1TVm2jqZpY/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=boQUPsPqHSXlQZtLvTPnfC6ZFvY++WR37ZG5wsBBs84sbXqqYnz6Dzp+A6XgwetPStqVSmBH1obqsIuKyZmNEoNlYM5Fxyo+gytTZdfn8DbVHyQwVCZ8xE4faSacGiT92DlXYGyo/resJGrUaNjlbGuFC8TUHVimoJ6cktYLf8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YB+ECKku; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YB+ECKku"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 55A83168F;
	Wed, 22 Jul 2026 08:31:33 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EEAE3F66F;
	Wed, 22 Jul 2026 08:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784734297; bh=YcD0jzoOahG6x/x7befgYnktlqrNhCa1TVm2jqZpY/w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YB+ECKku/PoYq2WT0AjK5FWjpwHm5WhvpyBL9iss6rJkCx9EWxGy5Xj4MUWQUp/nc
	 bB/WO9swVClnAHd0CCdiTAWlLHW6My7AKAaZCl2lFEqQMRkMNS2H2HjRUcp/qutLrl
	 XMv+zI5+luxlx6Hkz3AiZYLUrcxHFci+B5d421/c=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Wed, 22 Jul 2026 16:30:16 +0100
Subject: [PATCH RFC v2 08/20] mm: vmscan: remove stack copy address of pud
 pass in wallk_pud_range()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-dummy_ptxp3-v2-8-d9e4bad31e0a@arm.com>
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
 linux-openrisc@vger.kernel.org, Yeoreum Yun <yeoreum.yun@arm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=931; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=YcD0jzoOahG6x/x7befgYnktlqrNhCa1TVm2jqZpY/w=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqYOITGIRilBrCRHcB2LdtqoEOmFgxIF6Hd+Vnk
 IFCao2dq7WJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCamDiEwAKCRBt1cPRWsUx
 M9rNDACPX1gvLIbSeFSgpsXYw5fiwtsaAo8fF9fow2EFQfuqsIXmDvvDuGvc+tGU4BaWuGH0mzM
 eklxLiUek0JNBF0GJ2x3A4Kq/ui/Kd9sAqMqxOPWurPgfQayM/59RN2xzFcJzTZhoDSZjVcP8Ru
 FK3kg4Bd/FVwqL91rO7uKn8nVD/occoSK5fX2tc1M7dm/Z484Oq0dzF8MCB+CDCrvRkASH5o8fR
 7OBG17OYADT6CJpJ30NG3tnWw/z18SHM2Ho6dtWlczbf93oHjLBn9TtaJJ6TvsI6HevcytP/R4s
 mPt0zU94Gtx1B3c6i5b/GMxplXDdm1GNMjqlqgeIzBVATylzMaefHkFdkR/Ep2mCZJRH0hgBYvX
 M/U0vigKgKdlCN76Y4jnDC3QQ+LXNhIy8HWUDZKioYXWffW32R7/0W3xLPN4De5MFGGNUwfftWV
 WcWIiT/h7TzBoZGus/gSVNMHtcSBu9NwtPvLEQDo4Q8vWWR7vsw4ZNL4ki05RrlcOBNyM=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

The behaviour of pXdp_get() will change with generic compile-time folded
page tables. To prepare for that, replace passing the address of a stack
copy of a pXd to walk_pmd_range() with passing the pud pointer directly,
allowing folded entries to be ignored.

There should be no functional change.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 06e103f9781e..0c9c4ac89e09 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3727,7 +3727,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long start, unsigned long end,
 		if (!pud_present(val) || WARN_ON_ONCE(pud_leaf(val)))
 			continue;
 
-		walk_pmd_range(&val, addr, next, args);
+		walk_pmd_range(pud + i, addr, next, args);
 
 		if (need_resched() || walk->batched >= MAX_LRU_BATCH) {
 			end = (addr | ~PUD_MASK) + 1;

-- 
2.43.0

