From: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] kernel: Move arches to use common unaligned access
Date: Fri, 11 Apr 2008 08:19:26 -0700
Message-ID: <1207927166.22001.91.camel@brick>
References: <1207885132.22001.85.camel@brick>  <15208.1207908688@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <15208.1207908688-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>

On Fri, 2008-04-11 at 11:11 +0100, David Howells wrote:
> Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> 
> > -#ifndef _ASM_UNALIGNED_H
> > -#define _ASM_UNALIGNED_H
> > -
> > +#ifndef _ASM_FRV_UNALIGNED_H_
> > +#define _ASM_FRV_UNALIGNED_H_
> 
> Why?

Consistency with every other arch..no other reason.

> 
> > - * impractical.  So, now we fall back to using memcpy.
> > + * impractical.  So, now we fall back to using memmov.
> 
> That's memmove, not memmov.  Any why memmove, not memcpy?  Is __tmp likely to
> overlap with *ptr?
> 
> Also, for FRV, I think calling memmove/memcpy for MMU kernels may be the wrong
> thing to do...  I'm sort of leaning towards doing the same thing as NOMMU
> kernels and just using your inline ones.

OK, just let me know what you decide.  I'm stil open to bringing back
the frv asm versions if the do end up being faster.

> 
> The advantage of the inline ones is that they are quicker and probably involve
> fewer instructions executed; whereas using memcpy/memmove may end up with
> smaller, but slower code.  Hmmm...  Maybe key on CONFIG_CC_OPTIMIZE_FOR_SIZE?
> 

I suppose an out-of-line version could be easily added to accomplish
this.  It would be identical to the byteshifting implementation-wise.

Let me know if you'd like me to spin such a patch.

Harvey
