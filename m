From: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC patch 04/15] get_cycles() : powerpc64 HAVE_GET_CYCLES
Date: Fri, 17 Oct 2008 11:26:23 +1100
Message-ID: <18679.56239.74999.534588@cargo.ozlabs.ibm.com>
References: <20081016232729.699004293@polymtl.ca>
	<20081016234656.055839676@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:52798 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751511AbYJQA06 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Oct 2008 20:26:58 -0400
In-Reply-To: <20081016234656.055839676@polymtl.ca>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Thomas Gleixner <tglx@linutronix.de>, David Miller <davem@davemloft.net>, benh@kernel.crashing.org, Ingo Molnar <mingo@redhat.com>

Mathieu Desnoyers writes:

> This patch selects HAVE_GET_CYCLES and makes sure get_cycles_barrier() and
> get_cycles_rate() are implemented.

[snip]

> +static inline cycles_t get_cycles_rate(void)
> +{
> +	return CLOCK_TICK_RATE;
> +}

CLOCK_TICK_RATE is certainly wrong.  You want ppc_tb_freq (declared in
asm/time.h).  Or tb_ticks_per_sec, since we seem to have two variables
for exactly the same thing, for some reason. :)

Paul.
