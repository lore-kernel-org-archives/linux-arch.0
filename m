Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S262529AbULDD7o@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:13983 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262528AbULDD7o (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 3 Dec 2004 22:59:44 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16817.13868.599352.890898@cargo.ozlabs.ibm.com>
Date: Sat, 4 Dec 2004 14:59:40 +1100
From: Paul Mackerras <paulus@samba.org>
Subject: Re: other platforms interested in in-kernel unwinder?
In-Reply-To: <16816.54808.503077.473990@napali.hpl.hp.com>
References: <16815.21943.55627.572012@napali.hpl.hp.com>
	<200412031037.22445.arnd@arndb.de>
	<16816.54808.503077.473990@napali.hpl.hp.com>
To: davidm@hpl.hp.com
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, davidm@napali.hpl.hp.com, Wolfgang Gellerich <gellerich@de.ibm.com>
List-ID: <linux-arch.vger.kernel.org>

David Mosberger writes:

> Oh, that's a surprise.  I didn't realize ppc was maintaining a
> frame-chain.  Can somebody confirm?

Yes, both ppc and ppc64 maintain a series of stack frames linked
together, so getting the call chain is pretty straightforward.  (This
is a convention and part of the ABI, not something required by the
hardware.)

There are two things an unwinder could help with.  First, because of
the conventions about leaf functions, the first return address can be
in the link register or on the stack, or both, and the link register
value may or may not need to be used as part of the call chain.  An
unwinder could presumably get that right (at the moment we have some
heuristics that work pretty well but not perfectly).

Secondly, an unwinder could get us the contents of the callee-saved
registers in each stack frame, which may be useful for debugging.

I think an unwinder would be of some help to those of us doing kernel
debugging, but I don't know that it would make a dramatic difference.

Regards,
Paul.
