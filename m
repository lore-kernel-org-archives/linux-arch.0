From: Alexey Brodkin <Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 03/20] arc: use generic dma_noncoherent_ops
Date: Fri, 11 May 2018 12:44:23 +0000
Message-ID: <1526042662.19036.31.camel@synopsys.com>
References: <20180511075945.16548-1-hch@lst.de>
	<20180511075945.16548-4-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180511075945.16548-4-hch-jcswGhMUV9g@public.gmane.org>
Content-Language: en-US
Content-ID: <971F7A34D96DA94FBA9D4F8C88AF4970-z7JfP6tgrtVBCHUSTMH8dZqQE7yCjDx5@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "hch-jcswGhMUV9g@public.gmane.org" <hch-jcswGhMUV9g@public.gmane.org>
Cc: "linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org" <linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org>, "monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org" <monstr-pSz03upnqPeHXe+LvDLADg@public.gmane.org>, "linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org" <linux-c6x-dev-jPsnJVOj+W6hPH1hqNUYSQ@public.gmane.org>, "linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-parisc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-hexagon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org" <linux-m68k-cunTk1MwBs8S/qaLPR03pWD2FQJk+8+b@public.gmane.org>, "openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org" <openrisc-cunTk1MwBs9a3B2Vnqf2dGD2FQJk+8+b@public.gmane.org>, "green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <green.hu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-alpha-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

Hi Christoph,

On Fri, 2018-05-11 at 09:59 +0200, Christoph Hellwig wrote:
> Switch to the generic noncoherent direct mapping implementation.
> 
> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
> ---
>  arch/arc/Kconfig                   |   4 +
>  arch/arc/include/asm/Kbuild        |   1 +
>  arch/arc/include/asm/dma-mapping.h |  21 -----
>  arch/arc/mm/dma.c                  | 141 +++--------------------------
>  4 files changed, 19 insertions(+), 148 deletions(-)
>  delete mode 100644 arch/arc/include/asm/dma-mapping.h

Sorry I didn't try your proposed fix earlier - was away for a couple of days.

But that newer version with fixed lib/dma-noncoherent.c still doesn't work on ARC.

USB ECHI controller fails like that:
------------------------->8-------------------------
usb 1-1: new high-speed USB device number 2 using ehci-platform
usb 1-1: can't set config #1, error -32
------------------------->8-------------------------

Again with entire series reverted USB starts to work.
Let's wait for other arches previously affected to update on their status.

-Alexey
