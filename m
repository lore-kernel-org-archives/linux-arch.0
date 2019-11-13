From: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: Bug 205201 - overflow of DMA mask and bus mask
Date: Wed, 13 Nov 2019 11:14:16 +0100
Message-ID: <9b14ca1b-2d5d-52b5-c7b4-0e637dbb1157@xenosoft.de>
References: <71A251A5-FA06-4019-B324-7AED32F7B714@xenosoft.de>
 <1b0c5c21-2761-d3a3-651b-3687bb6ae694@xenosoft.de>
 <3504ee70-02de-049e-6402-2d530bf55a84@xenosoft.de>
 <46025f1b-db20-ac23-7dcd-10bc43bbb6ee@xenosoft.de>
 <20191105162856.GA15402@lst.de>
 <2f3c81bd-d498-066a-12c0-0a7715cda18f@xenosoft.de>
 <d2c614ec-c56e-3ec2-12d0-7561cd30c643@xenosoft.de>
 <af32bfcc-5559-578d-e1f4-75e454c965bf@xenosoft.de>
 <0c5a8009-d28b-601f-3d1a-9de0e869911c@xenosoft.de>
 <a794864f-04ae-9b90-50e7-01b416c861fe@xenosoft.de>
 <20191112144109.GA11805@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191112144109.GA11805@lst.de>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org, darren@stevens-zone.net, "contact@a-eon.com" <contact@a-eon.com>, rtd2@xtra.co.nz, mad skateman <madskateman@gmail.com>, Rob Herring <robh+dt@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, nsaenzjulienne@suse.de
List-Id: linux-arch.vger.kernel.org

Hello Christoph,

I have found the issue. :-)

GFP_DMA32 was renamed to GFP_DMA in the PowerPC updates 4.21-1 in 
December last year.

Some PCI devices still use GFP_DMA32 (grep -r GFP_DMA32 *). I renamed 
GFP_DMA32 to GFP_DMA in the file 
"drivers/media/v4l2-core/videobuf-dma-sg.c". After compiling the RC7 of 
kernel 5.4 my TV card works again.

Cheers,
Christian


On 12 November 2019 at 3:41 pm, Christoph Hellwig wrote:
> On Mon, Nov 11, 2019 at 01:22:55PM +0100, Christian Zigotzky wrote:
>> Now, I can definitely say that this patch does not solve the issue.
>>
>> Do you have another patch for testing or shall I bisect?
> I'm still interested in the .config and dmesg.  Especially if the
> board is using arch/powerpc/sysdev/fsl_pci.c, which is the only
> place inside the powerpc arch code doing funny things with the
> bus_dma_mask, which Robin pointed out looks fishy.
>
>> Thanks,
>> Christian
> ---end quoted text---
>
