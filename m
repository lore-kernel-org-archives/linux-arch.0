From: William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: Re: [RESEND PATCH v4 1/8] bitops: Introduce the for_each_set_clump
 macro
Date: Thu, 4 Oct 2018 19:36:20 +0900
Message-ID: <20181004103620.GB4779@icarus>
References: <cover.1538441919.git.vilhelm.gray@gmail.com>
 <f5250b9c78377e476667be1b616c86cf573b57dc.1538441919.git.vilhelm.gray@gmail.com>
 <40ecad49-2797-0d30-b52d-a2e6838dc1ab@rasmusvillemoes.dk>
 <20181002082142.GC15943@smile.fi.intel.com>
 <20181003114804.GE15943@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181003114804.GE15943@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, linus.walleij@linaro.org, akpm@linux-foundation.org, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-arch.vger.kernel.org

On Wed, Oct 03, 2018 at 02:48:04PM +0300, Andy Shevchenko wrote:
> On Tue, Oct 02, 2018 at 11:21:42AM +0300, Andy Shevchenko wrote:
> 
> > I would rather go with two prototypes to get()/set() a clump in the bitmap
> > in a way when it's aligned and BITS_PER_LONG % clump_size == 0.
> 
> To make things much easier, restrict clump_size to the one
> from the following set:
> 
> 1, 2, 4, 8, 16, 32 even on 64-bit platforms.
> 
> If it would be simpler solution to add 64 here (implying 32-bit platform),
> I would vote for that.
> 
> For the generic case we might need something like:
> 
> unsigned long bitmap_get_bits(unsigned long *src, unsigned int start, unsigned int nbits)
> {
> 	assert(nbits > BITS_PER_LONG);
> 
> 	/* Something like Rasmus proposed earlier */
> }
> 
> And similar to setter.
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko

I have no objections to have a simplier macro for these common clump
sizes -- afterall, I suspect most drivers will likely use clump sizes
that are powers of 2 anyway. It would be nice to have a more versatile
macro though for those drivers that would benefit from odd clump sizes,
but we can perhaps postpone that until the need arises (the GPIO drivers
in this patchset all use a power of 2).

William Breathitt Gray
