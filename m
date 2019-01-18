From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: use generic DMA mapping code in powerpc V4
Date: Fri, 18 Jan 2019 13:55:00 +0100
Message-ID: <20190118125500.GA15657@lst.de>
References: <20190115133558.GA29225@lst.de>
	<685f0c06-af1b-0bec-ac03-f9bf1f7a2b35@xenosoft.de>
	<20190115151732.GA2325@lst.de>
	<e9345547-4dc6-747a-29ec-6375dc8bfe83@xenosoft.de>
	<20190118083539.GA30479@lst.de>
	<871403f2-fa7d-de15-89eb-070432e15c69@xenosoft.de>
	<20190118112842.GA9115@lst.de>
	<a2ca0118-5915-8b1c-7cfa-71cb4b43eaa6@xenosoft.de>
	<20190118121810.GA13327@lst.de>
	<eceebeda-0e18-00f6-06e7-def2eb0aa961@xenosoft.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="xB0nW4MQa6jZONgY"
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <eceebeda-0e18-00f6-06e7-def2eb0aa961-KCoaydhb8eAb1SvskN2V4Q@public.gmane.org>
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


--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 18, 2019 at 01:46:46PM +0100, Christian Zigotzky wrote:
> Sorry, it's not possible to patch 
> '257002094bc5935dd63207a380d9698ab81f0775' with your patch. I also tried it 
> manually but without any success.

Weird:

hch@carbon:~/work/linux$ git checkout 257002094bc5935dd63207a380d9698ab81f0775
HEAD is now at 257002094bc5 powerpc/dma: use the dma-direct allocator for coherent platforms
hch@carbon:~/work/linux$ patch -p1 < dbg.diff 
patching file kernel/dma/direct.c

I've pushed the result to

git://git.infradead.org/users/hch/misc.git

as a new powerpc-dma.6-debug branch

--xB0nW4MQa6jZONgY
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="dbg.diff"

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 355d16acee6d..e46c9b64ec0d 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -118,8 +118,11 @@ struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 			page = NULL;
 		}
 	}
-	if (!page)
+	if (!page) {
 		page = alloc_pages_node(dev_to_node(dev), gfp, page_order);
+		if (!page)
+			pr_warn("failed to allocate memory with gfp 0x%x\n", gfp);
+	}
 
 	if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
 		__free_pages(page, page_order);
@@ -139,6 +142,10 @@ struct page *__dma_direct_alloc_pages(struct device *dev, size_t size,
 		}
 	}
 
+	if (!page) {
+		pr_warn("failed to allocate DMA memory!\n");
+		dump_stack();
+	}
 	return page;
 }
 

--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--xB0nW4MQa6jZONgY--
