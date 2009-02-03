Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46772 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbZBCRoK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 3 Feb 2009 12:44:10 -0500
Date: Tue, 3 Feb 2009 17:42:57 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: + preadv-pwritev-add-preadv-and-pwritev-system-calls.patch added to -mm tree
Message-ID: <20090203174257.GC20898@flint.arm.linux.org.uk>
References: <200902022135.n12LZa1a010673@imap1.linux-foundation.org> <49876A91.4000705@zytor.com> <49881904.30705@redhat.com> <498879B3.8030002@zytor.com> <20090203171559.GA20898@flint.arm.linux.org.uk> <49887EF4.1090300@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49887EF4.1090300@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, akpm@linux-foundation.org, mm-commits@vger.kernel.org, arnd@arndb.de, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, mingo@elte.hu, ralf@linux-mips.org, tglx@linutronix.de, viro@zeniv.linux.org.uk
Message-ID: <20090203174257.TFTXMZeiuxWbQljOfh7HqWB6ML510zLzpz4Uu_5rr7A@z>

On Tue, Feb 03, 2009 at 09:29:24AM -0800, H. Peter Anvin wrote:
> Russell King wrote:
> >>
> >> All in all, I think it is WRONG to make sane architectures suffer for
> >> what broken architectures have to do, and we should implement this the
> >> sane way without any shuffling, splitting, or other braindamage.
> > 
> > Disagree.  What is better: having _one_ _common_ argument order in the
> > syscall interface, or having architectures end up doing their own thing?
> > 
> > Think about your strace argument - you're effectively requiring strace
> > to know that on architecture X, the syscall argument order is X1, but
> > on architecture Y, that same syscall has argument order Y1, and maybe
> > architecture Z, it's again a different order Z1.
> > 
> > That _adds_ complexity to strace - rather than having one ordering to
> > deal with for a syscall, it now has three different random orders.
> > 
> > That's completely insane.  With one _common_ ordering, at least strace
> > has the possibility of cleanly sorting it out.
> > 
> 
> What we *SHOULD* be doing is to *HAVE ABIS RULE AND STICK TO THEM*.
> Which is that on architectures that need a padding register, we add the
> padding register on those architectures, and if they need stubs, then we
> add stubs -- preferrably by automation (c.f. my automation scripts for
> doing exactly that.)

This is an overly simplified view of things.  There exist syscalls where
it's not just a matter of padding, but instead where the chosen argument
order interacts with the ABI padding requirements to produce something
which the syscall interface can't handle.  There are two solutions to
that: reorder the syscall arguments or split them up into 32-bit high/low
quantities.

I'm thinking there of the silly fadvise64_64 syscall, where ARM was forced
into having a different argument ordering from everything else through
zero discussion.

So, what would your scripts do with the fadvise64_64 syscall on an
architecture requiring natural alignment of the 64-bit args in 32-bit
regs?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
