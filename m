Return-Path: <davidm@napali.hpl.hp.com>
Received: from palrel13.hp.com ([156.153.255.238]:34745 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S264506AbUEDQ34 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 4 May 2004 12:29:56 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <16535.50431.820664.953078@napali.hpl.hp.com>
Date: Tue, 4 May 2004 09:29:51 -0700
Subject: Re: static DEFINE_PER_CPU vs. modules
In-Reply-To: <200405041617.37371.arnd@arndb.de>
References: <200405031741.52504.arnd@arndb.de>
	<20040503193835.72c62ad8.akpm@osdl.org>
	<200405041617.37371.arnd@arndb.de>
Reply-To: davidm@hpl.hp.com
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@osdl.org>, rusty@rustcorp.com.au, linux-arch@vger.kernel.org, epasch@de.ibm.com, hare@suse.de
List-ID: <linux-arch.vger.kernel.org>

>>>>> On Tue, 4 May 2004 16:17:29 +0200, Arnd Bergmann <arnd@arndb.de> said:

  Arnd> On Tuesday 04 May 2004 04:38, Andrew Morton wrote:
  >> Arnd Bergmann <arnd@arndb.de> wrote:
  >> >
  >> > The idea I had for preventing the same bug from happening
  >> >  in the future is to provoke a compile error for modules using
  >> >  'static DEFINE_PER_CPU', see patch below.

  >> It's not a big success with CONFIG_SMP=n.

  >> kernel/fork.c:55: warning: return-type defaults to `int'
  >> kernel/fork.c: In function `__PER_CPU_NOSTATIC':

  Arnd> Sorry about that, I accidentally defined __PER_CPU_NOSTATIC
  Arnd> inside '#ifdef CONFIG_SMP'. This now builds with and without
  Arnd> SMP.

I do not understand why such a patch should get accepted.  In general,
it makes no sense at all to disallow static per-CPU variables.  If
some platforms are broken, fine, put a workaround _for that platform_
in, but don't prevent the others from doing the sane thing.

	--david
