From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 20/27] sparc64, smpboot: Use generic SMP booting
 infrastructure
Date: Fri, 01 Jun 2012 13:55:22 -0400 (EDT)
Message-ID: <20120601.135522.2065505829159749961.davem@davemloft.net>
References: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com>
	<20120601091449.31979.67743.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:42878 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932394Ab2FASEz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jun 2012 14:04:55 -0400
In-Reply-To: <20120601091449.31979.67743.stgit@srivatsabhat.in.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: srivatsa.bhat@linux.vnet.ibm.com
Cc: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, yong.zhang0@gmail.com, akpm@linux-foundation.org, vatsa@linux.vnet.ibm.com, rjw@sisk.pl, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, nikunj@linux.vnet.ibm.com, paul.gortmaker@windriver.com, vapier@gentoo.org, jkosina@suse.cz, sparclinux@vger.kernel.org

From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Date: Fri, 01 Jun 2012 14:44:54 +0530

> -	call		cpu_idle
>  	 mov		0, %o0
 ...
> -	call		cpu_idle
>  	 mov		0, %o0


The 'mov' has to be removed too, it's in the delay slot of the
call instruction and is passing in the first argument.
