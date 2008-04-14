From: Russell King <rmk-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCHv3 2/2] kernel: Move arches to use common unaligned access
Date: Mon, 14 Apr 2008 12:11:19 +0100
Message-ID: <20080414111119.GA6228@flint.arm.linux.org.uk>
References: <1207950449.22001.106.camel@brick> <4392.1208169129@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4392.1208169129-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>

On Mon, Apr 14, 2008 at 11:32:09AM +0100, David Howells wrote:
> Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> 
> > -#ifndef _ASM_UNALIGNED_H
> > -#define _ASM_UNALIGNED_H
> > +#ifndef _ASM_FRV_UNALIGNED_H_
> > +#define _ASM_FRV_UNALIGNED_H_
> 
> Please don't.  Why do you need to change these to make your patch work?

Indeed - ditto for the ARM changes.  The patch is changing them to a
different style to the others in the respective asm/ directories -
which is also different from the linux/ directory.

IMHO, if Harvey wishes to clean those up, then that should be a separate
patch and should be part of a set converting all includes to use the
same style.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
