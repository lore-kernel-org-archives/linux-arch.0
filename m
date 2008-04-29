From: David Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
Subject: Re: [patch 275/311] kernel: Move arches to use common unaligned
 access
Date: Tue, 29 Apr 2008 01:19:50 -0700 (PDT)
Message-ID: <20080429.011950.50578885.davem@davemloft.net>
References: <200804290803.m3T83UB3009859@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <200804290803.m3T83UB3009859-AB4EexQrvXRQetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Cc: torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

From: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org
Date: Tue, 29 Apr 2008 01:03:30 -0700

> From: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> Unaligned access is ok for the following arches:
> cris, m68k, mn10300, powerpc, s390, x86
> 
> Arches that use the memmove implementation for native endian, and
> the byteshifting for the opposite endianness.
> h8300, m32r, xtensa
> 
> Packed struct for native endian, byteshifting for other endian:
> alpha, blackfin, ia64, parisc, sparc, sparc64, mips, sh
> 
> m86knommu is generic_be for Coldfire, otherwise unaligned access is ok.
> 
> frv, arm chooses endianness based on compiler settings, uses the byteshifting
> versions.  Remove the unaligned trap handler from frv as it is now unused.
> 
> v850 is le, uses the byteshifting versions for both be and le.
> 
> Remove the now unused asm-generic implementation.
> 
> Signed-off-by: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Signed-off-by: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>

Acked-by: David S. Miller <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>
