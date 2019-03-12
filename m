Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:48209 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbfCLOyS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 Mar 2019 10:54:18 -0400
Date: Tue, 12 Mar 2019 16:54:12 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v9 1/9] bitops: Introduce the for_each_set_clump8 macro
Message-ID: <20190312145412.GD9224@smile.fi.intel.com>
References: <cover.1551598603.git.vilhelm.gray@gmail.com>
 <12b3a364ac7fc32194fa6f55911dd800aca92a56.1551598603.git.vilhelm.gray@gmail.com>
 <CACRpkdbvCGRjB1sZWqN3wm660cP8S4-j0ub1j1iYpitDK_eXcQ@mail.gmail.com>
 <20190308085733.GA3903@icarus>
 <CAK7LNARvv3Z-eJooj7Htv7xWzD_Ow1whxcPrpqn84JHyqUnEJA@mail.gmail.com>
 <20190312072222.GA2898@icarus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190312072222.GA2898@icarus>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Linus Walleij <linus.walleij@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20190312145412.jVYoA_UR4rRKEozdIGxyEczSuhKQrepH-927dKAnACc@z>

On Tue, Mar 12, 2019 at 04:22:22PM +0900, William Breathitt Gray wrote:

> Since Andy appears to have hardware outside of the GPIO subsystem he's
> testing, let's wait for that and see how it turns out.

Since I have still not much time, here is the driver I'm talking about
drivers/thermal/intel/intel_soc_dts_iosf.c

If you have a chance to look at it (add_dts_thermal_zone(), for example) and
prepare a patch, I will be able to test it on real hardware.

-- 
With Best Regards,
Andy Shevchenko
