Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:36985 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfLSNzL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Dec 2019 08:55:11 -0500
Subject: Re: use generic DMA mapping code in powerpc V4
From: Christian Zigotzky <chzigotzky@xenosoft.de>
References: <20181114082314.8965-1-hch@lst.de> <20181127074253.GB30186@lst.de>
 <87zhttfonk.fsf@concordia.ellerman.id.au>
 <535776df-dea3-eb26-6bf3-83f225e977df@xenosoft.de>
Message-ID: <ea5433f6-ef8d-3cd0-0645-dd89c4806dca@xenosoft.de>
Date: Thu, 19 Dec 2019 14:54:27 +0100
MIME-Version: 1.0
In-Reply-To: <535776df-dea3-eb26-6bf3-83f225e977df@xenosoft.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: de-DE
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>, Christoph Hellwig <hch@lst.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, "R.T.Dickinson" <rtd2@xtra.co.nz>, "contact@a-eon.com" <contact@a-eon.com>, mad skateman <madskateman@gmail.com>, Darren Stevens <darren@stevens-zone.net>
Message-ID: <20191219135427.84DV5zU6taFoNSSEaK2Ov1YcBlB06JXdIRFGW_i7jxk@z>

Hi All,

We still have some issues with PCI cards in our FSL P5020 and P5040 
systems since the DMA mapping updates. [1, 2]

We have to limit the RAM to 3500MB for some problematic PCI cards. 
(kernel boot argument 'mem=3500M')

The problematic DMA mapping code was added with the PowerPC updates 
4.21-1 to the official kernel source code last year. [3]

We have created a bug report. [4]

The old 4.x kernels aren't affected because they use the old DMA code.

Please check the new DMA code again.

Thanks,
Christian

[1] 
http://forum.hyperion-entertainment.com/viewtopic.php?f=58&p=49486#p49486
[2] 
http://forum.hyperion-entertainment.com/viewtopic.php?f=58&t=4349&start=50#p49099
[3] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8d6973327ee84c2f40dd9efd8928d4a1186c96e2
[4] https://bugzilla.kernel.org/show_bug.cgi?id=205201


On 28 November 2018 at 4:55 pm, Christian Zigotzky wrote:
> On 28 November 2018 at 12:05PM, Michael Ellerman wrote:
>> Nothing specific yet.
>>
>> I'm a bit worried it might break one of the many old obscure platforms
>> we have that aren't well tested.
>>
> Please don't apply the new DMA mapping code if you don't be sure if it 
> works on all supported PowerPC machines. Is the new DMA mapping code 
> really necessary? It's not really nice, to rewrote code if the old 
> code works perfect. We must not forget, that we work for the end 
> users. Does the end user have advantages with this new code? Is it 
> faster? The old code works without any problems. I am also worried 
> about this code. How can I test this new DMA mapping code?
>
> Thanks
>
>
