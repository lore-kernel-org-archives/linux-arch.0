From: Robert Richter <robert.richter@amd.com>
Subject: Re: [PATCH 4/7] ARM: oprofile: Move non-ARM code into separate
 init/exit
Date: Wed, 6 Oct 2010 20:44:07 +0200
Message-ID: <20101006184407.GY13563@erda.amd.com>
References: <cover.1286222593.git.matt@console-pimps.org>
 <74092b0d162aafc21e408033cec6146e227363b5.1286222593.git.matt@console-pimps.org>
 <20101006133309.GP13563@erda.amd.com>
 <20101006144921.GQ13563@erda.amd.com>
 <20101006145311.GA3754@linux-sh.org>
 <20101006145903.GR13563@erda.amd.com>
 <AANLkTikGQe99k_fK5pZtkn-ht9jgC0guDkn28dSedjUo@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from db3ehsobe006.messaging.microsoft.com ([213.199.154.144]:26958
	"EHLO DB3EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759780Ab0JFSoS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 6 Oct 2010 14:44:18 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTikGQe99k_fK5pZtkn-ht9jgC0guDkn28dSedjUo@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Paul Mundt <lethal@linux-sh.org>, Matt Fleming <matt@console-pimps.org>, Will Deacon <will.deacon@arm.com>, Russell King <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@elte.hu>, Frederic Weisbecker <fweisbec@gmail.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Deng-Cheng Zhu <dengcheng.zhu@gmail.com>

On 06.10.10 14:23:17, Grant Likely wrote:
> >> diff --git a/drivers/oprofile/oprof.c b/drivers/oprofile/oprof.c
> >> index b336cd9..76d97a5 100644
> >> --- a/drivers/oprofile/oprof.c
> >> +++ b/drivers/oprofile/oprof.c
> >> @@ -252,6 +252,8 @@ static int __init oprofile_init(void)
> >> =A0{
> >> =A0 =A0 =A0 int err;
> >>
> >> + =A0 =A0 memset(&oprofile_ops, 0, sizeof(struct oprofile_operatio=
ns));
> >> +
> >
> > Yes, this looks much better. Thanks Paul.
>=20
> oprofile_ops is allocated in bss and so is already zeroed.  No need t=
o
> do it explicitly.

Before oprofile_arch_init() it isn't necessarily needed, but we should
definitely add it before oprofile_timer_init(). For code readability I
would rather tend to let the first in too.

-Robert

--=20
Advanced Micro Devices, Inc.
Operating System Research Center
