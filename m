Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:46395 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390137AbfKEQ3A (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 5 Nov 2019 11:29:00 -0500
Date: Tue, 5 Nov 2019 17:28:56 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: Bug 205201 - overflow of DMA mask and bus mask
Message-ID: <20191105162856.GA15402@lst.de>
References: <20181213112511.GA4574@lst.de> <e109de27-f4af-147d-dc0e-067c8bafb29b@xenosoft.de> <ad5a5a8a-d232-d523-a6f7-e9377fc3857b@xenosoft.de> <e60d6ca3-860c-f01d-8860-c5e022ec7179@xenosoft.de> <008c981e-bdd2-21a7-f5f7-c57e4850ae9a@xenosoft.de> <20190103073622.GA24323@lst.de> <71A251A5-FA06-4019-B324-7AED32F7B714@xenosoft.de> <1b0c5c21-2761-d3a3-651b-3687bb6ae694@xenosoft.de> <3504ee70-02de-049e-6402-2d530bf55a84@xenosoft.de> <46025f1b-db20-ac23-7dcd-10bc43bbb6ee@xenosoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <46025f1b-db20-ac23-7dcd-10bc43bbb6ee@xenosoft.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Olof Johansson <olof@lixom.net>
Message-ID: <20191105162856.aFGJCAzyyuEcM_mnu2yX-bOSxOLYtsyQXZ5wVpIh6eE@z>

On Tue, Nov 05, 2019 at 08:56:27AM +0100, Christian Zigotzky wrote:
> Hi All,
>
> We still have DMA problems with some PCI devices. Since the PowerPC updates 
> 4.21-1 [1] we need to decrease the RAM to 3500MB (mem=3500M) if we want to 
> work with our PCI devices. The FSL P5020 and P5040 have these problems 
> currently.
>
> Error message:
>
> [   25.654852] bttv 1000:04:05.0: overflow 0x00000000fe077000+4096 of DMA 
> mask ffffffff bus mask df000000
>
> All 5.x Linux kernels can't initialize a SCSI PCI card anymore so booting 
> of a Linux userland isn't possible.
>
> PLEASE check the DMA changes in the PowerPC updates 4.21-1 [1]. The kernel 
> 4.20 works with all PCI devices without limitation of RAM.

Can you send me the .config and a dmesg?  And in the meantime try the
patch below?

---
