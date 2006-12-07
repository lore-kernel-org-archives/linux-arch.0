Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:38388
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S937903AbWLGBJB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 6 Dec 2006 20:09:01 -0500
Date: Wed, 06 Dec 2006 17:09:11 -0800 (PST)
Message-Id: <20061206.170911.45496956.davem@davemloft.net>
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an
 arch doesn't support it
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061206190828.GE4587@ftp.linux.org.uk>
References: <Pine.LNX.4.64.0612061054360.27047@schroedinger.engr.sgi.com>
	<Pine.LNX.4.64.0612061103260.3542@woody.osdl.org>
	<20061206190828.GE4587@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: viro@ftp.linux.org.uk
Cc: torvalds@osdl.org, clameter@sgi.com, rmk+lkml@arm.linux.org.uk, dhowells@redhat.com, akpm@osdl.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

From: Al Viro <viro@ftp.linux.org.uk>
Date: Wed, 6 Dec 2006 19:08:28 +0000

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
> 
> No.  sparc32 doesn't have one, for instance.

That's correct.  It has an atomic swap, but not a cmpxchg.
