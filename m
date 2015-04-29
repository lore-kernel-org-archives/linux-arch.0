Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:37638 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbbD2S1T (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 29 Apr 2015 14:27:19 -0400
MIME-Version: 1.0
In-Reply-To: <20150429181112.GI23123@twins.programming.kicks-ass.net>
References: <1429901803-29771-1-git-send-email-Waiman.Long@hp.com>
	<1429901803-29771-14-git-send-email-Waiman.Long@hp.com>
	<20150429181112.GI23123@twins.programming.kicks-ass.net>
Date: Wed, 29 Apr 2015 11:27:14 -0700
Message-ID: <CA+55aFzK4cC55MVu6D9gpvyyRBh5tzxkoS_o=3e4aChtXMpgpg@mail.gmail.com>
Subject: Re: [PATCH v16 13/14] pvqspinlock: Improve slowpath performance by
 avoiding cmpxchg
From: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman Long <Waiman.Long@hp.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, xen-devel@lists.xenproject.org, KVM list <kvm@vger.kernel.org>, Paolo Bonzini <paolo.bonzini@gmail.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, Daniel J Blueman <daniel@numascale.com>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>
Message-ID: <20150429182714.lNTCv4DPJZ4JtbWE90TiLuGcPv2Gsh1x6Nvc7EPudq8@z>

On Wed, Apr 29, 2015 at 11:11 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Fri, Apr 24, 2015 at 02:56:42PM -0400, Waiman Long wrote:
>> In the pv_scan_next() function, the slow cmpxchg atomic operation is
>> performed even if the other CPU is not even close to being halted. This
>> extra cmpxchg can harm slowpath performance.
>>
>> This patch introduces the new mayhalt flag to indicate if the other
>> spinning CPU is close to being halted or not. The current threshold
>> for x86 is 2k cpu_relax() calls. If this flag is not set, the other
>> spinning CPU will have at least 2k more cpu_relax() calls before
>> it can enter the halt state. This should give enough time for the
>> setting of the locked flag in struct mcs_spinlock to propagate to
>> that CPU without using atomic op.
>
> Yuck! I'm not at all sure you can make assumptions like that. And the
> worst part is, if it goes wrong the borkage is subtle and painful.\

I have to agree with Peter.

But it goes beyond this particular patch. Patterns like this:

       xchg(&pn->mayhalt, true);

are just evil and disgusting. Even befoe this patch, that code had

                (void)xchg(&pn->state, vcpu_halted);

which is *wrong* and should never be done.

If you want it to be "set_mb()" (which sets a value and has a memory
barrier), then use set_mb(). Yes, it happens to use a "xchg()" to do
so, but dammit, it documents that whole "this is a memory barrier" in
the name.

Also, anybody who does this should damn well document why the memory
barrier is needed. The xchg(&pn->state, vcpu_halted) at least is
preceded by a comment about the barriers. The new mayhalt has no sane
comment in it, and the reason seems to be that no sane comment is
possible. The xchg() seems to be some black magic thing.

Let's not introduce magic stuff in our locking primitives. At least
not undocumented magic that makes no sense.

                               Linus
