From: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Date: Sun, 27 Jan 2019 14:13:09 +0100
Message-ID: <1dec2fbe-f654-dac7-392a-93a5d20e3602@xenosoft.de>
References: <871403f2-fa7d-de15-89eb-070432e15c69@xenosoft.de>
 <20190118112842.GA9115@lst.de>
 <a2ca0118-5915-8b1c-7cfa-71cb4b43eaa6@xenosoft.de>
 <20190118121810.GA13327@lst.de>
 <eceebeda-0e18-00f6-06e7-def2eb0aa961@xenosoft.de>
 <20190118125500.GA15657@lst.de>
 <e11e61b1-6468-122e-fc2b-3b3f857186bb@xenosoft.de>
 <f39d4fc6-7e4e-9132-c03f-59f1b52260e0@xenosoft.de>
 <b9e5e081-a3cc-2625-4e08-2d55c2ba224b@xenosoft.de>
 <20190119130222.GA24346@lst.de> <20190119140452.GA25198@lst.de>
 <bfe4adcc-01c1-7b46-f40a-8e020ff77f58@xenosoft.de>
 <8434e281-eb85-51d9-106f-f4faa559e89c@xenosoft.de>
 <4d8d4854-dac9-a78e-77e5-0455e8ca56c4@xenosoft.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4d8d4854-dac9-a78e-77e5-0455e8ca56c4@xenosoft.de>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

Christoph,

What shall I do next?

Cheers,
Christian


On 25 January 2019 at 2:37PM, Christian Zigotzky wrote:
> Next step just with the first patch: 
> 5c532d07c2f3c3972104de505d06b8d85f403f06 (use powerpc zone selection)
>
> git clone git://git.infradead.org/users/hch/misc.git -b 
> powerpc-dma.6-debug a
>
> git checkout 5c532d07c2f3c3972104de505d06b8d85f403f06
>
> Link to the Git: 
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.6-debug
>
> Results:
>
> X5000: The kernel detects the SATA hard disk drive and boots without 
> any problems.
>
> X1000: The kernel boots and the P.A. Semi Ethernet works!
>
> -- Christian
>
>
> On 23 January 2019 at 3:34PM, Christian Zigotzky wrote:
>> Hi Christoph,
>>
>> I also compiled a kernel (zImage) for the X1000  from your Git 
>> 'powerpc-dma.6-debug' (both patches) today.
>>
>> It boots and the P.A. Semi Ethernet works!
>>
>> I will test just the first patch tomorrow.
>>
>> Thanks,
>> Christian
>>
>>
>> On 21 January 2019 at 3:38PM, Christian Zigotzky wrote:
>>> Hello Christoph,
>>>
>>> Thanks for your reply. I successfully compiled a kernel (uImage) for 
>>> the X5000 from your Git 'powerpc-dma.6-debug' (both patches) today.
>>>
>>> It detects the SATA hard disk drive and boots without any problems.
>>>
>>
>>
>
>
