Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:34710 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750825AbWCICis (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 8 Mar 2006 21:38:48 -0500
Message-ID: <440F952E.90808@yahoo.com.au>
Date: Thu, 09 Mar 2006 13:38:38 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
MIME-Version: 1.0
Subject: Re: [PATCH] Document Linux's memory barriers [try #2]
References: <Pine.LNX.4.64.0603081115300.32577@g5.osdl.org> <20060308184500.GA17716@devserv.devel.redhat.com> <20060308173605.GB13063@devserv.devel.redhat.com> <20060308145506.GA5095@devserv.devel.redhat.com> <31492.1141753245@warthog.cambridge.redhat.com> <29826.1141828678@warthog.cambridge.redhat.com> <9834.1141837491@warthog.cambridge.redhat.com> <11922.1141842907@warthog.cambridge.redhat.com> <14275.1141844922@warthog.cambridge.redhat.com> <19984.1141846302@warthog.cambridge.redhat.com> <17423.30789.214209.462657@cargo.ozlabs.ibm.com> <Pine.LNX.4.64.0603081652430.32577@g5.osdl.org> <17423.32792.500628.226831@cargo.ozlabs.ibm.com> <Pine.LNX.4.64.0603081716400.32577@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603081716400.32577@g5.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, akpm@osdl.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, Alan Cox <alan@redhat.com>, linuxppc64-dev@ozlabs.org
List-ID: <linux-arch.vger.kernel.org>

Linus Torvalds wrote:

>
>On Thu, 9 Mar 2006, Paul Mackerras wrote:
>
>>... and x86 mmiowb is a no-op.  It's not x86 that I think is buggy.
>>
>
>x86 mmiowb would have to be a real op too if there were any multi-pathed 
>PCI buses out there for x86, methinks.
>
>Basically, the issue boils down to one thing: no "normal" barrier will 
>_ever_ show up on the bus on x86 (ie ia64, afaik). That, together with any 
>situation where there are multiple paths to one physical device means that 
>mmiowb() _has_ to be a special op, and no spinlocks etc will _ever_ do the 
>serialization you look for.
>
>Put another way: the only way to avoid mmiowb() being special is either 
>one of:
> (a) have the bus fabric itself be synchronizing
> (b) pay a huge expense on the much more critical _regular_ barriers
>
>Now, I claim that (b) is just broken. I'd rather take the hit when I need 
>to, than every time. 
>

I'm not very driver-minded; would it make sense to have io versions of
locks, which can provide critical sections for IO operations?

The number of (uncommented) memory barriers sprinkled around drivers
looks pretty scary...

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
