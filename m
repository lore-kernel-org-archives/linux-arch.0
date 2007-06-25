Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from canuck.infradead.org ([209.217.80.40]:60249 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbXFYJsO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jun 2007 05:48:14 -0400
Subject: Re: Introduce fixed sys_sync_file_range2() syscall, implement on
	PowerPC and ARM
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <20070625021145.b84ea186.akpm@linux-foundation.org>
References: <1182761357.12109.14.camel@pmac.infradead.org>
	 <20070625021145.b84ea186.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Mon, 25 Jun 2007 10:48:10 +0100
Message-Id: <1182764890.12109.35.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: torvalds@linux-foundation.org, paulus@samba.org, linux-arch@vger.kernel.org, drepper@redhat.com, rmk@arm.linux.org.uk
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2007-06-25 at 02:11 -0700, Andrew Morton wrote:
> On Mon, 25 Jun 2007 09:49:17 +0100 David Woodhouse <dwmw2@infradead.org> wrote:
> 
> > +/* It would be nice if people remember that not all the world's an i386
> > +   when they introduce new system calls */
> 
> I think we could do without the smartarse comments, frankly.  It took about
> two weeks and 1000000000 emails for you guys to sort out the fallocate()
> ABI. 

It's exactly the same case -- two ints and two loff_ts. If we'd already
sorted it out properly for sys_sync_file_range() then it would have been
a no-brainer for fallocate().

>  How would you like "it would be nice if maintainers of oddball
> architectures would pay attention"?

Seems like a reasonable observation, although 'oddball' isn't really the
case here. There are a bunch of architectures which align 64-bit
arguments into even pairs of registers. And a lot of people who forget
that 64-bit quantities are often aligned to 8 bytes, on non-x86.
cf. f4d2781731e846c2f01dd85e71883d120860c6dd

But aside from nit-picking the wording, I do agree with the sentiment --
and that's precisely why you'll see warnings about sys_sync_file_range()
being unimplemented, when you build current kernels on certain
platforms. So that all arch maintainers pay attention to new syscalls.

> the naming, the implementation and the types are all inconsistent.  Can we
> pick one style and stick to it?

It might actually be useful to merge all these into fs/compat.c. I think
the only reason most of them are arch-specific at the moment is because
we have to deal with endianness when we put the two 32-bit integers
together into a 64-bit integer. And MIPS copes well enough with that,
with its merge_64() macro.

-- 
dwmw2

