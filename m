Return-Path: <arnd@arndb.de>
Received: from natsmtp00.rzone.de ([81.169.145.165]:21946 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S264108AbUECW2j
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 3 May 2004 18:28:39 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: static DEFINE_PER_CPU vs. modules
Date: Tue, 4 May 2004 00:24:02 +0200
References: <200405031741.52504.arnd@arndb.de> <20040503180156.GA10981@twiddle.net> <16534.37209.199911.737170@napali.hpl.hp.com>
In-Reply-To: <16534.37209.199911.737170@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405040024.03906.arnd@arndb.de>
To: davidm@hpl.hp.com
Cc: Richard Henderson <rth@twiddle.net>, Rusty Russell <rusty@rustcorp.com.au>, linux-arch@vger.kernel.org, epasch@de.ibm.com, hare@suse.de
List-ID: <linux-arch.vger.kernel.org>

On Monday 03 May 2004 20:37, David Mosberger wrote:
> This was in the context of per-CPU addressing.  I don't know the s390x
> well but if the 32-bit offset is a memory-model limitation, fine.  The
> real problem then seems to lie in the way per-CPU addressing is
> imlemented on s390x, no?
 
Exactly. However, s390x is using the same code as every other architecture
aside from ia64. Both s390{,x} and x86_64 have some optimized way to get
to the per_cpu_offset, but that does not impact the problem.

> Perhaps s390x could use a similar trick as we do on ia64?  We put the
> per-CPU area in the last 64KB of the address space, so the absolute
> address is guaranteed to fit into a small signed integer constant.
> Newer compilers support the "model(small)" attribute so the compiler
> knows it can use a simple "addl" instruction to calculate the address
> of a per-CPU variable.

I don't understand how that would help. On an 4GB+ system, modules get
get loaded to a >4GB address, so a 32 bit PC-relative relocation that
can not get to a small positive address won't be enough for a small negative
address either. The only way to force absolute addressing instead of
PC-relative on s390x is to compile with -fPIC (as we do) _and_ declare
the symbol non-static.
It could work if we load the modules to the top of the address space as
well, is that what you mean?

	Arnd <><
