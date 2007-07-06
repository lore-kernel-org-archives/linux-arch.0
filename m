Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:55582 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758311AbXGFS1m (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 6 Jul 2007 14:27:42 -0400
Date: Fri, 6 Jul 2007 19:26:12 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: + print-utsname-on-oops-on-all-architectures.patch added to -mm tree
Message-ID: <20070706182612.GA26179@flint.arm.linux.org.uk>
References: <200707061754.l66HsXfb010994@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200707061754.l66HsXfb010994@imap1.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: mm-commits@vger.kernel.org, jwise@google.com, ak@suse.de, benh@kernel.crashing.org, ink@jurassic.park.msu.ru, linux-arch@vger.kernel.org, paulus@samba.org, rth@twiddle.net
List-ID: <linux-arch.vger.kernel.org>

On Fri, Jul 06, 2007 at 10:54:33AM -0700, akpm@linux-foundation.org wrote:
> Potential impact:
>  This adds another line to the Oops output, causing the first few lines to
>  potentially scroll off the screen. This also adds a few more pointer
>  dereferences in the Oops path, because it adds to the die_chain notifier
>  chain, reducing the likelihood that the Oops will be printed if there is
>  very bad memory corruption.

Plus we don't get the utsname information on oops dumps during the kernel
initialisation.  Not good - I'd rather keep things as is rather than loose
that facility which we've just gained on ARM.

Instead, can we have this as a call-able function which returns the
pointer, or just make the pointer global.  That way we can also eliminate
the need for another additional line in the oops output.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
