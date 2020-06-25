From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v5 11/25] mm: Introduce arch_calc_vm_flag_bits()
Date: Thu, 25 Jun 2020 18:34:02 +0100
Message-ID: <20200625173344.GF14812@gaia>
References: <20200624175244.25837-1-catalin.marinas@arm.com>
 <20200624175244.25837-12-catalin.marinas@arm.com>
 <20200624113611.2cf12da3a325d03a862c0adf@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404938AbgFYReG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Jun 2020 13:34:06 -0400
Content-Disposition: inline
In-Reply-To: <20200624113611.2cf12da3a325d03a862c0adf@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>

On Wed, Jun 24, 2020 at 11:36:11AM -0700, Andrew Morton wrote:
> On Wed, 24 Jun 2020 18:52:30 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:
> > From: Kevin Brodsky <Kevin.Brodsky@arm.com>
> > Similarly to arch_calc_vm_prot_bits(), introduce a dummy
> > arch_calc_vm_flag_bits() invoked from calc_vm_flag_bits(). This macro
> > can be overridden by architectures to insert specific VM_* flags derived
> > from the mmap() MAP_* flags.
> > 
> > ...
> >
> > --- a/include/linux/mman.h
> > +++ b/include/linux/mman.h
> > @@ -74,13 +74,17 @@ static inline void vm_unacct_memory(long pages)
> >  }
> >  
> >  /*
> > - * Allow architectures to handle additional protection bits
> > + * Allow architectures to handle additional protection and flag bits
> >   */
> >  
> >  #ifndef arch_calc_vm_prot_bits
> >  #define arch_calc_vm_prot_bits(prot, pkey) 0
> >  #endif
> >  
> > +#ifndef arch_calc_vm_flag_bits
> > +#define arch_calc_vm_flag_bits(flags) 0
> > +#endif
> 
> It would be helpful to add a comment specifying which arch header file
> is responsible for defining arch_calc_vm_flag_bits.  Because in the
> past we've messed this sort of thing up and had different architectures
> define things in different header files, resulting in build issues as
> code evolves.

I'll add a comment that the overriding definitions need to go in the
arch asm/mman.h file.

Thanks.

-- 
Catalin
