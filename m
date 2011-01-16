From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH v4 05/24] arm: introduce little-endian bitops
Date: Sun, 16 Jan 2011 17:51:09 +0000
Message-ID: <20110116175109.GC13615@flint.arm.linux.org.uk>
References: <1295183333-13802-1-git-send-email-akinobu.mita@gmail.com> <1295183333-13802-6-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1295183333-13802-6-git-send-email-akinobu.mita@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Akinobu Mita <akinobu.mita@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Sun, Jan 16, 2011 at 10:08:34PM +0900, Akinobu Mita wrote:
> Introduce little-endian bit operations by renaming native ext2 bit
> operations.  The ext2 bit operations are kept as wrapper macros using
> little-endian bit operations to maintain bisectability until the
> conversions are finished.

This looks fine to me - is there any chance we can get this in to mainline
so we can avoid conflicts between this and some patches I'm working on atm
to fix the unsafe UP+SMP kernel combination with ARMs bitops ?

It's doing some stuff which needs to be done anyway (the casting to
unsigned long pointers for the ext2/minix find bit functions) which
otherwise will be duplicated in my patches.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
