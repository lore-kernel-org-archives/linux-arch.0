From: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: + kernel-add-common-infrastructure-for-unaligned-access.patch
	added to -mm tree
Date: Tue, 15 Apr 2008 08:07:53 -0700
Message-ID: <1208272073.11920.74.camel@brick>
References: <200804142214.m3EMET5L029431@imap1.linux-foundation.org>
	 <1208261668.9212.18.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1208261668.9212.18.camel-ZP4jZrcIevRpWr+L1FloEB2eb7JE58TQ@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, mm-commits-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, 2008-04-15 at 13:14 +0100, David Woodhouse wrote:
> On Mon, 2008-04-14 at 15:14 -0700, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org wrote:
> > 
> > Currently there are five implementations:
> > 1) packed_struct.h: C-struct based, from asm-generic/unaligned.h
> > 2) le_byteshift.h: Open coded byte-swapping, heavily based on asm-arm
> > 3) be_byteshift.h: Open coded byte-swapping, heavily based on asm-arm
> > 4) memmove.h: taken from multiple implementations in tree
> > 5) access_ok.h: taken from x86 and others, unaligned access is ok.
> > 
> > All of the new implementations checks for sizes not equal to 1,2,4,8
> > and will fail to link.
> 
> This seems like overkill to me. Can't we just use the packed struct
> version? GCC should then to the right thing for all architectures.
> 

> And couldn't these be macros rather than relying on a boatload of
> infrastructure?


The reason I kept the byte-shifting versions around was that for
arches that need special handling of unaligned access, they could
do the byteshifting manually and get the unaligned access 'for free'
as it were.  The packed struct implementation works fine for the
same endianness, but I tried to make this as little of a change for
each arch as a consolidation step...which is why I kept the
memmove variant.  We can discuss moving arches over to other
implementations after the fact.

Cheers,

Harvey
