Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B271261B71;
	Mon, 24 Aug 2026 02:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787537409; cv=none; b=EYIztazvsHhec4NQbH2viQOxpyFhW/Net3QSL6i9AjWnBj0VouxYEjRNkRxWcBZKsTSrKINtoswiHTSTN0gZ08LMrxFtn7hJ3LbDTCUF0vY7UH5TrxcNevsO+OaSud2GHnXNvv1FQmK9BU3J4mzcTJ/Dw9dAse3K7j4RXA/umIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787537409; c=relaxed/simple;
	bh=eOGK0wvkltA8yYZNmhWeTsiSVqPQxkng2Itm3Z60Z6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5lpHPgUIEUK4Ekftqem2Xrw6oTr2nnoetYxryf5Xd9poa/ieZI/cH7MXKkHTI4wOV9pQjV+XqdMfmK6ClzFD7L/Y0MKblScpyQCT3IiPQHxgeum0z6dg4b4kIV3f5ZuecPq03vg5e5zF0AdvXweZYOhL00JX7yyIq442HX/sZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=a4JUlAZ+; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="a4JUlAZ+"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42EDD16F2;
	Sun, 23 Aug 2026 19:10:01 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E7523F85F;
	Sun, 23 Aug 2026 19:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787537405; bh=eOGK0wvkltA8yYZNmhWeTsiSVqPQxkng2Itm3Z60Z6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a4JUlAZ+vGxifClv9CUQ6YhHZnMJIW47duH2wh57oz+0yuijrZVwRAh9yAD5nNS16
	 aHbgrzFWqMVd9B/mBLWI7ialac2s/E3e5i2TALgA9ogkPmX6xn+19TlregiL4AYNJl
	 eDLwVjZMZgsmICpyyUT+/RWvzafQ0urjffAc3AKw=
Date: Mon, 24 Aug 2026 07:40:01 +0530
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, David Hildenbrand <david@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] mm: Drop pxd_ERROR()
Message-ID: <on4gs65rttqkuw2zomuswauqrzal33wel7cmeep4yw3hpodyqd@zkrqwu4sxmnz>
References: <20260806080639.1916749-1-anshuman.khandual@arm.com>
 <aoqYS9eFTPqtgFMn@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoqYS9eFTPqtgFMn@kernel.org>

On Sun, Aug 23, 2026 at 09:50:51AM +0300, Mike Rapoport wrote:
> On Thu, Aug 06, 2026 at 01:36:39PM +0530, Anshuman Khandual wrote:
> > pxd_ERROR() has been used in generic mm just to print the page table entry
> > in pxd_clear_bad() before clearing those out with pxd_clear() later. These
> > pxd_ERROR() macros have been provided by all platforms which basically did
> > the same thing.
> > 
> > Make pxd_clear_bad() use recently added ptval_to_str() instead for printing
> > page table entries thus completely dropping dependency on platform provided
> > pxd_ERROR() macros which can then be dropped off. First move all required
> > helpers in core MM into a header file which could then be used else where.
> > 
> > Although some platforms still use those macros internally as well. In which
> > case just move these macros inside the platform for now.
> > 
> > Cc: David Hildenbrand (Arm) <david@kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org> 
> > Cc: linux-arch@vger.kernel.org
> > Cc: linux-mm@kvack.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > ---
> > This applies on v7.2-rc6 but after the following patch
> > 
> > https://lore.kernel.org/all/20260709044334.1741263-1-anshuman.khandual@arm.com/
> > 
> > Would it also make sense to just drop __FILE__ and __LINE__ from the output
> > in pxd_clear_bad() helpers as they always print the same details regardless
> > the error path and does not add much value.
> 
> Maybe replace them with the caller address?

Hi Mike,

Thanks for your review but the latest series can be found here.

https://lore.kernel.org/all/20260818040041.1891769-1-anshuman.khandual@arm.com/

- Anshuman

