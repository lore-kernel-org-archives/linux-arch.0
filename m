Return-Path: <wli@holomorphy.com>
Received: from holomorphy.com ([207.189.100.168]:28579 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264012AbUDVMt6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Apr 2004 08:49:58 -0400
Date: Thu, 22 Apr 2004 05:49:24 -0700
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [Patch] SMP call function cleanup
Message-ID: <20040422124924.GS743@holomorphy.com>
References: <1082636511.1332.34.camel@halo> <20040422122818.GR743@holomorphy.com> <20040422123703.GY22027@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040422123703.GY22027@krispykreme>
To: Anton Blanchard <anton@samba.org>
Cc: Jan Glauber <glauber@gmx.de>, linux-arch@vger.kernel.org, schwidefsky@de.ibm.com
List-ID: <linux-arch.vger.kernel.org>

At some point in the past, I wrote:
>> Any chance we could get an smp_call_function_cpumask()?

On Thu, Apr 22, 2004 at 10:37:03PM +1000, Anton Blanchard wrote:
> Unless there is a need Id prefer not to. Some arches do not support IPI
> to a cpumask, whereas they should do send to all and send to single.

I remember someone making noise about a need and don't remember the
context. I'll just let them take it up when the patches go out. I
actually presumed it wouldn't be natively supported, but rather be a
helper function for more general usage cases, esp. ones where > 1 cpu
is needed, but not all, and hitting every cpu on the system is greatly
more expensive than hitting only the desired cpus, which is about all
I remember of the noise that was made.


-- wli
