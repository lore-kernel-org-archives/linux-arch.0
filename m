From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Subject: Re: [PATCH 1/9] avr32: Provide dma_mmap_coherent() and
 dma_get_sgtable()
Date: Sun, 13 Jan 2013 17:01:52 +0100
Message-ID: <20130113160152.GA5885@samfundet.no>
References: <1358073890-3610-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1358073890-3610-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>
List-Id: linux-arch.vger.kernel.org

Around Sun 13 Jan 2013 11:44:42 +0100 or thereabout, Geert Uytterhoeven=
 wrote:
> avr32/allmodconfig:
>=20
> drivers/media/v4l2-core/videobuf2-dma-contig.c: In function =E2=80=98=
vb2_dc_mmap=E2=80=99:
> drivers/media/v4l2-core/videobuf2-dma-contig.c:204: error: implicit d=
eclaration of function =E2=80=98dma_mmap_coherent=E2=80=99
> drivers/media/v4l2-core/videobuf2-dma-contig.c: In function =E2=80=98=
vb2_dc_get_base_sgt=E2=80=99:
> drivers/media/v4l2-core/videobuf2-dma-contig.c:387: error: implicit d=
eclaration of function =E2=80=98dma_get_sgtable=E2=80=99
>=20
> For architectures using dma_map_ops, dma_mmap_coherent() and
> dma_get_sgtable() are provided in <asm-generic/dma-mapping-common.h>.
>=20
> Avr32 does not use dma_map_ops, hence it should implement them as inl=
ine
> stubs using dma_common_mmap() and dma_common_get_sgtable().

Thanks for fixing.

> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Haavard Skinnemoen <hskinnemoen@gmail.com>
> Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

<snipp diff>

--=20
mvh
Hans-Christian Egtvedt
