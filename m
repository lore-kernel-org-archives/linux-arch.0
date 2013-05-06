Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:48591 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759316Ab3EFXxW (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 6 May 2013 19:53:22 -0400
Message-ID: <51884263.4020608@zytor.com>
Date: Mon, 06 May 2013 16:53:07 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
MIME-Version: 1.0
Subject: The type of bitops
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <20130506235307.YC0-LA_0AYzvfYjGM2wxT6AvWCbnoszQqlom6JUEPO0@z>

The type of bitops is currently "int" on most, if not all, architectures
except sparc64 where it is "unsigned long".  This already has the
potential of causing failures on extremely large non-NUMA x86 boxes
(specifically if any one node contains more than 8 TiB of memory, e.g.
in an interleaved memory system.)

x86 has hardware bitmask instructions which are signed, this limits the
types to either "int" or "long".

It seems pretty clear to me at least that x86-64 really should use
"long".  However, before blindly making that change I wanted to feel
people out for what this should look like across architectures.

Moving this forward, I see a couple of possibilities:

1. We simply change the type to "long" on x86, and let this be a fully
   architecture-specific option.  This is easy, obviously.

2. Same as above, except we also define a typedef for whatever type is
   the bitops argument type (bitops_t?  bitpos_t?)

3. Change the type to "long" Linux-wide, on the logic that it should be
   the same as the general machine width across all platforms.

4. Do some macro hacks so the bitops are dependent on the size of the
   argument.

5. Introduce _long versions of the bitops.

6. Do nothing at all.


Are there any 64-bit architectures where a 64-bit argument would be very
costly?

	-hpa
