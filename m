Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:56913 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751953AbWCJF26 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 10 Mar 2006 00:28:58 -0500
Message-ID: <44110E93.8060504@yahoo.com.au>
Date: Fri, 10 Mar 2006 16:28:51 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: [PATCH] Document Linux's memory barriers [try #4]
References: <16835.1141936162@warthog.cambridge.redhat.com>
In-Reply-To: <16835.1141936162@warthog.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, mingo@redhat.com, alan@redhat.com, linux-arch@vger.kernel.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

David Howells wrote:

> +==========================
> +WHAT IS CONSIDERED MEMORY?
> +==========================
> +
> +For the purpose of this specification what's meant by "memory" needs to be
> +defined, and the division between CPU and memory needs to be marked out.
> +
> +
> +CACHED INTERACTIONS
> +-------------------
> +
> +As far as cached CPU vs CPU[*] interactions go, "memory" has to include the CPU
> +caches in the system.  Although any particular read or write may not actually
> +appear outside of the CPU that issued it (the CPU may may have been able to
> +satisfy it from its own cache), it's still as if the memory access had taken
> +place as far as the other CPUs are concerned since the cache coherency and
> +ejection mechanisms will propegate the effects upon conflict.
> +

Isn't the Alpha's split caches a counter-example of your model,
because the coherency itself is out of order?

Why do you need to include caches and queues in your model? Do
programmers care? Isn't the following sufficient...

          :    | m |
    CPU -----> | e |
          :    | m |
          :    | o |
    CPU -----> | r |
          :    | y |

... and bugger the implementation details?

> + [*] Also applies to CPU vs device when accessed through a cache.
> +
> +The system can be considered logically as:
> +
> +	    <--- CPU --->         :       <----------- Memory ----------->
> +	                          :
> +	+--------+    +--------+  :   +--------+    +-----------+
> +	|        |    |        |  :   |        |    |           |    +---------+
> +	|  CPU   |    | Memory |  :   | CPU    |    |           |    |	       |
> +	|  Core  |--->| Access |----->| Cache  |<-->|           |    |	       |
> +	|        |    | Queue  |  :   |        |    |           |--->| Memory  |
> +	|        |    |        |  :   |        |    |           |    |	       |
> +	+--------+    +--------+  :   +--------+    |           |    | 	       |
> +	                          :                 | Cache     |    +---------+
> +	                          :                 | Coherency |
> +	                          :                 | Mechanism |    +---------+
> +	+--------+    +--------+  :   +--------+    |           |    |	       |
> +	|        |    |        |  :   |        |    |           |    |         |
> +	|  CPU   |    | Memory |  :   | CPU    |    |           |--->| Device  |
> +	|  Core  |--->| Access |----->| Cache  |<-->|           |    | 	       |
> +	|        |    | Queue  |  :   |        |    |           |    | 	       |
> +	|        |    |        |  :   |        |    |           |    +---------+
> +	+--------+    +--------+  :   +--------+    +-----------+
> +	                          :
> +	                          :
> +

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
