From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: use generic DMA mapping code in powerpc V4
Date: Thu, 13 Dec 2018 10:10:21 +0100
Message-ID: <20181213091021.GA2106@lst.de>
References: <8a2c4581-0c85-8065-f37e-984755eb31ab@xenosoft.de>
	<424bb228-c9e5-6593-1ab7-5950d9b2bd4e@xenosoft.de>
	<c86d76b4-b199-557e-bc64-4235729c1e72@xenosoft.de>
	<1ecb7692-f3fb-a246-91f9-2db1b9496305@xenosoft.de>
	<6c997c03-e072-97a9-8ae0-38a4363df919@xenosoft.de>
	<4cfb3f26-74e1-db01-b014-759f188bb5a6@xenosoft.de>
	<82879d3f-83de-6438-c1d6-49c571dcb671@xenosoft.de>
	<20181212141556.GA4801@lst.de>
	<2242B4B2-6311-492E-BFF9-6740E36EC6D4@xenosoft.de>
	<84558d7f-5a7f-5219-0c3a-045e6b4c494f@xenosoft.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <84558d7f-5a7f-5219-0c3a-045e6b4c494f-KCoaydhb8eAb1SvskN2V4Q@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Christian Zigotzky <chzigotzky-KCoaydhb8eAb1SvskN2V4Q@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Darren Stevens <darren-YHtdit1eIT3easaKlIn9Lw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Julian Margetson <runaway-zqC88Q5qmK4@public.gmane.org>, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Dec 13, 2018 at 09:41:50AM +0100, Christian Zigotzky wrote:
> Today I tried the first patch (0001-get_required_mask.patch) with the last 
> good commit (977706f9755d2d697aa6f45b4f9f0e07516efeda). Unfortunately this 
> patch is already included in the last good commit 
> (977706f9755d2d697aa6f45b4f9f0e07516efeda). I will try the next patch.

Hmm, I don't think this is the case.  This is my local git log output:

commit 83a4b87de6bc6a75b500c9959de88e2157fbcd7c
Author: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Date:   Wed Dec 12 15:07:49 2018 +0100

    get_required_mask

commit 977706f9755d2d697aa6f45b4f9f0e07516efeda
Author: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Date:   Sat Nov 10 22:34:27 2018 +0100

    powerpc/dma: remove dma_nommu_mmap_coherent

I've also pushed a git branch with these out to:

    git://git.infradead.org/users/hch/misc.git powerpc-dma.5-debug
