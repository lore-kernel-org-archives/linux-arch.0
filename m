Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D369D7080D;
	Fri,  2 Oct 2026 15:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790954382; cv=none; b=fyZbFbJFRYhXkHuTbB37kCJoIE25lnoaRM51N/biD+VqlyMt1/dUI4Ga+VZyHcpz55wjjQjnztE0Qs/Z1MuiuruBGoDRv10YWGk5DSjRT87IdTvA2tHKZ0Vg/kV8T+zB8r0jEhIJWJiV2NjD9viu8QHedRfpZAaX/88WSbCDD2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790954382; c=relaxed/simple;
	bh=SSl2JQPa1sjMP27v12qlQtHRT4X5Eb5ZVPfcjcc+ylY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+VzQ2eo5/Jb/PH+xuFks5AcCVlsinj3PAxQZ0fiNTOcOp1qZw27BZ+oliY0x4CQ5z6ZxDIKa2u/3L6X3dyUriMOkJXmnIZLePbmR70EhrCNkGvQwZ1EWS5wlrWzUrDQIqcPETAWIypMwseos/1NbgDfgUO/rFZtyupNxnCjeSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=IlyejI7q; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="IlyejI7q"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 032FA1476;
	Fri,  2 Oct 2026 08:19:37 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 641853F85F;
	Fri,  2 Oct 2026 08:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790954380; bh=SSl2JQPa1sjMP27v12qlQtHRT4X5Eb5ZVPfcjcc+ylY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IlyejI7qb0gs7j139i/OXFX7YSa7K8RDIzOWTpRuOE9JAmghBbLW79oG+rU9uR0nM
	 /TUyql12KMCKrjEBq3NTEwvaca43sTKTauxz9jPkFBtfHxO2tjJ+5SNvDYkgZd4Cbt
	 yJb4XX+muSik5WMBpZk3TvG/LO7AvQ/V672lsWiA=
Date: Fri, 2 Oct 2026 16:19:32 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Muhammad Usama Anjum <usama.anjum@arm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-openrisc@vger.kernel.org, Sohil Mehta <sohil.mehta@intel.com>,
	Russell King <linux@armlinux.org.uk>,
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
	Stafford Horne <shorne@gmail.com>
Subject: Re: [PATCH 00/21] mm: change behavior of pXdp_get()/pXd_page() in
 compile-time folded pgtable
Message-ID: <ar_LhBOaywb-n_H2@e129823.arm.com>
References: <20260921-dummy_ptxp3-v1-0-cd40cf68242e@arm.com>
 <81b1fec1-3b5e-43ed-a5b3-1a73c80201d8@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81b1fec1-3b5e-43ed-a5b3-1a73c80201d8@arm.com>

