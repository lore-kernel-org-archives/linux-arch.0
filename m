From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch 2/3] spinlock: allow inlined spinlocks
Date: Sun, 16 Aug 2009 22:24:31 +0200
Message-ID: <20090816202431.GA27764@elte.hu>
References: <20090814125801.881618121@de.ibm.com> <20090814125857.181021997@de.ibm.com> <20090816175750.GA5808@osiris.boeblingen.de.ibm.com> <20090816180631.GA23448@elte.hu> <alpine.LFD.2.01.0908161123250.3162@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:44077 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755498AbZHPUYo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 16 Aug 2009 16:24:44 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0908161123250.3162@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, linux-arch@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Horst Hartmann <horsth@linux.vnet.ibm.com>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, Nick Piggin <nickpiggin@yahoo.com.au>


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, 16 Aug 2009, Ingo Molnar wrote:
> > 
> > What's the current situation on s390, precisely which of the 28 lock 
> > functions are a win to be inlined and which ones are a loss? Do you 
> > have a list/table perhaps?
> 
> Let's look at x86 instead. 
> 
> The one I can _guarantee_ is worth inlining is "spin_unlock()", 
> since it just generates a single "incb %m" or whatever. [...]

We do that already for that reason:

/*
 * We inline the unlock functions in the nondebug case:
 */
#if defined(CONFIG_DEBUG_SPINLOCK) || defined(CONFIG_PREEMPT) || \
        !defined(CONFIG_SMP)
# define spin_unlock(lock)              _spin_unlock(lock)
# define read_unlock(lock)              _read_unlock(lock)
# define write_unlock(lock)             _write_unlock(lock)
# define spin_unlock_irq(lock)          _spin_unlock_irq(lock)
# define read_unlock_irq(lock)          _read_unlock_irq(lock)
# define write_unlock_irq(lock)         _write_unlock_irq(lock)

this works fine here:

 ffffffff8103d359 <finish_task_switch>:
 ...
 ffffffff8103d393:	fe 03                	incb   (%rbx)
 ffffffff8103d395:	fb                   	sti    

that's an inlined spin_unlock_irq() in finish_task_switch().

We dont do this if DEBUG_SPINLOCK is defined (which bloats the 
function) or if CONFIG_PREEMPT is defined.

Maybe the latter case could be revised although generally it's not 
worth inlining functions that also touch task-struct / threadinfo.

	Ingo
