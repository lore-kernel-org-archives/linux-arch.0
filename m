From: Christian Zigotzky <chzigotzky-KCoaydhb8eAb1SvskN2V4Q@public.gmane.org>
Subject: Re: use generic DMA mapping code in powerpc V4
Date: Tue, 12 Feb 2019 20:31:56 +0100
Message-ID: <47bff9d1-7001-4d92-4ad1-e24215b56555@xenosoft.de>
References: <20190204123852.GA10428@lst.de>
	<b1c0161f-4211-03af-022d-0db7237516e9@xenosoft.de>
	<20190206151505.GA31065@lst.de> <20190206151655.GA31172@lst.de>
	<61EC67B1-12EF-42B6-B69B-B59F9E4FC474@xenosoft.de>
	<7c1f208b-6909-3b0a-f9f9-38ff1ac3d617@xenosoft.de>
	<20190208091818.GA23491@lst.de>
	<4e7137db-e600-0d20-6fb2-6d0f9739aca3@xenosoft.de>
	<20190211073804.GA15841@lst.de>
	<820bfeb1-30c0-3d5a-54a2-c4f9a8c15b0e@xenosoft.de>
	<20190212152543.GA24061@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190212152543.GA24061-jcswGhMUV9g@public.gmane.org>
Content-Language: de-DE
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Darren Stevens <darren-YHtdit1eIT3easaKlIn9Lw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Julian Margetson <runaway-zqC88Q5qmK4@public.gmane.org>, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On 12 February 2019 at 4:25PM, Christoph Hellwig wrote:
> On Tue, Feb 12, 2019 at 01:42:56PM +0100, Christian Zigotzky wrote:
>> On 11 February 2019 at 08:38AM, Christoph Hellwig wrote:
>>> On Sun, Feb 10, 2019 at 01:00:20PM +0100, Christian Zigotzky wrote:
>>>> I tested the whole series today. The kernels boot and the P.A. Semi
>>>> Ethernet works! :-) Thanks a lot!
>>>>
>>>> I also tested it in a virtual e5500 QEMU machine today. Unfortunately the
>>>> kernel crashes.
>>> This looks like a patch I fixed in mainline a while ago, but which
>>> the powerpc tree didn't have yet.
>>>
>>> I've cherry picked this commit
>>> ("swiotlb: clear io_tlb_start and io_tlb_end in swiotlb_exit")
>>>
>>> and added it to the powerpc-dma.6 tree, please retry with that one.
>>>
>> Hello Christoph,
>>
>> Have you added it to the powerpc-dma.6 tree yet? The last commit was 4 days
>> ago.
> I added it, but forgot to push it out.  It is there now, sorry:
>
> http://git.infradead.org/users/hch/misc.git/commitdiff/2cf0745b7420af4a3e871d5a970a45662dfae69c
>
Hi Christoph

Many thanks! Your Git kernel works in a virtual e5500 machine now! :-)

I think we have reached the end of testing! All things are working with 
your DMA updates.

I am looking forward to test your DMA changes in the next merge window 
again. :-)

Cheers
Christian
