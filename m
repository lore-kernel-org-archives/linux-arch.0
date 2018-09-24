From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V7 1/2] csky/dma: bugfix dma_sync_for_cpu/device
Date: Mon, 24 Sep 2018 22:38:04 +0200
Message-ID: <CAK8P3a0RDiP_R8+Lo9-nwiRS3k1NrtcsCFLi0Ww0TJGoAdb3iQ@mail.gmail.com>
References: <cover.1537276837.git.ren_guo@c-sky.com> <1ccf1bed89758a5a9b57ac2ce6d11ca898a1b9ae.1537276837.git.ren_guo@c-sky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1ccf1bed89758a5a9b57ac2ce6d11ca898a1b9ae.1537276837.git.ren_guo@c-sky.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Guo Ren <ren_guo@c-sky.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, Greentime Hu <green.hu@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Tue, Sep 18, 2018 at 3:48 PM Guo Ren <ren_guo@c-sky.com> wrote:
>
> ref: https://lkml.org/lkml/2018/5/18/1068
>
>         map             for_cpu         for_device      unmap
> TO_DEV  writeback       none            writeback       none
> TO_CPU  invalidate      invalidate*     invalidate      invalidate*
> BIDIR   writeback       invalidate      writeback       invalidate
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>

Same comment as for the other patch: Explain why the original
version is wrong first. When giving a reference to some other
discussion, use the "Link" tag above your Signed-off-by line.
To point to a discussion on lkml, lore.kernel.org is the
recommended archive, so it would become

Link: https://lore.kernel.org/lkml/20180518215548.GH17671@n2100.armlinux.org.uk/

       Arnd
