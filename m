From: "Niklas =?iso-8859-1?Q?S=F6derlund?=" <niklas.soderlund-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
Subject: Re: [PATCH v3 1/8] iommu: Add MMIO mapping type
Date: Tue, 16 Feb 2016 13:06:27 +0100
Message-ID: <20160216120626.GA26710@bigcity.dyn.berto.se>
References: <1455065878-11906-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
	<1455065878-11906-2-git-send-email-niklas.soderlund+renesas@ragnatech.se>
	<13740597.5lZXKsEG19@avalon> <56BCAF66.8010206@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56BCAF66.8010206-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-arch.vger.kernel.org

Hi Robin,

Thanks for your update patch I will include it in my next version. But
I'm sorry I do not understand, is your modification an addition or a
substitution to your original patch?

* Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> [2016-02-11 15:57:26 +0000]:

> On 11/02/16 00:02, Laurent Pinchart wrote:
> >Hi Niklas,
> >
> >Thank you for the patch.
> >
> >On Wednesday 10 February 2016 01:57:51 Niklas S=F6derlund wrote:
> >>From: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> >>
> >>On some platforms, MMIO regions might need slightly different treatment
> >>compared to mapping regular memory; add the notion of MMIO mappings to
> >>the IOMMU API's memory type flags, so that callers can let the IOMMU
> >>drivers know to do the right thing.
> >>
> >>Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> >>Acked-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> >
> >Answering the question from the cover letter, yes, it's totally fine to =
pick
> >the ack, that's actually expected.
> >
> >>---
> >>  drivers/iommu/io-pgtable-arm.c | 4 +++-
> >>  include/linux/iommu.h          | 1 +
> >
> >You might be asked to split this patch in two.
>
> Worse than that, you might also be asked to fix it up when the silly auth=
or
> remembers that he did this on a stage-2-only ARM SMMU, and the attributes
> for the stage 1 tables that the IPMMU uses are in a different code path:
>
> --->8---
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-ar=
m.c
> index 5b5c299..7622c6e 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -354,7 +354,10 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct
> arm_lpae_io_pgtable *data,
>                 if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
>                         pte |=3D ARM_LPAE_PTE_AP_RDONLY;
>
> -               if (prot & IOMMU_CACHE)
> +               if (prot & IOMMU_MMIO)
> +                       pte |=3D (ARM_LPAE_MAIR_ATTR_IDX_DEV
> +                               << ARM_LPAE_PTE_ATTRINDX_SHIFT);
> +               else if (prot & IOMMU_CACHE)
>                         pte |=3D (ARM_LPAE_MAIR_ATTR_IDX_CACHE
>                                 << ARM_LPAE_PTE_ATTRINDX_SHIFT);
>         } else {
> --->8---
>
> Sorry for the bother,
> Robin.
>
> >>  2 files changed, 4 insertions(+), 1 deletion(-)
> >>
> >>diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-=
arm.c
> >>index 381ca5a..3ff4f87 100644
> >>--- a/drivers/iommu/io-pgtable-arm.c
> >>+++ b/drivers/iommu/io-pgtable-arm.c
> >>@@ -364,7 +364,9 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct
> >>arm_lpae_io_pgtable *data, pte |=3D ARM_LPAE_PTE_HAP_READ;
> >>  		if (prot & IOMMU_WRITE)
> >>  			pte |=3D ARM_LPAE_PTE_HAP_WRITE;
> >>-		if (prot & IOMMU_CACHE)
> >>+		if (prot & IOMMU_MMIO)
> >>+			pte |=3D ARM_LPAE_PTE_MEMATTR_DEV;
> >>+		else if (prot & IOMMU_CACHE)
> >>  			pte |=3D ARM_LPAE_PTE_MEMATTR_OIWB;
> >>  		else
> >>  			pte |=3D ARM_LPAE_PTE_MEMATTR_NC;
> >>diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> >>index a5c539f..34b6432 100644
> >>--- a/include/linux/iommu.h
> >>+++ b/include/linux/iommu.h
> >>@@ -30,6 +30,7 @@
> >>  #define IOMMU_WRITE	(1 << 1)
> >>  #define IOMMU_CACHE	(1 << 2) /* DMA cache coherency */
> >>  #define IOMMU_NOEXEC	(1 << 3)
> >>+#define IOMMU_MMIO	(1 << 4) /* e.g. things like MSI doorbells */
> >>
> >>  struct iommu_ops;
> >>  struct iommu_group;
> >
>
