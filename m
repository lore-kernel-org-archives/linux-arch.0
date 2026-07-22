Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E134F798C;
	Wed, 22 Jul 2026 17:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740726; cv=none; b=HlZHV1kCJCmmaSyD2bpQ9/6Xl6ER1ilrzgd4oemJFR2aUzY4+ABjjipzv6iuZLpq0UvXDXQee+wTVoTipGQ69OTJJpBhFyYvToClabEGDhdYZZki5t0MMXjW5WYL8tPLZypigqqrhr/fU+B7sFyT1LIzU2L5ZIQB4xRIrcrgvX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740726; c=relaxed/simple;
	bh=2NDCcLKodqKCpw2t0NDotrWkpKm4cYytW7/B76Q9mwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTgK1tdERTxfxiAIztX1+hufC4HsQTxSGz1uY+BcN6OlpNrxIwSUTgFWTlycqZML1aJpl5+SyY/11ysPymytbSDz0XAxsgTMA5fuUfP59LUBvn57GiMOHkFR0C15Tw+Yq8iCT5cFdsAOXSBOMT1fruCNU6fAyqs0AoMr+1w2CJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Das3j0Am; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Das3j0Am"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E7591595;
	Wed, 22 Jul 2026 10:18:39 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F8683F66F;
	Wed, 22 Jul 2026 10:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784740723; bh=2NDCcLKodqKCpw2t0NDotrWkpKm4cYytW7/B76Q9mwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Das3j0AmK5wTaHG4tQV+vaD2IuCrxPRNwYvLASUFPiBuUVqMzxuym7Y9yOS6KG2Ei
	 tTEwkxPYF7fgFUJ9zTix5YA8MAxyV/197dUq0IJrrTNTEeD+WwVVI2vp+T9s0F04m3
	 cSuvOYeQfWsSA3qkTMWLNYwUi1xxvOwbv1FzSGdg=
Date: Wed, 22 Jul 2026 18:18:33 +0100
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
	Stafford Horne <shorne@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-openrisc@vger.kernel.org
Subject: Re: [PATCH RFC v2 14/20] x86: mm: skip pud setup when using generic
 compile-time folded pagetable
Message-ID: <amD7ab_KuJPdBQBh@e129823.arm.com>
References: <20260722-dummy_ptxp3-v2-0-d9e4bad31e0a@arm.com>
 <20260722-dummy_ptxp3-v2-14-d9e4bad31e0a@arm.com>
 <0ea931f1-4801-4d32-b6ce-4787a8d3daa9@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ea931f1-4801-4d32-b6ce-4787a8d3daa9@intel.com>

On Wed, Jul 22, 2026 at 09:33:55AM -0700, Dave Hansen wrote:
> On 7/22/26 08:30, Yeoreum Yun wrote:
> > We want to rework how set_pXd() behaves for generic compile-time folded
> 
> Please move this all to imperative voice. I think I asked for this
> before, but perhaps I didn't. Either way, please fix the whole series.

Oh. Sorry, I've forgotten to edit this commit message.
I'll fix in next around.

> 
> > page tables by disallowing its use and triggering a compile-time error
> > when it is used improperly, ensuring that the actual first-level set_pXd()
> > function is used instead.
> > 
> > The behaviour of pXd_page() will change with generic compile-time folded
> > page tables by disallowing its use and triggering a compile-time error
> > when it's used improperly, ensuring that the actual.
> > 
> > To prepare fot that, skip collapse_pud_page() and populate_pud() according
> > to CONFIG_PGTABLE_LEVELS.
> > 
> > There should be no functional change.
> 
> If this wasn't done, what would happen? There would be a compile error,
> right?
> 
> Shouldn't that be said out loud somewhere?

Yes compile error for using pud_page(). I'll shout out detail in the
commit message.

