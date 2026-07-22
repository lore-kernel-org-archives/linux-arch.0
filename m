Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1528B345EA6;
	Wed, 22 Jul 2026 17:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784741272; cv=none; b=JVg+KO0Pp8xbD1F9rbU+t5xQzAskAp4JGzWG9rl34H4VnC2Qbe8C4PRfJND2Nwf95PoMaaGGKr4fv/7i666OGYtvQkX3W6O4R3QqiETU+QWH8wD+tKn7jl/Wz2589FV2HxW1O0PVUkRQiWPpSOFjEGRXi+Ej6kL/RT6/PMxqjYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784741272; c=relaxed/simple;
	bh=UJJJ6gDdFfQhPAspitY0ExVcYQKJakkmR/X3IOo4bZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILQJsubn1TrusxHcTLsOiyqePhYNZilyQFl1f7Z18+bZm0j71SiKTighZBIrX0vQUxAtYdwRxHfyIWt6JguUIYxg4+WDzlnJzut9LWUMlCukR8naFTt2RMJ2VSdQLfON0pL002lDCQ90YSqpArpv1jWH8yTHqJDc1tGz8mdFygA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SoeZpZp+; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SoeZpZp+"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2D7B1595;
	Wed, 22 Jul 2026 10:27:41 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B55B63F66F;
	Wed, 22 Jul 2026 10:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784741265; bh=UJJJ6gDdFfQhPAspitY0ExVcYQKJakkmR/X3IOo4bZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SoeZpZp+wsxHy2IPoBPIESiHfIlciJelBcAUO0h9BaNgywgcLRKe59vGZr1KsfOtU
	 zXqwnNHi8fnyFJ4Z4tV45RCq4+uQHINF4Mo8FApJ3gK1YQgEZ3tQYqJ6ysDA6eAPD+
	 h3LKbzFF1zV5s5ibd/Q5KVSGVirnUpwJnXEtiFKM=
Date: Wed, 22 Jul 2026 18:27:36 +0100
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
Subject: Re: [PATCH RFC v2 12/20] x86: mm: define pudp_set_access_flags()
 when CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD is enabled only.
Message-ID: <amD9iD7rjmU__9b6@e129823.arm.com>
References: <20260722-dummy_ptxp3-v2-0-d9e4bad31e0a@arm.com>
 <20260722-dummy_ptxp3-v2-12-d9e4bad31e0a@arm.com>
 <188623a9-dba0-4229-a7ff-5feb2ef0c088@intel.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <188623a9-dba0-4229-a7ff-5feb2ef0c088@intel.com>

Hi Dave,

> > diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> > index f32facdb3035..edad847a2ecd 100644
> > --- a/arch/x86/mm/pgtable.c
> > +++ b/arch/x86/mm/pgtable.c
> > @@ -411,6 +411,7 @@ int pmdp_set_access_flags(struct vm_area_struct *vma,
> >  	return changed;
> >  }
> >  
> > +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> >  int pudp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
> >  			  pud_t *pudp, pud_t entry, int dirty)
> >  {
> > @@ -430,6 +431,7 @@ int pudp_set_access_flags(struct vm_area_struct *vma, unsigned long address,
> >  
> >  	return changed;
> >  }
> > +#endif /* CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD */
> >  #endif
> >  
> >  bool ptep_test_and_clear_young(struct vm_area_struct *vma,
> 
> #ifdefs in .c files are evil.
> 
> The changelog doesn't make a strong enough case for why this evil should
> be tolerated.
> 
> These are also _precisely_ the kind of #ifdefs that cause compilation
> problems. This one is:
> 
> #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> /// function here
> #ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> /// another function here
> #endif
> #endif
> 
> So there end up being a couple of dependent config options in play. If
> there are compile problems, this makes them harder to find.
> 
> What is the _actual_ goal here? Saving 50 bytes of kernel text?

TBH, this came from for v1's change of behavior set_pud() where
triggered compiliation problem with v2 this change wouldn't require.

However, wrappering pudp_set_access_flags() with
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD seems reasonable for not only
saving a kernel text but also keeping consistency with the other pattern
like pudp_invalidate(), pudp_establish() and etc.

Am I mising something?

-- 
Sincerely,
Yeoreum Yun
