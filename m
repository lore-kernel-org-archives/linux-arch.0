From: Toralf =?utf-8?q?F=C3=B6rster?= <toralf.foerster@gmx.de>
Subject: Re: dma-mapping commit breaks UML
Date: Wed, 29 Sep 2010 16:29:38 +0200
Message-ID: <201009291629.39077.toralf.foerster@gmx.de>
References: <201009291155.30873.toralf.foerster@gmx.de> <20100929221620K.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:48237 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751194Ab0I2O3m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 29 Sep 2010 10:29:42 -0400
In-Reply-To: <20100929221620K.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org


=46UJITA Tomonori wrote at 15:20:38
> On Wed, 29 Sep 2010 11:55:30 +0200
>=20
> Toralf **UNKNOWN CHARSET** <toralf.foerster@gmx.de> wrote:
> > The
> >=20
> > 4565f0170dfc849b3629c27d769db800467baa62 is the first bad commit
> > commit 4565f0170dfc849b3629c27d769db800467baa62
> > Author: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> > Date:   Tue Aug 10 18:03:22 2010 -0700
> >=20
> >     dma-mapping: unify dma_get_cache_alignment implementations
>=20
> I think that the commit f3c072ad727617f00bffae17dba8cd895f5b7bdb
> already fixed this breakage. You still have the issue with the latest
> git?

Argh,

I use a script for git-bisect to catch this compile error in the curren=
t git kernel v2.6.36-rc6-20-g8189b14 :

=2E..
  CC      arch/um/kernel/trap.o
arch/um/drivers/hostaudio_kern.c: In function =E2=80=98hostaudio_open=E2=
=80=99:
arch/um/drivers/hostaudio_kern.c:204: error: =E2=80=98__param_dsp=E2=80=
=99 undeclared (first use in this function)
arch/um/drivers/hostaudio_kern.c:204: error: (Each undeclared identifie=
r is reported only once
arch/um/drivers/hostaudio_kern.c:204: error: for each function it appea=
rs in.)
arch/um/drivers/hostaudio_kern.c: In function =E2=80=98hostmixer_open_m=
ixdev=E2=80=99:
arch/um/drivers/hostaudio_kern.c:265: error: =E2=80=98__param_mixer=E2=80=
=99 undeclared (first use in this function)
arch/um/drivers/hostaudio_kern.c:272: error: =E2=80=98__param_dsp=E2=80=
=99 undeclared (first use in this function)
make[1]: *** [arch/um/drivers/hostaudio_kern.o] Error 1
make: *** [arch/um/drivers] Error 2
make: *** Waiting for unfinished jobs....
=2E..

but catched another compile error -  how can I now automatically git-bi=
sect for
that wrong commit w/o heavy scripting ? - Or simply asking who to blame=
 wrt this compile error ?

--=20
MfG/Kind regards
Toralf F=C3=B6rster

pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
