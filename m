Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:27862 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbeLGPFA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 7 Dec 2018 10:05:00 -0500
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 01/34] powerpc: use mm zones more sensibly
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <20181207140910.GA23609@lst.de>
Date: Fri, 7 Dec 2018 16:04:16 +0100
Content-Transfer-Encoding: quoted-printable
Message-ID: <037E87F4-38C7-4E5F-A132-B7BB30E3D69D@xenosoft.de>
References: <20181114082314.8965-1-hch@lst.de> <20181114082314.8965-2-hch@lst.de> <20181206140948.GB29741@infradead.org> <87sgz9jzsl.fsf@concordia.ellerman.id.au> <20181207140910.GA23609@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Message-ID: <20181207150416.98j85lTCgWtBFtuhIJrAQx-G_iE4CQwkpWhH9F7TroY@z>

I will work at the weekend to figure out where the problematic commit is.

=E2=80=94 Christian

Sent from my iPhone

> On 7. Dec 2018, at 15:09, Christoph Hellwig <hch@lst.de> wrote:
>=20
>> On Fri, Dec 07, 2018 at 11:18:18PM +1100, Michael Ellerman wrote:
>> Christoph Hellwig <hch@infradead.org> writes:
>>=20
>>> Ben / Michael,
>>>=20
>>> can we get this one queued up for 4.21 to prepare for the DMA work later=

>>> on?
>>=20
>> I was hoping the PASEMI / NXP regressions could be solved before
>> merging.
>>=20
>> My p5020ds is booting fine with this series, so I'm not sure why it's
>> causing problems on Christian's machine.
>>=20
>> The last time I turned on my PASEMI board it tripped some breakers, so I
>> need to investigate that before I can help test that.
>>=20
>> I'll see how things look on Monday and either merge the commits you
>> identified or the whole series depending on if there's any more info
>> from Christian.
>=20
> Christian just confirmed everything up to at least
> "powerpc/dma: stop overriding dma_get_required_mask" works for his
> setups.
