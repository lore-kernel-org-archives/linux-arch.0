Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:2170 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425623AbWLHQrq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 8 Dec 2006 11:47:46 -0500
Date: Fri, 8 Dec 2006 16:47:33 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH] WorkStruct: Implement generic UP cmpxchg() where an arch doesn't support it
Message-ID: <20061208164733.GE31068@flint.arm.linux.org.uk>
References: <20061206190025.GC9959@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612061111130.27263@schroedinger.engr.sgi.com> <20061206195820.GA15281@flint.arm.linux.org.uk> <4577DF5C.5070701@yahoo.com.au> <20061207150303.GB1255@flint.arm.linux.org.uk> <4578BD7C.4050703@yahoo.com.au> <20061208085634.GA25751@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612080758120.15242@schroedinger.engr.sgi.com> <20061208163127.GD31068@flint.arm.linux.org.uk> <Pine.LNX.4.64.0612080841560.15472@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612080841560.15472@schroedinger.engr.sgi.com>
Sender: linux-arch-owner@vger.kernel.org
To: Christoph Lameter <clameter@sgi.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Fri, Dec 08, 2006 at 08:43:09AM -0800, Christoph Lameter wrote:
> On Fri, 8 Dec 2006, Russell King wrote:
> 
> > You're advocating cmpxchg is adopted by all architectures.  It isn't
> > available on many architectures, and those which it can be requires
> > unnecessarily complicated coding.
> 
> Not having cmpxchg is even worse because it requires the introduction and 
> maintenance of large sets of arch specific operations. Much more complex.

And which bit of "not available on many architectures" have you not grasped
yet?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
