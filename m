Return-Path: <akpm@osdl.org>
Received: from fw.osdl.org ([65.172.181.6]:4275 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264586AbUEDTEZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 4 May 2004 15:04:25 -0400
Date: Tue, 4 May 2004 12:03:17 -0700
From: Andrew Morton <akpm@osdl.org>
Subject: Re: static DEFINE_PER_CPU vs. modules
Message-Id: <20040504120317.36d45341.akpm@osdl.org>
In-Reply-To: <16535.50431.820664.953078@napali.hpl.hp.com>
References: <200405031741.52504.arnd@arndb.de>
	<20040503193835.72c62ad8.akpm@osdl.org>
	<200405041617.37371.arnd@arndb.de>
	<16535.50431.820664.953078@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
To: davidm@hpl.hp.com
Cc: arnd@arndb.de, rusty@rustcorp.com.au, linux-arch@vger.kernel.org, epasch@de.ibm.com, hare@suse.de
List-ID: <linux-arch.vger.kernel.org>

David Mosberger <davidm@napali.hpl.hp.com> wrote:
>
> >>>>> On Tue, 4 May 2004 16:17:29 +0200, Arnd Bergmann <arnd@arndb.de> said:
> 
>   Arnd> On Tuesday 04 May 2004 04:38, Andrew Morton wrote:
>   >> Arnd Bergmann <arnd@arndb.de> wrote:
>   >> >
>   >> > The idea I had for preventing the same bug from happening
>   >> >  in the future is to provoke a compile error for modules using
>   >> >  'static DEFINE_PER_CPU', see patch below.
> 
>   >> It's not a big success with CONFIG_SMP=n.
> 
>   >> kernel/fork.c:55: warning: return-type defaults to `int'
>   >> kernel/fork.c: In function `__PER_CPU_NOSTATIC':
> 
>   Arnd> Sorry about that, I accidentally defined __PER_CPU_NOSTATIC
>   Arnd> inside '#ifdef CONFIG_SMP'. This now builds with and without
>   Arnd> SMP.
> 
> I do not understand why such a patch should get accepted.  In general,
> it makes no sense at all to disallow static per-CPU variables.  If
> some platforms are broken, fine, put a workaround _for that platform_
> in, but don't prevent the others from doing the sane thing.
> 

Because s390 can use (almost) all modules.  It's like the "atomic_t only
holds 24-bits because of sparc32" thing which we lived with for ages.

We can certainly live with this workaround, but it would be nice to find
something better. per-module per-cpu data sections?
