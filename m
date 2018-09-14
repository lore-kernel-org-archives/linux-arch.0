Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:41183 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727676AbeINTwY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 Sep 2018 15:52:24 -0400
Date: Fri, 14 Sep 2018 22:37:20 +0800
From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V4 00/27] C-SKY(csky) Linux Kernel Port
Message-ID: <20180914143719.GA27689@guoren-Inspiron-7460>
References: <cover.1536757532.git.ren_guo@c-sky.com>
 <CAK8P3a0CUYyMR9hDG97Zf2Oyj+D9vwQRnPZrEs0rrOLwHqxYfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0CUYyMR9hDG97Zf2Oyj+D9vwQRnPZrEs0rrOLwHqxYfw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, DTML <devicetree@vger.kernel.org>, andrea.parri@amarulasolutions.com, Peter Zijlstra <peterz@infradead.org>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <20180914143720.7wuKtbp6mzKoZ1MwLhpWR6glJ1gDouqO3yKgRnRoL9o@z>

On Wed, Sep 12, 2018 at 04:30:36PM +0200, Arnd Bergmann wrote:
> On Wed, Sep 12, 2018 at 3:25 PM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > This is the 3th version patchset to add the Linux kernel port for C-SKY(csky).
> > Thanks to everyone who provided feedback on the previous version.
> >
> > This patchset adds architecture support to Linux for C-SKY's 32-bit embedded
> > CPU cores and the patches are based on linux-4.18.4
> >
> > There are two ABI versions with several CPU cores in this patchset:
> >   ABIv1: ck610 (16-bit instruction, 32-bit data path, VIPT Cache ...)
> >   ABIv2: ck807 ck810 ck860 (16/32-bit variable length instruction, PIPT Cache,
> >          SMP ...)
> >
> > More information: http://en.c-sky.com
> 
> This looks good to me overall. I think a good next step would be to get the port
> included in linux-next, by preparing a git tree with all the patches and asking
> Stephen Rothwell to include it there. Further comments on the architecture
> port itself can be done on top of the existing patches. I would suggest you
> base the git tree on an -rc release (either 4.19-rc1 or 4.19-rc3) and then never
> rebase again.
Nice :) I'll follow the rules.

> 
> You have included a couple of drivers in the submission: two timer and
> two irqchip drivers. Please leave those out for the moment, and either have
> them merged through the respective subsystem  trees, or get an Ack
> from the maintainers to merge them through your tree.
Ok. 

> 
> I notice that a lot of the patches have no changeset comments on them.
> You should fix that and make a habit of describing every single patch
> with a few sentences, even if it seems obvious to you. Have a look at
> the changeset descriptions for the nds32 and riscv architectures when
> they got merged.
Ok, I'll fixup them.

> 
> One big question for me is what to do about time_t. Deepa and I are
> in the process of finalizing the system call ABI for 32-bit architectures
> with 64-bit time_t, but we are not done yet and it won't be complete
> for 4.20. If you target 4.21, that could be a chance to make csky the
> first architecture to only need the 64-bit time_t interface, with the
> corresponding user space changes.
y2038 is very important and csky32 has the issue. But 4.21 is too late for
us, we really want to get into kernel.org as soon as possible.
We could remove 32-bit time_t in future.

Best Regards
 Guo Ren
