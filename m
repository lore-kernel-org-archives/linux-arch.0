Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:42884 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932480Ab2FASEz (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jun 2012 14:04:55 -0400
Date: Fri, 01 Jun 2012 13:56:12 -0400 (EDT)
Message-ID: <20120601.135612.699120609738854050.davem@davemloft.net>
Subject: Re: [PATCH 21/27] sparc32, smpboot: Use generic SMP booting
 infrastructure
From: David Miller <davem@davemloft.net>
In-Reply-To: <20120601091503.31979.52537.stgit@srivatsabhat.in.ibm.com>
References: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com>
	<20120601091503.31979.52537.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: srivatsa.bhat@linux.vnet.ibm.com
Cc: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, yong.zhang0@gmail.com, akpm@linux-foundation.org, vatsa@linux.vnet.ibm.com, rjw@sisk.pl, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, nikunj@linux.vnet.ibm.com, sam@ravnborg.org, vapier@gentoo.org, konrad@gaisler.com, tkhai@yandex.ru, sparclinux@vger.kernel.org
Message-ID: <20120601175612.5PPwuGliQa1nYSQTFQG_xCFteqiPA-0ruI8Cock3DAw@z>

From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Date: Fri, 01 Jun 2012 14:45:09 +0530

>  smp_do_cpu_idle:
> -	call	cpu_idle
>  	 mov	0, %o0

Just like the sparc64 patch, you need to remove the 'mov'