On Mon, Sep 21, 2026 at 10:11:04PM +0100, Muhammad Usama Anjum wrote:
> On 21/09/2026 11:55 am, Yeoreum Yun wrote:
> > Using ptep_get() and its counterparts in common code is suboptimal on
> > kernel configurations with generic compile-time folded page tables.
> > By default, ptep_get() and its friends expands to READ_ONCE(),
> > forcing the compiler to emit a load even when the value is not used afterwards.
> > 
> > This issue was recently reported by Christophe Leroy [1] for ppc32
> > preventing futher code conversion to ptep_get()/pmdp_get()/... helper
> > and the same behavior can also be observed on arm64 when built with
> > 2- or 3-level page tables
> > 
> > e.g) perf_get_page_size() in arm64 with CONFIG_PGTABLE_LEVEL=3:
> > 
> > 00000000000052a0 <perf_get_page_size>:
> >     ...
> >     52dc: d53b4234     	mrs	x20, DAIF
> >     52e0: d50343df     	msr	DAIFSet, #0x3
> >     ...
> >     52fc: d35e9a69     	ubfx	x9, x19, #30, #9        /* pud_offset_lockless() */
> >     5300: f9403508     	ldr	x8, [x8, #0x68]
> >     5304: f869790a     	ldr	x10, [x8, x9, lsl #3]   /* pudp_get() */
> >     5308: f90007ea     	str	x10, [sp, #0x8]
> >     530c: f8697908     	ldr	x8, [x8, x9, lsl #3]    /* pudp_get() */
> >     ...
> >     5360: 90000009     	adrp	x9, 0x5000 <perf_prepare_sample+0x548>
> >     5364: 92746908     	and	x8, x8, #0x7ffffff000
> >     5368: d3557675     	ubfx	x21, x19, #21, #9       /* pmd_offset_lockless() */
> >     ...
> >     5394: f8757ac8     	ldr	x8, [x22, x21, lsl #3]  /* pmdp_get() */
> > 
> > Though PGTABLE_LEVEL=3, since the pudp_get() still remain with
> > READ_ONCE(), there's redundant load for the pud which is folded.
> > 
> > To prevent generating suboptimal code, make pXdp_get() return a dummy
> > entry for compile-time folded page tables, make the helpers such as
> > pXd_offset()/pXd_offset_lockless(), set_pXd() validate dummy entries
> > at compile time to catch the wrong usage and prohibit calls to
> > pXd_page() in pgtable-nopXd.h.
> > 
> > This series does not change the behaviour of existing code that directly
> > manipulates folded page-table levels using set_pgd(), pgd_page_vaddr(), and
> > related helpers. Those helpers continue to behave as before.
> > 
> > The new restrictions only apply to code that adopts the pXdp_get()-based
> > access model for compile-time folded page tables.
> > 
> > As the pXdp_get() can return *dummy* entry, some of code using
> > the stack value where saves the pXdp_get() could be a problematic:
> > 
> >   1. Passing address of stack value where saves the pXdp_get() result
> >      to pXd_offset() for example:
> > 
> >        pud_t *pudp, pud;
> >        pmd_t *pmdp;
> > 
> >        pud = pudp_get(pudp, address);
> >        pmdp = pmd_offset(&pud, pud, address);
> > 
> >      (e.g. host_pfn_mapping_level() in loongarch).
> > 
> >   2. Using the pXdp_get() result to use as argument of pXd_val() and
> >      to check prot without checking pgtable is folded.
> >      for example, x86's effective_prot().
> > 
> >   3. Using set_pXd() with pXdp_get() will set problematic dummy entry
> >      in folded page table like:
> > 
> >        set_pXd(pxdp, pXdp_get(pxdp_k));
> > 
> >   4. Using pgd_page_vaddr() to get the first-level pgtable.
> >      passing dummy pxdp_get() for pgd_page_vaddr() will return wrong
> >      address. Therefore, make pgd_page_vaddr() and pXd_pgtable() to
> >      trigger the error for improper usage with folded dummy entry in the
> >      generic compile-time folded pgtable.
> > 
> > Thanksfully, above cases are rare since (1) most of usage using
> > pXd_offset() with result of upper pXd_offset(), (2) it's extreamely
> > rare to use pXd_val() for non-leaf entry in the kernel,
> > (3) is to handle the vmalloc_fault or set the first level of page table
> > and (4) to setup early page table and etc.
> > 
> > Therefore, properly handle this uncommon and problematic pattern, and
> > document the current design of compile-time folded page tables.
> > 
> > This patch is based on mm-unstable.
> > 
> > Future work
> > ===========
> >  - print_bad_page_map() and show_pte() still prints dummy values
> >    instead of printing the same content for all generic compile-time
> >    folded page tables. We might want to skip printing dummy values later.
> > 
> >  - We currently catch abuse of dummy values on the stack at compile-time by
> >    relying on constant propagation by the compiler. Usama's work [3] on using
> >    distinct types for sw vs. hw PTEs could help here as well."
> > 
> >  - Clean up vmalloc fault handling by synchronizing the vmalloc entry on
> >    32-bit architectures. This code is almost identical across architectures.
> > 
> >  - Unfortunately, the current design of compile-time folded page tables appears
> >    to be internally consistent but confusing. For example,
> >    when CONFIG_PGTABLE_LEVELS is 2, p4d, pud, and pmd are expected to
> >    be folded into pgd. However, the architecture code uses set_pmd()
> >    to update the top-level page-table entry, even though it includes pgtable-nopmd.h.
> > 
> >    In the future, it would be good to eliminate this source of confusion,
> >    possibly by treating all folded upper levels consistently as dummy wrappers
> >    around the highest real page-table level:
> > 
> >          NOPGD
> >    --> +------+           P4D
> >        | ptr0 |-------> +------+           PUD
> >        +------+         | ptr0 |-------> +-----+
> >                         | ptr1 |-        | ptr | -------> ...
> >                         | ptr2 | \       | ptr |
> >                         | ptr3 |  \        ...
> >                           ...      \
> >                                     \        PUD
> >                                      +----> +-----+
> >                                             | ptr | -------> ...
> >                                             | ptr |
> >                                               ...
> > 
> > Link: [1] https://lore.kernel.org/all/0019d675-ce3d-4a5c-89ed-f126c45145c9@kernel.org/
> > Link: [2] https://lore.kernel.org/all/20251113014656.2605447-1-samuel.holland@sifive.com/
> > Link: [3] https://lore.kernel.org/r/74182e50-b54f-4d2d-a27f-3a59a538d6bc@arm.com
> 
> I applied all 21 patches to the declared base and built and booted the
> kernels before and after on x86_64 and arm64 using virtme-ng.
> 
> Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>

Thanks for your testing ;)

[...]

-- 
Sincerely,
Yeoreum Yun
