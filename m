Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A32472093;
	Wed,  2 Sep 2026 11:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788350269; cv=none; b=Z06hAXeflstYanM4PnDp6MPMld58gJQ828fFCdQnp2PL0Ir2S8+UXldKWsc5849h5cAb2jvxy1c5kWDjKdssFfAQl8KLfmS8Yf/Cd7e8LqeNyD6bbHFDZk/YY+mXXbElhAvBp05+2smjzr72cJRrxgkl+3u9Y597+HLJkVjFg2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788350269; c=relaxed/simple;
	bh=hoNRRxOZ7Q1TQ3tPx9cyjNqGROvazqJ7TpP1oXJkYEo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U+NUYWaM0luipnd3S6acmDUQNkFPlKm+rz5GcL3fbDs+3w/53Gn8EzGo2d/G2grPUms4YeIrV1sR9LYHNNrjJJHMG7MV9ekNKZS0awUN0wE6JcIaWSjL5WoEa1NFW51PMMk2vT9IV4WeGc823oTHb27XhzLjE9JdEklNhtAK5W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HQPs1WFX; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HQPs1WFX"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29AAE1684;
	Wed,  2 Sep 2026 04:57:32 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85EC13F85F;
	Wed,  2 Sep 2026 04:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788350255; bh=hoNRRxOZ7Q1TQ3tPx9cyjNqGROvazqJ7TpP1oXJkYEo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HQPs1WFXY9CW3alroELpjH318TftojKz/4UscrbJ2jzOFyxx3UatrpJLr33W9KNfE
	 Asl/9rxAlMVPA9iigGjXVyLoAqrTCxfagAzzbKGU1vafeZPpNPJsLqD5plO8kJvIF7
	 CaAYby5EXyJ2Sp3R2RxfIvknlwZ8d+mi2y2qcyb8=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Wed, 02 Sep 2026 12:56:10 +0100
Subject: [PATCH RFC v3 08/21] mm: vmscan: remove stack copy address of
 pud/pmd pass in walk_pud/pmd_range()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-dummy_ptxp3-v3-8-5d8f5b17c25c@arm.com>
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
 linux-openrisc@vger.kernel.org, Muhammad Usama Anjum <usama.anjum@arm.com>, 
 Yeoreum Yun <yeoreum.yun@arm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1414; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=hoNRRxOZ7Q1TQ3tPx9cyjNqGROvazqJ7TpP1oXJkYEo=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqmA7lNaVBcsfB9ZliAXNxOQ6b9wJghPjcL8fDa
 uK2aRokBiGJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCapgO5QAKCRBt1cPRWsUx
 M7ySC/4oY0cDV4bfPbL9NxITYd9JIehHPFNxIAbq4GdJg2qXG5UDzoBj4Wg+TBEiBJtleT7fIh7
 V/SUCFBsSIOPfl21gAV4DsJqqIR2BI9tpisGacYX4mBzjdSVensar8f+n2/L+1HDi08QM7Jfab+
 vw/jd4OIcl5haxvZT1/9ckj2vzQjqGUNnVIQtu3cKR/zayGHnPRqXFeLj7Feqw64p3A05OQ2d3j
 z+koBd6eCH3o4f+a6JZkpt4dea7g7soIxmhTudXuzjnFdZ3j247H1g1jWvNpqX7WLUnUqXJes2M
 TgWOc1HdziiVK5q2kLYUiANmR9JGvyRR08qduHULn09JGSR4TYQBM97x7YeDQwLPSQ5wtU1BnNi
 MP/XV2imJviNZrvi/+xofZE/1KHQ6IchyObI70sbt1mEw24q8+T/I1AmCjW4cX/b7p7K6z6WT5c
 q898aoJd2V8gO2BB56t63O0drtKXzGoei518zBzrff8qAZoIk9QbxY+W21MH5ju9gxOd8=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

The behaviour of pXdp_get() will change with generic compile-time folded
page tables. To prepare for that, replace passing the address of a stack
copy of a pud/pmd to walk_pmd/pte_range() with passing the pud/pmd pointer
directly so that  makes allowing folded entries to be ignored and
check the concurrent access proeprly otherwise pXd_same() would return
always true.

There should be no functional change.

Reviewed-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 mm/vmscan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 4d51b0d8e287..4e98088becab 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3777,7 +3777,7 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
 
 		walk->mm_stats[MM_NONLEAF_FOUND]++;
 
-		if (!walk_pte_range(&val, addr, next, args))
+		if (!walk_pte_range(pmd + i, addr, next, args))
 			continue;
 
 		walk->mm_stats[MM_NONLEAF_ADDED]++;
@@ -3813,7 +3813,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long start, unsigned long end,
 		if (!pud_present(val) || WARN_ON_ONCE(pud_leaf(val)))
 			continue;
 
-		walk_pmd_range(&val, addr, next, args);
+		walk_pmd_range(pud + i, addr, next, args);
 
 		if (need_resched() || walk->batched >= MAX_LRU_BATCH) {
 			end = (addr | ~PUD_MASK) + 1;

-- 
2.43.0

