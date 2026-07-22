Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE193D902E;
	Wed, 22 Jul 2026 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734336; cv=none; b=RsuPQLgeKWU27jV6ujP1Jg7sS5ofJw+Qhi9G+dG6LKseEeDfWxPvrX4XVhBDBqwP+AtnuEF2Mu0dvRLYvv463iQCXKuvb92Uea+N2PqdmaM3yLHQmnUEaCtWS8UcqTJf+KKqV6fkElLCg6cxaveKfboOieVLqBQ8RMjo5177vxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734336; c=relaxed/simple;
	bh=yIEI9TusozWN8JuTGtczFutPYB9cl2kOS5ZHqTwGcQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JO8IWojWId23QYjwdnycKtWNFh6A+IlrPlA2fsfaNUsAXnQH9zH+13WRge7Jy18c1wB1Fl7gALGA2ysp44hGmYG+K4dS6jx4YOkSY5o8ZnbfHRH8V4y+u14B2+uTOAJFM4wqIAiur2ExzyvRJJwgEZubtGTAaqrqYC3JWnx8+BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=qRUJLFHg; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="qRUJLFHg"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EC20168F;
	Wed, 22 Jul 2026 08:32:09 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA6373F66F;
	Wed, 22 Jul 2026 08:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784734333; bh=yIEI9TusozWN8JuTGtczFutPYB9cl2kOS5ZHqTwGcQ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qRUJLFHgOJjrfi+0gOnSAAWEwPfJRGMmZiCR/0lSgWgMyzUOCyvBmFc1wrXlZGTug
	 +NmZavPY1FkNb5X9TeGnbtZD83EoZCYeskRRy4frc1M8Vh74wbAQwbXrcchc7SzpPG
	 EpZUSMLdn/NzjDMJMU42Do1Z9A6kSfv4QS/Zu/sk=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Wed, 22 Jul 2026 16:30:21 +0100
Subject: [PATCH RFC v2 13/20] x86: mm: carve out the generic compile-time
 folded pgtable case in effective_prot()
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-dummy_ptxp3-v2-13-d9e4bad31e0a@arm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2785; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=JZD/Lbfbj4HSmqdnx7eUuD3cSDyNIRyRTYfHOiVHoYI=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBqYOIVinW6xJ66J0AtgWmoOBZtJI2fJu39cT+lG
 lmMvjqN7dmJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCamDiFQAKCRBt1cPRWsUx
 MyCyDACle63B8F6HDqrCyaIvfxal1+c5g69sl4AqthRg5hNwvh6sb1rxEXQB/52AWeOXNH9P8sR
 aDlnR0TLzPJEldaqF746pWxMSKMrSydQ6xEWF3RWwa7WRkAZidtkw5heNBQGEHKzfWiwRW8gjAu
 k2gZi06lUIxph0Ng9HnPaoOHTQ8mVePaIzcmaQRlTrI4fjoHxddyfgzqqVtef+CYsvIFerrUzCY
 +TKNNtfkN3EqkPCNpDmA80f6fj4thl2/gTRaqCVex8in/rEy1PCid4f7edIoKlXUW7Ov7/vmN6s
 oSgu1pyEnnf+gjJZ2ZXc3YmrzRhoody2r0uJy76JCg3hjD2VTb6hw/uSFrO/spCd6Zyo2+Dl805
 ztdWGgHUEEuWsQn2ZOG9CNHwgwPSo0WuEfwGHlnD9Z2VEZ9n6XsBJEqTCnUnSCBO4O2DaefO8Ki
 jwe3YWiyFr3Zzq7G3qqDmUmmBm94H+C+l4mENG+3rFbDzXHuFtK+NWkNmEwmd/4ezLd50=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

From: "David Hildenbrand (Arm)" <david@kernel.org>

The behaviour of pXdp_get() will change with generic compile-time folded
page tables. To prepare for that, rework effective_prot() to ignore any
folded page tables entries, as it will unconditionally get called by
ptdump core with pXd_val(pXdp_get()), and we really should be ignoring
that value for folded entries.

For this, introduce ptdump_pt_level_first() to identify the first real
page-table level and update effective_prot with higher_prot only
when the current entry is not folded nor the first level.

There should be no functional change.

Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
---
 arch/x86/mm/dump_pagetables.c |  5 ++++-
 include/linux/ptdump.h        |  1 +
 mm/ptdump.c                   | 11 +++++++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index 2afa7a23340e..4e545988953a 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -27,6 +27,7 @@
  */
 struct pg_state {
 	struct ptdump_state ptdump;
+	int first_level;
 	int level;
 	pgprotval_t current_prot;
 	pgprotval_t effective_prot;
@@ -254,7 +255,7 @@ static void effective_prot(struct ptdump_state *pt_st, int level, u64 val)
 	pgprotval_t prot = val & PTE_FLAGS_MASK;
 	pgprotval_t effective;
 
-	if (level > 0) {
+	if (level > st->first_level) {
 		pgprotval_t higher_prot = st->prot_levels[level - 1];
 
 		effective = (higher_prot & prot & (_PAGE_USER | _PAGE_RW)) |
@@ -455,6 +456,8 @@ bool ptdump_walk_pgd_level_core(struct seq_file *m,
 		.seq		= m
 	};
 
+	st.first_level = ptdump_pt_level_first(mm);
+
 	ptdump_walk_pgd(&st.ptdump, mm, pgd);
 
 	if (!checkwx)
diff --git a/include/linux/ptdump.h b/include/linux/ptdump.h
index 240bd3bff18d..26fa624eac44 100644
--- a/include/linux/ptdump.h
+++ b/include/linux/ptdump.h
@@ -29,6 +29,7 @@ bool ptdump_walk_pgd_level_core(struct seq_file *m,
 				struct mm_struct *mm, pgd_t *pgd,
 				bool checkwx, bool dmesg);
 void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm, pgd_t *pgd);
+int ptdump_pt_level_first(struct mm_struct *mm);
 bool ptdump_check_wx(void);
 
 static inline void debug_checkwx(void)
diff --git a/mm/ptdump.c b/mm/ptdump.c
index 5851096e6f65..96676c90430f 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -197,6 +197,17 @@ void ptdump_walk_pgd(struct ptdump_state *st, struct mm_struct *mm, pgd_t *pgd)
 	st->note_page_flush(st);
 }
 
+int ptdump_pt_level_first(struct mm_struct *mm)
+{
+	if (mm_pmd_folded(mm))
+		return 3;
+	if (mm_pud_folded(mm))
+		return 2;
+	if (mm_p4d_folded(mm))
+		return 1;
+	return 0;
+}
+
 static int check_wx_show(struct seq_file *m, void *v)
 {
 	if (ptdump_check_wx())

-- 
2.43.0

