From: Syed Nayyar Waris <syednwaris@gmail.com>
Subject: Re: [PATCH v7 0/4] Introduce the for_each_set_clump macro
Date: Mon, 15 Jun 2020 18:16:37 +0530
Message-ID: <CACG_h5pP1ffeG4E-Vz_C+cX=2PGaHvNBPe+sUpP7sbfMC-0sdQ@mail.gmail.com>
References: <cover.1590017578.git.syednwaris@gmail.com> <CAMpxmJUrC270rgWcADYruqA_qVeh9-N8mCVPWgJkL-8kU2bO1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbgFOMqu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jun 2020 08:46:50 -0400
In-Reply-To: <CAMpxmJUrC270rgWcADYruqA_qVeh9-N8mCVPWgJkL-8kU2bO1A@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, William Breathitt Gray <vilhelm.gray@gmail.com>, Michal Simek <michal.simek@xilinx.com>, Arnd Bergmann <arnd@arndb.de>, rrichter@marvell.com, Masahiro Yamada <yamada.masahiro@socionext.com>, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@verdurent.com>, Linux-Arch <linux-arch@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>, linux-pm <linux-pm@vger.kernel.org>

On Mon, May 25, 2020 at 3:06 PM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
>
> niedz., 24 maj 2020 o 07:00 Syed Nayyar Waris <syednwaris@gmail.com> napi=
sa=C5=82(a):
> >
> > Hello Linus,
> >
> > Since this patchset primarily affects GPIO drivers, would you like
> > to pick it up through your GPIO tree?
> >
> > This patchset introduces a new generic version of for_each_set_clump.
> > The previous version of for_each_set_clump8 used a fixed size 8-bit
> > clump, but the new generic version can work with clump of any size but
> > less than or equal to BITS_PER_LONG. The patchset utilizes the new macr=
o
> > in several GPIO drivers.
> >
> > The earlier 8-bit for_each_set_clump8 facilitated a
> > for-loop syntax that iterates over a memory region entire groups of set
> > bits at a time.
> >
>
> The GPIO part looks good to me. Linus: how do we go about merging it
> given the bitops dependency?
>
> Bart

A minor change has been done in patch [2/4] to fix compilation warning.
Kindly refer patchset v8 in future.

Thanks
Syed Nayyar Waris
