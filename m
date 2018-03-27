Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:49004 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752027AbeC0ClT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Mar 2018 22:41:19 -0400
Date: Tue, 27 Mar 2018 10:41:11 +0800
From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH 10/19] csky: Signal handling
Message-ID: <20180327024111.GB11454@guoren>
References: <cover.1521399976.git.ren_guo@c-sky.com>
 <f482eb9ffcebaf12595d5d6043953de221fda024.1521399976.git.ren_guo@c-sky.com>
 <CAK8P3a3p2nbBG-NM9X-DHc6U61s65M8-3XDyx0CRsADSZ+prqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3p2nbBG-NM9X-DHc6U61s65M8-3XDyx0CRsADSZ+prqw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, thomas.petazzoni@bootlin.com, wbx@uclibc-ng.org
Message-ID: <20180327024111.WR41NwbneuFexFYXUFGPxmQiI-SOeL13h2kl63s7JnI@z>

On Mon, Mar 26, 2018 at 03:04:01PM +0200, Arnd Bergmann wrote:
> On Sun, Mar 18, 2018 at 8:51 PM, Guo Ren <ren_guo@c-sky.com> wrote:
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > ---
> >  arch/csky/include/uapi/asm/sigcontext.h |  33 +++
> >  arch/csky/include/uapi/asm/signal.h     | 164 ++++++++++++++
> >  arch/csky/kernel/signal.c               | 379 ++++++++++++++++++++++++++++++++
> >  3 files changed, 576 insertions(+)
> 
> Please have a look at arch/riscv and arch/nds32 for this, I think it can be
> simplified. This is an incompatible change of course, but when we change
> the system call ABI anyway, that is the right time to do it.
Ok.

> 
> 
> > +#define NSIG           32
> > +typedef unsigned long sigset_t;
> > +
> > +#endif /* __KERNEL__ */
> > +
> > +#define SIGHUP          1
> > +#define SIGINT          2
> > +#define SIGQUIT                 3
> > +#define SIGILL          4
> > +#define SIGTRAP                 5
> > +#define SIGABRT                 6
> > +#define SIGIOT          6
> > +#define SIGBUS          7
> > +#define SIGFPE          8
> > +#define SIGKILL                 9
> > +#define SIGUSR1                10
> > +#define SIGSEGV                11
> > +#define SIGUSR2                12
> > +#define SIGPIPE                13
> 
> In particular the constants should come from the asm-generic headers
> rather than being duplicated. If you need anything special, it may be
> better to modify the generic headers.
Ok, use asm-generic.

Best Regards
 Guo Ren
