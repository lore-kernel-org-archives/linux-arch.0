Return-Path: <SRS0=FJBn=AF=kvack.org=owner-linux-mm@kernel.org>
Date: Wed, 24 Jun 2020 11:36:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v5 11/25] mm: Introduce arch_calc_vm_flag_bits()
Message-ID: <20200624113611.2cf12da3a325d03a862c0adf@linux-foundation.org>
In-Reply-To: <20200624175244.25837-12-catalin.marinas@arm.com>
References: <20200624175244.25837-1-catalin.marinas@arm.com>
	<20200624175244.25837-12-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mm@kvack.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>, Kevin Brodsky <Kevin.Brodsky@arm.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200624183611.83SC0Z-f4XFGe31_ENkp-k7aZqTdp3Dg8j14k-VTIsw@z>

On Wed, 24 Jun 2020 18:52:30 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:

> From: Kevin Brodsky <Kevin.Brodsky@arm.com>
> 
> Similarly to arch_calc_vm_prot_bits(), introduce a dummy
> arch_calc_vm_flag_bits() invoked from calc_vm_flag_bits(). This macro
> can be overridden by architectures to insert specific VM_* flags derived
> from the mmap() MAP_* flags.
> 
> ...
>
> --- a/include/linux/mman.h
> +++ b/include/linux/mman.h
> @@ -74,13 +74,17 @@ static inline void vm_unacct_memory(long pages)
>  }
>  
>  /*
> - * Allow architectures to handle additional protection bits
> + * Allow architectures to handle additional protection and flag bits
>   */
>  
>  #ifndef arch_calc_vm_prot_bits
>  #define arch_calc_vm_prot_bits(prot, pkey) 0
>  #endif
>  
> +#ifndef arch_calc_vm_flag_bits
> +#define arch_calc_vm_flag_bits(flags) 0
> +#endif

It would be helpful to add a comment specifying which arch header file
is responsible for defining arch_calc_vm_flag_bits.  Because in the
past we've messed this sort of thing up and had different architectures
define things in different header files, resulting in build issues as
code evolves.

>  #ifndef arch_vm_get_page_prot
>  #define arch_vm_get_page_prot(vm_flags) __pgprot(0)
>  #endif
> @@ -131,7 +135,8 @@ calc_vm_flag_bits(unsigned long flags)
>  	return _calc_vm_trans(flags, MAP_GROWSDOWN,  VM_GROWSDOWN ) |
>  	       _calc_vm_trans(flags, MAP_DENYWRITE,  VM_DENYWRITE ) |
>  	       _calc_vm_trans(flags, MAP_LOCKED,     VM_LOCKED    ) |
> -	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      );
> +	       _calc_vm_trans(flags, MAP_SYNC,	     VM_SYNC      ) |
> +	       arch_calc_vm_flag_bits(flags);
>  }
>  
>  unsigned long vm_commit_limit(void);
