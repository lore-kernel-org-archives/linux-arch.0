From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: start_kernel(): bug: interrupts were enabled early
Date: Wed, 31 Mar 2010 14:05:00 -0700
Message-ID: <4BB3B8FC.1020608@zytor.com>
References: <20100325194100.GA2364@debian> <20100331134048.da4e35a7.akpm@linux-foundation.org> <4BB3B4DB.7040904@kernel.org> <20100331210145.GB32165@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:33646 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758173Ab0CaVKH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 31 Mar 2010 17:10:07 -0400
In-Reply-To: <20100331210145.GB32165@parisc-linux.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Yinghai Lu <yinghai@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Rabin Vincent <rabin@rab.in>, lkml <linux-kernel@vger.kernel.org>, penberg@cs.helsinki.fi, cl@linux-foundation.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-arch@vger.kernel.org

On 03/31/2010 02:01 PM, Matthew Wilcox wrote:
> On Wed, Mar 31, 2010 at 01:47:23PM -0700, Yinghai Lu wrote:
>>>>> This appears to be caused by:
>>>>>
>>>>>   start_kernel -> radix_tree_init -> kmem_cache_create (slub) ->
>>>>>    down_write -> __down_write (lib/rwsem-spinlock.c) -> spin_unlock_irq
>>>>>
>>> That's going to be hard to fix.
>>>
>> spin_unlock_irq from arm is different from other archs?
> 
> Not all arches use lib/rwsem-spinlock.c.  In particular, x86 doesn't
> when X86_XADD is set.
> 

What I note is that lib/rwsem-spinlock.c seems to be rather inconsistent
in its use of spin_lock_irqsave/spin_lock_irqrestore versus
spin_lock_irq/spin_unlock_irq... in fact, __down_read is the *only*
place where we use the latter as opposed to the former.

Is that a bug?  If so, it would certainly explain this behavior.

	-hpa
