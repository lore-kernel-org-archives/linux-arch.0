Return-Path: <davidm@napali.hpl.hp.com>
Received: from palrel10.hp.com ([156.153.255.245]:24245 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S263850AbUECSif (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 3 May 2004 14:38:35 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16534.37209.199911.737170@napali.hpl.hp.com>
Date: Mon, 3 May 2004 11:37:13 -0700
Subject: Re: static DEFINE_PER_CPU vs. modules
In-Reply-To: <20040503180156.GA10981@twiddle.net>
References: <200405031741.52504.arnd@arndb.de>
	<16534.34396.940596.361864@napali.hpl.hp.com>
	<20040503180156.GA10981@twiddle.net>
Reply-To: davidm@hpl.hp.com
To: Richard Henderson <rth@twiddle.net>
Cc: davidm@hpl.hp.com, Arnd Bergmann <arnd@arndb.de>, Rusty Russell <rusty@rustcorp.com.au>, linux-arch@vger.kernel.org, epasch@de.ibm.com, hare@suse.de
List-ID: <linux-arch.vger.kernel.org>

>>>>> On Mon, 3 May 2004 11:01:56 -0700, Richard Henderson <rth@twiddle.net> said:

  Rich> On Mon, May 03, 2004 at 10:50:20AM -0700, David Mosberger
  Rich> wrote:

  >> Seems to me this is a gcc bug if it generates code that is unable
  >> to reach all possible addresses.

  Rich> Nope.  There are multiple memory models for amd64.  The
  Rich> default assumes a 32-bit local data segment, since that makes
  Rich> for the most efficient code generation and works virtually all
  Rich> of the time.

This was in the context of per-CPU addressing.  I don't know the s390x
well but if the 32-bit offset is a memory-model limitation, fine.  The
real problem then seems to lie in the way per-CPU addressing is
imlemented on s390x, no?

Perhaps s390x could use a similar trick as we do on ia64?  We put the
per-CPU area in the last 64KB of the address space, so the absolute
address is guaranteed to fit into a small signed integer constant.
Newer compilers support the "model(small)" attribute so the compiler
knows it can use a simple "addl" instruction to calculate the address
of a per-CPU variable.

	--david
