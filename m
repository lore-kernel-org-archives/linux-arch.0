From: Christian Zigotzky <chzigotzky-KCoaydhb8eAb1SvskN2V4Q@public.gmane.org>
Subject: Re: use generic DMA mapping code in powerpc V4
Date: Wed, 5 Dec 2018 10:44:05 +0100
Message-ID: <ef56d279-f75d-008e-71ba-7068c1b37c48@xenosoft.de>
References: <87zhttfonk.fsf@concordia.ellerman.id.au>
	<4d4e3cdd-d1a9-affe-0f63-45b8c342bbd6@xenosoft.de>
	<20181129170351.GC27951@lst.de>
	<d0e04a85-f17d-414e-6fea-971414417430@xenosoft.de>
	<20181130105346.GB26765@lst.de>
	<8694431d-c669-b7b9-99fa-e99db5d45a7d@xenosoft.de>
	<20181130131056.GA5211@lst.de>
	<25999587-2d91-a63c-ed38-c3fb0075d9f1@xenosoft.de>
	<c5202d29-863d-1377-0e2d-762203b317e2@xenosoft.de>
	<58c61afb-290f-6196-c72c-ac7b61b84718@xenosoft.de>
	<20181204142426.GA2743@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181204142426.GA2743-jcswGhMUV9g@public.gmane.org>
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

On 04 December 2018 at 3:24PM, Christoph Hellwig wrote:
> On Tue, Dec 04, 2018 at 10:53:39AM +0100, Christian Zigotzky wrote:
>> I don't know why this kernel doesn't recognize the hard disks connected to
>> my physical P5020 board and why the onboard ethernet on my PASEMI board
>> doesn't work. (dma_direct_map_page: overflow)
> Do you know if this actually works for the baseline before my patches?
> E.g. with commit 721c01ba8b46ddb5355bd6e6b3bbfdabfdf01e97 ?
>
Hi Christoph,

Thanks for your reply. I undid all dma mapping commits with the 
following command:

git checkout 721c01ba8b46ddb5355bd6e6b3bbfdabfdf01e97

After that I compiled the kernels with this code for my P5020 board 
(Cyrus) and for my PASEMI board (Nemo) today.

Result: PASEMI onboard ethernet works again and the P5020 board boots.

It seems the dma mapping commits are the problem.

@All
Could you please test Christoph's kernel on your PASEMI and NXP boards? 
Download:

'git clone git://git.infradead.org/users/hch/misc.git -b powerpc-dma.5 a'

Thanks,
Christian
