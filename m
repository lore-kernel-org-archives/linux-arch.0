Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:39489 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbeDEHAK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Apr 2018 03:00:10 -0400
MIME-Version: 1.0
In-Reply-To: <1522886301-25955-1-git-send-email-okaya@codeaurora.org>
References: <1522886301-25955-1-git-send-email-okaya@codeaurora.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 5 Apr 2018 09:00:08 +0200
Message-ID: <CAK8P3a0Noun+8AaRUcMdOX09KXxFXZxfcyUgJnezPkS2gVkg6w@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] io: define several IO & PIO barrier types for the
 asm-generic version
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Timur Tabi <timur@codeaurora.org>, sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <20180405070008.d6-HBM15Qvl9eSVRbBvQdxH0jvaVTvjKYFg7i9dPaLU@z>

On Thu, Apr 5, 2018 at 1:58 AM, Sinan Kaya <okaya@codeaurora.org> wrote:

Looks good, but I'd change the comments to ones that document exactly
what those barriers are for:

> +#ifndef __io_ar
> +#ifdef rmb
> +/* prefer rmb() as the default implementation of __io_ar() if supported */
> +#define __io_ar()      rmb()

/*
 * prevent prefetching of coherent DMA data ahead of a dma-complete */

> +#ifndef __io_bw
> +#ifdef wmb
> +/* prefer wmb() as the default implementation of __io_bw() if supported */
> +#define __io_bw()      wmb()
> +#else

/* flush writes to coherent DMA data before possibly triggering a DMA read */

> +#ifndef __io_aw
> +#define __io_aw()      barrier()
> +#endif

/* serialize device access against a spin_unlock, usually handled there */

The other four patches look perfect already.  What's the timing we need for
these patches? Are they 4.18 material, or do we need them in 4.17 and
stable kernels to work around known bugs?

      Arnd
