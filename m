Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:49067 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727965AbfASNCY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 19 Jan 2019 08:02:24 -0500
Date: Sat, 19 Jan 2019 14:02:22 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Message-ID: <20190119130222.GA24346@lst.de>
References: <20190118083539.GA30479@lst.de> <871403f2-fa7d-de15-89eb-070432e15c69@xenosoft.de> <20190118112842.GA9115@lst.de> <a2ca0118-5915-8b1c-7cfa-71cb4b43eaa6@xenosoft.de> <20190118121810.GA13327@lst.de> <eceebeda-0e18-00f6-06e7-def2eb0aa961@xenosoft.de> <20190118125500.GA15657@lst.de> <e11e61b1-6468-122e-fc2b-3b3f857186bb@xenosoft.de> <f39d4fc6-7e4e-9132-c03f-59f1b52260e0@xenosoft.de> <b9e5e081-a3cc-2625-4e08-2d55c2ba224b@xenosoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9e5e081-a3cc-2625-4e08-2d55c2ba224b@xenosoft.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
Message-ID: <20190119130222.DZlwGlZrwOvS8Ju8X2CMXdnHb9FK_2K3vnZSjC5yGyg@z>

On Sat, Jan 19, 2019 at 12:52:52PM +0100, Christian Zigotzky wrote:
> Hi Christoph,
>
> I have found a small workaround. If I add 'mem=3500M' to the boot arguments 
> then it detects the SATA hard disk and boots without any problems.
>
> X5000> setenv bootargs root=/dev/sda2 console=ttyS0,115200 mem=3500M

Interesting.  This suggest it is related to the use of ZONE_DMA by
the FSL SOCs that your board uses.  Let me investigate this a bit more.
