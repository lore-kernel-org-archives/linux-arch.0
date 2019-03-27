Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:47487 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbfC0MbF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 Mar 2019 08:31:05 -0400
Date: Wed, 27 Mar 2019 14:30:59 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v13 01/11] bitops: Introduce the for_each_set_clump8 macro
Message-ID: <20190327123059.GI9224@smile.fi.intel.com>
References: <cover.1553661964.git.vilhelm.gray@gmail.com>
 <497dc4b5b1f668b54e008e10a43d4108f4a41213.1553661964.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <497dc4b5b1f668b54e008e10a43d4108f4a41213.1553661964.git.vilhelm.gray@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: linus.walleij@linaro.org, bgolaszewski@baylibre.com, akpm@linux-foundation.org, linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk, yamada.masahiro@socionext.com, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, geert@linux-m68k.org, preid@electromag.com.au, Lukas Wunner <lukas@wunner.de>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20190327123059.ahFtNql7wAXVYbkVNt82H2xe-BbNuXoE05CDPM5yMvo@z>

On Wed, Mar 27, 2019 at 01:58:45PM +0900, William Breathitt Gray wrote:
> This macro iterates for each 8-bit group of bits (clump) with set bits,
> within a bitmap memory region. For each iteration, "start" is set to the
> bit offset of the found clump, while the respective clump value is
> stored to the location pointed by "clump". Additionally, the
> bitmap_get_value8 and bitmap_set_value8 functions are introduced to
> respectively get and set an 8-bit value in a bitmap memory region.

> +unsigned long bitmap_get_value8(const unsigned long *addr, unsigned long start)
> +{
> +	const size_t idx = BIT_WORD(start);
> +	const unsigned long offset = start % BITS_PER_LONG;
> +
> +	return (addr[idx] >> offset) & 0xFF;

I would spell index instead of idx, but it's minor and up to you.

> +}

-- 
With Best Regards,
Andy Shevchenko
