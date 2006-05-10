Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:19845 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964857AbWEJVFd (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Wed, 10 May 2006 17:05:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17506.21908.857189.645889@cargo.ozlabs.ibm.com>
Date: Thu, 11 May 2006 07:05:24 +1000
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
In-Reply-To: <20060510.124003.04457042.davem@davemloft.net>
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com>
	<20060510154702.GA28938@twiddle.net>
	<20060510.124003.04457042.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>
Cc: rth@twiddle.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org
List-ID: <linux-arch.vger.kernel.org>

David S. Miller writes:

> From: Richard Henderson <rth@twiddle.net>
> Date: Wed, 10 May 2006 08:47:13 -0700
> 
> > How do you plan to address the compiler optimizing
>  ...
> > Across the schedule, we may have changed cpus, making the cached
> > address invalid.
> 
> Per-cpu variables need to be accessed only with preemption
> disabled.  And the preemption enable/disable operations
> provide a compiler memory barrier.

No, Richard has a point, it's not the value that is the concern, it's
the address, which gcc could assume is still valid after a barrier.
Drat.

Paul.
