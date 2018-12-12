From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: use generic DMA mapping code in powerpc V4
Date: Wed, 12 Dec 2018 11:47:16 +1100
Message-ID: <d447ac4e18bddd030aa2f56a0547c0132b3f8dcd.camel@kernel.crashing.org>
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
	<424bb228-c9e5-6593-1ab7-5950d9b2bd4e@xenosoft.de>
	<c86d76b4-b199-557e-bc64-4235729c1e72@xenosoft.de>
	<1ecb7692-f3fb-a246-91f9-2db1b9496305@xenosoft.de>
	<6c997c03-e072-97a9-8ae0-38a4363df919@xenosoft.de>
	<4cfb3f26-74e1-db01-b014-759f188bb5a6@xenosoft.de>
	<82879d3f-83de-6438-c1d6-49c571dcb671@xenosoft.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <82879d3f-83de-6438-c1d6-49c571dcb671-KCoaydhb8eAb1SvskN2V4Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christian Zigotzky <chzigotzky-KCoaydhb8eAb1SvskN2V4Q@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Darren Stevens <darren-YHtdit1eIT3easaKlIn9Lw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Julian Margetson <runaway-zqC88Q5qmK4@public.gmane.org>, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Tue, 2018-12-11 at 19:17 +0100, Christian Zigotzky wrote:
> X5000 (P5020 board): U-Boot loads the kernel and the dtb file. Then the 
> kernel starts but it doesn't find any hard disks (partitions). That 
> means this is also the bad commit for the P5020 board.

What are the disks hanging off ? A PCIe device of some sort ?

Can you send good & bad dmesg logs ?

Ben.
