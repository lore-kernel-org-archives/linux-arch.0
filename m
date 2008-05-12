From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: Remove last reminants of dyntick support
Date: Mon, 12 May 2008 17:31:29 +0100
Message-ID: <20080512163129.GA25110@flint.arm.linux.org.uk>
References: <git-1210542959-a5b32acc9d50dd3c819c2dc5d43bd416f24aa8fd@dyn-67.arm.linux.org.uk> <git-1210542959-a11b6c9b49632402270784b9d516213aad96da7e@dyn-67.arm.linux.org.uk> <20080511221719.GO1645@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37661 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330AbYELQbr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 12 May 2008 12:31:47 -0400
Content-Disposition: inline
In-Reply-To: <20080511221719.GO1645@cs181133002.pp.htv.fi>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Adrian Bunk <bunk@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org, LAK <linux-arm-kernel@lists.arm.linux.org.uk>

On Mon, May 12, 2008 at 01:17:19AM +0300, Adrian Bunk wrote:
> On Sun, May 11, 2008 at 10:56:00PM +0100, Russell King wrote:
> > From: Russell King <rmk@dyn-67.arm.linux.org.uk>
> > 
> > Neither S390 nor SH have the configuration option for NO_IDLE_HZ
> > in their Kconfig files, yet their defconfig files lists them.
> > Remove those references.
> >...
> 
> I'm not a fan of touching defconfig files this way - this easily leads 
> to patch conflicts without any real advantage.

That only becomes a problem if the defconfigs are regularly touched.
If we do find that there's conflicts, I'll drop them.

Actually, I'll move them into separate commits now, so if a conflict
occurs it's just a case of removing the offending commit.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
