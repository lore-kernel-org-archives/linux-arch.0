Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.166]:21153 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbfBHK7f (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Feb 2019 05:59:35 -0500
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: use generic DMA mapping code in powerpc V4
From: Christian Zigotzky <chzigotzky@xenosoft.de>
In-Reply-To: <20190208091818.GA23491@lst.de>
Date: Fri, 8 Feb 2019 11:59:14 +0100
Content-Transfer-Encoding: quoted-printable
Message-ID: <A289D18C-1239-4296-B58F-FFB0DF1D9C79@xenosoft.de>
References: <9632DCDF-B9D9-416C-95FC-006B6005E2EC@xenosoft.de> <594beaae-9681-03de-9f42-191cc7d2f8e3@xenosoft.de> <20190204075616.GA5408@lst.de> <ffbf56ae-c259-47b5-9deb-7fb21fead254@xenosoft.de> <20190204123852.GA10428@lst.de> <b1c0161f-4211-03af-022d-0db7237516e9@xenosoft.de> <20190206151505.GA31065@lst.de> <20190206151655.GA31172@lst.de> <61EC67B1-12EF-42B6-B69B-B59F9E4FC474@xenosoft.de> <7c1f208b-6909-3b0a-f9f9-38ff1ac3d617@xenosoft.de> <20190208091818.GA23491@lst.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
Message-ID: <20190208105914.fvXIA0QxS9P-fIz2N6XjFLZOhHTHxd2MTqS3VWig3ms@z>

OK, I will test it.

=E2=80=94 Christian

Sent from my iPhone

> On 8. Feb 2019, at 10:18, Christoph Hellwig <hch@lst.de> wrote:
>=20
>> On Fri, Feb 08, 2019 at 10:01:46AM +0100, Christian Zigotzky wrote:
>> Hi Christoph,
>>=20
>> Your new patch fixes the problems with the P.A. Semi Ethernet! :-)
>=20
> Thanks a lot once again for testing!
>=20
> Now can you test with this patch and the whole series?
>=20
> I've updated the powerpc-dma.6 branch to include this fix.
