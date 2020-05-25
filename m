Return-Path: <SRS0=uIBl=7H=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389421AbgEYJgr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 May 2020 05:36:47 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0567C08C5C1
        for <linux-arch@vger.kernel.org>; Mon, 25 May 2020 02:36:46 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id y1so2698388qtv.12
        for <linux-arch@vger.kernel.org>; Mon, 25 May 2020 02:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590017578.git.syednwaris@gmail.com>
In-Reply-To: <cover.1590017578.git.syednwaris@gmail.com>
From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date: Mon, 25 May 2020 11:36:35 +0200
Message-ID: <CAMpxmJUrC270rgWcADYruqA_qVeh9-N8mCVPWgJkL-8kU2bO1A@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] Introduce the for_each_set_clump macro
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Syed Nayyar Waris <syednwaris@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, William Breathitt Gray <vilhelm.gray@gmail.com>, Michal Simek <michal.simek@xilinx.com>, Arnd Bergmann <arnd@arndb.de>, rrichter@marvell.com, Masahiro Yamada <yamada.masahiro@socionext.com>, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@verdurent.com>, linux-arch@vger.kernel.org, linux-gpio <linux-gpio@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>, linux-pm <linux-pm@vger.kernel.org>
Message-ID: <20200525093635.-XHV-ma1Btug2divxE0j6E3Bx22Dn4FLLcxkT8f3fAY@z>

niedz., 24 maj 2020 o 07:00 Syed Nayyar Waris <syednwaris@gmail.com> napisa=
=C5=82(a):
>
> Hello Linus,
>
> Since this patchset primarily affects GPIO drivers, would you like
> to pick it up through your GPIO tree?
>
> This patchset introduces a new generic version of for_each_set_clump.
> The previous version of for_each_set_clump8 used a fixed size 8-bit
> clump, but the new generic version can work with clump of any size but
> less than or equal to BITS_PER_LONG. The patchset utilizes the new macro
> in several GPIO drivers.
>
> The earlier 8-bit for_each_set_clump8 facilitated a
> for-loop syntax that iterates over a memory region entire groups of set
> bits at a time.
>

The GPIO part looks good to me. Linus: how do we go about merging it
given the bitops dependency?

Bart
