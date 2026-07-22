Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55C242122F;
	Wed, 22 Jul 2026 21:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784754028; cv=none; b=ugABU4T4+S0ZyiA7R93v4WEm26ZNB6OL1WaJApWOAtBGN2NI6v8rOCdtqhfln6LE44J1XBbwS7/JUkC88erxmBraoaSnzxffx3H3xb9IyRY3RtNrxXaU7KHZvqwl0t0uB0n07WGHbeK5F+YyWUnAXsZ2Sm/DfC8+SDsedt7MQls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784754028; c=relaxed/simple;
	bh=T2r4Egp/s+16B0hoCunOZbfeqvExxi27eFGafMCU8ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xe1Ai09uO4uHiL+tb6nUwTSi4NIzDnYYnjf7a2HZ8WLgpIzkNC+OumQt1Zh7fQP6E5Itm4z+jXHa1qa2z3mHHEGRQqCgtMktt8qCeHaSadtSHs5E4Dtmc9W3jBfW7eCN+Z6Gy8/qK0MigMpZPxP8lv2o+XNV/Y7rkb+30REKz1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=YWMrR1YN; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="YWMrR1YN"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D08F51595;
	Wed, 22 Jul 2026 14:00:21 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27E8B3F59E;
	Wed, 22 Jul 2026 14:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784754026; bh=T2r4Egp/s+16B0hoCunOZbfeqvExxi27eFGafMCU8ps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YWMrR1YN3bfiCwiezM9DJOx6TakLDNvhmwvKnHA5Wkhoz7J/eEz5QdDttGzppOqLI
	 zc4F6tSsSpkQhSGeJsl+pVpGr5bnG6/UISWfFwGO6FJzqovJrkoePCsw3tVFPUswwq
	 Upv27aJLOhDf0wbnQxdJABxfJrqgq2VT4sARSYOY=
Date: Wed, 22 Jul 2026 22:00:17 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>,
	Bibo Mao <maobibo@loongson.cn>, Anup Patel <anup@brainfault.org>,
	Atish Patra <atish.patra@linux.dev>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-openrisc@vger.kernel.org
Subject: Re: [PATCH RFC v2 13/20] x86: mm: carve out the generic compile-time
 folded pgtable case in effective_prot()
Message-ID: <amEvYRs7CjhQdQWT@e129823.arm.com>
References: <20260722-dummy_ptxp3-v2-0-d9e4bad31e0a@arm.com>
 <20260722-dummy_ptxp3-v2-13-d9e4bad31e0a@arm.com>
 <d16a8412-acee-4c21-a126-f570d6306983@intel.com>
 <amD_5r04mzMoZ0-r@e129823.arm.com>
 <33c774f6-2750-4831-8eee-e43dc471da32@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33c774f6-2750-4831-8eee-e43dc471da32@intel.com>

On Wed, Jul 22, 2026 at 01:20:39PM -0700, Dave Hansen wrote:
> On 7/22/26 10:37, Yeoreum Yun wrote:
> >> On 7/22/26 08:30, Yeoreum Yun wrote:
> >>>  struct pg_state {
> >>>  	struct ptdump_state ptdump;
> >>> +	int first_level;
> >>>  	int level;
> >>>  	pgprotval_t current_prot;
> >>>  	pgprotval_t effective_prot;
> >> There is zero reason on x86 to hold this value in a data structure. It
> >> is 100% determined at boot time or earlier. Pre-5-level-paging it's a
> >> compile-time constant.
> >>
> >> On x86, it never varies per-mm.
> > However, mm_pXd_folded() requires to mm for other architecture like
> > s390. might save the mm instead of first_level and calls the
> > ptdump_pt_level_first() with static inline version would make the
> > constant comparison. So it requires to save *mm* structure in here.
> 
> I'm having a really hard time parsing that.
> 
> I think you're trying to say that the effective_prot_p*() functions need
> to know the first level but they don't (today) need the mm_struct. If
> they don't get the (calculated) first_level passed in, they need the
> mm_struct instead.
> 
> I think you're arguing 'pg_state' needs a ->first_level or a ->mm.
> Having a pg_state->mm doesn't seem bad to me at all.
> 
> But, it's also a little bit silly. It would not be rocket science to
> pass an mm_struct down to the effective_prot_p*() functions. It makes a
> whole lot of sense to me for a page table walking function to need
> metadata from the mm_struct to walk correctly.

Yes. I mean to add pg_state->mm like:

diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index 2afa7a23340e..aaf00f0c6624 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -38,6 +38,7 @@ struct pg_state {
        bool check_wx;
        unsigned long wx_pages;
        struct seq_file *seq;
+       struct mm_struct *mm;
 };

 struct addr_marker {
@@ -254,7 +255,7 @@ static void effective_prot(struct ptdump_state *pt_st, int level, u64 val)
        pgprotval_t prot = val & PTE_FLAGS_MASK;
        pgprotval_t effective;

-       if (level > 0) {
+       if (level > pgtable_first_level(st->mm)) {
                pgprotval_t higher_prot = st->prot_levels[level - 1];

                effective = (higher_prot & prot & (_PAGE_USER | _PAGE_RW)) |
@@ -452,7 +453,8 @@ bool ptdump_walk_pgd_level_core(struct seq_file *m,
                .level = -1,
                .to_dmesg       = dmesg,
                .check_wx       = checkwx,
-               .seq            = m
+               .seq            = m,
+               .mm             = mm,
        };

        ptdump_walk_pgd(&st.ptdump, mm, pgd);
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 8c093c119e5a..6e7d0580db99 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -2490,4 +2490,15 @@ pgprot_t vm_get_page_prot(vm_flags_t vm_flags)                           \
 }                                                                      \
 EXPORT_SYMBOL(vm_get_page_prot);

+static inline int pgtable_first_level(struct mm_struct *mm)
+{
+       if (mm_pmd_folded(mm))
+               return 3;
+       if (mm_pud_folded(mm))
+               return 2;
+       if (mm_p4d_folded(mm))
+               return 1;
+       return 0;
+}
+
 #endif /* _LINUX_PGTABLE_H */

-- 
Sincerely,
Yeoreum Yun
