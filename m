Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S261160AbULDVEk@vger.kernel.org>
Received: from palrel12.hp.com ([156.153.255.237]:19095 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S261158AbULDVEj (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 4 Dec 2004 16:04:39 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16818.9823.674936.616800@napali.hpl.hp.com>
Date: Sat, 4 Dec 2004 13:04:31 -0800
Subject: Re: other platforms interested in in-kernel unwinder?
In-Reply-To: <16817.13868.599352.890898@cargo.ozlabs.ibm.com>
References: <16815.21943.55627.572012@napali.hpl.hp.com>
	<200412031037.22445.arnd@arndb.de>
	<16816.54808.503077.473990@napali.hpl.hp.com>
	<16817.13868.599352.890898@cargo.ozlabs.ibm.com>
Reply-To: davidm@hpl.hp.com
To: Paul Mackerras <paulus@samba.org>
Cc: davidm@hpl.hp.com, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, davidm@napali.hpl.hp.com, Wolfgang Gellerich <gellerich@de.ibm.com>
List-ID: <linux-arch.vger.kernel.org>

>>>>> On Sat, 4 Dec 2004 14:59:40 +1100, Paul Mackerras <paulus@samba.org> said:

  Paul> David Mosberger writes:
  >> Oh, that's a surprise.  I didn't realize ppc was maintaining a
  >> frame-chain.  Can somebody confirm?

  Paul> Yes, both ppc and ppc64 maintain a series of stack frames
  Paul> linked together, so getting the call chain is pretty
  Paul> straightforward.  (This is a convention and part of the ABI,
  Paul> not something required by the hardware.)

OK, thanks for the info.  There is always something new to learn... ;-)

  Paul> There are two things an unwinder could help with.  First,
  Paul> because of the conventions about leaf functions, the first
  Paul> return address can be in the link register or on the stack, or
  Paul> both, and the link register value may or may not need to be
  Paul> used as part of the call chain.  An unwinder could presumably
  Paul> get that right (at the moment we have some heuristics that
  Paul> work pretty well but not perfectly).

  Paul> Secondly, an unwinder could get us the contents of the
  Paul> callee-saved registers in each stack frame, which may be
  Paul> useful for debugging.

  Paul> I think an unwinder would be of some help to those of us doing
  Paul> kernel debugging, but I don't know that it would make a
  Paul> dramatic difference.

Nobody so far has said they badly want an in-kernel unwinder for
anything other than ia64, so I'll probably go ahead and make it
ia64-specific for now, while keeping an eye open for not doing
anything that would make it more difficult to add in the DWARF2
unwinder should some day the need arise.

Thanks,

	--david
