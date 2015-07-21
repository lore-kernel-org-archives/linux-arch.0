From: "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: Re: [PATCH 09/10] arch: introduce memremap()
Date: Wed, 22 Jul 2015 01:58:48 +0200
Message-ID: <20150721235848.GI30479@wotan.suse.de>
References: <20150720001614.30857.89063.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150720001822.30857.65670.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38941 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933665AbbGUX6x (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 21 Jul 2015 19:58:53 -0400
Content-Disposition: inline
In-Reply-To: <20150720001822.30857.65670.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com, linux-arch@vger.kernel.org, tony.luck@intel.com, linux@arm.linux.org.uk, arnd@arndb.de, benh@kernel.crashing.org, x86@kernel.org, linux-kernel@vger.kernel.org, ralf@linux-mips.org, Andy Shevchenko <andy.shevchenko@gmail.com>, geert@linux-m68k.org, toshi.kani@hp.com, ross.zwisler@linux.intel.com, hch@lst.de, linux-arm-kernel@lists.infradead.org

On Sun, Jul 19, 2015 at 08:18:23PM -0400, Dan Williams wrote:
> diff --git a/include/linux/io.h b/include/linux/io.h
> index 080a4fbf2ba4..2983b6e63970 100644
> --- a/include/linux/io.h
> +++ b/include/linux/io.h
> @@ -192,4 +192,15 @@ static inline int arch_phys_wc_index(int handle)
>  #endif
>  #endif
>  
> +enum {
> +	MEMREMAP_WB = 1 << 0,
> +	MEMREMAP_WT = 1 << 1,
> +	MEMREMAP_WC = 1 << 2,
> +	MEMREMAP_STRICT = 1 << 3,
> +	MEMREMAP_CACHE = MEMREMAP_WB,
> +};

A few things:

1) You'll need MEMREMAP_UC now as well now.

2) as you are doing all this sweep over architectures on this please
also address the lack of ioremap_*() variant implemention to return
NULL, ie not supported, because we've decided for now that so long
as the semantics are not well defined we can't expect architectures
to get it right unless they are doing the work themselves, and the
old strategy of just #defin'ing a variant to iorempa_nocache() which
folks tended to just can lead to issues. In your case since you are
jumping to the flags implementation this might be knocking two birds
with one stone.

3) For the case that architectures have no MMU we currently do a direct
mapping such as what you try to describe to do with memremap(). I wonder
if its worth it to then enable that code to just map to memremap(). That
throws off your usage of CONFIG_ARCH_HAS_MEMREMAP if we want to repurpose
that implementation for no the MMU case, unless of course you just have a
__memremap() which does the default basic direct mapping implementation.

4) Since we are all blaming semantics on our woes I'd like to ask for
some effort on semantics to be well defined. Semantics here sholud cover
some form of Documentation but also sparse annotation checks and perhaps
Coccinelle grammar rules for how things should be done. This should not only
cover general use but also if there are calls which depend on a cache
type to have been set. If we used sparse annotations it  may meen a
different return type for each cache type.  Not sure if we want this.
If we went with grammar rules I'm looking to for instance have in place
rules on scripts/coccinelle which would allow developers to use

make coccicheck M=foo/

to find issues. I can perhaps help with this, but we'd need to do a good
sweep here to not only cover good territory but also get folks to agree
on things.

5) This may be related to 4), not sure. There are aligment requirements we
should probably iron out for architectures. How will we annotate these
requirements or allow architectures to be pedantic over these requirements?

  Luis
