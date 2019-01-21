From: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Date: Mon, 21 Jan 2019 15:38:38 +0100
Message-ID: <bfe4adcc-01c1-7b46-f40a-8e020ff77f58@xenosoft.de>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190119140452.GA25198@lst.de>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: linux-arch@vger.kernel.org, Darren Stevens <darren@stevens-zone.net>, linux-kernel@vger.kernel.org, Julian Margetson <runaway@candw.ms>, linux-mm@kvack.org, iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-arch.vger.kernel.org

Hello Christoph,

Thanks for your reply. I successfully compiled a kernel (uImage) for the 
X5000 from your Git 'powerpc-dma.6-debug' (both patches) today.

It detects the SATA hard disk drive and boots without any problems. I 
will test the first patch in next days.

Thanks for your help,

Christian


On 19 January 2019 at 3:04PM, Christoph Hellwig wrote:
> On Sat, Jan 19, 2019 at 02:02:22PM +0100, Christoph Hellwig wrote:
>> Interesting.  This suggest it is related to the use of ZONE_DMA by
>> the FSL SOCs that your board uses.  Let me investigate this a bit more.
> As a hack to check that theory I've pushed a new commit to the
> powerpc-dma.6-debug branch to use old powerpc GFP_DMA selection
> with the new dma direct code:
>
> http://git.infradead.org/users/hch/misc.git/commitdiff/5c532d07c2f3c3972104de505d06b8d85f403f06
>
> And another one that drops the addressability checks that powerpc
> never had:
>
> http://git.infradead.org/users/hch/misc.git/commitdiff/18e7629b38465ca98f8e7eed639123a13ac3b669
>
> Can you first test with both patches, and then just with the first
> in case that worked?
>
>