>  
> > Build tested for various architectures.
> > 
> >  arch/alpha/include/asm/pgtable.h              |  7 ----
> >  arch/arc/include/asm/pgtable-levels.h         | 11 -----
> >  arch/arm/include/asm/pgtable.h                |  7 ----
> >  arch/arm/kernel/traps.c                       | 17 --------
> >  arch/arm64/include/asm/pgtable.h              | 15 -------
> >  arch/csky/include/asm/pgtable.h               |  4 --
> >  arch/hexagon/include/asm/pgtable.h            |  3 --
> >  arch/loongarch/include/asm/pgtable.h          | 10 -----
> >  arch/m68k/include/asm/mcf_pgtable.h           |  6 ---
> >  arch/m68k/include/asm/motorola_pgtable.h      |  8 ----
> >  arch/m68k/include/asm/sun3_pgtable.h          |  7 ----
> >  arch/microblaze/include/asm/pgtable.h         |  7 ----
> >  arch/mips/include/asm/pgtable-32.h            | 10 -----
> >  arch/mips/include/asm/pgtable-64.h            | 13 ------
> >  arch/nios2/include/asm/pgtable.h              |  7 ----
> >  arch/openrisc/include/asm/pgtable.h           |  7 ----
> >  arch/parisc/include/asm/pgtable.h             |  3 +-
> >  arch/powerpc/include/asm/book3s/32/pgtable.h  |  2 -
> >  arch/powerpc/include/asm/book3s/64/pgtable.h  |  7 ----
> >  arch/powerpc/include/asm/nohash/32/pgtable.h  |  2 -
> >  .../include/asm/nohash/64/pgtable-4k.h        |  3 --
> >  arch/powerpc/include/asm/nohash/64/pgtable.h  |  5 ---
> >  arch/riscv/include/asm/pgtable-64.h           |  9 ----
> >  arch/riscv/include/asm/pgtable.h              |  4 --
> >  arch/s390/include/asm/pgtable.h               | 11 -----
> >  arch/sh/include/asm/pgtable-3level.h          |  6 +++
> >  arch/sparc/include/asm/pgtable_32.h           |  3 --
> >  arch/sparc/include/asm/pgtable_64.h           | 10 -----
> >  arch/um/include/asm/pgtable-2level.h          |  7 ----
> >  arch/um/include/asm/pgtable-4level.h          | 13 ------
> >  arch/x86/include/asm/pgtable-2level.h         |  5 ---
> >  arch/x86/include/asm/pgtable-3level.h         | 11 -----
> >  arch/x86/include/asm/pgtable_64.h             | 18 --------
> >  arch/xtensa/include/asm/pgtable.h             |  4 --
> >  include/asm-generic/pgtable-nop4d.h           |  1 -
> >  include/asm-generic/pgtable-nopmd.h           |  1 -
> >  include/asm-generic/pgtable-nopud.h           |  1 -
> >  include/linux/mm_types.h                      | 40 ++++++++++++++++++
> >  mm/memory.c                                   | 41 +------------------
> >  mm/pgtable-generic.c                          | 21 ++++++++--
> >  40 files changed, 65 insertions(+), 302 deletions(-)
> 
> This is nice :)
>  
> > diff --git a/arch/parisc/include/asm/pgtable.h b/arch/parisc/include/asm/pgtable.h
> > index 467b8547ac8b..cca30bf11b4c 100644
> > --- a/arch/parisc/include/asm/pgtable.h
> > +++ b/arch/parisc/include/asm/pgtable.h
> > @@ -75,12 +75,11 @@ extern void __update_cache(pte_t pte);
> >  
> >  #endif /* !__ASSEMBLER__ */
> >  
> > -#define pte_ERROR(e) \
> > -	printk("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
> >  #if CONFIG_PGTABLE_LEVELS == 3
> >  #define pmd_ERROR(e) \
> >  	printk("%s:%d: bad pmd %08lx.\n", __FILE__, __LINE__, (unsigned long)pmd_val(e))
> >  #endif
> > +
> 
> Stray whitespace change?
> 
> >  #define pgd_ERROR(e) \
> >  	printk("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, (unsigned long)pgd_val(e))
> >  
> > diff --git a/arch/sh/include/asm/pgtable-3level.h b/arch/sh/include/asm/pgtable-3level.h
> > index d1ce73f3bd85..3cfbec15de2f 100644
> > --- a/arch/sh/include/asm/pgtable-3level.h
> > +++ b/arch/sh/include/asm/pgtable-3level.h
> > @@ -28,6 +28,12 @@
> >  #define pmd_ERROR(e) \
> >  	printk("%s:%d: bad pmd %016llx.\n", __FILE__, __LINE__, pmd_val(e))
> >  
> > +#define pud_ERROR(e) \
> > +	printk("%s:%d: bad pud %016llx.\n", __FILE__, __LINE__, pud_val(e))
> > +
> > +#define p4d_ERROR(e) \
> > +	printk("%s:%d: bad p4d %016llx.\n", __FILE__, __LINE__, p4d_val(e))
> > +
> 
> I'd expect that all arch changes would only remove code. Why sh needs
> those?
> 
> >  typedef union {
> >  	struct {
> >  		unsigned long pmd_low;
> > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > index b18c2b2e7d2c..1025b9140c0b 100644
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -2001,4 +2001,44 @@ static inline unsigned long mmf_init_legacy_flags(unsigned long flags)
> >  	return flags & MMF_INIT_LEGACY_MASK;
> >  }
> >  
> > +static inline void ptval_bytes_to_hex_str(char *buf, size_t buf_size, const void *entry, size_t entry_size)
> 
> include/linux/pgtable.h seems more natural home for this
> 
> > +{
> > +	if (WARN_ON_ONCE(buf_size < entry_size * 2 + 1)) {
> > +		snprintf(buf, buf_size, "overflow");
> > +		return;
> > +	}
> 
> -- 
> Sincerely yours,
> Mike.
