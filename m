From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v8 0/8] Introduce the for_each_set_clump8 macro
Date: Wed, 30 Jan 2019 12:56:23 +0100
Message-ID: <CACRpkdYuqU0YkEBoWdPAeuB7Ab8ERinVg_-yz6Q=vQVXFbvDRA@mail.gmail.com>
References: <cover.1547445576.git.vilhelm.gray@gmail.com> <20190129170734.688a6adf91267cc6f1b5fa08@linux-foundation.org>
 <20190130101814.GA3668@icarus>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130101814.GA3668@icarus>
Sender: linux-kernel-owner@vger.kernel.org
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-arch@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
List-Id: linux-arch.vger.kernel.org

On Wed, Jan 30, 2019 at 11:17 AM William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:
> On Tue, Jan 29, 2019 at 05:07:34PM -0800, Andrew Morton wrote:

> > Do we have any expectation that these facilities will be used by
> > anything other than GPIO?  If not then perhaps they should be sited
> > within drivers/gpio (presumably as a standalone module) until such a
> > need is found?
>
> I can move it within drivers/gpio since my only use at moment is for
> these gpio drivers I maintain. However, moving it to the gpio subsystem
> does make it less likely to be seen by authors in other subsystems who
> may have use for it -- so there is the chance that this becomes isolated
> and untilized only amonst the gpio drivers. That may not be such a bad
> thing in the end; I suspect it will be easy to spot if other subsystems
> start implementing their own for_each_set_clump (if other subsystems
> would even have such a need for it).

I would sure prefer to have these in the generic core where this patch
puts them. I don't see the problem with that. We have to start generic
code from some point.

> Linus, if I move the for_each_set_clump macro and related functions to
> drivers/gpio, should I move the code into the gpiolib.h and gpiolib.c
> files? Or would it be best to implement this as a separate standalone
> module, and make a Kconfig dependency for those gpio drivers which
> require it? A standalone module feels somewhat overkill for such little
> code in my opinion.

Yeah. I was however thinking about that we should create a helper
library for port-mapped IO along the lines of gpio-mmio.c so we might
as well get started with that in that case, just call it gpio-port-mapped-io.c
and put these in first or something.

Yours,
Linus Walleij
