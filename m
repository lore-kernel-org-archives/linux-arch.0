Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S262340AbULCVUD@vger.kernel.org>
Received: from palrel12.hp.com ([156.153.255.237]:16007 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262298AbULCVUD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 3 Dec 2004 16:20:03 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16816.54808.503077.473990@napali.hpl.hp.com>
Date: Fri, 3 Dec 2004 13:09:44 -0800
Subject: Re: other platforms interested in in-kernel unwinder?
In-Reply-To: <200412031037.22445.arnd@arndb.de>
References: <16815.21943.55627.572012@napali.hpl.hp.com>
	<200412031037.22445.arnd@arndb.de>
Reply-To: davidm@hpl.hp.com
To: Arnd Bergmann <arnd@arndb.de>
Cc: davidm@hpl.hp.com, linux-arch@vger.kernel.org, davidm@napali.hpl.hp.com, Wolfgang Gellerich <gellerich@de.ibm.com>
List-ID: <linux-arch.vger.kernel.org>

>>>>> On Fri, 3 Dec 2004 10:37:22 +0100, Arnd Bergmann <arnd@arndb.de> said:

  Arnd> I think it doesn't make much sense for unwinding s390 kernel
  Arnd> stacks, since they already have reliable back traces trough
  Arnd> the backchain pointers. In particular, those pointers are
  Arnd> needed anyway for easy unwinding by hand when debugging in
  Arnd> z/VM.

Yes, that certainly makes sense.

On s390, do you get just the frame-chain or do the frames contain
enough information to figure out which callee-saved registers where
saved?

  Arnd> My limited experience on ppc64 suggests that the situation
  Arnd> there is very similar.

Oh, that's a surprise.  I didn't realize ppc was maintaining a
frame-chain.  Can somebody confirm?

  Arnd> OTOH, I've heard that oprofile is unwinding user stacks to get
  Arnd> call graph information.

That's correct.

  Arnd> For that purpose, a kernel unwinder might turn out very
  Arnd> valuable on many architectures, including those that use a
  Arnd> backchain pointer in kernel but not in user space.

I should point out that, at the moment, my plan is to only support
unwinding within the kernel itself, so in that sense, it may or may
not help oprofile.

A corretion to yesterday's message: I forgot that the x86-64 libunwind
that I was looking at had debugging enabled, which causes lots of
replicated code because inlining is disabled.  I don't have x86-64
figures handy for the no-debug version, but for x86, the entire
libunwind library, some of which won't be needed in the kernel
version, is just 35KB of text and ~16KB of data.

	--david
