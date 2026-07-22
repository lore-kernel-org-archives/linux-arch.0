Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD0243747C;
	Wed, 22 Jul 2026 20:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784751531; cv=none; b=kPqVSWRaqbp9psIVDf/XcOtxO4ItfdBpUZFS4+UFyQPBdja0Dh9fHzm9/QCHpskFndnsaxw/q53lQhTkjYIp+HWa+vf/QSaRqoHUKbT/NO77JiqWgwqd2/rl73T+xyAfwF+txDtgBW1nCJIXVYCUbtv80WI3nYP8NKyS7Kj3tgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784751531; c=relaxed/simple;
	bh=ov7c+9CWDC2LAyEksO+C2pB8mXtkAOCi10JJO6wa1g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmZ055sEWToJID2/oOr2bQcTXcP001VKK444ZKpD28wDqGspIAsjq1GAUBrIJUFWDUdZSXQAScpAQXl24xc+qw6JJh/vfc64te3ZBjgUmdlDFoSqLsLWmlaxx8iXxqMIafqdXvKs3q0kUjOHsuHk/cd+ZISRVBcWf6g4u5MkQmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=aiMgIq3l; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="aiMgIq3l"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED3061595;
	Wed, 22 Jul 2026 13:18:41 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 066363F59E;
	Wed, 22 Jul 2026 13:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784751526; bh=ov7c+9CWDC2LAyEksO+C2pB8mXtkAOCi10JJO6wa1g4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aiMgIq3lU/qztGdY5ckcEtoH4sGXiubpcTNstTvwu98UOWWePxdJNyZ59CI4DTUgx
	 yDvv0SQFD+xDj41NppNkZJE85iCi+rKzLxJK7D5KIdXE5wBFK4aLMoc9apSCP5Bf3x
	 lWhfLdLFiXooDHH9+ISqgCgK1LUPPRLrHnct3Y6Q=
Date: Wed, 22 Jul 2026 21:18:36 +0100
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
Message-ID: <amElnEbvRTjv2hyU@e129823.arm.com>
References: <20260722-dummy_ptxp3-v2-0-d9e4bad31e0a@arm.com>
 <20260722-dummy_ptxp3-v2-14-d9e4bad31e0a@arm.com>
 <0ea931f1-4801-4d32-b6ce-4787a8d3daa9@intel.com>
 <amD7ab_KuJPdBQBh@e129823.arm.com>
 <6f5060a7-0a64-49fc-81a3-ae88729ef794@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f5060a7-0a64-49fc-81a3-ae88729ef794@intel.com>

> On 7/22/26 10:18, Yeoreum Yun wrote:
> >>> @@ -1730,7 +1730,8 @@ static int populate_pud(struct cpa_data *cpa, unsigned long start, p4d_t *p4d,
> >>>  	/*
> >>>  	 * Map everything starting from the Gb boundary, possibly with 1G pages
> >>>  	 */
> >>> -	while (boot_cpu_has(X86_FEATURE_GBPAGES) && end - start >= PUD_SIZE) {
> >>> +	while (CONFIG_PGTABLE_LEVELS > 3 && boot_cpu_has(X86_FEATURE_GBPAGES) &&
> >>> +	       end - start >= PUD_SIZE) {
> >>>  		set_pud(pud, pud_mkhuge(pfn_pud(cpa->pfn,
> >>>  				   canon_pgprot(pud_pgprot))));
> >> This is an OK approach. But there's a way to fix this site *and*
> >> optimize a non-zero amount of other code at the same time. Add this hunk
> >> to arch/x86/Kconfig.cpufeatures:
> >>
> >> config X86_DISABLED_FEATURE_GBPAGES
> >>         def_bool y
> >>         depends on X86_32
> >>
> >> That will turn the boot_cpu_has() check in to something that can be
> >> resolved at compile time. It has the added advantage of compiling out
> >> all of the code under X86_FEATURE_GBPAGES everywhere else in the tree.
> > Does it? when I glimpse check, this wouldn't be compiled since
> > there is no bit for X86_DISABLED_FEATURE_GBPAGES and defining the
> > DISABLED bit for FEATURE_GBPAGES seems odd since bit X86_FEATURE_GBPAGES
> > is already defined.
> 
> x86 is a special snowflake here and all the similarly-named things glued
> together with magic makes them hard to grok.
> 
> Our X86_FEATURE_* bits normally compile down to a bit in a bitmap in
> memory. But, there are also some optimizations in the helpers that
> access those bits. The optimizations turn bit checks like:
> 
> 	if (bitmap[N] & bit)
> 		...
> 
> into a compile-time check:
> 
> 	if (__builtin_constant_p(bit) && DISABLED_MASK_BIT_SET(bit) ? 0:
> 	    (bitmap[N] & bit))
> 		...
> 
> The DISABLED_MASK_BIT_SET() macro magic check if (for instance)
> X86_DISABLED_FEATURE_GBPAGES is around. Some processing of the Kconfig
> variables produces a header with X86_DISABLED_FEATURE_GBPAGES defined.

Sorry. But do you mean check with cpu_feature_enabled() not with
boot_cpu_has()?
IIRC, the boot_cpu_has() doesn't use the DISABLE_MASK_BIT_SET() but
uses REQUIRED_MASK_BIT_SET() and I don't expect it wouldn't make
an optimisation to constant check which is contrast to DISABLE_MASK_BIT_SET().

> > Instead of CONFIG_PGTABLE_LEVEL > 3, as above, would it be better to
> > add check IS_ENABLED(CONFIG_X86_DIRECT_GBPAGES)?
> 
> That would definitely change the behavior. It honestly might be the
> _right_ change, but I'm ignoring that for the moment because even if it
> is best it is fodder for another patch, not this one.
> 
> Please just keep the check against X86_FEATURE_GBPAGES for now.

Okay. In round, we can remove CONFIG_PGTABLE_LEVEL check too since
it wouldn't make a compile error right now.

-- 
Sincerely,
Yeoreum Yun
