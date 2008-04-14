From: Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv3 2/2] kernel: Move arches to use common unaligned
	access
Date: Mon, 14 Apr 2008 09:27:12 -0700
Message-ID: <1208190432.5721.1.camel@brick>
References: <1207950449.22001.106.camel@brick> <4392.1208169129@redhat.com>
	 <20080414111119.GA6228@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20080414111119.GA6228-f404yB8NqCZvn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-arch-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <rmk-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Cc: David Howells <dhowells-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Mon, 2008-04-14 at 12:11 +0100, Russell King wrote:
> On Mon, Apr 14, 2008 at 11:32:09AM +0100, David Howells wrote:
> > Harvey Harrison <harvey.harrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > 
> > > -#ifndef _ASM_UNALIGNED_H
> > > -#define _ASM_UNALIGNED_H
> > > +#ifndef _ASM_FRV_UNALIGNED_H_
> > > +#define _ASM_FRV_UNALIGNED_H_
> > 
> > Please don't.  Why do you need to change these to make your patch work?
> 
> Indeed - ditto for the ARM changes.  The patch is changing them to a
> different style to the others in the respective asm/ directories -
> which is also different from the linux/ directory.
> 
> IMHO, if Harvey wishes to clean those up, then that should be a separate
> patch and should be part of a set converting all includes to use the
> same style.
> 

OK, I'll revise without these changes.  I am curious what the preferred
'linux' style is (if there is one).

Linus, Andrew?

Harvey
