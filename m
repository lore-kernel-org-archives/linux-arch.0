Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.83]:18310 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfKUMVb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 21 Nov 2019 07:21:31 -0500
Subject: Re: Bug 205201 - Booting halts if Dawicontrol DC-2976 UW SCSI board
 installed, unless RAM size limited to 3500M
From: Christian Zigotzky <chzigotzky@xenosoft.de>
References: <F1EBB706-73DF-430E-9020-C214EC8ED5DA@xenosoft.de>
 <20191121072943.GA24024@lst.de>
 <dbde2252-035e-6183-7897-43348e60647e@xenosoft.de>
Message-ID: <6eec5c42-019c-a988-fc2a-cb804194683d@xenosoft.de>
Date: Thu, 21 Nov 2019 13:21:23 +0100
MIME-Version: 1.0
In-Reply-To: <dbde2252-035e-6183-7897-43348e60647e@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org, darren@stevens-zone.net, "contact@a-eon.com" <contact@a-eon.com>, rtd2@xtra.co.nz, mad skateman <madskateman@gmail.com>, Rob Herring <robh+dt@kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, nsaenzjulienne@suse.de
Message-ID: <20191121122123.5BaXjGEplFxeH5KDyzdAim2UBKtC6ZG_LXQRZFMoDNo@z>

On 21 November 2019 at 01:16 pm, Christian Zigotzky wrote:
> On 21 November 2019 at 08:29 am, Christoph Hellwig wrote:
>> On Sat, Nov 16, 2019 at 08:06:05AM +0100, Christian Zigotzky wrote:
>>> /*
>>>   *  DMA addressing mode.
>>>   *
>>>   *  0 : 32 bit addressing for all chips.
>>>   *  1 : 40 bit addressing when supported by chip.
>>>   *  2 : 64 bit addressing when supported by chip,
>>>   *      limited to 16 segments of 4 GB -> 64 GB max.
>>>   */
>>> #define   SYM_CONF_DMA_ADDRESSING_MODE 
>>> CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE
>>>
>>> Cyrus config:
>>>
>>> CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
>>>
>>> I will configure “0 : 32 bit addressing for all chips” for the RC8. 
>>> Maybe this is the solution.
>> 0 means you are going to do bounce buffering a lot, which seems
>> generally like a bad idea.
>>
>> But why are we talking about the sym53c8xx driver now?  The last issue
>> you reported was about video4linux allocations.
>>
> Both drivers have the same problem. They don't work if we have more 
> than 3.5GB RAM. I try to find a solution until you have a good 
> solution. I have already a solution for V4L but I still need one for 
> the sym53c8xx driver.
OK, you mean that "0" is a bad idea but maybe it works until you have a 
solution. ;-)
