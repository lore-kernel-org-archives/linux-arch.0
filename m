Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45944 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeJQXHZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Oct 2018 19:07:25 -0400
MIME-Version: 1.0
References: <cover.1539655731.git.ren_guo@c-sky.com> <9ae1d1609a49d976ae7659157507018b0c846423.1539655732.git.ren_guo@c-sky.com>
In-Reply-To: <9ae1d1609a49d976ae7659157507018b0c846423.1539655732.git.ren_guo@c-sky.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 17 Oct 2018 17:11:00 +0200
Message-ID: <CAK8P3a31sVAMCPXLqyqMpvj-gsxOmuf2qL0bT5crDQo0Wcg__g@mail.gmail.com>
Subject: Re: [PATCH V9 08/21] csky: Process management and Signal
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, David Miller <davem@davemloft.net>, gregkh <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@infradead.org>, Marc Zyngier <marc.zyngier@arm.com>, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Rob Herring <robh@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, c-sky_gcc_upstream@c-sky.com
Message-ID: <20181017151100.FboqxW2dti7MvcrXRD15HYoKehSjnQNx_cDyeurPK9A@z>

On Tue, Oct 16, 2018 at 5:01 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> This patch adds files related to task_switch, sigcontext, signal,
> fpu context switch.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> ---
> Changelog:
>  - abiv2/fpu.c: Userspace should never be sent NSIGXXX as a si_code.
>    Use FPE_FLTUNK instead.
>  - abiv2/fpu.c: Use force_sig_fault instead.

I'm hesitant to provide a Reviewed-by: tag for this one, as I don't
understand the signal handling enough myself, and it's something
that should be reviewed properly because of the ABI implications.

Maybe someone else can have a closer look at this?

       Arnd
