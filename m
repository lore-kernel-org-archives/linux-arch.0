Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:34516 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751143AbWCYVvP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sat, 25 Mar 2006 16:51:15 -0500
Date: Sat, 25 Mar 2006 13:47:29 -0800
From: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 1/1] remove fixup_cpu_present_map()
Message-Id: <20060325134729.3db82a6c.akpm@osdl.org>
In-Reply-To: <20060325213845.GB25788@flint.arm.linux.org.uk>
References: <200603252027.k2PKRkpP011257@shell0.pdx.osdl.net>
	<20060325213845.GB25788@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Russell King <rmk@arm.linux.org.uk> wrote:
>
> On Sat, Mar 25, 2006 at 12:24:11PM -0800, akpm@osdl.org wrote:
> > A consequence of this (actually of the boot_cpu_init() change) is that the
> > architecture _must_ populate cpu_present_map itself (probably in
> > smp_prepare_cpus()).  fixup_cpu_present_map() won't do it any more.
> 
> The other side effect (though less serious) is that smp_prepare_boot_cpu()
> no longer needs to mark the boot cpu in the online and present maps - 
> boot_cpu_init() does that for everyone.

Yup, thanks.

btw, we did that marking of the boot cpu in boot_cpu_init() to make printk
work early in boot.  ia64 needed this, in printk():

	if (!cpu_online(smp_processor_id())) {
		/*
		 * Some console drivers may assume that per-cpu resources have
		 * been allocated.  So don't allow them to be called by this
		 * CPU until it is officially up.  We shouldn't be calling into
		 * random console drivers on a CPU which doesn't exist yet..
		 */
		printk_cpu = UINT_MAX;
		spin_unlock_irqrestore(&logbuf_lock, flags);
		goto out;
	}

So really it's only necessary to mark the boot cpu in cpu_online_map.  But
that's supposed to be a subset of present_map, which is a subset of
possible_map.

