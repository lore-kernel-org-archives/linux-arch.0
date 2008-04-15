From: David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Subject: Re: + kernel-add-common-infrastructure-for-unaligned-access.patch
	added to -mm tree
Date: Tue, 15 Apr 2008 17:12:07 +0100
Message-ID: <1208275927.9212.58.camel@pmac.infradead.org>
References: <200804142214.m3EMET5L029431@imap1.linux-foundation.org>
	 <1208261668.9212.18.camel@pmac.infradead.org>
	 <1208272073.11920.74.camel@brick>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1208272073.11920.74.camel@brick>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, mm-commits-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, 2008-04-15 at 08:07 -0700, Harvey Harrison wrote:
> The reason I kept the byte-shifting versions around was that for
> arches that need special handling of unaligned access,

Are there any? GCC should emit appropriate code for the packed-structure
version on all architectures, shouldn't it?

> they could do the byteshifting manually and get the unaligned access
> 'for free' as it were. 

GCC really ought to be able to sort that out for itself. Let the dog see
the rabbit.

>  The packed struct implementation works fine for the same endianness,
> but I tried to make this as little of a change for each arch as a
> consolidation step...which is why I kept the
> memmove variant.  We can discuss moving arches over to other
> implementations after the fact.

TBH I'd rather just provide the generic implementations (using packed
structs) then convert the arches to them one at a time.

-- 
dwmw2
