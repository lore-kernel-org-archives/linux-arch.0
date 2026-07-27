Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA793374721;
	Mon, 27 Jul 2026 15:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167463; cv=none; b=GGN2ExAHh8It8wIn7d9auBEcuB6NsTk6mcgIdbtxvu31Xy2dhYP79dN84zHb5JIQaHAMxGV3JnNa1urPwNtYOahmPCBCiFMYn4JUt2CC79x53JG8erZ7phAt03Rvh7929WGwWFsdLV2E9l4C3NwwmCVCvW25ACEGde7GQIvqPOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167463; c=relaxed/simple;
	bh=ppKyIilh92SxJAUCgXnn55E0Ht4c4utSVo8m2JGUl6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZlV7skzLiXzxi8R37CKXrZQx3DC8sb24hUqk79OnyJAlPWV5QiOSkLNJd46QzWl07z48TUpK8O91ZDeii/OM7vtMtfdgFqQZ6l71byV7VgBEFEe+eKFAFG7ULCw7weVgY/0DsMidjIIUmyGPfSYZs1xXlWEzWBlIH8F+NHoSG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CAzb1J3R; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CAzb1J3R"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08E9B15A1;
	Mon, 27 Jul 2026 08:50:57 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D0923F763;
	Mon, 27 Jul 2026 08:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785167461; bh=ppKyIilh92SxJAUCgXnn55E0Ht4c4utSVo8m2JGUl6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CAzb1J3RvS7dAaxGpiUZMcpmhuOLyE3H5eHiBiE2m0YEkDO6qDZ7Lqich6Vv5OhX1
	 EK7wUBI9x0E+2OspOWwN0sF+iBLiRBIV6786feaJHGbBxX4bSwgutgvX/z9p1LCWyl
	 f7iWW8NaSn6UkJF8qxCrYmgmdiKe80Y7r+WCd/TU=
Date: Mon, 27 Jul 2026 16:50:52 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, Dave Hansen <dave.hansen@intel.com>,
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
Subject: Re: [PATCH RFC v2 00/20] mm: optimize unnecessary loads due to
 ptep_get() and friends out
Message-ID: <amd-XDcvRZJzkLRX@e129823.arm.com>
References: <20260722-dummy_ptxp3-v2-0-d9e4bad31e0a@arm.com>
 <0143b927-08c5-4e94-ae6e-2a0d7bfe950f@intel.com>
 <amD-TLGWGdMK2ItC@e129823.arm.com>
 <2a2923e4-6166-4ed6-97ba-2e544a1a2f9d@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a2923e4-6166-4ed6-97ba-2e544a1a2f9d@kernel.org>

On Mon, Jul 27, 2026 at 05:18:00PM +0200, David Hildenbrand (Arm) wrote:
> On 7/22/26 19:30, Yeoreum Yun wrote:
> >> One of my nits about v1 was that it didn't really frame the series
> >> precisely. It talks about "optimization" instead of fundamentally
> >> changing the way that the kernel deals with folded page table levels.
> >>
> >> The optimization that this *wants* to talk about kinda falls out of that
> >> refactoring. It's not really the core of the series, IMNHO.
> >>
> >> This series effectively changes the rules about where and how folded
> >> page table levels can be manipulated. In doing that, the door is opened
> >> to optimizing out the unnecessary loads.
> > 
> > I see. might the title and the cover letter should be reparsed.
> > Thanks to remind it again :)
> 
> While v1 changed "where and how folded page table levels can be manipulated"
> more drastically, v2 leaves most of set_pgd/... working for now, and really only
> changes how pgd_get() operates.
> 
> With v2, there is mostly only a change for page table walkers that use
> pgd_get(): while the existing model already made all these levels be skipped in
> most places except in ptdump code, we now also have to skip them in ptdump code.
> 
> So yes, that should be clearly spelled out: as long as pgd_get() is not
> involved, set_pgd()/pgd_page_vaddr()... will keep working as is.
> 
> The moment someone switches to pgd_get() with folded page tables (like riscv
> already does), set_pgd() is disallowed, and modifications on the actual level
> must be performed. As discussed, a common helper for vmalloc faults would
> already minimize the pain quite a lot in that scenario.
> 
> While we should make that clearer in the patch description, I am wondering
> whether we should also add some basic MM documentation for folded page tables,
> where we at least explain the current state-of-the-art (what's ignored when
> traversing, why does "no_p4d" actually mean "pgd helpers are dummies and p4d
> helpers implement the real logic").

I see, while I'm trying to spell out those, let me see the MM doc
to check whether we need to explain more about this.

-- 
Sincerely,
Yeoreum Yun
