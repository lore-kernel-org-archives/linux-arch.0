Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:39113 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeILTfk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Sep 2018 15:35:40 -0400
MIME-Version: 1.0
References: <cover.1536757532.git.ren_guo@c-sky.com>
In-Reply-To: <cover.1536757532.git.ren_guo@c-sky.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 12 Sep 2018 16:30:36 +0200
Message-ID: <CAK8P3a0CUYyMR9hDG97Zf2Oyj+D9vwQRnPZrEs0rrOLwHqxYfw@mail.gmail.com>
Subject: Re: [PATCH V4 00/27] C-SKY(csky) Linux Kernel Port
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guo Ren <ren_guo@c-sky.com>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Jason Cooper <jason@lakedaemon.net>, DTML <devicetree@vger.kernel.org>, andrea.parri@amarulasolutions.com, Peter Zijlstra <peterz@infradead.org>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <20180912143036.zXaJ8mGNwPfeIKIZd4U5CNjj-7qtyvO5uPpeCxRI1Qs@z>

On Wed, Sep 12, 2018 at 3:25 PM Guo Ren <ren_guo@c-sky.com> wrote:
>
> This is the 3th version patchset to add the Linux kernel port for C-SKY(csky).
> Thanks to everyone who provided feedback on the previous version.
>
> This patchset adds architecture support to Linux for C-SKY's 32-bit embedded
> CPU cores and the patches are based on linux-4.18.4
>
> There are two ABI versions with several CPU cores in this patchset:
>   ABIv1: ck610 (16-bit instruction, 32-bit data path, VIPT Cache ...)
>   ABIv2: ck807 ck810 ck860 (16/32-bit variable length instruction, PIPT Cache,
>          SMP ...)
>
> More information: http://en.c-sky.com

This looks good to me overall. I think a good next step would be to get the port
included in linux-next, by preparing a git tree with all the patches and asking
Stephen Rothwell to include it there. Further comments on the architecture
port itself can be done on top of the existing patches. I would suggest you
base the git tree on an -rc release (either 4.19-rc1 or 4.19-rc3) and then never
rebase again.

You have included a couple of drivers in the submission: two timer and
two irqchip drivers. Please leave those out for the moment, and either have
them merged through the respective subsystem  trees, or get an Ack
from the maintainers to merge them through your tree.

I notice that a lot of the patches have no changeset comments on them.
You should fix that and make a habit of describing every single patch
with a few sentences, even if it seems obvious to you. Have a look at
the changeset descriptions for the nds32 and riscv architectures when
they got merged.

One big question for me is what to do about time_t. Deepa and I are
in the process of finalizing the system call ABI for 32-bit architectures
with 64-bit time_t, but we are not done yet and it won't be complete
for 4.20. If you target 4.21, that could be a chance to make csky the
first architecture to only need the 64-bit time_t interface, with the
corresponding user space changes.

        Arnd
