Return-Path: <manfred@colorfullife.com>
Received: from dbl.q-ag.de ([213.172.117.3]:46282 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264155AbUDGTPv (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 7 Apr 2004 15:15:51 -0400
Message-ID: <40745360.6000709@colorfullife.com>
Date: Wed, 07 Apr 2004 21:15:44 +0200
From: Manfred Spraul <manfred@colorfullife.com>
MIME-Version: 1.0
Subject: Re: posix message queues
References: <20040407120720.6b937deb.akpm@osdl.org>
In-Reply-To: <20040407120720.6b937deb.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Andrew Morton wrote:

>Manfred, if/when this gets merged up the long-suffering arch maintainers
>might appreciate a little test app to exercise the syscalls which must be
>added.  Do you have something suitable at hand?
>  
>
I have a few separate apps, I'll merge them into one app and post it to 
lkml. Probably tomorrow or Friday.

>
>Also, before we go too far the 64-bit guys may like to comment on the
>syscall interface.   For example, this:
>
>struct mq_attr {
>	long	mq_flags;	/* message queue flags			*/
>	long	mq_maxmsg;	/* maximum number of messages		*/
>	long	mq_msgsize;	/* maximum message size			*/
>	long	mq_curmsgs;	/* number of messages currently queued	*/
>	long	__reserved[4];	/* ignored for input, zeroed for output */
>};
>
>looks like it will require emulation for 32-bit apps.  But if we were to
>make these __u32 perhaps that could be avoided?
>  
>
No. The unix spec mandates 'long' for the final C-library api. Using u32 
would mean that glibc would have to add an emulation layer in user space 
for 64-bit archs. In the long run, 64-bit kernels running 64-bit apps 
will be the common case. I don't want to add an emulation layer to the 
common case.

--
    Manfred
