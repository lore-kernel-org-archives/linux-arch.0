Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:53008 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727606AbeIYPYN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 Sep 2018 11:24:13 -0400
Date: Tue, 25 Sep 2018 17:17:03 +0800
From: Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH V7 2/2] csky: remove irq_mapping from smp.c.
Message-ID: <20180925091702.GA6607@guoren>
References: <cover.1537276837.git.ren_guo@c-sky.com>
 <ec95f397f52b8b5d9191b85d0d907a1a43d2e2c1.1537276837.git.ren_guo@c-sky.com>
 <CAK8P3a2WLCZNZ_A1qPQuEQdxEyLKZj2EY2oHzG+_GTGiWEna7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2WLCZNZ_A1qPQuEQdxEyLKZj2EY2oHzG+_GTGiWEna7w@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com, Greentime Hu <green.hu@gmail.com>
Message-ID: <20180925091703.316PQIwI9I-1pB8cCgBqXNk3tn4X0GjE3PxZUgY4znk@z>

On Mon, Sep 24, 2018 at 10:23:14PM +0200, Arnd Bergmann wrote:
> On Tue, Sep 18, 2018 at 3:48 PM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> >  - remove irq_mapping from smp.c to irq-driver
> >  - Add set_ipi_irq_mapping api to irq-driver
> >  - update asm/smp.h
> >
> > Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> 
> The patch seems ok to me, but please try to improve the changelog comments.
> Generally speaking, use full English sentences instead of an enumerated list,
> and explain what the change is for rather than what you are doing. The text
Ok, I'll improve it.
> you have here can easily be derived from looking at the code changes,
> but I still don't understand what caused you to change it, and why this
> is better than the previous version.
The changelog comment will change to:

There are some feedbacks from irqchip, and we need to adjust "smp.c & smp.h"
to match the csky_mptimer modification.
 - Move IPI_IRQ define into drivers/irqchip/csky_mpintc.c, because it's a
   interrupt controller specific.
 - Bugfix request_irq with IPI_IRQ, we must use irq_mapping return value not
   directly use IPI_IRQ. The modification also involves csky_mpintc.

Best Regards
 Guo Ren
