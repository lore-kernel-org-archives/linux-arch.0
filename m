Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:34642 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937423AbWLFT0t (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 6 Dec 2006 14:26:49 -0500
Date: Wed, 6 Dec 2006 12:26:47 -0700
From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch doesn't support it
Message-ID: <20061206192647.GW3013@parisc-linux.org>
References: <20061206164314.19870.33519.stgit@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com> <Pine.LNX.4.64.0612061103260.3542@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612061103260.3542@woody.osdl.org>
Sender: linux-arch-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Lameter <clameter@sgi.com>, Russell King <rmk+lkml@arm.linux.org.uk>, David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>, linux-arm-kernel@lists.arm.linux.org.uk, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, Dec 06, 2006 at 11:05:22AM -0800, Linus Torvalds wrote:
> On Wed, 6 Dec 2006, Christoph Lameter wrote:
> >
> > I'd really appreciate a cmpxchg that is generically available for 
> > all arches. It will allow lockless implementation for various performance 
> > criticial portions of the kernel.
> 
> I suspect ARM may have been the last one without one, no?

It's just been pointed out to me that the parisc one isn't safe.

<dhowells> imagine variable X is set to 3
<dhowells> CPU A issues cmpxchg(&X, 3, 5)
<dhowells> you'd expect that to change X to 5
<dhowells> but what if CPU B assigns 6 to X between cmpxchg reading X
and it setting X?

Given parisc's paucity of atomic operations (load-and-zero-32bit and
load-and-zero-64bit), cmpxchg() is impossible to implement safely.
There has to be something we can hook to exclude another processor
modifying the variable.  I'm OK with using atomic_cmpxchg(); we have
atomic_set locked against it.

Of course, using cmpxchg() isn't really lockless.  It's just hidden
locking.
