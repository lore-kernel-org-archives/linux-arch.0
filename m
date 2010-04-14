From: David VomLehn <dvomlehn@cisco.com>
Subject: Re: [PATCH 1/23] Make register values available to panic notifiers
Date: Wed, 14 Apr 2010 17:04:39 -0400
Message-ID: <4BC62DE7.20603@cisco.com>
References: <20100412122745.GC28208@flint.arm.linux.org.uk> <20100412060609.GA25273@dvomlehn-lnx2.corp.sa.net> <25356.1271076327@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from sj-iport-4.cisco.com ([171.68.10.86]:26086 "EHLO
	sj-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756759Ab0DNVEl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 14 Apr 2010 17:04:41 -0400
In-Reply-To: <25356.1271076327@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-arch@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org

David Howells wrote:
> Russell King <rmk@arm.linux.org.uk> wrote:
>
>   
>> Can you explain why you want this?
>>
>> I'm wondering about the value of saving the registers; normally when a panic
>> occurs, it's because of a well defined reason, and not because something
>> went wrong in some CPU register; to put it another way, a panic() is a
>> more controlled exception than a BUG() or a bad pointer dereference.
>>     
>
> +1.
>
> I found in FS-Cache and CacheFiles that often the things I most wanted to know
> when I had something of the form:
>
> 	if (A == B)
> 		BUG();
>
> was a and b, so I made the following macro:
>
> 	#define ASSERTCMP(X, OP, Y)					\
> 	do {								\
> 		if (unlikely(!((X) OP (Y)))) {				\
> 			printk(KERN_ERR "\n");				\
> 			printk(KERN_ERR "AFS: Assertion failed\n");	\
> 			printk(KERN_ERR "%lu " #OP " %lu is false\n",	\
> 			       (unsigned long)(X), (unsigned long)(Y));	\
> 			printk(KERN_ERR "0x%lx " #OP " 0x%lx is false\n", \
> 			       (unsigned long)(X), (unsigned long)(Y));	\
> 			BUG();						\
> 		}							\
> 	} while(0)
>
> which I could then call like this:
>
> 	ASSERTCMP(A, ==, B);
>
> and if the assertion failed, it prints A and B explicitly.  This is much
> easier than trying to pick the values out of a register dump, especially as
> the compiler may be free to clobber A or B immediately after testing them.
>   
This is great if you'r in a development environment, and can focus on a 
single, well
characterized case. Unfortunately, I'm staring at hundreds of thousands 
of systems
in the field, all which which have a large number of panic() statements 
for which this
approach has not been taken. So, I have no alternative but to pick the 
value out of
a register dump.
> David
>   
