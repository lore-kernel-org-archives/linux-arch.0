Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:55529 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119AbbEFWCA (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 6 May 2015 18:02:00 -0400
Date: Wed, 6 May 2015 15:01:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RFC 00/15] decouple pagefault_disable() from
 preempt_disable()
Message-ID: <20150506150158.0a927470007e8ea5f3278956@linux-foundation.org>
In-Reply-To: <1430934639-2131-1-git-send-email-dahi@linux.vnet.ibm.com>
References: <1430934639-2131-1-git-send-email-dahi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, yang.shi@windriver.com, bigeasy@linutronix.de, benh@kernel.crashing.org, paulus@samba.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, tglx@linutronix.de, David.Laight@ACULAB.COM, hughd@google.com, hocko@suse.cz, ralf@linux-mips.org, herbert@gondor.apana.org.au, linux@arm.linux.org.uk, airlied@linux.ie, daniel.vetter@intel.com, linux-mm@kvack.org, linux-arch@vger.kernel.org
Message-ID: <20150506220158.sDavW3NnwliqRzeq3_z5uh21U283K67j9KxiHwaz4OU@z>

On Wed,  6 May 2015 19:50:24 +0200 David Hildenbrand <dahi@linux.vnet.ibm.com> wrote:

> As Peter asked me to also do the decoupling in one shot, this is
> the new series.
> 
> I recently discovered that might_fault() doesn't call might_sleep()
> anymore. Therefore bugs like:
> 
>   spin_lock(&lock);
>   rc = copy_to_user(...);
>   spin_unlock(&lock);
> 
> would not be detected with CONFIG_DEBUG_ATOMIC_SLEEP. The code was
> changed to disable false positives for code like:
> 
>   pagefault_disable();
>   rc = copy_to_user(...);
>   pagefault_enable();
> 
> Whereby the caller wants do deal with failures.

hm, that was a significant screwup.  I wonder how many bugs we
subsequently added.

>
> ..
>

> This series therefore does 2 things:
> 
> 
> 1. Decouple pagefault_disable() from preempt_enable()
> 
> ...
> 
> 2. Reenable might_sleep() checks for might_fault()

All seems sensible to me.  pagefault_disabled has to go into the
task_struct (rather than being per-cpu) because
pagefault_disabled_inc() doesn't disable preemption, yes?

