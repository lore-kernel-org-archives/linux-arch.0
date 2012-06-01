From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 01/27] smpboot: Provide a generic method to boot
	secondary processors
Date: Fri, 1 Jun 2012 18:51:13 +0200
Message-ID: <20120601165113.GA18870@merkur.ravnborg.org>
References: <20120601090952.31979.24799.stgit@srivatsabhat.in.ibm.com> <20120601091008.31979.93586.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.snhosting.dk ([87.238.248.203]:42796 "EHLO
	smtp.domainteam.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965469Ab2FAQvQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 1 Jun 2012 12:51:16 -0400
Content-Disposition: inline
In-Reply-To: <20120601091008.31979.93586.stgit@srivatsabhat.in.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: tglx@linutronix.de, peterz@infradead.org, paulmck@linux.vnet.ibm.com, rusty@rustcorp.com.au, mingo@kernel.org, yong.zhang0@gmail.com, akpm@linux-foundation.org, vatsa@linux.vnet.ibm.com, rjw@sisk.pl, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, nikunj@linux.vnet.ibm.com, Suresh Siddha <suresh.b.siddha@intel.com>, Venkatesh Pallipadi <venki@google.com>

> +/* Implement the following functions in your architecture, as appropriate. */
> +
> +/**
> + * __cpu_pre_starting()
> + *
> + * Implement whatever you need to do before the CPU_STARTING notifiers are
> + * invoked. Note that the CPU_STARTING callbacks run *on* the cpu that is
> + * coming up. So that cpu better be prepared! IOW, implement all the early
> + * boot/init code for the cpu here. And do NOT enable interrupts.
> + */
> +#ifndef __cpu_pre_starting
> +void __weak __cpu_pre_starting(void *arg) {}
> +#endif

__What __is __the __purpose __of __all __these __underscaores __used
__as __function __prefix? __It __does __not __help __readability.

Does the nicely worded comment follow kerneldoc style?
I think not as the parameter is not described.

	Sam
