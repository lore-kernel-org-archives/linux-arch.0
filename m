From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Re: [PATCH] x86/mm: Add warning to ioremap() for conflicting cache
 type
Date: Wed, 25 May 2016 01:33:18 +0200
Message-ID: <20160524233318.GC11948@wotan.suse.de>
References: <1461770757-26817-1-git-send-email-toshi.kani@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461770757-26817-1-git-send-email-toshi.kani@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Toshi Kani <toshi.kani@hpe.com>
Cc: mingo@kernel.org, bp@suse.de, hpa@zytor.com, tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Julia Lawall <julia.lawall@lip6.fr>, Christoph Hellwig <hch@infradead.org>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Will Deacon <will.deacon@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-arch <linux-arch@vger.kernel.org>, mcgrof@kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Apr 27, 2016 at 09:25:57AM -0600, Toshi Kani wrote:
> On x86, ioremap() and remap_pfn_range() fail on conflicting cache
> type of an alias mapping request only if the case is not allowed
> by the rule set in is_new_memtype_allowed(). While this exemption
> is necessary for remap_pfn_range() called for /dev/mem mappings,
> it is not necessary for ioremap().

The wording here is a bit unclear. How about:

Currently we allow for conflicting cache requests to account for
reading out /dev/mem, however /dev/mem uses remap_pfn_range(). An
explicit exception is not currently known to exist for conflicting
cache type requests for ioremap(), however we are not certain if
such conflicting use type currently does exist.

> Drivers should never call
> ioremap() with a conflicting cache type. This exemption handling
> may hide possible bugs in drivers.

And this to:

Upon review, we've determined that at least device drivers have
no business in calling ioremap() with a conflicting cache type.

> Add a warning message to ioremap() when a conflicting cache type
> is allowed by is_new_memtype_allowed(). This 

will help us

> helps us identify
> such usages in drivers.

such valid uses in device drivers

> 
> There is no change in the behavior.

There are no functional changes introduced by this commit other than
the addition of the new warning.

> Link: https://lkml.org/lkml/2016/4/16/54

lkml.org references should be avoided, we have no control over
that domain. Please instead use:

http://lkml.kernel.org/r/20160416092018.GA8453@gmail.com

> Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Luis R. Rodriguez <mcgrof@suse.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> ---
>  arch/x86/mm/ioremap.c |   10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index 0d8d53d..16c5887 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -138,14 +138,16 @@ static void __iomem *__ioremap_caller(resource_size_t phys_addr,
>  	}
>  
>  	if (pcm != new_pcm) {
> -		if (!is_new_memtype_allowed(phys_addr, size, pcm, new_pcm)) {
> -			printk(KERN_ERR
> -		"ioremap error for 0x%llx-0x%llx, requested 0x%x, got 0x%x\n",
> +		retval = is_new_memtype_allowed(phys_addr, size, pcm, new_pcm);
> +		pr_err(
> +		    "ioremap %s for 0x%llx-0x%llx, requested 0x%x, got 0x%x\n",
> +				retval ? "warning" : "error",
>  				(unsigned long long)phys_addr,
>  				(unsigned long long)(phys_addr + size),
>  				pcm, new_pcm);

This doesn't really make it humanly consumable, a pcm_to_str may help,
such use already exists but not generalized see pat_get_cache_mode().

> +		if (!retval)
>  			goto err_free_memtype;
> -		}
> +
>  		pcm = new_pcm;
>  	}

In the future we may be able to proactively hunt for these invalid uses
semantically but to do so we need first a demo driver with all known possible
bugs we can think of.

  Luis
