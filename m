From: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Date: Wed, 6 Feb 2019 14:45:34 +0100
Message-ID: <b1c0161f-4211-03af-022d-0db7237516e9@xenosoft.de>
References: <6f2d6bc9-696b-2cb1-8a4e-df3da2bd6c0a@xenosoft.de>
 <20190129161411.GA14022@lst.de> <20190129163415.GA14529@lst.de>
 <F4AB3D9A-97EC-45D7-9061-A750D0934C3C@xenosoft.de>
 <96762cd2-65fc-bce5-8c5b-c03bc3baf0a1@xenosoft.de>
 <20190201080456.GA15456@lst.de>
 <9632DCDF-B9D9-416C-95FC-006B6005E2EC@xenosoft.de>
 <594beaae-9681-03de-9f42-191cc7d2f8e3@xenosoft.de>
 <20190204075616.GA5408@lst.de>
 <ffbf56ae-c259-47b5-9deb-7fb21fead254@xenosoft.de>
 <20190204123852.GA10428@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190204123852.GA10428@lst.de>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

On 04 February 2019 at 01:38PM, Christoph Hellwig wrote:
>
> It seems like the pasemi driver fails to set a DMA mask, but seems
> otherwise 64-bit DMA capable.  The old PPC code didn't verify the
> dma mask during the map operations, but the x86-derived generic
> code does.
>
> This patch just sets the DMA mask.
>
> Olof: does this look ok?  The DMA device seems to not directly
> bound by the net driver, but not really used by anything else in tree
> either..
>
> diff --git a/drivers/net/ethernet/pasemi/pasemi_mac.c b/drivers/net/ethernet/pasemi/pasemi_mac.c
> index d21041554507..d98bd447c536 100644
> --- a/drivers/net/ethernet/pasemi/pasemi_mac.c
> +++ b/drivers/net/ethernet/pasemi/pasemi_mac.c
> @@ -1716,6 +1716,7 @@ pasemi_mac_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>   		err = -ENODEV;
>   		goto out;
>   	}
> +	dma_set_mask(&mac->dma_pdev->dev, DMA_BIT_MASK(32));
>   
>   	mac->iob_pdev = pci_get_device(PCI_VENDOR_ID_PASEMI, 0xa001, NULL);
>   	if (!mac->iob_pdev) {
>
Hello Christoph,

I patched the source code from the Git 'powerpc-dma.6' with your patch 
today. Unfortunately the P.A. Semi Ethernet doesn't work with the 
patched Git kernel.

After that I tried it with the patch applied over the working setup 
again (powerpc/dma: use the dma_direct mapping routines). Unfortunately 
after compiling
and booting, the P.A. Semi Ethernet doesn't work either.

Cheers,
Christian
