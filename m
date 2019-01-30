From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v8 0/8] Introduce the for_each_set_clump8 macro
Date: Wed, 30 Jan 2019 10:44:58 +0100
Message-ID: <CACRpkdZi1BHUq4mT==5OOepq=o4Pus1=DJBY-fWBZyjG5bdpoA@mail.gmail.com>
References: <cover.1547445576.git.vilhelm.gray@gmail.com> <20190129170734.688a6adf91267cc6f1b5fa08@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190129170734.688a6adf91267cc6f1b5fa08@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, linux-arch@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>
List-Id: linux-arch.vger.kernel.org

On Wed, Jan 30, 2019 at 2:07 AM Andrew Morton <akpm@linux-foundation.org> wrote:
> On Mon, 14 Jan 2019 15:19:17 +0900 William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> >  drivers/gpio/gpio-104-dio-48e.c   |  73 ++++++--------------
> >  drivers/gpio/gpio-104-idi-48.c    |  37 +++-------
> >  drivers/gpio/gpio-gpio-mm.c       |  73 ++++++--------------
> >  drivers/gpio/gpio-pci-idio-16.c   |  75 ++++++++------------
> >  drivers/gpio/gpio-pcie-idio-24.c  | 111 +++++++++++-------------------
> >  drivers/gpio/gpio-ws16c48.c       |  72 ++++++-------------
> >  include/asm-generic/bitops/find.h |  14 ++++
> >  include/linux/bitops.h            |   5 ++
> >  lib/find_bit.c                    |  81 ++++++++++++++++++++++
> >  lib/test_bitmap.c                 |  65 +++++++++++++++++
> >  10 files changed, 307 insertions(+), 299 deletions(-)
>
> It's a shame that it doesn't actually dercease the kernel line count,
> but there are other benefits.
>
> The patches are missing the hoped-for acks, but I think you maintain
> most/all of those drivers.

He does, but FWIW:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
