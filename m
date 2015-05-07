From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC 00/15] decouple pagefault_disable() from
 preempt_disable()
Date: Thu, 7 May 2015 08:23:46 +0200
Message-ID: <20150507082346.3e8e045e@thinkpad-w530>
References: <1430934639-2131-1-git-send-email-dahi@linux.vnet.ibm.com>
	<20150506150158.0a927470007e8ea5f3278956@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp16.uk.ibm.com ([195.75.94.112]:44913 "EHLO
	e06smtp16.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569AbbEGGXy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 7 May 2015 02:23:54 -0400
Received: from /spool/local
	by e06smtp16.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <dahi@linux.vnet.ibm.com>;
	Thu, 7 May 2015 07:23:53 +0100
In-Reply-To: <20150506150158.0a927470007e8ea5f3278956@linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, yang.shi@windriver.com, bigeasy@linutronix.de, benh@kernel.crashing.org, paulus@samba.org, heiko.carstens@de.ibm.com, schwidefsky@de.ibm.com, borntraeger@de.ibm.com, mst@redhat.com, tglx@linutronix.de, David.Laight@ACULAB.COM, hughd@google.com, hocko@suse.cz, ralf@linux-mips.org, herbert@gondor.apana.org.au, linux@arm.linux.org.uk, airlied@linux.ie, daniel.vetter@intel.com, linux-mm@kvack.org, linux-arch@vger.kernel.org

> > This series therefore does 2 things:
> > 
> > 
> > 1. Decouple pagefault_disable() from preempt_enable()
> > 
> > ...
> > 
> > 2. Reenable might_sleep() checks for might_fault()
> 
> All seems sensible to me.  pagefault_disabled has to go into the
> task_struct (rather than being per-cpu) because
> pagefault_disabled_inc() doesn't disable preemption, yes?
> 

Right, we can now get scheduled while in pagefault_disable() (if preemption
hasn't been disabled manually). So we have to store it per task/thread not per
cpu.

Actually even the preempt disable counter is only per-cpu for x86 and lives in
thread_info for all other archs (which is also not 100% clean but doesn't
matter at that point).

I had that pagefault disable counter in thread_info before, but that required
messing with asm-offsets of some arch (I had a proper version but this one
feels cleaner).

Thanks for having a look!

David
