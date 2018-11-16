From: Palmer Dabbelt <palmer-SpMDHPYPyPbQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] csky, h8300,
	riscv: remove <asm/scatterlist.h> leftovers
Date: Thu, 15 Nov 2018 17:47:26 -0800 (PST)
Message-ID: <mhng-328f3881-d91e-4e25-b711-c5d7d91c62e6@palmer-si-x1c4>
References: <20181109090008.24150-2-hch@lst.de>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20181109090008.24150-2-hch-jcswGhMUV9g@public.gmane.org>
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
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-arch.vger.kernel.org

On Fri, 09 Nov 2018 01:00:07 PST (-0800), Christoph Hellwig wrote:
> There has been no <asm/scatterlist.h> for a long time, which also means
> there is no point in using it from asm-generic.
>
> Signed-off-by: Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
> ---
>  arch/csky/include/asm/Kbuild  | 1 -
>  arch/h8300/include/asm/Kbuild | 1 -
>  arch/riscv/include/asm/Kbuild | 1 -
>  3 files changed, 3 deletions(-)
>
> diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
> index 2a0abe8f2a35..7c48a123300d 100644
> --- a/arch/csky/include/asm/Kbuild
> +++ b/arch/csky/include/asm/Kbuild
> @@ -34,7 +34,6 @@ generic-y += pci.h
>  generic-y += percpu.h
>  generic-y += preempt.h
>  generic-y += qrwlock.h
> -generic-y += scatterlist.h
>  generic-y += sections.h
>  generic-y += serial.h
>  generic-y += shm.h
> diff --git a/arch/h8300/include/asm/Kbuild b/arch/h8300/include/asm/Kbuild
> index a5d0b2991f47..32f0c8952147 100644
> --- a/arch/h8300/include/asm/Kbuild
> +++ b/arch/h8300/include/asm/Kbuild
> @@ -36,7 +36,6 @@ generic-y += parport.h
>  generic-y += percpu.h
>  generic-y += pgalloc.h
>  generic-y += preempt.h
> -generic-y += scatterlist.h
>  generic-y += sections.h
>  generic-y += serial.h
>  generic-y += sizes.h
> diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
> index 6a646d9ea780..011cc7c7b3ad 100644
> --- a/arch/riscv/include/asm/Kbuild
> +++ b/arch/riscv/include/asm/Kbuild
> @@ -37,7 +37,6 @@ generic-y += poll.h
>  generic-y += posix_types.h
>  generic-y += preempt.h
>  generic-y += resource.h
> -generic-y += scatterlist.h
>  generic-y += sections.h
>  generic-y += sembuf.h
>  generic-y += serial.h

Reviewed-by: Palmer Dabbelt <palmer-SpMDHPYPyPbQT0dZR+AlfA@public.gmane.org>
