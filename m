From: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
Subject: Re: [PATCH] powerpc: ensure that swiotlb buffer is allocated from
 low memory
Date: Wed, 4 Dec 2019 14:56:32 +0100
Message-ID: <20191204135632.GA31262@lst.de>
References: <20191204123524.22919-1-rppt@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20191204123524.22919-1-rppt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Sender: "iommu" <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
To: Mike Rapoport <rppt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Darren Stevens <darren-YHtdit1eIT3easaKlIn9Lw@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mike Rapoport <rppt-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>, linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, mad skateman <madskateman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Christian Zigotzky <chzigotzky-KCoaydhb8eAb1SvskN2V4Q@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Nicolas Saenz Julienne <nsaenzjulienne-l3A5Bk7waGM@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-arch.vger.kernel.org

On Wed, Dec 04, 2019 at 02:35:24PM +0200, Mike Rapoport wrote:
> From: Mike Rapoport <rppt-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>
> 
> Some powerpc platforms (e.g. 85xx) limit DMA-able memory way below 4G. If a
> system has more physical memory than this limit, the swiotlb buffer is not
> addressable because it is allocated from memblock using top-down mode.
> 
> Force memblock to bottom-up mode before calling swiotlb_init() to ensure
> that the swiotlb buffer is DMA-able.
> 
> Link: https://lkml.kernel.org/r/F1EBB706-73DF-430E-9020-C214EC8ED5DA-KCoaydhb8eAb1SvskN2V4Q@public.gmane.org
> Reported-by: Christian Zigotzky <chzigotzky-KCoaydhb8eAb1SvskN2V4Q@public.gmane.org>
> Signed-off-by: Mike Rapoport <rppt-tEXmvtCZX7AybS5Ee8rs3A@public.gmane.org>

Looks good:

Reviewed-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
