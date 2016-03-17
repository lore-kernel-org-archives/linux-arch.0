From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH v5 5/9] dmaengine: rcar-dmac: slave address are physical
Date: Thu, 17 Mar 2016 13:30:20 +0200
Message-ID: <1661205.m6h487t3oE@avalon>
References: <1457404974-1800-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
	<1457404974-1800-6-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1457404974-1800-6-git-send-email-niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-arch.vger.kernel.org

Hi Niklas,

Thank you for the patch.

On Tuesday 08 March 2016 03:42:50 Niklas S=F6derlund wrote:
> Slave addresses coming from a client is physical not dma. Store the
> address using the correct data type. This is in preparation for hooking
> up the dma-mapping API to the slave addresses.
> =

> Signed-off-by: Niklas S=F6derlund <niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
> ---
>  drivers/dma/sh/rcar-dmac.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> =

> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> index 7820d07..01cf82f 100644
> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c
> @@ -144,8 +144,8 @@ struct rcar_dmac_chan {
> =

>  	unsigned int src_xfer_size;
>  	unsigned int dst_xfer_size;
> -	dma_addr_t src_slave_addr;
> -	dma_addr_t dst_slave_addr;
> +	phys_addr_t src_slave_addr;
> +	phys_addr_t dst_slave_addr;

This moves the cast from phys_addr_t to dma_addr_t from the driver's DMA =

engine operations to other places. I'm not sure there's much value in doing =

so. I'd squash this patch with 7/9, the result will be easier to review.

>  	int mid_rid;
> =

>  	spinlock_t lock;

-- =

Regards,

Laurent Pinchart
