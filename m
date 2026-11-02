Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618586;
	b=IMDL7KcZUeIuJVzKb3NcOhapNLPXFzqQSeLziiVnybo/u32V6bCWFhmkz/NtWNwO8PZo
	 GmwnF52MuEawlP5c/+HOHG3UY7+E3uun9v2pELL9xvF8RtHBDl476up0wMnlenUK51sDw
	 KGw7uQqGZHy1c/NLxi7iO22KKadoodLpoCdTMSX5Y7wjpquICJnA9WLunRAzDYLLGygUp
	 RNmZJ0xqxiGy8rers2q4LrOooQtAq/YL3QalyI98JWwDYwhmLN4gaplIhHBTUueihD17w
	 FG5yVFwiTIHQ0Gt1z8oMgCq0WBGDcDnmMXXHDp/wZxTEGNEml5ZHEdp7BqikHG5PORw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618586;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=eb9H+uxRvArRVVJKhsUr+93SDYJ1x6sKU3xCIma4RUU=;
	b=NxKv8G3mowGWKlulq7Y2QBdurfqU8/+DcXQhtr0tV4HARYUseUE6BzRM1qc0lBpvCh9C
	 IV1HRvg6TIVx0OXM5q8q4ADHhYasTMIKmLANFgg1Rx+kS3LVYaIIPGL6qsboBK6N4xkWz
	 664kBVx2JMK9Ir4MANmV90iE7tflR5f/Vj1v0M7SqnPYKcEYEGp0qDrL/B+G8GHIHtVc7
	 zLru5/xz6LutaFpAxBP5gbY1gLggYtxlib05m6FBo8eigMcygWxEqJ6N1AZmq3gTf1mS8
	 sJtEOSNGQatXM012WjIkyc07K0134ZADyCR9g3QJt4peWJqVNOQwMdgs3z3DIWk4uAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=S6G8eANt;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AC6606A32F;
	Mon,  2 Nov 2026 11:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8AC6606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=S6G8eANt
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EBDA1691;
	Mon,  2 Nov 2026 03:23:02 -0800 (PST)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 254863F632;
	Mon,  2 Nov 2026 03:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793618585; bh=zghhBXP63HUkMVsnVTW1BBI8m5GQHzJyarBmwmrVkLw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=S6G8eANtslFyveBpwPLZwAJIlHGPtPzLOZkPNUbQZrbf/e83nfgLtEhyRdEl+CKWq
	 qbwPr2yNqC5ubwdh6TO7JSUkTYZQmq68VurvEE5YHy1zupilBrGF0jDnFDGjxNIWLR
	 ZIyYkP1apZziEAVLn/pciEqxsStbIpEa7Hh9LprE=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Mon, 02 Nov 2026 11:21:27 +0000
Subject: [PATCH RESEND v2 14/21] x86: mm: use pgtable_level enum in
 effective_prot_pXd()
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
Message-Id: <20261102-dummy_ptxp3-v2-14-78840b2ec73c@arm.com>
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
 linux-openrisc@vger.kernel.org, Yeoreum Yun <yeoreum.yun@arm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2497; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=zghhBXP63HUkMVsnVTW1BBI8m5GQHzJyarBmwmrVkLw=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBq6HI1tf/eYu583XiESkJqcFh0Ln97GwifsA4yJ
 5hjudYl5LCJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCauhyNQAKCRBt1cPRWsUx
 M7CXC/9fvtgv/f2rLKFCQe85Z/Wsksb1TC8gpZAQmESeMsNOLwhQJwTmCgEHPluLgWZmholGaYO
 PnqbceUGyr1pcmOkepbh9WeQhL4X2VSfrEtz0/h20WYKiCUi6DjQ3COgz2a7ktLMFI97hvziCdm
 bvP/6V7nAGdhgaX5vVjhY3R9ZwFtaoK1vBgC48ycNo9pXyZAfuFvBcRGqEYuq6LOBAI/hFZIZcH
 xqCDdDYjQPSZH2av9CiYtQwZF5ykGASC3RunuGlgf5r27ykbJeWBfHvdzeoW2F3QkYqyH2l0vU0
 Z0S7et8IybfbSLMVGkurx+pcnIm7053a78ucdXh1zT6HrolfrzEBXSYNJluRMeCZjjAIH2AV5sC
 t8UzGaK5BaQLzP07023I0MrQcTZipUNmqyxr6TiuRmJaiSFAezEea6wC8bi5Jlni2CUujgPL+pY
 1hdZrIDSt+PFoWQZaFdmoxibu5GmrsqgFCoMZphc2Vn0XSC70lJ+vtovtimon2aZhoE9g=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

Instead of using hard-coded integers in effective_prot_pXd(), use the
page-table level enum so that architecture code does not need to know
the numeric value of each page-table level, while also providing type
safety.

This also prepares for using generic MM helpers, mm_first_pgtable_level()
which use symbolic names for page-table levels rather than integers.

There should be no functional change.

Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/x86/mm/dump_pagetables.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index 2afa7a23340e9..a18a61e732c3d 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -248,13 +248,13 @@ static void note_wx(struct pg_state *st, unsigned long addr)
 		  (void *)st->start_address);
 }
 
-static void effective_prot(struct ptdump_state *pt_st, int level, u64 val)
+static void effective_prot(struct ptdump_state *pt_st, enum pgtable_level level, u64 val)
 {
 	struct pg_state *st = container_of(pt_st, struct pg_state, ptdump);
 	pgprotval_t prot = val & PTE_FLAGS_MASK;
 	pgprotval_t effective;
 
-	if (level > 0) {
+	if (level > PGTABLE_LEVEL_PGD) {
 		pgprotval_t higher_prot = st->prot_levels[level - 1];
 
 		effective = (higher_prot & prot & (_PAGE_USER | _PAGE_RW)) |
@@ -268,27 +268,27 @@ static void effective_prot(struct ptdump_state *pt_st, int level, u64 val)
 
 static void effective_prot_pte(struct ptdump_state *st, pte_t pte)
 {
-	effective_prot(st, 4, pte_val(pte));
+	effective_prot(st, PGTABLE_LEVEL_PTE, pte_val(pte));
 }
 
 static void effective_prot_pmd(struct ptdump_state *st, pmd_t pmd)
 {
-	effective_prot(st, 3, pmd_val(pmd));
+	effective_prot(st, PGTABLE_LEVEL_PMD, pmd_val(pmd));
 }
 
 static void effective_prot_pud(struct ptdump_state *st, pud_t pud)
 {
-	effective_prot(st, 2, pud_val(pud));
+	effective_prot(st, PGTABLE_LEVEL_PUD, pud_val(pud));
 }
 
 static void effective_prot_p4d(struct ptdump_state *st, p4d_t p4d)
 {
-	effective_prot(st, 1, p4d_val(p4d));
+	effective_prot(st, PGTABLE_LEVEL_P4D, p4d_val(p4d));
 }
 
 static void effective_prot_pgd(struct ptdump_state *st, pgd_t pgd)
 {
-	effective_prot(st, 0, pgd_val(pgd));
+	effective_prot(st, PGTABLE_LEVEL_PGD, pgd_val(pgd));
 }
 
 

-- 
2.43.0

