From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH 01/14] Introduce cpu_enabled_map and friends
Date: Tue, 15 Jul 2008 19:48:22 +0100
Message-ID: <20080715184822.GB29991@flint.arm.linux.org.uk>
References: <20080715023344.2528.1836.stgit@blender.achiang> <20080715023349.2528.9423.stgit@blender.achiang> <20080715031512.GF14894@parisc-linux.org> <87wsjnxy4w.fsf@basil.nowhere.org> <20080715102130.GA22866@flint.arm.linux.org.uk> <20080715175740.GB10919@ldl.fc.hp.com> <20080715181632.GG14894@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:55671 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761981AbYGOS64 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jul 2008 14:58:56 -0400
Content-Disposition: inline
In-Reply-To: <20080715181632.GG14894@parisc-linux.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Alex Chiang <achiang@hp.com>, Andi Kleen <andi@firstfloor.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org

On Tue, Jul 15, 2008 at 12:16:32PM -0600, Matthew Wilcox wrote:
> On Tue, Jul 15, 2008 at 11:57:40AM -0600, Alex Chiang wrote:
> > My thought was that big SMP systems like ia64, possibly sparc and
> > ppc, and increasingly, x86, might find something like this
> > useful, as systems get larger and larger, and vendors are going
> > to want to do RAS-ish features, like the ability to keep CPUs in
> > firmware across reboots until told otherwise by the sysadmin.
> > 
> > Right now, a 'present' CPU strongly implies 'online' as well,
> > since we're calling cpu_up() for all 'present' CPUs in
> > smp_init(). But this hurts if:
> > 
> > 	- you don't actually want to bring up all 'present' CPUs
> > 	- you still want to interact with these weirdo zombie
> > 	  CPUs that are 'present' but not 'online'
> 
> Have you considered simply failing __cpu_up() for CPUs that are
> deconfigured by firmware?

But what if you want to have a system boot with, say, 4 CPUs and
then decide at run time to bring up another 4 CPUs when required?

How about having smp_init() call into arch code to query whether
it should bring up a not-already-online CPU?  Architectures that
want to do something special can then make the decision there and
everyone else can define the test completely away.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
