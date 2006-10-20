Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:50446 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S2992725AbWJTV2U (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Oct 2006 17:28:20 -0400
Date: Fri, 20 Oct 2006 22:28:05 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
Message-ID: <20061020212805.GG8894@flint.arm.linux.org.uk>
References: <Pine.LNX.4.64.0610200846260.3962@g5.osdl.org> <20061020.123635.95058911.davem@davemloft.net> <Pine.LNX.4.64.0610201251440.3962@g5.osdl.org> <20061020.125851.115909797.davem@davemloft.net> <Pine.LNX.4.64.0610201302090.3962@g5.osdl.org> <20061020205929.GE8894@flint.arm.linux.org.uk> <Pine.LNX.4.64.0610201408070.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610201408070.3962@g5.osdl.org>
Sender: linux-arch-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au, ralf@linux-mips.org, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, anemo@mba.ocn.ne.jp, linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-arch.vger.kernel.org>

On Fri, Oct 20, 2006 at 02:12:11PM -0700, Linus Torvalds wrote:
> On Fri, 20 Oct 2006, Russell King wrote:
> > Well, looking at do_wp_page() I'm now quite concerned about ARM and COW.
> > I can't see how this code could _possibly_ work with a virtually indexed
> > cache as it stands.  Yet, the kernel does appear to work.
> 
> It really shouldn't need any extra code, exactly because by the time it 
> hits any page-fault, the caches had better be in sync with the physical 
> page contents _anyway_ (yes, being virtual, the caches will _duplicate_ 
> the contents, but since the pages are read-only, that aliasing should be 
> perfectly fine).

Oh, of course!  That explains why it actually works as expected!  Thanks
for filling back in that bit of swapped-out-years-ago-and-lost information.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
