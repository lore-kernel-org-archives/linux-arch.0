From: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Date: Fri, 8 Feb 2019 10:01:46 +0100
Message-ID: <7c1f208b-6909-3b0a-f9f9-38ff1ac3d617@xenosoft.de>
References: <F4AB3D9A-97EC-45D7-9061-A750D0934C3C@xenosoft.de>
 <96762cd2-65fc-bce5-8c5b-c03bc3baf0a1@xenosoft.de>
 <20190201080456.GA15456@lst.de>
 <9632DCDF-B9D9-416C-95FC-006B6005E2EC@xenosoft.de>
 <594beaae-9681-03de-9f42-191cc7d2f8e3@xenosoft.de>
 <20190204075616.GA5408@lst.de>
 <ffbf56ae-c259-47b5-9deb-7fb21fead254@xenosoft.de>
 <20190204123852.GA10428@lst.de>
 <b1c0161f-4211-03af-022d-0db7237516e9@xenosoft.de>
 <20190206151505.GA31065@lst.de> <20190206151655.GA31172@lst.de>
 <61EC67B1-12EF-42B6-B69B-B59F9E4FC474@xenosoft.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <61EC67B1-12EF-42B6-B69B-B59F9E4FC474@xenosoft.de>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

Hi Christoph,

Your new patch fixes the problems with the P.A. Semi Ethernet! :-)

Thanks,
Christian


On 07 February 2019 at 05:34AM, Christian Zigotzky wrote:
> Hi Christoph,
>
> I also didn’t notice the 32-bit DMA mask in your patch. I have to read your patches and descriptions carefully in the future. I will test your new patch at the weekend.
>
> Thanks,
> Christian
>
> Sent from my iPhone
>
>> On 6. Feb 2019, at 16:16, Christoph Hellwig <hch@lst.de> wrote:
>>
>>> On Wed, Feb 06, 2019 at 04:15:05PM +0100, Christoph Hellwig wrote:
>>> The last good one was 29e7e2287e196f48fe5d2a6e017617723ea979bf
>>> ("dma-direct: we might need GFP_DMA for 32-bit dma masks"), if I
>>> remember correctly.  powerpc/dma: use the dma_direct mapping routines
>>> was the one that you said makes the pasemi ethernet stop working.
>>>
>>> Can you post the dmesg from the failing runs?
>> But I just noticed I sent you a wrong patch - the pasemi ethernet
>> should set a 64-bit DMA mask, not 32-bit.  Updated version below,
>> 32-bit would just keep the previous status quo.
>>
>> commit 6c8f88045dee35933337b9ce2ea5371eee37073a
>> Author: Christoph Hellwig <hch@lst.de>
>> Date:   Mon Feb 4 13:38:22 2019 +0100
>>
>>     pasemi WIP
>>
>> diff --git a/drivers/net/ethernet/pasemi/pasemi_mac.c b/drivers/net/ethernet/pasemi/pasemi_mac.c
>> index 8a31a02c9f47..2d7d1589490a 100644
>> --- a/drivers/net/ethernet/pasemi/pasemi_mac.c
>> +++ b/drivers/net/ethernet/pasemi/pasemi_mac.c
>> @@ -1716,6 +1716,7 @@ pasemi_mac_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>         err = -ENODEV;
>>         goto out;
>>     }
>> +    dma_set_mask(&mac->dma_pdev->dev, DMA_BIT_MASK(64));
>>
>>     mac->iob_pdev = pci_get_device(PCI_VENDOR_ID_PASEMI, 0xa001, NULL);
>>     if (!mac->iob_pdev) {
