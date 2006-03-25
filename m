Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49933 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751097AbWCYVjD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sat, 25 Mar 2006 16:39:03 -0500
Date: Sat, 25 Mar 2006 21:38:45 +0000
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [patch 1/1] remove fixup_cpu_present_map()
Message-ID: <20060325213845.GB25788@flint.arm.linux.org.uk>
References: <200603252027.k2PKRkpP011257@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603252027.k2PKRkpP011257@shell0.pdx.osdl.net>
Sender: linux-arch-owner@vger.kernel.org
To: akpm@osdl.org
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sat, Mar 25, 2006 at 12:24:11PM -0800, akpm@osdl.org wrote:
> A consequence of this (actually of the boot_cpu_init() change) is that the
> architecture _must_ populate cpu_present_map itself (probably in
> smp_prepare_cpus()).  fixup_cpu_present_map() won't do it any more.

The other side effect (though less serious) is that smp_prepare_boot_cpu()
no longer needs to mark the boot cpu in the online and present maps - 
boot_cpu_init() does that for everyone.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
