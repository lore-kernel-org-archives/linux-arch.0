Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801258;
	b=wr9WXccx/RGh4503N7GG9EuZfVJn43y1tD7NpZ6sn2MaolhKE2r9D5sK9vwXJ5YE6rkI
	 s0DlXPtSVB63+M5hiJcYXk633wKenjG3YkVhdmaEMdpM9CAYNhkNA4H413NrWIAx9LkHq
	 jU3p87CtgI/UiKhocWxa0Vom8mKJmW7e2KxmB2DObACxA29DBWPjtx+L0ovirODT3SKM/
	 mP6oyHsIgouIsa8oqzlnWGzHSPCnegkEtrEs8j+fPgvH8pgq9Er9oH1ic6uzhX80ZDhbx
	 LBlwoctA04OzwqBnoQWLCM1kT+6e8X6sXMFKRH7Pz0/arlF53S6rBDBK07++MdVCg5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801258;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=lu+By1tioveqgXijEvnKTH9hPcb3YW7+OPvZU2YHEqU=;
	b=fNdBoxtcsO4cARk7xkpYCAu+BEhkSqAOrD0baBYUumhCfajq1bkfB7Xrk9/VoqvGA8ja
	 9Naml6dBynrFAD5USGGMYkeYluEaIVcYdRFal9jErhew3w24oSE2ocDrHQ6LBgYH05YXP
	 wBxRiyHx/Y1A25gCilF0oFS1TtB0JUP8hAW2LHooymz6qLHQ/Fr/YvZrMYSTM5wEU2wPl
	 1OhkS3fOPZ6hg9RXTe4W5EglFPDFxNqx5daXTu2fDQaR+pimU5F7wZT6sfNj7n1akFlgt
	 oM3Pw2DqAcpLXc+I7XHQCjB8BlRKcF3lmRHerIOl9x24gc4v+INybjwhK5YiMTl5pkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xtq1rXDH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4B6606A32C;
	Wed,  4 Nov 2026 14:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xtq1rXDH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7652A1F00919;
	Wed,  4 Nov 2026 14:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793801257;
	bh=lu+By1tioveqgXijEvnKTH9hPcb3YW7+OPvZU2YHEqU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Xtq1rXDHtjUtiz8ZQNhGl864CXHsKzFi7B8tvlmfWu7TR4c8iU1QQ7cE7+ej14qL7
	 pS6JNOtv23O1/J8qhN2eLLxNFn2kbXGEqpCY8pZ1HAwQNIaSurSyvEUbjql/gPvPal
	 T61iZnGV/vR2e3ac0Bw20MADsSnu4thaTB1LlycSD0uxm/ysKcL7IDveGbARhJDu2n
	 UqqT1++qFKe5w5mHs/I5Tz0WsPNt65ShBsotTQGk4N2WWfr9HhScOOyEFInpetJXft
	 htHQMU8YKPJgBdeZNHOobv7YqLUCZLSGPQa21XFzFhn26VdaOrT6x53EJ8UNTJmbov
	 BccP2EIaWfYYA==
Message-ID: <64b74093-541c-4f32-8ea4-c8007067eeea@kernel.org>
Date: Wed, 4 Nov 2026 15:07:16 +0100
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v2 00/21] mm: change behavior of
 pXdp_get()/pXd_page() in compile-time folded pgtable
To: Yeoreum Yun <yeoreum.yun@arm.com>, Russell King <linux@armlinux.org.uk>,
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>,
 Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Barry Song <baohua@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Michal Hocko <mhocko@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski
 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
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
 Sohil Mehta <sohil.mehta@intel.com>
