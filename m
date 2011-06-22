From: KyongHo Cho <pullip.cho@samsung.com>
Subject: Re: [Linaro-mm-sig] [PATCH 8/8] ARM: dma-mapping: use alloc, mmap,
 free from dma_ops
Date: Wed, 22 Jun 2011 15:53:55 +0900
Message-ID: <BANLkTikE6qziSZhcyx4HxWqpmg0eZhR+wg@mail.gmail.com>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<1308556213-24970-9-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38560 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784Ab1FVGx4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 22 Jun 2011 02:53:56 -0400
Received: by yxi11 with SMTP id 11so210430yxi.19
        for <linux-arch@vger.kernel.org>; Tue, 21 Jun 2011 23:53:55 -0700 (PDT)
In-Reply-To: <1308556213-24970-9-git-send-email-m.szyprowski@samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Joerg Roedel <joro@8bytes.org>, Arnd Bergmann <arnd@arndb.de>

Hi.

On Mon, Jun 20, 2011 at 4:50 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:

> -extern void *dma_alloc_coherent(struct device *, size_t, dma_addr_t =
*, gfp_t);
> +extern void *arm_dma_alloc(struct device *dev, size_t size, dma_addr=
_t *handle,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0gfp_t gfp, struc=
t dma_attrs *attrs);
> +
> +#define dma_alloc_coherent(d,s,h,f) dma_alloc_attrs(d,s,h,f,NULL)
> +
> +static inline void *dma_alloc_attrs(struct device *dev, size_t size,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0dma_addr_t *dma_handle, gfp_t flag,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0struct dma_attrs *attrs)
> +{
> + =A0 =A0 =A0 struct dma_map_ops *ops =3D get_dma_ops(dev);
> + =A0 =A0 =A0 void *cpu_addr;
> + =A0 =A0 =A0 BUG_ON(!ops);
> +
> + =A0 =A0 =A0 cpu_addr =3D ops->alloc(dev, size, dma_handle, flag, at=
trs);
> + =A0 =A0 =A0 debug_dma_alloc_coherent(dev, size, *dma_handle, cpu_ad=
dr);
> + =A0 =A0 =A0 return cpu_addr;
> +}
>

Apart from the necessity of alloc_attr,
I hope the callback implementations to check if a function pointer is N=
ULL.
Suppose that a system want to use default ARM implementation of dma_all=
oc_*()
while it uses its own implementations of dma_map_*().


With your suggestion,
we have only one option:

void *my_alloc(...) {
return dma_alloc_coherent(NULL, ...);
}

struct dma_map_ops ops =3D {
=2Ealloc_coherent =3D &my_alloc,
=2E..
};



I think the following method is simpler:

struct dma_map_ops ops =3D {
=2Ealloc_coherent =3D NULL,
=2E..
};
