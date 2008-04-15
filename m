From: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv4 2/2] kernel: Move arches to use common unaligned
	access
Date: Tue, 15 Apr 2008 08:17:05 -0700
Message-ID: <1208272625.11920.78.camel@brick>
References: <1208195405.5721.45.camel@brick>  <17632.1208253714@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <17632.1208253714-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Russell King <rmk-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>

On Tue, 2008-04-15 at 11:01 +0100, David Howells wrote:
> Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> 
> >  arch/frv/kernel/traps.c           |    7 +-
> >  arch/frv/mm/unaligned.c           |  217 -------------------------------------
> 
> And arch/frv/mm/Makefile?  It still refers to unaligned.c.
> 

Missed that, thanks a lot.

> > -#ifndef _ASM_UNALIGNED_H
> > -#define _ASM_UNALIGNED_H
> > +#ifndef _ASM_FRV_UNALIGNED_H
> > +#define _ASM_FRV_UNALIGNED_H
> 
> Please don't!

Andrew, do you need an incremental patch for this, or can you take care
of it on your end?

Cheers,

Harvey
