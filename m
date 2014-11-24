Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp15.uk.ibm.com ([195.75.94.111]:34840 "EHLO
	e06smtp15.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860AbaKXVRB (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 24 Nov 2014 16:17:01 -0500
Received: from /spool/local
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <borntraeger@de.ibm.com>;
	Mon, 24 Nov 2014 21:16:59 -0000
Message-ID: <5473A046.2020901@de.ibm.com>
Date: Mon, 24 Nov 2014 22:16:54 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH/RFC 7/7] kernel: Force ACCESS_ONCE to work only on scalar
 types
References: <1416834210-61738-1-git-send-email-borntraeger@de.ibm.com> <1416834210-61738-8-git-send-email-borntraeger@de.ibm.com> <15567.1416835858@warthog.procyon.org.uk> <CAADnVQJQydX9OU_rem+BObR0eWc-jrrwirUYVKH9rnN=Z8LG6A@mail.gmail.com> <CA+55aFxc72VsGTw4yFdeC1Sq65RUjYLKPD1ORnXB2d18WBMzvg@mail.gmail.com> <547381D7.2070404@de.ibm.com>	<12209.1416859494@warthog.procyon.org.uk> <CA+55aFwHJyyo1y=-u=t798PFTeZN796hnwd9-XzEnL=JaqVmDw@mail.gmail.com> <54739AB2.8030002@de.ibm.com> <CA+55aFz2bCbhQP3d1bh48AcWTh9bkoMO07JjmwbApGCanJFEMQ@mail.gmail.com>
In-Reply-To: <CA+55aFz2bCbhQP3d1bh48AcWTh9bkoMO07JjmwbApGCanJFEMQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, linux-mips <linux-mips@linux-mips.org>, linux-x86_64@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Paul McKenney <paulmck@linux.vnet.ibm.com>, Ingo Molnar <mingo@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Message-ID: <20141124211654.1mMa3OqPGyJpk1tRYIw4lUAoinIxKzseonc0VgOI_gs@z>

Am 24.11.2014 um 22:02 schrieb Linus Torvalds:
> On Mon, Nov 24, 2014 at 12:53 PM, Christian Borntraeger
> <borntraeger@de.ibm.com> wrote:
>>
>> That looks like a lot of changes all over ACCESS_ONCE -> ASSIGN_ONCE:
>> git grep "ACCESS_ONCE.*=.*"
>> gives me 200 placea not in Documentation.
> 
> Yeah, that's a bit annoying.
> 
> How about a combination of the two:
> 
>  - accept the fact that right now ACCESS_ONCE() is fairly widespread
> (even for writing)
> 
>  - but also admit that we'd be better off with a nicer interface
> 
> and make the solution be:
> 
>  - make ACCESS_ONCE() only work on scalars, and deprecate it
> 
>  - add new "read_once()" and "write_once()" interfaces that *do* work
> on (appropriately sized) structures and unions, and start migrating
> things over. In particular, start with the ones that can no longer use
> ACCESS_ONCE() because they aren't scalar..
> 
> That second point would make the conversion patches actually easier to
> read. Instead of this:
> 
>  static inline int arch_spin_is_locked(arch_spinlock_t *lock)
>  {
> -       struct __raw_tickets tmp = ACCESS_ONCE(lock->tickets);
> +       arch_spinlock_t tmp = {};
> 
> -       return tmp.tail != tmp.head;
> +       tmp.head_tail =ACCESS_ONCE(lock->head_tail);
> +       return tmp.tickets.tail != tmp.tickets.head;
>  }
> 
> which isn't *complex*, but is also not an obvious conversion, we'd have just
> 
>  static inline int arch_spin_is_locked(arch_spinlock_t *lock)
>  {
> -       struct __raw_tickets tmp = ACCESS_ONCE(lock->tickets);
> -       struct __raw_tickets tmp = read_once(lock->tickets);
> 
>         return tmp.tail != tmp.head;
>  }
> 
> which is a much simpler and more obvious change.
> 
> And then we could slowly try to migrate existing ACCESS_ONCE() users
> over (particularly writers).
> 
> Hmm? Too much?

I will give it a try. I will start with Alexei's version for ACCESS_ONCE and your snippets to build read_once and write_once. The only open question is, what to do with the "too large" accesses. Pauls initial patch showed several 
places, e.g. kernel/sched/fair.c accessing an u64 even on 32bit:
[...]
   age_stamp = ACCESS_ONCE(rq->age_stamp);
        avg = ACCESS_ONCE(rq->rt_avg);
[...]

I think I will simply not touch those...



Christian

