Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbfBOBWE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 Feb 2019 20:22:04 -0500
Date: Fri, 15 Feb 2019 09:21:56 +0800
From: Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH 01/10] irqchip/csky: Support csky,dh7k SOC intc driver
Message-ID: <20190215012156.GA3226@guoren-Inspiron-7460>
References: <1548764669-16656-1-git-send-email-guoren@kernel.org>
 <86bm3esbzr.wl-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86bm3esbzr.wl-marc.zyngier@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: arnd@arndb.de, robh+dt@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
Message-ID: <20190215012156.CFLTSphfDgQhRyIktouqlUgnSZK0F7ZkysU_GxR8rys@z>

On Thu, Feb 14, 2019 at 02:03:52PM +0000, Marc Zyngier wrote:
> On Tue, 29 Jan 2019 12:24:20 +0000,
> guoren@kernel.org wrote:
> > 
> > From: Guo Ren <ren_guo@c-sky.com>
> > 
> > C-SKY dh7k SOC use simple APB interrupt controller and most of driver's
> > implementation codes could be reused in csky-apb-intc.c. So merge them
> > together.
> > 
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> > ---
> >  drivers/irqchip/irq-csky-apb-intc.c | 95 +++++++++++++++++++++++++++++++++----
> >  1 file changed, 85 insertions(+), 10 deletions(-)
> > 
> 
> So this patch series seems to contain both core c-sky stuff as well as
> irqchip updates.
There are no dependencies on core-csky stuff and irqchip in this patch
series.

> 
> Please send an irqchip series that I can take standalone. 
Ok, I'll send a standalone irqchip series later.

> If there are
> dependencies, please state so in the cover letter, and we'll work out
> something. Please make sure that everybody gets at least the cover
> letter (I didn't receive one for this series).

I guess you are worried about:

+#include <asm/traps.h>
 ...
+
+	for (i = 32; i < 128; i++)
+		VEC_INIT(i, csky_irq);
+

In arch/csky, 32 - 127 trap entries are reserved for vector irqs. But
the mode of vector irq need irq controller to support, or csky cpu will
use trap 10 for all interrupts and get irq-num from interrupt controller.

Some interrupt controllers don't support trap 10, so they need working
at vector mode and get irq-num by mfcr("psr").

Here we just use csky_irq instead of csky_trap which initiated by arch/csky.

Best Regards
 Guo Ren
