From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] arch: m32r: include: asm: add "dma-mapping-common.h"
Date: Thu, 27 Jun 2013 17:40:33 +0800
Message-ID: <51CC0891.9050704@asianux.com>
References: <51CBC4B3.807@asianux.com> <2831217.RWPZkclVnp@wuerfel> <51CC0598.2080409@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:28044 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751408Ab3F0Jl1 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 27 Jun 2013 05:41:27 -0400
In-Reply-To: <51CC0598.2080409@asianux.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Hirokazu Takata <takata@linux-m32r.org>, "dhowells@redhat.com" <dhowells@redhat.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, Rusty Russell <rusty@rustcorp.com.au>, linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

On 06/27/2013 05:27 PM, Chen Gang wrote:
> On 06/27/2013 04:30 PM, Arnd Bergmann wrote:
>> > On Thursday 27 June 2013 12:50:59 Chen Gang wrote:
>>> >> Need add generic "dma-mapping-common.h", or compiling may fail.
>>> >>
>>> >> The related error (with allmodconfig):
>>> >>
>>> >>     CC [M]  net/irda/irlan/irlan_eth.o
>>> >>   drivers/media/v4l2-core/videobuf2-dma-contig.c: In function =E2=
=80=98vb2_dc_mmap=E2=80=99:
>>> >>   drivers/media/v4l2-core/videobuf2-dma-contig.c:202:2: error: i=
mplicit declaration of function =E2=80=98dma_mmap_coherent=E2=80=99 [-W=
error=3Dimplicit-function-declaration]
>>> >>   drivers/media/v4l2-core/videobuf2-dma-contig.c: In function =E2=
=80=98vb2_dc_get_base_sgt=E2=80=99:
>>> >>   drivers/media/v4l2-core/videobuf2-dma-contig.c:385:2: error: i=
mplicit declaration of function =E2=80=98dma_get_sgtable=E2=80=99 [-Wer=
ror=3Dimplicit-function-declaration]
>>> >>
>>> >>
>>> >> Signed-off-by: Chen Gang <gang.chen@asianux.com>
>> >=20
>> > m32r does not provide the "common" version of the dma mapping API,=
 so this
>> > is certainly wrong.
>> >=20

Oh, sorry, the reply below is incorrect, I will check it, again, thanks=
=2E

> But m32r really has pci.h, and also can cause this issue.


--=20
Chen Gang
