From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arch: m32r: include: asm: add "dma-mapping-common.h"
Date: Thu, 27 Jun 2013 10:30:51 +0200
Message-ID: <2831217.RWPZkclVnp@wuerfel>
References: <51CBC4B3.807@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <51CBC4B3.807@asianux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Gang <gang.chen@asianux.com>
Cc: Hirokazu Takata <takata@linux-m32r.org>, "dhowells@redhat.com" <dhowells@redhat.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, Rusty Russell <rusty@rustcorp.com.au>, linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thursday 27 June 2013 12:50:59 Chen Gang wrote:
> Need add generic "dma-mapping-common.h", or compiling may fail.
>=20
> The related error (with allmodconfig):
>=20
>     CC [M]  net/irda/irlan/irlan_eth.o
>   drivers/media/v4l2-core/videobuf2-dma-contig.c: In function =E2=80=98=
vb2_dc_mmap=E2=80=99:
>   drivers/media/v4l2-core/videobuf2-dma-contig.c:202:2: error: implic=
it declaration of function =E2=80=98dma_mmap_coherent=E2=80=99 [-Werror=
=3Dimplicit-function-declaration]
>   drivers/media/v4l2-core/videobuf2-dma-contig.c: In function =E2=80=98=
vb2_dc_get_base_sgt=E2=80=99:
>   drivers/media/v4l2-core/videobuf2-dma-contig.c:385:2: error: implic=
it declaration of function =E2=80=98dma_get_sgtable=E2=80=99 [-Werror=3D=
implicit-function-declaration]
>=20
>=20
> Signed-off-by: Chen Gang <gang.chen@asianux.com>

m32r does not provide the "common" version of the dma mapping API, so t=
his
is certainly wrong.

	Arnd
