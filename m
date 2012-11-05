From: Damian Hobson-Garcia <dhobsong@igel.co.jp>
Subject: Re: [v2 PATCH 1/2] Add new uio device for dynamic memory allocation
Date: Mon, 05 Nov 2012 11:34:50 +0900
Message-ID: <509725CA.4030809@igel.co.jp>
References: <1348553352-14334-1-git-send-email-dhobsong@igel.co.jp> <1348553352-14334-2-git-send-email-dhobsong@igel.co.jp> <CAMuHMdWKByLXR-2wkiej=F1WPf7xePf3nMkUqwSf_hEJNNZbvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:39379 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441Ab2KECe4 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 4 Nov 2012 21:34:56 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so2471621dak.19
        for <linux-arch@vger.kernel.org>; Sun, 04 Nov 2012 18:34:55 -0800 (PST)
In-Reply-To: <CAMuHMdWKByLXR-2wkiej=F1WPf7xePf3nMkUqwSf_hEJNNZbvg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: hjk@hansjkoch.de, gregkh@linuxfoundation.org, magnus.damm@gmail.com, horms@verge.net.au, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, hdk@igel.co.jp, Linux-Next <linux-next@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

Hi Geert,

On 2012/11/04 22:20, Geert Uytterhoeven wrote:
> On Tue, Sep 25, 2012 at 8:09 AM, Damian Hobson-Garcia
> <dhobsong@igel.co.jp> wrote:
>> are holding the device file open, the address returned to userspace =
is
>> DMA_ERROR_CODE.
>=20
> Only a small subset of the architectures
> (arm/ia64/microblaze/openrisc/powerpc/sparc/x86)
> seem to define DMA_ERROR_CODE, causing everywhere else:
>=20
> drivers/uio/uio_dmem_genirq.c: In function =E2=80=98uio_dmem_genirq_r=
elease=E2=80=99:
> drivers/uio/uio_dmem_genirq.c:95: error: =E2=80=98DMA_ERROR_CODE=E2=80=
=99 undeclared
> (first use in this function)
> drivers/uio/uio_dmem_genirq.c:95: error: (Each undeclared identifier
> is reported only once
> drivers/uio/uio_dmem_genirq.c:95: error: for each function it appears=
 in.)
> drivers/uio/uio_dmem_genirq.c: In function =E2=80=98uio_dmem_genirq_p=
robe=E2=80=99:
> drivers/uio/uio_dmem_genirq.c:238: error: =E2=80=98DMA_ERROR_CODE=E2=80=
=99 undeclared
> (first use in this function)
> make[1]: *** [drivers/uio/uio_dmem_genirq.o] Error 1
> make: *** [drivers/uio/] Error 2
>=20
> (e.g. http://kisskb.ellerman.id.au/kisskb/buildresult/7462173/)
>=20
> Furthermore, none of them define it in <uapi/...>, so DMA_ERROR_CODE =
is not
> part of the userspace API (yet), while it is architecture-specific (s=
ome use 0,
> others ~0).
>=20
Good points, thank you.  In that case, does fixing the value to
something like ~0 sound like a better (more portable) solution?

Damian

--=20
Damian Hobson-Garcia
IGEL Co.,Ltd
http://www.igel.co.jp
