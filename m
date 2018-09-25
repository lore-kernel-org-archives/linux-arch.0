From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V7 1/2] csky/dma: bugfix dma_sync_for_cpu/device
Date: Tue, 25 Sep 2018 17:46:03 +0800
Message-ID: <20180925094601.GA2102@guoren>
References: <cover.1537276837.git.ren_guo@c-sky.com>
 <1ccf1bed89758a5a9b57ac2ce6d11ca898a1b9ae.1537276837.git.ren_guo@c-sky.com>
 <CAK8P3a0RDiP_R8+Lo9-nwiRS3k1NrtcsCFLi0Ww0TJGoAdb3iQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a0RDiP_R8+Lo9-nwiRS3k1NrtcsCFLi0Ww0TJGoAdb3iQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, Greentime Hu <green.hu@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Mon, Sep 24, 2018 at 10:38:04PM +0200, Arnd Bergmann wrote:
> On Tue, Sep 18, 2018 at 3:48 PM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > ref: https://lkml.org/lkml/2018/5/18/1068
> >
> >         map             for_cpu         for_device      unmap
> > TO_DEV  writeback       none            writeback       none
> > TO_CPU  invalidate      invalidate*     invalidate      invalidate*
> > BIDIR   writeback       invalidate      writeback       invalidate
> >
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> 
> Same comment as for the other patch: Explain why the original
> version is wrong first. When giving a reference to some other
> discussion, use the "Link" tag above your Signed-off-by line.
> To point to a discussion on lkml, lore.kernel.org is the
> recommended archive, so it would become
> 
> Link: https://lore.kernel.org/lkml/20180518215548.GH17671@n2100.armlinux.org.uk/
Ok, I'll improve the comment:

Fixup dma_mapping error in linux-4.19-rc3, and we must implement all
DMA_TO_DEVICE/FROM_DEVICE/BIDIRECTIONAL for both sync_dma_for_device/cpu.
The implementation of arch should follow the following rules:

         map             for_cpu         for_device      unmap
 TO_DEV  writeback       none            writeback       none
 TO_CPU  invalidate      invalidate*     invalidate      invalidate*
 BIDIR   writeback       invalidate      writeback       invalidate

 Link: https://lore.kernel.org/lkml/20180518215548.GH17671@n2100.armlinux.org.uk/
 Signed-off-by: Guo Ren <ren_guo@c-sky.com>

Best Regards
 Guo Ren
