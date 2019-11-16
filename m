Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:27842 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfKPHGv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 16 Nov 2019 02:06:51 -0500
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (1.0)
Date: Sat, 16 Nov 2019 08:06:05 +0100
Subject: Bug 205201 - Booting halts if Dawicontrol DC-2976 UW SCSI board installed, unless RAM size limited to 3500M
Message-ID: <F1EBB706-73DF-430E-9020-C214EC8ED5DA@xenosoft.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org, darren@stevens-zone.net, "contact@a-eon.com" <contact@a-eon.com>, rtd2@xtra.co.nz, mad skateman <madskateman@gmail.com>, Rob Herring <robh+dt@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, nsaenzjulienne@suse.de
Message-ID: <20191116070605.cRDPKNH4D_VnJ-ynnCLtB7201VPXC_SI2BfskbK89zw@z>

FYI: Source files of the Dawicontrol DC 2976 UW SCSI board (PCI): https://gi=
t.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/scsi/s=
ym53c8xx_2?h=3Dv5.4-rc7

/*
 *  DMA addressing mode.
 *
 *  0 : 32 bit addressing for all chips.
 *  1 : 40 bit addressing when supported by chip.
 *  2 : 64 bit addressing when supported by chip,
 *      limited to 16 segments of 4 GB -> 64 GB max.
 */
#define   SYM_CONF_DMA_ADDRESSING_MODE CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_=
MODE

Cyrus config:

CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=3D1

I will configure =E2=80=9C0 : 32 bit addressing for all chips=E2=80=9D for t=
he RC8. Maybe this is the solution.

> On 13. Nov 2019, at 12:02, Christoph Hellwig <hch@lst.de> wrote:
>=20
> Interesting.  Give me some time to come up with a real fix, as drivers
> really should not mess with GFP flags for these allocations, and even
> if they did swiotlb is supposed to take care of any resulting problems.
