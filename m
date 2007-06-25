Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:57684 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751312AbXFYMIN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jun 2007 08:08:13 -0400
Subject: Re: Introduce fixed sys_sync_file_range2() syscall, implement on
	PowerPC and ARM
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <20070625114742.GG22063@parisc-linux.org>
References: <1182761357.12109.14.camel@pmac.infradead.org>
	 <20070625021145.b84ea186.akpm@linux-foundation.org>
	 <20070625103535.GF22063@parisc-linux.org>
	 <20070625110907.GA23438@flint.arm.linux.org.uk>
	 <1182771454.12109.71.camel@pmac.infradead.org>
	 <20070625114742.GG22063@parisc-linux.org>
Content-Type: text/plain
Date: Mon, 25 Jun 2007 13:01:34 +0100
Message-Id: <1182772894.12109.77.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: Russell King <rmk@arm.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, torvalds@linux-foundation.org, paulus@samba.org, linux-arch@vger.kernel.org, drepper@redhat.com
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2007-06-25 at 05:47 -0600, Matthew Wilcox wrote:
> On Mon, Jun 25, 2007 at 12:37:34PM +0100, David Woodhouse wrote:
> > - Some architectures must align 64-bit integers into an aligned
> >   pair of registers. A slot may be wasted for padding.
> > - S390 may not have a 64-bit integer in slots 5/6.
> 
> Uhm, doesn't sys_sync_file_range2 break that?

Yes, but the consensus when it was discussed for fallocate() seemed to
be that it was more important to have the fd first, for reasons not
entirely clear to me. S390 needs special handling for fallocate(), and
in fact has already implemented sys_sync_file_range() so doesn't need to
do sys_sync_file_range2().

> Also, you might want to put something in the syscall file about signed
> vs unsigned arguments and how they behave with 32-on-64 systems.

True. If I properly understood why arch/powerpc/sys_ppc32.c has _some_
of that stuff but apparently no longer needs it, then I would have tried
to say something coherent about it.

-- 
dwmw2

