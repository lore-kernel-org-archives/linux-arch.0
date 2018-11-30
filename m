From: Christian Zigotzky <chzigotzky-KCoaydhb8eAb1SvskN2V4Q@public.gmane.org>
Subject: Re: use generic DMA mapping code in powerpc V4
Date: Fri, 30 Nov 2018 16:29:40 +0100
Message-ID: <25999587-2d91-a63c-ed38-c3fb0075d9f1@xenosoft.de>
References: <20181114082314.8965-1-hch@lst.de> <20181127074253.GB30186@lst.de>
	<87zhttfonk.fsf@concordia.ellerman.id.au>
	<4d4e3cdd-d1a9-affe-0f63-45b8c342bbd6@xenosoft.de>
	<20181129170351.GC27951@lst.de>
	<d0e04a85-f17d-414e-6fea-971414417430@xenosoft.de>
	<20181130105346.GB26765@lst.de>
	<8694431d-c669-b7b9-99fa-e99db5d45a7d@xenosoft.de>
	<20181130131056.GA5211@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181130131056.GA5211-jcswGhMUV9g@public.gmane.org>
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
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Darren Stevens <darren-YHtdit1eIT3easaKlIn9Lw@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Julian Margetson <runaway-zqC88Q5qmK4@public.gmane.org>, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-arch.vger.kernel.org

Hello Christoph,

Thanks for your reply.

On 30 November 2018 at 2:10PM, Christoph Hellwig wrote:
> On Fri, Nov 30, 2018 at 01:23:20PM +0100, Christian Zigotzky wrote:
>> Yes, of course. I patched your Git kernel and after that I compiled it
>> again. U-Boot loads the kernel and the dtb file. Then the kernel starts but
>> it doesn't find any hard disks (partitions).
> Interesting.  Does it find the storage controller (what kind of
> storage does it use?).
It seems not. I don't see any infos about hard disks in the kernel ring 
buffer. The two serial ATA (SATA 2.0) controllers are integrated in the 
P5020 SoC and the hard disks are connected via SerDes lanes (PCIe) to 
the SoC. LANE 16 = SATA 0 and LANE 17 = SATA 1.
> For the PASEMI board can you test the attached patch?  Also are you
> using Compact Flash cards on that system?
Yes, we are using Compact Flash cards. The slot is wired to the CPU 
local bus. It works with your kernel. :-)

Where is the attached patch?

I downloaded the version 5 of your Git kernel and compiled it today. 
Unfortunately the PASEMI ethernet doesn't work.

Error message: pci 0000:00:1a.0: dma_direct_map_page: overflow 
0x000000026bcb5002+110 of device mask ffffffff bus mask 0

@All
Could you please also test Christoph's kernel on your PASEMI and NXP boards? Download:

'git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.5 a'

Thanks,
Christian
