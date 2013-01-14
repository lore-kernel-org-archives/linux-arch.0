From: Jesper Nilsson <jesper.nilsson@axis.com>
Subject: Re: [PATCH 4/9] cris: Provide dma_mmap_coherent() and
 dma_get_sgtable()
Date: Mon, 14 Jan 2013 09:38:02 +0100
Message-ID: <20130114083802.GA23529@axis.com>
References: <1358073890-3610-1-git-send-email-geert@linux-m68k.org>
 <1358073890-3610-4-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1358073890-3610-4-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Marek Szyprowski <m.szyprowski@samsung.com>, linux-cris-kernel@axis.com
List-Id: linux-arch.vger.kernel.org

On Sun, Jan 13, 2013 at 11:44:45AM +0100, Geert Uytterhoeven wrote:
> cris/allmodconfig:
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
> Cris does not use dma_map_ops, hence it should implement them as inli=
ne
> stubs using dma_common_mmap() and dma_common_get_sgtable().
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: linux-cris-kernel@axis.com

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
--=20
               Jesper Nilsson -- jesper.nilsson@axis.com
