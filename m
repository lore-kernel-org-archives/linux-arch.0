Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:39380 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbeHVTcj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Aug 2018 15:32:39 -0400
MIME-Version: 1.0
References: <alpine.LRH.2.02.1808161556450.13597@file01.intranet.prod.int.rdu2.redhat.com>
 <CAK8P3a09jqhxYah6SZUjbku3NGiPX2PyhA+jJNG7VzJUnwUZKQ@mail.gmail.com>
 <alpine.LFD.2.21.1808172254110.26277@eddie.linux-mips.org>
 <CAK8P3a3kq35zny70Mnzmk9Tzfm2U9DLPNMyBrursPtOHpOyJSw@mail.gmail.com>
 <28597e7477418ac7cb646e2edb5e6da2@codeaurora.org> <alpine.LRH.2.02.1808201010200.15146@file01.intranet.prod.int.rdu2.redhat.com>
 <CAK8P3a3ribyvLwXaB=J4dcTwD9aYc64hfw+ORTFtyvOHuS-U0g@mail.gmail.com>
 <alpine.LRH.2.02.1808201740170.2948@file01.intranet.prod.int.rdu2.redhat.com>
 <CAK8P3a1E2V-zFN5PpJ868L=6CgTykkyjtF6-aTsCCh6QqryUig@mail.gmail.com>
 <alpine.LRH.2.02.1808210814250.24287@file01.intranet.prod.int.rdu2.redhat.com>
 <CAK8P3a3vJK1caKpDqkEhMG=8n8N3U6ckqe=0f2fjUJwk-9K0XA@mail.gmail.com>
 <alpine.LRH.2.02.1808220743270.12730@file01.intranet.prod.int.rdu2.redhat.com>
 <21c0bd37-0ae7-db8f-76b8-6552c30faa4f@codeaurora.org> <alpine.LFD.2.21.1808221609000.26277@eddie.linux-mips.org>
 <alpine.LRH.2.02.1808221136480.18647@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1808221136480.18647@file01.intranet.prod.int.rdu2.redhat.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 22 Aug 2018 18:06:51 +0200
Message-ID: <CAK8P3a20xrD3C2uGPm6dawp_02kbbZaocK5nTZLoUyeiaCkRgw@mail.gmail.com>
Subject: Re: Alpha Avanti broken by 9ce8654323d69273b4977f76f11c9e2d345ab130
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, Sinan Kaya <okaya@codeaurora.org>, Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org, okaya@kernel.org, Will Deacon <will.deacon@arm.com>, linux-arch <linux-arch@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>

On Wed, Aug 22, 2018 at 5:50 PM Mikulas Patocka <mpatocka@redhat.com> wrote:
> On Wed, 22 Aug 2018, Maciej W. Rozycki wrote:
> > On Wed, 22 Aug 2018, Sinan Kaya wrote:
>
> According to the Alpha handbook, non-overlapping accesses may be
> reordered.
>
> So if someone does
> writel(REG1);
> readl(REG2);
>
> readl may (according to the spec) reach the device before writel. Although
> actual experiments suggests that the read flushes the queued writes.
>
> I would be quite interested why did Linux developers decide that readl
> should be implemented as "read+barrier" and writel should be implemented
> as "barrier+write". Why is there this assymetry in the barriers?

I can explain this part: those two barriers are used specifically do order
an MMIO access against a DMA access: a writel() may be used to start
a DMA operation copying data from RAM to the device, so we must
have a barrier between the store to that data and the store to the register
to ensure the data is visible to the device.
Similarly, a readl() may check the status of a register that tells us when
a DMA from device to RAM has completed. We must have a read
barrier between that mmio load and the load from RAM to prevent
the data to be prefetched while the MMIO is still in progress.

> Does ARM have some hardware magic that prevents reordering the write and
> the read in this case?

Most architecture have this AFAICT, ARM and x86 definitely do, and
PCI requires this to be true on the bus:

All MMIO accesses from a given CPU to a given device (according
to an architecture-specific definition of "device") are ordered with respect
to one another.

If the hardware does not guarantee that, for simple load/store operations
on uncached device memory, then we need a full barrier after each store
in addition to the write barrier needed for the DMA synchronization.

      Arnd
