Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618548;
	b=wrDAgnTAmC46cpF5hUO3OGUeFbTdzSQKbb/0AKkwMw/vLzISHwkKZ78SAFpMQmAysOzK
	 NrqtjAyay/EuebqYLmKmjcGZke7xD+UNzU5nyKL+8ZdodATwa7FgkbmlSEkKuj7zgjHun
	 1FKcKqrQwMQ1YdGDLvXlmSQijHsl8GpBW3jiAfhJSjtqgvwOeITvAiecnn3h2ttYm7Gd+
	 Ey6smzZFvDgCApjyl0whBTZm5lz2bY0PEFEaG/gPlhO1wEFw/vuaawTD7d80bX2er7ZeA
	 fCTIBoG2POXtwPKrUCZAfOa3BvxuitC2FdhmhEkSQHPjODifXhb+bB6scG6sK4mQEcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618548;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=8hJ1iPHVTbYTDAq/C1HnaYE5+XA4A6mgYVB8Pyb4aLM=;
	b=x4uJDOKy6/3AQv7xos2v7HPAjZGd1Lb/mGKT+zGbbONnM/Hm213gP2fZUS5+uRObioe+
	 vCDPM7BrthOAeUZp+zE10B73qj3mk4tIOlrcylOH8HdeiXtgyydGcxw+LLpNQNqo0DAyn
	 p3z54M1YKAzYBlGK2ZGj3G9+iMdALv149fHwBYM1n/228ULiYPU8PxnX5nBLfI2xJwzeF
	 nCSbTiTXEBAJiZLrrLPppb+XTCsKiorJdV91Bpij0YbEsskxJTl+iKlkQR3hoatWaPJhX
	 4BEPXEvq3GYkxAgzYC4YjXW33o8SgFAGCS6HmKFUt6dfdUCZ+8cDDQcisn+wD7sKC4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YdZ50qos;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668BE60A380B;
	Mon,  2 Nov 2026 11:22:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 668BE60A380B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YdZ50qos
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9987E1691;
	Mon,  2 Nov 2026 03:22:23 -0800 (PST)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7612A3F632;
	Mon,  2 Nov 2026 03:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793618546; bh=/Ssd4kAdbyYc2WVWtdpRP5Vxi5IuwO7Iv1puKU0SNto=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YdZ50qos+A3w9ZaM+D9UJ7oLQBvwyhsBU/ruoPIHunkF9HB8/GvUZPOFwIhq0hj+b
	 XMmZmMiyF5M+zRGKttEOthHofyTIfdOb6kRAKiJfrH27FTrj7aQ3tXK4ZJ1L2PFzo+
	 h5y+NPPSkIndHx1iv7x0/IC7DPBuyoL72xdV5wCE=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Mon, 02 Nov 2026 11:21:21 +0000
Subject: [PATCH RESEND v2 08/21] mm: vmscan: remove stack copy address of
 pud/pmd pass in walk_pud/pmd_range()
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-dummy_ptxp3-v2-8-78840b2ec73c@arm.com>
References: <20261102-dummy_ptxp3-v2-0-78840b2ec73c@arm.com>
In-Reply-To: <20261102-dummy_ptxp3-v2-0-78840b2ec73c@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1374; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=/Ssd4kAdbyYc2WVWtdpRP5Vxi5IuwO7Iv1puKU0SNto=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBq6HIyfn2gL02dSTH4U1Digx7JtPpPj8Bgyn8x9
 UoFtdHycjSJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCauhyMgAKCRBt1cPRWsUx
 Mz/2C/42LrIml4kwQBW+YjAT4YcNn/U4Nb8+hQWZ9x0kXwPAdxvb9J43k+UVxO9ahHOIk6g6HIT
 XtZL/MTOK7/jgTNkxXqFVeYK8VyzWEiqpibgZjNpiX9XLh6Z8cmnp8G47IUvXkJP0wA+Hmakv3A
 9myK1wyAcp0SHF/i/sVsHm7iyIbMyGfGc6Z5CBiWiTjnDvafMkvBazMphB0j5dU46MUuWd+W7qy
 GwEdURQVvkAFrul/krfqIl8qyLzn4vPYYBCRYUd4SCIlcw5QjS3Qthc6ED7WMnukAn35Yx6W0oL
 oPVAV5N01l94+aU9yml7y7eXDNrR6dgu0Ocio3vbsU2eTqNw/dYDJL0PD+h2rPLcEwUkPmIQlTt
 o0ewlFkj/UUYwiFIUbO3PGph11XhYzVDb++4zdSLnOfSYG/ZBB9EGVS2GVUt55QTEBEc3tRmB+f
 YQCEfFaDjsnzZBrd0gL/KZqDv8WqDSWqrGeR2W82At20bHA5Qs1wSXjJiIn3cDFFKuyPg=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

The behaviour of pXdp_get() will change with generic compile-time folded
page tables. To prepare for that, replace passing the address of a stack
copy of a pud/pmd to walk_pmd/pte_range() with passing the pud/pmd pointer
directly so that makes allowing folded entries to be ignored and
check the concurrent access proeprly otherwise pXd_same() would return
always true.

Reviewed-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 mm/vmscan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 9959ca158ce83..6a1af9b92349f 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3911,7 +3911,7 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
 
 		walk->mm_stats[MM_NONLEAF_FOUND]++;
 
-		if (!walk_pte_range(&val, addr, next, args))
+		if (!walk_pte_range(pmd + i, addr, next, args))
 			continue;
 
 		walk->mm_stats[MM_NONLEAF_ADDED]++;
@@ -3947,7 +3947,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long start, unsigned long end,
 		if (!pud_present(val) || WARN_ON_ONCE(pud_leaf(val)))
 			continue;
 
-		walk_pmd_range(&val, addr, next, args);
+		walk_pmd_range(pud + i, addr, next, args);
 
 		if (need_resched() || walk->batched >= MAX_LRU_BATCH) {
 			end = (addr | ~PUD_MASK) + 1;

-- 
2.43.0

