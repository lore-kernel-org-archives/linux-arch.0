From: Mark Salter <msalter@redhat.com>
Subject: Re: [Linux-c6x-dev] [PATCH 3/9] c6x: Provide dma_mmap_coherent()
 and dma_get_sgtable()
Date: Mon, 14 Jan 2013 10:37:52 -0500
Message-ID: <1358177872.4357.53.camel@t520.localdomain>
References: <1358073890-3610-1-git-send-email-geert@linux-m68k.org>
	 <1358073890-3610-3-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-7
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:3795 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756545Ab3ANPiE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 14 Jan 2013 10:38:04 -0500
In-Reply-To: <1358073890-3610-3-git-send-email-geert@linux-m68k.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-arch@vger.kernel.org, linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>

On Sun, 2013-01-13 at 11:44 +0100, Geert Uytterhoeven wrote:
> c6x/allmodconfig (assumed):
>=20
> drivers/media/v4l2-core/videobuf2-dma-contig.c: In function =A1vb2_dc=
_mmap=A2:
> drivers/media/v4l2-core/videobuf2-dma-contig.c:204: error: implicit d=
eclaration of function =A1dma_mmap_coherent=A2
> drivers/media/v4l2-core/videobuf2-dma-contig.c: In function =A1vb2_dc=
_get_base_sgt=A2:
> drivers/media/v4l2-core/videobuf2-dma-contig.c:387: error: implicit d=
eclaration of function =A1dma_get_sgtable=A2
>=20
> For architectures using dma_map_ops, dma_mmap_coherent() and
> dma_get_sgtable() are provided in <asm-generic/dma-mapping-common.h>.
>=20
> C6x does not use dma_map_ops, hence it should implement them as inlin=
e
> stubs using dma_common_mmap() and dma_common_get_sgtable().
>=20

So are dma_mmap_coherent() and dma_get_sgtable() part of the DMA API
now? I don't them in Documentation/DMA*.txt anywhere.

Why does the default dma_common_mmap() for !CONFIG_MMU return an
error?

Wouldn't it be better to provide default implementations that an arch
could override rather than having to patch all "no dma_map_ops"
architectures?

--Mark
