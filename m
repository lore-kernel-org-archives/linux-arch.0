Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4574 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1426170AbWLHToN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 8 Dec 2006 14:44:13 -0500
Date: Fri, 8 Dec 2006 19:43:57 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch doesn't support it
Message-ID: <20061208194357.GJ31068@flint.arm.linux.org.uk>
References: <20061207150303.GB1255@flint.arm.linux.org.uk> <4578BD7C.4050703@yahoo.com.au> <20061208085634.GA25751@flint.arm.linux.org.uk> <4595.1165597017@redhat.com> <Pine.LNX.4.64.0612080903370.15959@schroedinger.engr.sgi.com> <20061208171816.GG31068@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612080919220.16029@schroedinger.engr.sgi.com> <Pine.LNX.4.64.0612081101280.3516@woody.osdl.org> <20061208193116.GI31068@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612081136230.3516@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612081136230.3516@woody.osdl.org>
Sender: linux-arch-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Lameter <clameter@sgi.com>, David Howells <dhowells@redhat.com>, Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, Dec 08, 2006 at 11:37:45AM -0800, Linus Torvalds wrote:
> 
> 
> On Fri, 8 Dec 2006, Russell King wrote:
> > 
> > I utterly disagree.  I could code atomic_add() as:
> 
> Sure. And Alpha could do that too. If you write the C code a specific way, 
> you can make it work. That does NOT mean that you can expose it widely as 
> a portable interface - it's still just a very _nonportable_ interface that 
> you use internally within one architecture to implement other interfaces.

However, nothing stops you wrapping the non-portable nature of ll/sc up
into the store part though.

If you can efficiently implement cmpxchg inside an ll/sc based portable
interface (yes you can) and you can implement problematical ll/sc
structures inside a cmpxchg() interface, you can do it either way around.
Only one way doesn't penalise broken ll/sc based implementations though.

That is the essence of my argument.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
