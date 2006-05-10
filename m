Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:13218
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751229AbWEJTkn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 May 2006 15:40:43 -0400
Date: Wed, 10 May 2006 12:40:03 -0700 (PDT)
Message-Id: <20060510.124003.04457042.davem@davemloft.net>
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060510154702.GA28938@twiddle.net>
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com>
	<20060510154702.GA28938@twiddle.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: rth@twiddle.net
Cc: paulus@samba.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org
List-ID: <linux-arch.vger.kernel.org>

From: Richard Henderson <rth@twiddle.net>
Date: Wed, 10 May 2006 08:47:13 -0700

> How do you plan to address the compiler optimizing
 ...
> Across the schedule, we may have changed cpus, making the cached
> address invalid.

Per-cpu variables need to be accessed only with preemption
disabled.  And the preemption enable/disable operations
provide a compiler memory barrier.

#define preempt_disable() \
do { \
	inc_preempt_count(); \
	barrier(); \
} while (0)

 ...

#define preempt_enable() \
do { \
	preempt_enable_no_resched(); \
	barrier(); \
	preempt_check_resched(); \
} while (0)

The scheduler itself need to take care to not cause the situation
you mention either.

Therefore this is an issue we had already, not some new thing
introduced by using __thread for per-cpu variables.
