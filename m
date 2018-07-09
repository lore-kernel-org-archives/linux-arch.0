Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:42087 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754528AbeGIMzw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 9 Jul 2018 08:55:52 -0400
MIME-Version: 1.0
References: <20180709124741.21037-1-abrodkin@synopsys.com>
In-Reply-To: <20180709124741.21037-1-abrodkin@synopsys.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 9 Jul 2018 14:55:38 +0200
Message-ID: <CAMuHMdV0XhDRyRLp_mPnZjg3QXMt_qY1eD-Tr=i-reOKA6x_mA@mail.gmail.com>
Subject: Re: [PATCH] atomic{64}_t: Explicitly specify data storage length and alignment
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, arcml <linux-snps-arc@lists.infradead.org>, Linux-Arch <linux-arch@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Darren Hart <dvhart@infradead.org>, Shuah Khan <shuah@kernel.org>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Josh Triplett <josh@joshtriplett.org>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, David Laight <David.Laight@aculab.com>, Greg KH <gregkh@linuxfoundation.org>
Message-ID: <20180709125538.n3Ib5m8m2pIWwGmnL6W7x1pHvYs3kOKRPo4VzkL2x2M@z>

Hi Alexey,

On Mon, Jul 9, 2018 at 2:48 PM Alexey Brodkin
<Alexey.Brodkin@synopsys.com> wrote:
> Atomic instructions require data they operate on to be aligned
> according to data size. I.e. 32-bit atomic values must be 32-bit
> aligned while 64-bit values must be 64-bit aligned.
>
> Otherwise even if CPU may handle not-aligend normal data access,
> still atomic instructions fail and typically raise an exception
> leaving us dead in the water.
>
> This came-up during lengthly discussion here:
> http://lists.infradead.org/pipermail/linux-snps-arc/2018-July/004022.html
>
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>

Thanks for your patch!

> --- a/include/asm-generic/atomic64.h
> +++ b/include/asm-generic/atomic64.h
> @@ -13,7 +13,7 @@
>  #define _ASM_GENERIC_ATOMIC64_H
>
>  typedef struct {
> -       long long counter;
> +       u64 __aligned(8) counter;

I think you can drop the change to this file, as this is the generic
implementation using spinlocks, for processors that don't have 64-bit atomic
instructions.

>  } atomic64_t;

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
