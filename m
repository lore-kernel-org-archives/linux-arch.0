From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: use generic DMA mapping code in powerpc V4
Date: Sat, 19 Jan 2019 15:04:52 +0100
Message-ID: <20190119140452.GA25198@lst.de>
References: <871403f2-fa7d-de15-89eb-070432e15c69@xenosoft.de>
	<20190118112842.GA9115@lst.de>
	<a2ca0118-5915-8b1c-7cfa-71cb4b43eaa6@xenosoft.de>
	<20190118121810.GA13327@lst.de>
	<eceebeda-0e18-00f6-06e7-def2eb0aa961@xenosoft.de>
	<20190118125500.GA15657@lst.de>
	<e11e61b1-6468-122e-fc2b-3b3f857186bb@xenosoft.de>
	<f39d4fc6-7e4e-9132-c03f-59f1b52260e0@xenosoft.de>
	<b9e5e081-a3cc-2625-4e08-2d55c2ba224b@xenosoft.de>
	<20190119130222.GA24346@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190119130222.GA24346-jcswGhMUV9g@public.gmane.org>
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

On Sat, Jan 19, 2019 at 02:02:22PM +0100, Christoph Hellwig wrote:
> Interesting.  This suggest it is related to the use of ZONE_DMA by
> the FSL SOCs that your board uses.  Let me investigate this a bit more.

As a hack to check that theory I've pushed a new commit to the
powerpc-dma.6-debug branch to use old powerpc GFP_DMA selection
with the new dma direct code:

http://git.infradead.org/users/hch/misc.git/commitdiff/5c532d07c2f3c3972104de505d06b8d85f403f06

And another one that drops the addressability checks that powerpc
never had:

http://git.infradead.org/users/hch/misc.git/commitdiff/18e7629b38465ca98f8e7eed639123a13ac3b669

Can you first test with both patches, and then just with the first
in case that worked?
