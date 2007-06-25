Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:46246 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbXFYKYP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jun 2007 06:24:15 -0400
Date: Mon, 25 Jun 2007 04:24:13 -0600
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: Introduce fixed sys_sync_file_range2() syscall, implement on PowerPC and ARM
Message-ID: <20070625102412.GE22063@parisc-linux.org>
References: <1182761357.12109.14.camel@pmac.infradead.org> <20070625021145.b84ea186.akpm@linux-foundation.org> <1182764890.12109.35.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1182764890.12109.35.camel@pmac.infradead.org>
Sender: linux-arch-owner@vger.kernel.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org, paulus@samba.org, linux-arch@vger.kernel.org, drepper@redhat.com, rmk@arm.linux.org.uk
List-ID: <linux-arch.vger.kernel.org>

On Mon, Jun 25, 2007 at 10:48:10AM +0100, David Woodhouse wrote:
> Seems like a reasonable observation, although 'oddball' isn't really the
> case here. There are a bunch of architectures which align 64-bit
> arguments into even pairs of registers. And a lot of people who forget
> that 64-bit quantities are often aligned to 8 bytes, on non-x86.
> cf. f4d2781731e846c2f01dd85e71883d120860c6dd
[...]
> It might actually be useful to merge all these into fs/compat.c. I think
> the only reason most of them are arch-specific at the moment is because
> we have to deal with endianness when we put the two 32-bit integers
> together into a 64-bit integer. And MIPS copes well enough with that,
> with its merge_64() macro.

PowerPC is new to me -- I had thought that MIPS and PA-RISC were the
only two.  Seems like you took the opposite path from parisc -- you've
got glibc to call the functions correctly, rather than what we did which
was fix them up in the kernel.

