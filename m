Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:4064 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S938067AbWLHPdB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 8 Dec 2006 10:33:01 -0500
Date: Fri, 8 Dec 2006 15:32:50 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch doesn't support it
Message-ID: <20061208153250.GB31068@flint.arm.linux.org.uk>
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com> <Pine.LNX.4.64.0612061103260.3542@woody.osdl.org> <20061207150606.GC1255@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061207150606.GC1255@flint.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>, Christoph Lameter <clameter@sgi.com>, David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>, linux-arm-kernel@lists.arm.linux.org.uk, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, Dec 07, 2006 at 03:06:06PM +0000, Russell King wrote:
> On Wed, Dec 06, 2006 at 11:05:22AM -0800, Linus Torvalds wrote:
> > 
> > 
> > On Wed, 6 Dec 2006, Christoph Lameter wrote:
> > >
> > > I'd really appreciate a cmpxchg that is generically available for 
> > > all arches. It will allow lockless implementation for various performance 
> > > criticial portions of the kernel.
> > 
> > I suspect ARM may have been the last one without one, no?
> > 
> > That said, cmpxchg won't necessarily be "high-performance" unless the hw 
> > supports it naturally in hardware, so..
> > 
> > Russell, are you ok with the code DavidH posted (the "try 2" one)? I'd 
> > like to get an ack from the ARM maintainer before applying it, but it 
> > looked ok.
> 
> Things seem to have moved on since this request.  Do I need to do
> anything?  I dunno.

ARM's still broken.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
