From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH 01/14] Introduce cpu_enabled_map and friends
Date: Tue, 15 Jul 2008 11:21:30 +0100
Message-ID: <20080715102130.GA22866@flint.arm.linux.org.uk>
References: <20080715023344.2528.1836.stgit@blender.achiang> <20080715023349.2528.9423.stgit@blender.achiang> <20080715031512.GF14894@parisc-linux.org> <87wsjnxy4w.fsf@basil.nowhere.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:60376 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754806AbYGOK1L (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 15 Jul 2008 06:27:11 -0400
Content-Disposition: inline
In-Reply-To: <87wsjnxy4w.fsf@basil.nowhere.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andi Kleen <andi@firstfloor.org>
Cc: Matthew Wilcox <matthew@wil.cx>, Alex Chiang <achiang@hp.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org

On Tue, Jul 15, 2008 at 12:03:27PM +0200, Andi Kleen wrote:
> Matthew Wilcox <matthew@wil.cx> writes:
> >
> > I don't understand why we want to know about these CPUs.  Surely they
> > should be 'possible', but not 'present'?  What useful thing can Linux do
> > with them?
> 
> He explained it in the intro, near the end (I nearly complained about
> this too when I hadn't finished reading it completely :):
> 
> |The big picture implication is that we can allow userspace
> |to interact with disabled CPUs. In this particular example,
> |we provide a knob that lets a sysadmin schedule any present
> |CPU for firmware deconfiguration or enablement.
> 
> The reason sounds pretty exotic, but ok.

I don't see why this needs to be cross architecture then - shouldn't
the generic kernel only be concerning itself with things that are
possible, present and/or online?

If you have an interface which allows you to change the machines
configuration in a machine specific way, shouldn't that be something
for that machine to support and forced upon the entire kernel?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
