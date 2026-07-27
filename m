Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361D815E5DC;
	Mon, 27 Jul 2026 18:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785175601; cv=none; b=hvhQVV4wA3+1zKdWNzveyjaqFtKB6p8Itms3c660ZxpEOFix4QSXwCcV4kJYi/lyuZbylLz8wJe+eeLKVemVUT/0qhJ3UMWEzysO/aHg+wr5gz2YKkBWi1cIYheKyW7KHi297GtGpUmATJm/42iMc4BcPkqAJBlSmueTwqQ5nk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785175601; c=relaxed/simple;
	bh=17fUHUjXNeVWMgUSlC4I4UbGJCuscyMxz/0B2wiLID0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jSCdM+0nzTbVn2h6pcP47KmTWwnSrKG9CVHqclsU7YBTbHAxs3EL09M0Xr6uI0V/EU3dLd7Zj0WLEOmxo+ezQ0ZLdEvQ3B3JmM1vZfGZ+x5RosF9VAISLUCcPSbLN8j/3g+YxFN438ribKtBi2VnXlJBNxLSb0KvYihP4+N4PwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Lu1jXBGs; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Lu1jXBGs"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6879A16F8;
	Mon, 27 Jul 2026 11:06:34 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 380273F86F;
	Mon, 27 Jul 2026 11:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785175598; bh=17fUHUjXNeVWMgUSlC4I4UbGJCuscyMxz/0B2wiLID0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lu1jXBGsav0iVgrGWSZsvRyAlJ5at2QxNHv1w1hXfz5ioFXzND+YJHKyFrA03qRFY
	 Q/hx54v2Cd4KFrZuJPBBE4RftgYfvLs49KTQX5Dz6eKnnAQEbcQ/tI+05OTQ1z0zkD
	 i2PqFVr45Lxp9zCvG4+AVFaAlSVytmKw9arVF48g=
Date: Mon, 27 Jul 2026 19:06:29 +0100
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
	Stafford Horne <shorne@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org, kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
	linux-openrisc@vger.kernel.org
Subject: Re: [PATCH RFC v2 12/20] x86: mm: define pudp_set_access_flags()
 when CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD is enabled only.
Message-ID: <ameeJWmSQqTJ7uzU@e129823.arm.com>
References: <20260722-dummy_ptxp3-v2-0-d9e4bad31e0a@arm.com>
 <20260722-dummy_ptxp3-v2-12-d9e4bad31e0a@arm.com>
 <188623a9-dba0-4229-a7ff-5feb2ef0c088@intel.com>
 <amD9iD7rjmU__9b6@e129823.arm.com>
 <4dbf7e54-a541-45de-b4b9-43ee5add287b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dbf7e54-a541-45de-b4b9-43ee5add287b@kernel.org>

On Mon, Jul 27, 2026 at 05:02:00PM +0200, David Hildenbrand (Arm) wrote:
> On 7/22/26 19:27, Yeoreum Yun wrote:
> > Hi Dave,
> > 
> >>> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> >>> index f32facdb3035..edad847a2ecd 100644
> >>> --- a/arch/x86/mm/pgtable.c
> >>> +++ b/arch/x86/mm/pgtable.c
> >>> @@ -411,6 +411,7 @@ int pmdp_set_access_flags(struct vm_area_struct *vma,
> >>>  	return changed;
> >>>  }
> >>>  
> >>> +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> >>>  int pudp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
> >>>  			  pud_t *pudp, pud_t entry, int dirty)
> >>>  {
> >>> @@ -430,6 +431,7 @@ int pudp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
> >>>  
> >>>  	return changed;
> >>>  }
> >>> +#endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
> >>>  #endif
> >>>  
> >>>  bool ptep_test_and_clear_young(struct vm_area_struct *vma,
> >>
> >> #ifdefs in .c files are evil.
> >>
> >> The changelog doesn't make a strong enough case for why this evil should
> >> be tolerated.
> >>
> >> These are also _precisely_ the kind of #ifdefs that cause compilation
> >> problems. This one is:
> >>
> >> #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >> /// function here
> >> #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> >> /// another function here
> >> #endif
> >> #endif
> >>
> >> So there end up being a couple of dependent config options in play. If
> >> there are compile problems, this makes them harder to find.
> >>
> >> What is the _actual_ goal here? Saving 50 bytes of kernel text?
> > 
> > TBH, this came from for v1's change of behavior set_pud() where
> > triggered compiliation problem with v2 this change wouldn't require.
> 
> If the patch is not required right now, let's drop it.
> 
> I agree that it's the right thing to do: just look at pudp_invalidate() in the
> very same file, but if we can reduce the churn and leave the cleanups to x86
> folks, that seems to be preferred.

Yes. I'll drop in next version.

-- 
Sincerely,
Yeoreum Yun
