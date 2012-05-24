From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/3] sparc: Increase portability of strncpy_from_user()
 implementation.
Date: Thu, 24 May 2012 16:04:36 -0400 (EDT)
Message-ID: <20120524.160436.1964884992253662536.davem@davemloft.net>
References: <20120523.233430.1084831063018998232.davem@davemloft.net>
	<CA+55aFw8jsrqipdKq9-EiA5a+Y-HKMQmpBsirs9ojfk1yUSxww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:42514 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933776Ab2EXUEi (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 24 May 2012 16:04:38 -0400
In-Reply-To: <CA+55aFw8jsrqipdKq9-EiA5a+Y-HKMQmpBsirs9ojfk1yUSxww@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-arch@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 24 May 2012 09:04:27 -0700

> Btw, this would have been much cleaner with something like
> 
>    #ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>       #define IS_UNALIGNED(src,dst) 0
>    #else
>       #define IS_UNALIGNED(src,dst) (((long)(src) | (long)(dst)) &
> (sizeof(long) - 1))
>    #endif
> 
> and then just
> 
>      if (IS_UNALIGNED(src,dst))
>         goto byte_at_a_time;

Ok, I'll make this adjustment.
