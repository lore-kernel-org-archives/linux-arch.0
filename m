Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40906 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389254AbeKPL5v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Nov 2018 06:57:51 -0500
Received: by mail-pf1-f195.google.com with SMTP id x2-v6so10581397pfm.7
        for <linux-arch@vger.kernel.org>; Thu, 15 Nov 2018 17:47:28 -0800 (PST)
Date: Thu, 15 Nov 2018 17:47:26 -0800 (PST)
Subject: Re: [PATCH 1/2] csky, h8300, riscv: remove <asm/scatterlist.h> leftovers
In-Reply-To: <20181109090008.24150-2-hch@lst.de>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-328f3881-d91e-4e25-b711-c5d7d91c62e6@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux-foundation.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20181116014726.KrzyOkedIE09UKv0hhpmyuMFIOhaL_XlzebeTnSPGGg@z>

On Fri, 09 Nov 2018 01:00:07 PST (-0800), Christoph Hellwig wrote:
> There has been no <asm/scatterlist.h> for a long time, which also means
> there is no point in using it from asm-generic.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
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

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
