From: Valdis.Kletnieks@vt.edu
Subject: Re: [PATCH 1/2] sched: INIT_PREEMPT_COUNT
Date: Fri, 10 Jul 2009 11:42:26 -0400
Message-ID: <17047.1247240546@turing-police.cc.vt.edu>
References: <20090710125755.559739294@chello.nl>
            <20090710130125.037018244@chello.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1247240546_3858P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from turing-police.cc.vt.edu ([128.173.14.107]:60772 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbZGJPrN (ORCPT
	<RFC822;linux-arch@vger.kernel.org>); Fri, 10 Jul 2009 11:47:13 -0400
In-Reply-To: Your message of "Fri, 10 Jul 2009 14:57:56 +0200."
             <20090710130125.037018244@chello.nl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Matt Mackall <mpm@selenic.com>, Anton Vorontsov <avorontsov@ru.mvista.com>, Andrew Morton <akpm@linux-foundation.org>, oleg@redhat.com, mingo@elte.hu, tony.luck@intel.com, rth@twiddle.net, geert@linux-m68k.org

--==_Exmh_1247240546_3858P
Content-Type: text/plain; charset=us-ascii

On Fri, 10 Jul 2009 14:57:56 +0200, Peter Zijlstra said:

> +/*
> + * Disable preemption until the scheduler is running.
> + * Reset by start_kernel()->sched_init()->init_idle().
> + */
> +#define INIT_PREEMPT_COUNT	(1)
> +

I had to look at this for quite some time before it sank in that it wasn't
a reset of a #define, or a reset of (1) (anybody else remember changing the
value of '5' in a Fortran program?).  Especially when stuck in with a bunch
of cputimer defines. Would have taken even longer if I was looking in sched.h
for something and not looking at this patch at the same time.

Can we fix this comment to mention it's thread_info.preempt_count that
needs the reset?

--==_Exmh_1247240546_3858P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFKV2FicC3lWbTT17ARAnoRAJ4qyvpK+r/gaFG63FLWMt2ZqXjl7ACfSveu
PlK95waFksNCIHON+oex5JI=
=E2Xr
-----END PGP SIGNATURE-----

--==_Exmh_1247240546_3858P--
