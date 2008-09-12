From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: CONFIG_HAVE_ARCH_TRACEHOOK and you
Date: Fri, 12 Sep 2008 14:13:51 +0100
Message-ID: <20080912131351.GA31545@flint.arm.linux.org.uk>
References: <20080912025733.E55F415420D@magilla.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:41024 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751273AbYILNON (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 12 Sep 2008 09:14:13 -0400
Content-Disposition: inline
In-Reply-To: <20080912025733.E55F415420D@magilla.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Roland McGrath <roland@redhat.com>
Cc: linux-arch@vger.kernel.org, utrace-devel@redhat.com, linux-kernel@vger.kernel.org

Okay, let's comment on each bit separately.

Regsets
-------

These don't appear to be a problem for ARM, and turn out to be relatively
clean.  The only thing I did do was invent some alternative simpler
helper functions rather than using the user_regset_copy* functions (to
avoid taking the address of function arguments, which needlessly forces
them onto the stack.)

However, in looking at other architectures, I notice that sparc does this
when initializing its regsets:

                .n = 38 * sizeof(u32),
                .size = sizeof(u32), .align = sizeof(u32),

and sparc64:

                .n = 36 * sizeof(u64),
                .size = sizeof(u64), .align = sizeof(u64),

which, given that fs/binfmt_elf.c does this:

                        size_t size = regset->n * regset->size;
                        void *data = kmalloc(size, GFP_KERNEL);
                        if (unlikely(!data))
                                return 0;

means sparc ends up allocating 38 * sizeof(u32) * sizeof(u32), and
sparc64 ends up with 36 * sizeof(u64) * sizeof(u64), which must surely
be wrong?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
