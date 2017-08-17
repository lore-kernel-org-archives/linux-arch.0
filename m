From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH] [RESEND] mtd: only use __xipram annotation when
 XIP_KERNEL is set
Date: Thu, 17 Aug 2017 15:01:18 +0200
Message-ID: <20170817150118.3c4d8214@bbrezillon>
References: <20170721202636.3361536-1-arnd@arndb.de>
        <20170804093550.41e5936c@bbrezillon>
        <CAK8P3a2Zvsc880ZYy9aaQ1fOJeO50uJc92OKMK0QxCcTzwGPsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a2Zvsc880ZYy9aaQ1fOJeO50uJc92OKMK0QxCcTzwGPsg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Russell King <linux@armlinux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Nicholas Piggin <npiggin@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Michal Marek <mmarek@suse.com>, Linus Walleij <linus.walleij@linaro.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Kees Cook <keescook@chromium.org>, Peter Zijlstra <peterz@infradead.org>, Chris Metcalf <cmetcalf@mellanox.com>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mtd <linux-mtd@lists.infradead.org>
List-Id: linux-arch.vger.kernel.org

Le Fri, 4 Aug 2017 11:00:05 +0200,
Arnd Bergmann <arnd@arndb.de> a écrit :

> On Fri, Aug 4, 2017 at 9:35 AM, Boris Brezillon
> <boris.brezillon@free-electrons.com> wrote:
> > On Fri, 21 Jul 2017 22:26:25 +0200
> > Arnd Bergmann <arnd@arndb.de> wrote:  
> 
> >> Note that MTD_XIP has been broken on ARM since around 2011 or 2012. I
> >> have sent another patch[2] to fix compilation, which I plan to merge
> >> through arm-soc unless there are objections. The obvious alternative
> >> to that would be to completely rip out the MTD_XIP support from the
> >> kernel, since obviously nobody has been using it in a long while.
> >>
> >> Link: [1] https://patchwork.kernel.org/patch/8109771/
> >> Link: [2] https://patchwork.kernel.org/patch/9855225/
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >>  include/asm-generic/vmlinux.lds.h |  1 +
> >>  include/linux/mtd/xip.h           | 10 ++++++----  
> >
> > For the MTD part,
> >
> > Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>  
> 
> Thanks. If you don't mind, could you just apply the patch to the mtd tree?

Applied to l2-mtd/master.

Thanks,

Boris

> 
>       Arnd
