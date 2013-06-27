From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH] arch: m32r: include: asm: add "dma-mapping-common.h"
Date: Thu, 27 Jun 2013 17:27:52 +0800
Message-ID: <51CC0598.2080409@asianux.com>
References: <51CBC4B3.807@asianux.com> <2831217.RWPZkclVnp@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:46674 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752200Ab3F0J2p (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 27 Jun 2013 05:28:45 -0400
In-Reply-To: <2831217.RWPZkclVnp@wuerfel>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Hirokazu Takata <takata@linux-m32r.org>, "dhowells@redhat.com" <dhowells@redhat.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, Rusty Russell <rusty@rustcorp.com.au>, linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

On 06/27/2013 04:30 PM, Arnd Bergmann wrote:
> On Thursday 27 June 2013 12:50:59 Chen Gang wrote:
>> Need add generic "dma-mapping-common.h", or compiling may fail.
>>
>> The related error (with allmodconfig):
>>
>>     CC [M]  net/irda/irlan/irlan_eth.o
>>   drivers/media/v4l2-core/videobuf2-dma-contig.c: In function =E2=80=
=98vb2_dc_mmap=E2=80=99:
>>   drivers/media/v4l2-core/videobuf2-dma-contig.c:202:2: error: impli=
cit declaration of function =E2=80=98dma_mmap_coherent=E2=80=99 [-Werro=
r=3Dimplicit-function-declaration]
>>   drivers/media/v4l2-core/videobuf2-dma-contig.c: In function =E2=80=
=98vb2_dc_get_base_sgt=E2=80=99:
>>   drivers/media/v4l2-core/videobuf2-dma-contig.c:385:2: error: impli=
cit declaration of function =E2=80=98dma_get_sgtable=E2=80=99 [-Werror=3D=
implicit-function-declaration]
>>
>>
>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
>=20
> m32r does not provide the "common" version of the dma mapping API, so=
 this
> is certainly wrong.
>=20

But m32r really has pci.h, and also can cause this issue.


Thanks.
--=20
Chen Gang
