Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S262820AbUKXSqO@vger.kernel.org>
Received: from zeus.kernel.org ([204.152.189.113]:26849 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262789AbUKXSnu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 24 Nov 2004 13:43:50 -0500
Received: from Cantor.suse.de (cantor.suse.de [195.135.220.2])
	by zeus.kernel.org (8.12.11/8.11.6) with ESMTP id iAOFij9A018576
	for <linux-arch@vger.kernel.org>; Wed, 24 Nov 2004 07:44:52 -0800
Date: Wed, 24 Nov 2004 16:43:19 +0100
From: Andi Kleen <ak@suse.de>
Subject: Re: [patch] sys_stime needs a compat function.
Message-ID: <20041124154319.GC2729@wotan.suse.de>
References: <20041124154033.GA4832@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041124154033.GA4832@mschwid3.boeblingen.de.ibm.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: arnd@arndb.de, linux-arch@vger.kernel.org, tony.luck@intel.com, ak@suse.de, ralf@linux-mips.org, matthew@wil.cx, anton@samba.org, davem@davemloft.net, jdike@addtoit.com, davidm@hpl.hp.com
List-ID: <linux-arch.vger.kernel.org>

> x86_64   : Remove sys32_time. Use compat_sys_time and compat_sys_stime
>            in 32 bit syscall table.
> 
> The original stime bug is fixed for mips, parisc, s390, sparc64 and
> x86_64. Can the arch-maintainers please take a look at this?

Looks good from my side.

Thanks,
-Andi
