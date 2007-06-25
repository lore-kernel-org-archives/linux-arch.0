Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from canuck.infradead.org ([209.217.80.40]:57028 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776AbXFYNeh (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 25 Jun 2007 09:34:37 -0400
Subject: Re: Introduce fixed sys_sync_file_range2() syscall, implement on
	PowerPC and ARM
From: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <44a862a6e0b8df8765958d456d9b17d6@kernel.crashing.org>
References: <1182761357.12109.14.camel@pmac.infradead.org>
	 <20070625021145.b84ea186.akpm@linux-foundation.org>
	 <20070625103535.GF22063@parisc-linux.org>
	 <20070625110907.GA23438@flint.arm.linux.org.uk>
	 <1182771454.12109.71.camel@pmac.infradead.org>
	 <20070625114742.GG22063@parisc-linux.org>
	 <2fc3aacccf036072f1b959e7b9ec3629@kernel.crashing.org>
	 <1182774873.12109.83.camel@pmac.infradead.org>
	 <44a862a6e0b8df8765958d456d9b17d6@kernel.crashing.org>
Content-Type: text/plain
Date: Mon, 25 Jun 2007 14:33:46 +0100
Message-Id: <1182778426.12109.87.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: torvalds@linux-foundation.org, Russell King <rmk@arm.linux.org.uk>, Matthew Wilcox <matthew@wil.cx>, Andrew Morton <akpm@linux-foundation.org>, drepper@redhat.com, paulus@samba.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 2007-06-25 at 15:10 +0200, Segher Boessenkool wrote:
> >> I don't see any 64-bit integers here.
> >
> > Of course not. This is the routine which is called from 32-bit code.
> > The prototype in the 32-bit code is (int, unsigned, loff_t, loff_t).
> 
> Ah I see, sorry for the confusion.

> Yes exactly, signed integers need sign extensions, which
> makes them less efficient.  Some ABIs need zero extensions
> too, but on a whole unsigned works better.  Most of the
> time you don't need to do much on the (C code) kernel side
> of things.

Most of the time, true. But not in the case we're actually talking
about.

> Is this enough handwaving?  I'm sure someone else can explain
> this a lot better than me :-)

Perhaps so :)

-- 
dwmw2

