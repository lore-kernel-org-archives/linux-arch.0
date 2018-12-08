Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165]:30348 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbeLHNru (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 8 Dec 2018 08:47:50 -0500
Subject: Re: use generic DMA mapping code in powerpc V4
From: Christian Zigotzky <chzigotzky@xenosoft.de>
References: <20181129170351.GC27951@lst.de>
 <d0e04a85-f17d-414e-6fea-971414417430@xenosoft.de>
 <20181130105346.GB26765@lst.de>
 <8694431d-c669-b7b9-99fa-e99db5d45a7d@xenosoft.de>
 <20181130131056.GA5211@lst.de>
 <25999587-2d91-a63c-ed38-c3fb0075d9f1@xenosoft.de>
 <c5202d29-863d-1377-0e2d-762203b317e2@xenosoft.de>
 <58c61afb-290f-6196-c72c-ac7b61b84718@xenosoft.de>
 <20181204142426.GA2743@lst.de>
 <ef56d279-f75d-008e-71ba-7068c1b37c48@xenosoft.de>
 <20181205140550.GA27549@lst.de>
 <1948cf84-49ab-543c-472c-d18e27751903@xenosoft.de>
 <5a2ea855-b4b0-e48a-5c3e-c859a8451ca2@xenosoft.de>
 <7B6DDB28-8BF6-4589-84ED-F1D4D13BFED6@xenosoft.de>
 <8a2c4581-0c85-8065-f37e-984755eb31ab@xenosoft.de>
Message-ID: <424bb228-c9e5-6593-1ab7-5950d9b2bd4e@xenosoft.de>
Date: Sat, 8 Dec 2018 14:47:44 +0100
MIME-Version: 1.0
In-Reply-To: <8a2c4581-0c85-8065-f37e-984755eb31ab@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
Message-ID: <20181208134744.sWcgAhXGlYm0suIGow9qdOP5DGPY4uKsEtYrljlyesc@z>

Next step: e15cd8173ef85e9cc3e2a9c7cc2982f5c1355615 (powerpc/dma: fix an 
off-by-one in dma_capable)

git checkout e15cd8173ef85e9cc3e2a9c7cc2982f5c1355615

The PASEMI onboard ethernet also works with this commit and the X5000 
boots without any problems.

-- Christian


On 08 December 2018 at 11:29AM, Christian Zigotzky wrote:
> Next step: 7ebc44c535f6bd726d553756d38b137acc718443 (powerpc/dma: 
> remove max_direct_dma_addr)
>
> git checkout 7ebc44c535f6bd726d553756d38b137acc718443
>
> OK, the PASEMI onboard ethernet works and the P5020 board boots.
>
> -- Christian
>
>
> On 07 December 2018 at 7:33PM, Christian Zigotzky wrote:
>> Next step: 13c1fdec5682b6e13257277fa16aa31f342d167d (powerpc/dma: 
>> move pci_dma_dev_setup_swiotlb to fsl_pci.c)
>>
>> git checkout 13c1fdec5682b6e13257277fa16aa31f342d167d
>>
>> Result: The PASEMI onboard ethernet works and the P5020 board boots.
>>
>> — Christian
>
>
>
