From: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] kernel: Move arches to use common unaligned access
Date: Fri, 11 Apr 2008 11:11:28 +0100
Message-ID: <15208.1207908688@redhat.com>
References: <1207885132.22001.85.camel@brick>
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1207885132.22001.85.camel@brick>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>

Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> -#ifndef _ASM_UNALIGNED_H
> -#define _ASM_UNALIGNED_H
> -
> +#ifndef _ASM_FRV_UNALIGNED_H_
> +#define _ASM_FRV_UNALIGNED_H_

Why?

> - * impractical.  So, now we fall back to using memcpy.
> + * impractical.  So, now we fall back to using memmov.

That's memmove, not memmov.  Any why memmove, not memcpy?  Is __tmp likely to
overlap with *ptr?

Also, for FRV, I think calling memmove/memcpy for MMU kernels may be the wrong
thing to do...  I'm sort of leaning towards doing the same thing as NOMMU
kernels and just using your inline ones.

The advantage of the inline ones is that they are quicker and probably involve
fewer instructions executed; whereas using memcpy/memmove may end up with
smaller, but slower code.  Hmmm...  Maybe key on CONFIG_CC_OPTIMIZE_FOR_SIZE?

David
