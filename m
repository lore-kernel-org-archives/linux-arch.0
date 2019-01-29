From: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Date: Tue, 29 Jan 2019 16:03:32 +0100
Message-ID: <6f2d6bc9-696b-2cb1-8a4e-df3da2bd6c0a@xenosoft.de>
References: <e11e61b1-6468-122e-fc2b-3b3f857186bb@xenosoft.de>
 <f39d4fc6-7e4e-9132-c03f-59f1b52260e0@xenosoft.de>
 <b9e5e081-a3cc-2625-4e08-2d55c2ba224b@xenosoft.de>
 <20190119130222.GA24346@lst.de> <20190119140452.GA25198@lst.de>
 <bfe4adcc-01c1-7b46-f40a-8e020ff77f58@xenosoft.de>
 <8434e281-eb85-51d9-106f-f4faa559e89c@xenosoft.de>
 <4d8d4854-dac9-a78e-77e5-0455e8ca56c4@xenosoft.de>
 <1dec2fbe-f654-dac7-392a-93a5d20e3602@xenosoft.de>
 <20190128070422.GA2772@lst.de> <20190128162256.GA11737@lst.de>
 <D64B1ED5-46F9-43CF-9B21-FABB2807289B@xenosoft.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <D64B1ED5-46F9-43CF-9B21-FABB2807289B@xenosoft.de>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

Hi Christoph,

I compiled kernels for the X5000 and X1000 from your new branch 
'powerpc-dma.6-debug.2' today. The kernels boot and the P.A. Semi 
Ethernet works!

Cheers,
Christian


On 28 January 2019 at 5:52PM, Christian Zigotzky wrote:
> Thanks a lot! I will test it tomorrow.
>
> — Christian
>
> Sent from my iPhone
>
>> On 28. Jan 2019, at 17:22, Christoph Hellwig <hch@lst.de> wrote:
>>
>>> On Mon, Jan 28, 2019 at 08:04:22AM +0100, Christoph Hellwig wrote:
>>>> On Sun, Jan 27, 2019 at 02:13:09PM +0100, Christian Zigotzky wrote:
>>>> Christoph,
>>>>
>>>> What shall I do next?
>>> I'll need to figure out what went wrong with the new zone selection
>>> on powerpc and give you another branch to test.
>> Can you try the new powerpc-dma.6-debug.2 branch:
>>
>>     git://git.infradead.org/users/hch/misc.git powerpc-dma.6-debug.2
>>
>> Gitweb:
>>
>>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.6-debug.2
>