> 
> > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > index 078689aa7206..91b33a265a43 100644
> > --- a/arch/x86/mm/pat/set_memory.c
> > +++ b/arch/x86/mm/pat/set_memory.c
> > @@ -1346,7 +1346,7 @@ static int collapse_pud_page(pud_t *pud, unsigned long addr,
> >  	pmd_t *pmd, first;
> >  	int i;
> >  
> > -	if (!direct_gbpages)
> > +	if (CONFIG_PGTABLE_LEVELS == 2 || !direct_gbpages)
> >  		return 0;
> 
> This is subtly wrong. It probably shuts the compiler up, but it's subtly
> wrong.
> 
> x86 has 4 paging modes. I'll use the SDM/Intel terminology:
> 
> 32-bit:
>  * 32-bit paging: 2-level
>  * PAE: 3-level
> 64-bit:
>  * 4-level paging
>  * 5-level paging
> 
> But "gbpages" are not available in PAE paging. It's a hardware
> limitation. This doesn't cause a functional problem because the pud
> level is not folded. But it is confusing and not really an accurate way
> to write this check.
> 
> The *right* way to do this is probably something like this in a header:
> 
> static inline bool direct_gbpages(void)
> {
> 	if (!IS_ENABLED(CONFIG_X86_DIRECT_GBPAGES))
> 		return false;
> 
> 	return __direct_gbpages;
> }
> 
> Which just happens to point readers over to this Kconfig nugget:
> 
> config X86_DIRECT_GBPAGES
>         def_bool y
>         depends on X86_64
> 
> which, combined with the knowledge that 32-bit has a 3-level mode, would
> make the proposed check obviously wrong.
> 
> So I'll take this as a suitable alternative:
> 
> 	/* Avoid compiling the below code if PUD-level mappings are impossible: */
> 	if (IS_ENABLED(CONFIG_X86_DIRECT_GBPAGES))
> 		return 0;
> 
> 	if (!direct_gbpages)
> 		return 0;
> 
> That will compile-time optimize the code away in the exact right
> conditions *and* fix the (assumed by me) compile error that you were
> chasing.

I thought the same. but It seemed odd at the time since direct_gbpages is
always 0 when !CONFIG_X86_DIRECT_GBPAGES.

Howver, I've missed the X86_DIRECT_GBPAGES is for X86_64 only and It was
wrong totally.

I'll follow your suggestion.

> > @@ -1730,7 +1730,8 @@ static int populate_pud(struct cpa_data *cpa, unsigned long start, p4d_t *p4d,
> >  	/*
> >  	 * Map everything starting from the Gb boundary, possibly with 1G pages
> >  	 */
> > -	while (boot_cpu_has(X86_FEATURE_GBPAGES) && end - start >= PUD_SIZE) {
> > +	while (CONFIG_PGTABLE_LEVELS > 3 && boot_cpu_has(X86_FEATURE_GBPAGES) &&
> > +	       end - start >= PUD_SIZE) {
> >  		set_pud(pud, pud_mkhuge(pfn_pud(cpa->pfn,
> >  				   canon_pgprot(pud_pgprot))));
> 
> This is an OK approach. But there's a way to fix this site *and*
> optimize a non-zero amount of other code at the same time. Add this hunk
> to arch/x86/Kconfig.cpufeatures:
> 
> config X86_DISABLED_FEATURE_GBPAGES
>         def_bool y
>         depends on X86_32
> 
> That will turn the boot_cpu_has() check in to something that can be
> resolved at compile time. It has the added advantage of compiling out
> all of the code under X86_FEATURE_GBPAGES everywhere else in the tree.

Does it? when I glimpse check, this wouldn't be compiled since
there is no bit for X86_DISABLED_FEATURE_GBPAGES and defining the
DISABLED bit for FEATURE_GBPAGES seems odd since bit X86_FEATURE_GBPAGES
is already defined.

In stead of CONFIG_PGTABLE_LEVEL > 3, as above, would it be better to
add check IS_ENABLED(CONFIG_X86_DIRECT_GBPAGES)?

Thanks.

-- 
Sincerely,
Yeoreum Yun
