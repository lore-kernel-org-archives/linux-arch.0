From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v7 1/4] bitops: Introduce the the for_each_set_clump macro
Date: Fri, 29 May 2020 21:38:24 +0300
Message-ID: <20200529183824.GW1634618@smile.fi.intel.com>
References: <17cb2b080b9c4c36cf84436bc5690739590acc53.1590017578.git.syednwaris@gmail.com>
 <202005242236.NtfLt1Ae%lkp@intel.com>
 <CACG_h5oOsThkSfdN_adWHxHfAWfg=W72o5RM6JwHGVT=Zq9MiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga12.intel.com ([192.55.52.136]:53988 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbgE2SiY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 29 May 2020 14:38:24 -0400
Content-Disposition: inline
In-Reply-To: <CACG_h5oOsThkSfdN_adWHxHfAWfg=W72o5RM6JwHGVT=Zq9MiQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Syed Nayyar Waris <syednwaris@gmail.com>
Cc: kbuild test robot <lkp@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, kbuild-all@lists.01.org, William Breathitt Gray <vilhelm.gray@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, May 29, 2020 at 11:38:18PM +0530, Syed Nayyar Waris wrote:
> On Sun, May 24, 2020 at 8:15 PM kbuild test robot <lkp@intel.com> wrote:

...

> >    579  static inline unsigned long bitmap_get_value(const unsigned long *map,
> >    580                                                unsigned long start,
> >    581                                                unsigned long nbits)
> >    582  {
> >    583          const size_t index = BIT_WORD(start);
> >    584          const unsigned long offset = start % BITS_PER_LONG;
> >    585          const unsigned long ceiling = roundup(start + 1, BITS_PER_LONG);
> >    586          const unsigned long space = ceiling - start;
> >    587          unsigned long value_low, value_high;
> >    588
> >    589          if (space >= nbits)
> >  > 590                  return (map[index] >> offset) & GENMASK(nbits - 1, 0);
> >    591          else {
> >    592                  value_low = map[index] & BITMAP_FIRST_WORD_MASK(start);
> >    593                  value_high = map[index + 1] & BITMAP_LAST_WORD_MASK(start + nbits);
> >    594                  return (value_low >> offset) | (value_high << space);
> >    595          }
> >    596  }

> Regarding the above compilation warnings. All the warnings are because
> of GENMASK usage in my patch.
> The warnings are coming because of sanity checks present for 'GENMASK'
> macro in include/linux/bits.h.
> 
> Taking the example statement (in my patch) where compilation warning
> is getting reported:
> return (map[index] >> offset) & GENMASK(nbits - 1, 0);
> 
> 'nbits' is of type 'unsigned long'.
> In above, the sanity check is comparing '0' with unsigned value. And
> unsigned value can't be less than '0' ever, hence the warning.
> But this warning will occur whenever there will be '0' as one of the
> 'argument' and an unsigned variable as another 'argument' for GENMASK.
> 
> This warning is getting cleared if I cast the 'nbits' to 'long'.
> 
> Let me know if I should submit a next patch with the casts applied.
> What do you guys think?

Proper fix is to fix GENMASK(), but allowed workaround is to use
	(BIT(nbits) - 1)
instead.

-- 
With Best Regards,
Andy Shevchenko
