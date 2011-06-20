From: KyongHo Cho <pullip.cho@samsung.com>
Subject: Re: [PATCH 7/8] common: dma-mapping: change alloc/free_coherent
 method to more generic alloc/free_attrs
Date: Mon, 20 Jun 2011 23:45:41 +0900
Message-ID: <BANLkTikFdrOuXsLCfvyA_V+p7S_fd72dyQ@mail.gmail.com>
References: <1308556213-24970-1-git-send-email-m.szyprowski@samsung.com>
	<1308556213-24970-8-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36273 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755007Ab1FTOpl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jun 2011 10:45:41 -0400
Received: by gyh3 with SMTP id 3so1414992gyh.19
        for <linux-arch@vger.kernel.org>; Mon, 20 Jun 2011 07:45:41 -0700 (PDT)
In-Reply-To: <1308556213-24970-8-git-send-email-m.szyprowski@samsung.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

Hi.

On Mon, Jun 20, 2011 at 4:50 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:

> =A0struct dma_map_ops {
> - =A0 =A0 =A0 void* (*alloc_coherent)(struct device *dev, size_t size=
,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_add=
r_t *dma_handle, gfp_t gfp);
> - =A0 =A0 =A0 void (*free_coherent)(struct device *dev, size_t size,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *vaddr=
, dma_addr_t dma_handle);
> + =A0 =A0 =A0 void* (*alloc)(struct device *dev, size_t size,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_add=
r_t *dma_handle, gfp_t gfp,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
dma_attrs *attrs);
> + =A0 =A0 =A0 void (*free)(struct device *dev, size_t size,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *vaddr=
, dma_addr_t dma_handle,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct dma_=
attrs *attrs);
> + =A0 =A0 =A0 int (*mmap)(struct device *, struct vm_area_struct *,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *, dma_addr_t,=
 size_t, struct dma_attrs *attrs);
> +
> =A0 =A0 =A0 =A0dma_addr_t (*map_page)(struct device *dev, struct page=
 *page,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned =
long offset, size_t size,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 enum dma_=
data_direction dir,

I still don't agree with your idea that change alloc_coherent() with al=
loc().
As I said before, we actually do not need dma_alloc_writecombine() anym=
ore
because it is not different from dma_alloc_coherent() in ARM.
Most of other architectures do not have dma_alloc_writecombine().
If you want dma_alloc_coherent() to allocate user virtual address,
I believe that it is also available with mmap() you introduced.

Regards,
Cho KyongHo.