References: <20261102-dummy_ptxp3-v2-0-78840b2ec73c@arm.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261102-dummy_ptxp3-v2-0-78840b2ec73c@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/2/26 12:21, Yeoreum Yun wrote:
> Using ptep_get() and its counterparts in common code is suboptimal on
> kernel configurations with generic compile-time folded page tables.
> By default, ptep_get() and its friends expands to READ_ONCE(),
> forcing the compiler to emit a load even when the value is not used afterwards.
> 
> This issue was recently reported by Christophe Leroy [1] for ppc32
> preventing futher code conversion to ptep_get()/pmdp_get()/... helper
> and the same behavior can also be observed on arm64 when built with
> 2- or 3-level page tables
> 
> e.g) perf_get_page_size() in arm64 with CONFIG_PGTABLE_LEVEL=3:
> 
> 00000000000052a0 <perf_get_page_size>:
>     ...
>     52dc: d53b4234     	mrs	x20, DAIF
>     52e0: d50343df     	msr	DAIFSet, #0x3
>     ...
>     52fc: d35e9a69     	ubfx	x9, x19, #30, #9        /* pud_offset_lockless() */
>     5300: f9403508     	ldr	x8, [x8, #0x68]
>     5304: f869790a     	ldr	x10, [x8, x9, lsl #3]   /* pudp_get() */
>     5308: f90007ea     	str	x10, [sp, #0x8]
>     530c: f8697908     	ldr	x8, [x8, x9, lsl #3]    /* pudp_get() */
>     ...
>     5360: 90000009     	adrp	x9, 0x5000 <perf_prepare_sample+0x548>
>     5364: 92746908     	and	x8, x8, #0x7ffffff000
>     5368: d3557675     	ubfx	x21, x19, #21, #9       /* pmd_offset_lockless() */
>     ...
>     5394: f8757ac8     	ldr	x8, [x22, x21, lsl #3]  /* pmdp_get() */
> 
> Though PGTABLE_LEVEL=3, since the pudp_get() still remain with
> READ_ONCE(), there's redundant load for the pud which is folded.
> 
> To prevent generating suboptimal code, make pXdp_get() return a dummy
> entry for compile-time folded page tables, make the helpers such as
> pXd_offset()/pXd_offset_lockless(), set_pXd() validate dummy entries
> at compile time to catch the wrong usage and prohibit calls to
> pXd_page() in pgtable-nopXd.h.
> 
> This series does not change the behaviour of existing code that directly
> manipulates folded page-table levels using set_pgd(), pgd_page_vaddr(), and
> related helpers. Those helpers continue to behave as before.
> 
> The new restrictions only apply to code that adopts the pXdp_get()-based
> access model for compile-time folded page tables.
> 
> As the pXdp_get() can return *dummy* entry, some of code using
> the stack value where saves the pXdp_get() could be a problematic:
> 
>   1. Passing address of stack value where saves the pXdp_get() result
>      to pXd_offset() for example:
> 
>        pud_t *pudp, pud;
>        pmd_t *pmdp;
> 
>        pud = pudp_get(pudp, address);
>        pmdp = pmd_offset(&pud, pud, address);
> 
>      (e.g. host_pfn_mapping_level() in loongarch).
> 
>   2. Using the pXdp_get() result to use as argument of pXd_val() and
>      to check prot without checking pgtable is folded.
>      for example, x86's effective_prot().
> 
>   3. Using set_pXd() with pXdp_get() will set problematic dummy entry
>      in folded page table like:
> 
>        set_pXd(pxdp, pXdp_get(pxdp_k));
> 
>   4. Using pgd_page_vaddr() to get the first-level pgtable.
>      passing dummy pxdp_get() for pgd_page_vaddr() will return wrong
>      address. Therefore, make pgd_page_vaddr() and pXd_pgtable() to
>      trigger the error for improper usage with folded dummy entry in the
>      generic compile-time folded pgtable.
> 
> Thanksfully, above cases are rare since (1) most of usage using
> pXd_offset() with result of upper pXd_offset(), (2) it's extreamely
> rare to use pXd_val() for non-leaf entry in the kernel,
> (3) is to handle the vmalloc_fault or set the first level of page table
> and (4) to setup early page table and etc.
> 
> Therefore, properly handle this uncommon and problematic pattern, and
> document the current design of compile-time folded page tables.
> 
> This patch is based on mm-unstable.
> 
> Future work
> ===========
>  - print_bad_page_map() and show_pte() still prints dummy values
>    instead of printing the same content for all generic compile-time
>    folded page tables. We might want to skip printing dummy values later.
> 
>  - We currently catch abuse of dummy values on the stack at compile-time by
>    relying on constant propagation by the compiler. Usama's work [3] on using
>    distinct types for sw vs. hw PTEs could help here as well."
> 
>  - Clean up vmalloc fault handling by synchronizing the vmalloc entry on
>    32-bit architectures. This code is almost identical across architectures.
> 
>  - Unfortunately, the current design of compile-time folded page tables appears
>    to be internally consistent but confusing. For example,
>    when CONFIG_PGTABLE_LEVELS is 2, p4d, pud, and pmd are expected to
>    be folded into pgd. However, the architecture code uses set_pmd()
>    to update the top-level page-table entry, even though it includes pgtable-nopmd.h.
> 
>    In the future, it would be good to eliminate this source of confusion,
>    possibly by treating all folded upper levels consistently as dummy wrappers
>    around the highest real page-table level:
> 
>          NOPGD
>    --> +------+           P4D
>        | ptr0 |-------> +------+           PUD
>        +------+         | ptr0 |-------> +-----+
>                         | ptr1 |-        | ptr | -------> ...
>                         | ptr2 | \       | ptr |
>                         | ptr3 |  \        ...
>                           ...      \
>                                     \        PUD
>                                      +----> +-----+
>                                             | ptr | -------> ...
>                                             | ptr |
>                                               ...
> 
> Link: [1] https://lore.kernel.org/all/0019d675-ce3d-4a5c-89ed-f126c45145c9@kernel.org/
> Link: [2] https://lore.kernel.org/all/20251113014656.2605447-1-samuel.holland@sifive.com/
> Link: [3] https://lore.kernel.org/r/74182e50-b54f-4d2d-a27f-3a59a538d6bc@arm.com
> 
> Patch History
> =============
> from v1 to v2:
>   - fix docutils warning.
>   - Link to v1: https://lore.kernel.org/r/20260921-dummy_ptxp3-v1-0-cd40cf68242e@arm.com
> 
> from RFC v3 to v1:
>   - Drop and rebase for CONFIG_X86_DIRECT_GBPAGES and use the Dave's
>     patch (https://lore.kernel.org/all/20260902194718.E1FF3041@davehans-spike.ostc.intel.com/)
>   - Link to RFC v3: https://lore.kernel.org/r/20260902-dummy_ptxp3-v3-0-5d8f5b17c25c@arm.com
> 
> from RFC v2 to RFC v3:
>   - repasre commit message
>   - move ptdump_pgtable_first_level() into pgalloc.h
>   - skip the huge pud operation when CONFIG_X86_DIRECT_GBPAGES is disabled
>   - docuemtns compile-time folded page table
>   - drop the applied patch.
>   - Link to RFC v2: https://lore.kernel.org/all/20260722-dummy_ptxp3-v2-0-d9e4bad31e0a@arm.com/
> 
> from RFC v1 to RFC v2:
>   - Restore slient fallback to next pXd in set_pXd() and pXd_pgtable()
>     and add check whether they're called with dummy entry.
>   - Add some comment for returning first entry of pgd in arm with
>     2 pgtable-level
>   - Link to RFC v1: https://lore.kernel.org/all/20260713135614.1618183-1-yeoreum.yun@arm.com/
> 
> ---
> Dave Hansen (1):
>       x86/mm: Introduce helper for checking direct map 1G page support
> 
> David Hildenbrand (Arm) (13):
>       ARM: mm: make nommu pgd_t a scalar
>       ARM: mm: make 2-level pgd_t a scalar
>       ARM: mm: remove custom pgdp_get()
>       LoongArch: mm: define pud_leaf() only when PUD exists
>       MIPS: mm: define pud_leaf() only when PUD exists
>       mm/pgtable: define (pgd|p4d|pud)_leaf() for folded page tables
>       mm/pgtable: define (pgd|p4d|pud)_offset_lockless() for folded page tables
>       openrisc/pgtable: drop __pmd_offset()
>       mm/pgtable: optimize pmdp_get() and friends for folded pagetable levels
>       mm/pgtable: catch abuse of folded dummy pgd_t/p4d_t/pud_t
>       mm/pgtable: disallow calling (pgd|p4d|pud)_page, pgd_page_vaddr() and (p4d|pud)_pgtable with dummy
>       mm/pgtable: disallow calling folded set_pgd/set_p4d/set_pud with dummy
>       Documentation: mm: clarify behaviour of compile-time folded page tables
> 
> Yeoreum Yun (7):
>       mm: vmscan: remove stack copy address of pud/pmd pass in walk_pud/pmd_range()
>       loongarch: kvm: remove stack copy address of pXd in pXd_offset()
>       riscv: kvm: remove stack copy address of pXd in pXd_offset()
>       riscv: mm: use proper set_pXd() for generic compile-time folded patable in vmalloc_fault()
>       mm/pgtable: redefine PGTABLE_LEVEL enum with ascend order from PGD
>       x86: mm: use pgtable_level enum in effective_prot_pXd()
>       x86: mm: carve out the generic compile-time folded pgtable case in effective_prot()
> 
>  Documentation/mm/page_tables.rst            | 84 +++++++++++++++++++++++++----
>  arch/arm/include/asm/page-nommu.h           |  4 +-
>  arch/arm/include/asm/pgtable-2level-types.h | 20 +++++--
>  arch/arm/include/asm/pgtable.h              |  2 -
>  arch/arm64/include/asm/pgtable.h            | 23 --------
>  arch/loongarch/include/asm/pgtable.h        |  2 +
>  arch/loongarch/kvm/mmu.c                    | 20 ++++---
>  arch/mips/include/asm/pgtable.h             |  2 +
>  arch/openrisc/include/asm/pgtable.h         |  3 --
>  arch/riscv/kvm/mmu.c                        | 20 ++++---
>  arch/riscv/mm/fault.c                       | 52 +++++++++++-------

To move forward with this we need an ACK from riscv folks. All other arch
changes are fairly trivial.

@Riscv people, any comments?

-- 
Cheers,

David
