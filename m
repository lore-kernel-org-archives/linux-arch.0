From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: Remove execution domain support
Date: Sat, 11 Apr 2015 19:03:15 -0700
Message-ID: <20150412020315.GA16882@roeck-us.net>
References: <1428785283-20501-1-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56459 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbbDLCDW (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 11 Apr 2015 22:03:22 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1Yh7F3-001dHP-Bo
	for linux-arch@vger.kernel.org; Sun, 12 Apr 2015 02:03:21 +0000
Content-Disposition: inline
In-Reply-To: <1428785283-20501-1-git-send-email-richard@nod.at>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Richard Weinberger <richard@nod.at>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com, vgupta@synopsys.com, linux@arm.linux.org.uk, catalin.marinas@arm.com, will.deacon@arm.com, hskinnemoen@gmail.com, egtvedt@samfundet.no, realmz6@gmail.com, msalte@roeck-us.net

On Sat, Apr 11, 2015 at 10:47:39PM +0200, Richard Weinberger wrote:

[ ... ]
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/rw/misc.git exec_domain_rip_v1
> 

Build results:
	total: 121 pass: 121 fail: 0
Qemu test results:
	total: 30 pass: 27 fail: 3
Failed tests:
	sparc32:sparc_defconfig
	sparc32:sparc_smp_defconfig
	xtensa:xtensa_defconfig

Sparc crashes, xtensa hangs.

Details (with logs) ara available at http://server.roeck-us.net:8010/builders,
in the 'testing' column.

Guenter
