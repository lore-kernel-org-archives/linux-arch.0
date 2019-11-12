From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: Bug 205201 - overflow of DMA mask and bus mask
Date: Tue, 12 Nov 2019 15:41:09 +0100
Message-ID: <20191112144109.GA11805@lst.de>
References: <71A251A5-FA06-4019-B324-7AED32F7B714@xenosoft.de>
	<1b0c5c21-2761-d3a3-651b-3687bb6ae694@xenosoft.de>
	<3504ee70-02de-049e-6402-2d530bf55a84@xenosoft.de>
	<46025f1b-db20-ac23-7dcd-10bc43bbb6ee@xenosoft.de>
	<20191105162856.GA15402@lst.de>
	<2f3c81bd-d498-066a-12c0-0a7715cda18f@xenosoft.de>
	<d2c614ec-c56e-3ec2-12d0-7561cd30c643@xenosoft.de>
	<af32bfcc-5559-578d-e1f4-75e454c965bf@xenosoft.de>
	<0c5a8009-d28b-601f-3d1a-9de0e869911c@xenosoft.de>
	<a794864f-04ae-9b90-50e7-01b416c861fe@xenosoft.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <a794864f-04ae-9b90-50e7-01b416c861fe-KCoaydhb8eAb1SvskN2V4Q@public.gmane.org>
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
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, darren-YHtdit1eIT3easaKlIn9Lw@public.gmane.org, mad skateman <madskateman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org, rtd2-kGM0oXzJM5p02iOg2JU2CQ@public.gmane.org, "contact-+1neenJGU+oAvxtiuMwx3w@public.gmane.org" <contact-+1neenJGU+oAvxtiuMwx3w@public.gmane.org>, linuxppc-dev <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, nsaenzjulienne-l3A5Bk7waGM@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Mon, Nov 11, 2019 at 01:22:55PM +0100, Christian Zigotzky wrote:
> Now, I can definitely say that this patch does not solve the issue.
>
> Do you have another patch for testing or shall I bisect?

I'm still interested in the .config and dmesg.  Especially if the
board is using arch/powerpc/sysdev/fsl_pci.c, which is the only
place inside the powerpc arch code doing funny things with the
bus_dma_mask, which Robin pointed out looks fishy.

>
> Thanks,
> Christian
---end quoted text---
