From: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCHv8 07/10] ARM: dma-mapping: move all dma bounce code to
	separate dma ops structure
Date: Tue, 10 Apr 2012 14:51:55 +0200
Message-ID: <002801cd1718$b556a1e0$2003e5a0$%szyprowski@samsung.com>
References: <1334055852-19500-1-git-send-email-m.szyprowski@samsung.com>
	<1334055852-19500-8-git-send-email-m.szyprowski@samsung.com>
	<201204101224.24959.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <201204101224.24959.arnd-r2nGTMty4D4@public.gmane.org>
Content-language: pl
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: 'Arnd Bergmann' <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Russell King - ARM Linux' <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, 'Benjamin Herrenschmidt' <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, 'Kyungmin Park' <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Subash Patel' <subashrp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linaro-mm-sig-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, 'Krishna Reddy' <vdumpa-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Andrzej Pietrasiewicz <andrzej.p-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'KyongHo Cho' <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Chunsang Jeong' <chunsang.jeong-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-arch.vger.kernel.org

Hi Arnd,

On Tuesday, April 10, 2012 2:24 PM Arnd Bergmann wrote:

> On Tuesday 10 April 2012, Marek Szyprowski wrote:
> > This patch removes dma bounce hooks from the common dma mapping
> > implementation on ARM architecture and creates a separate set of
> > dma_map_ops for dma bounce devices.
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> > Acked-by: Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> 
> I could be misunderstanding something, but it looks like this
> one should come before patch 6, where you remove
> some of the dmabounce functions. Can you clarify?

Before patch no 6, there were custom methods for all scatter/gather
related operations. They iterated over the whole scatter list and called
cache related operations directly (which in turn checked if we use dma
bounce code or not and called respective version). Patch no 6 changed
them not to use such shortcut for direct calling cache related operations.

Instead it provides similar loop over scatter list and calls methods
from the current device's dma_map_ops structure. This way, after patch no 
7 these functions call simple dma_map_page() method for all standard 
devices and dma bounce aware version for devices registered for dma 
bouncing (with use different dma_map_ops).

I can provide a separate set of scatter/gather list related functions for
the linear dma mapping implementation and dma bouncing implementation 
if you think that the current approach is too complicated or 
over-engineered.

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
