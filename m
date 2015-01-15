Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54727 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752699AbbAOUCY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 15 Jan 2015 15:02:24 -0500
Date: Thu, 15 Jan 2015 21:01:19 +0100
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 4/8] x86/spinlock: Leftover conversion
	ACCESS_ONCE->READ_ONCE
Message-ID: <20150115200119.GA29684@redhat.com>
References: <1421312314-72330-1-git-send-email-borntraeger@de.ibm.com> <1421312314-72330-5-git-send-email-borntraeger@de.ibm.com> <20150115193839.GA28727@redhat.com> <54B81A37.80109@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54B81A37.80109@de.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, xen-devel@lists.xenproject.org, linux-mm@kvack.org
Message-ID: <20150115200119.i2HgqEzQbyleEcVDIwakVTW8y_umwFD96U6N3gE0Rjw@z>

On 01/15, Christian Borntraeger wrote:
>
> Am 15.01.2015 um 20:38 schrieb Oleg Nesterov:
> > On 01/15, Christian Borntraeger wrote:
> >>
> >> --- a/arch/x86/include/asm/spinlock.h
> >> +++ b/arch/x86/include/asm/spinlock.h
> >> @@ -186,7 +186,7 @@ static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
> >>  	__ticket_t head = ACCESS_ONCE(lock->tickets.head);
> >>
> >>  	for (;;) {
> >> -		struct __raw_tickets tmp = ACCESS_ONCE(lock->tickets);
> >> +		struct __raw_tickets tmp = READ_ONCE(lock->tickets);
> >
> > Agreed, but what about another ACCESS_ONCE() above?
> >
> > Oleg.
>
> tickets.head is a scalar type, so ACCESS_ONCE does work fine with gcc 4.6/4.7.
> My goal was to convert all accesses on non-scalar types

I understand, but READ_ONCE(lock->tickets.head) looks better anyway and
arch_spin_lock() already use READ_ONCE() for this.

So why we should keep the last ACCESS_ONCE() in spinlock.h ? Just to make
another cosmetic cleanup which touches the same function later?

Oleg.

