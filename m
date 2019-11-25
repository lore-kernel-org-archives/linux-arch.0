Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33803 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfKYWOI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 25 Nov 2019 17:14:08 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so20089590wrr.1
        for <linux-arch@vger.kernel.org>; Mon, 25 Nov 2019 14:14:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1573179553.git.thehajime@gmail.com> <567fd4d5c395e2279e86ca0bfca544ad2773a31d.1573179553.git.thehajime@gmail.com>
In-Reply-To: <567fd4d5c395e2279e86ca0bfca544ad2773a31d.1573179553.git.thehajime@gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Mon, 25 Nov 2019 23:13:55 +0100
Message-ID: <CAFLxGvxytmS4WSFj2ibyJKCuR5TbspdNf6MvHNvzh9dtKx2rJg@mail.gmail.com>
Subject: Re: [RFC v2 07/37] lkl: interrupt support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, Linux-Arch <linux-arch@vger.kernel.org>, Octavian Purdila <tavi.purdila@gmail.com>, Akira Moroo <retrage01@gmail.com>, linux-kernel-library@freelists.org, Michael Zimmermann <sigmaepsilon92@gmail.com>

On Fri, Nov 8, 2019 at 6:03 AM Hajime Tazaki <thehajime@gmail.com> wrote:
>
> From: Octavian Purdila <tavi.purdila@gmail.com>
>
> Add APIs that allows the host to reserve and free and interrupt number
> and also to trigger an interrupt.
>
> The trigger operation will simply store the interrupt data in
> queue. The interrupt handler is run later, at the first opportunity it
> has to avoid races with any kernel threads.
>
> Currently, interrupts are run on the first interrupt enable operation
> if interrupts are disabled and if we are not already in interrupt
> context.
>
> When triggering an interrupt, it uses GCC's built-in functions for
> atomic memory access to synchronize and simple boolean flags.
>
> Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
> Signed-off-by: Michael Zimmermann <sigmaepsilon92@gmail.com>
> Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
> ---
>  arch/um/lkl/include/asm/irq.h             |  13 ++
>  arch/um/lkl/include/uapi/asm/irq.h        |  36 ++++
>  arch/um/lkl/include/uapi/asm/sigcontext.h |  16 ++
>  arch/um/lkl/kernel/irq.c                  | 193 ++++++++++++++++++++++

Like I said before, this also something to unify with UML.
I'm aware that this is easily said but we cannot have too much duplication.

Feel free to ask if UML internals give you headache. :-)

--
Thanks,
//richard
