Return-Path: <nickpiggin@yahoo.com.au>
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:51609 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261879AbUE3HAe (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 30 May 2004 03:00:34 -0400
Message-ID: <40B9868C.4010302@yahoo.com.au>
Date: Sun, 30 May 2004 17:00:28 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: [RFC][PATCH] Consolidate architecture context switch locking
References: <40B94D79.8090903@yahoo.com.au> <20040529232802.24a367c7.davem@redhat.com>
In-Reply-To: <20040529232802.24a367c7.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@redhat.com>
Cc: linux-arch@vger.kernel.org, mingo@redhat.com
List-ID: <linux-arch.vger.kernel.org>

David S. Miller wrote:
> On Sun, 30 May 2004 12:56:57 +1000
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>Those that do need to define TIF_RUNNING, which I haven't done
>>in the patch.
> 
> 
> How come we can't use a spinlock like the existing instances
> did?  A spinlock should be cheaper than a SMP atomic bitop
> on at least some such platforms.  It is on sparc at least.
> 

It could just as easily use the switch_lock system, yes.

AFAIKS it could even use a plain "int" as the flag...
