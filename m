Return-Path: <wli@holomorphy.com>
Received: from holomorphy.com ([207.189.100.168]:19107 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263992AbUDVM2x (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Apr 2004 08:28:53 -0400
Date: Thu, 22 Apr 2004 05:28:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [Patch] SMP call function cleanup
Message-ID: <20040422122818.GR743@holomorphy.com>
References: <1082636511.1332.34.camel@halo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082636511.1332.34.camel@halo>
To: Jan Glauber <glauber@gmx.de>
Cc: linux-arch@vger.kernel.org, schwidefsky@de.ibm.com
List-ID: <linux-arch.vger.kernel.org>

On Thu, Apr 22, 2004 at 02:21:51PM +0200, Jan Glauber wrote:
> I've been looking into the SMP call function stuff on different
> archs and found many different functions...
> In the common code part there are 2 functions:
> smp_call_function()  	// call a function on all CPUs but my own
> on_each_cpu()		// call a function on all CPUs
> Many archs need an additional function to call a function on a 
> specific CPU:
> arch-s390:
> smp_call_function_on()
> arch-alpha:
> smp_call_function_on_cpu()
> arch-ia64:
> smp_call_function_single()
> On i386 there is no smp_call_function_single() so they have a workaround
> with smp_call_function() and testing for smp_processor_id().
> Finally the slab allocator has its own on_each_cpu() function:

Any chance we could get an smp_call_function_cpumask()?


-- wli
