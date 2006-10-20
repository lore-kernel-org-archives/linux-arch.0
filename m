Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:6337
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1030357AbWJTVGT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 20 Oct 2006 17:06:19 -0400
Date: Fri, 20 Oct 2006 14:06:19 -0700 (PDT)
Message-Id: <20061020.140619.11628819.davem@davemloft.net>
Subject: Re: [PATCH 1/3] Fix COW D-cache aliasing on fork
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061020205929.GE8894@flint.arm.linux.org.uk>
References: <20061020.125851.115909797.davem@davemloft.net>
	<Pine.LNX.4.64.0610201302090.3962@g5.osdl.org>
	<20061020205929.GE8894@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: rmk+lkml@arm.linux.org.uk
Cc: torvalds@osdl.org, nickpiggin@yahoo.com.au, ralf@linux-mips.org, akpm@osdl.org, linux-kernel@vger.kernel.org, anemo@mba.ocn.ne.jp, linux-arch@vger.kernel.org, schwidefsky@de.ibm.com
List-ID: <linux-arch.vger.kernel.org>

From: Russell King <rmk+lkml@arm.linux.org.uk>
Date: Fri, 20 Oct 2006 21:59:29 +0100

> However, when I look at this code now, I see _no where_ where we synchronise
> the cache between the userspace mapping and the kernel space mapping before
> copying a COW page.

When the user obtains write access to the page, we'll flush.

Since there are many locations at which write access can be
obtained, there are many locations where the synchronization
is obtained.

One popular way to obtain the synchronization is to implement
flush_dcache_page() to flush, and implement clear_page() and
copy_user_page() to clear and copy pages in kernel space at
special temporrary mappings whose virtual address will alias
up properly with userspace's mapping.  That's why we pass a
virtual address to these two arch functions.
