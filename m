Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:43390 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbbEDOGU (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 4 May 2015 10:06:20 -0400
Date: Mon, 4 May 2015 16:05:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v16 13/14] pvqspinlock: Improve slowpath performance by
 avoiding cmpxchg
Message-ID: <20150504140551.GJ23123@twins.programming.kicks-ass.net>
References: <1429901803-29771-1-git-send-email-Waiman.Long@hp.com>
 <1429901803-29771-14-git-send-email-Waiman.Long@hp.com>
 <20150429181112.GI23123@twins.programming.kicks-ass.net>
 <55427936.4080900@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55427936.4080900@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <waiman.long@hp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, Daniel J Blueman <daniel@numascale.com>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>
Message-ID: <20150504140551.sJhxbCRAL_Lj6i3xsgSQOls0KI0yzb3W15T_CqICb90@z>

On Thu, Apr 30, 2015 at 02:49:26PM -0400, Waiman Long wrote:
> On 04/29/2015 02:11 PM, Peter Zijlstra wrote:
> >On Fri, Apr 24, 2015 at 02:56:42PM -0400, Waiman Long wrote:
> >>In the pv_scan_next() function, the slow cmpxchg atomic operation is
> >>performed even if the other CPU is not even close to being halted. This
> >>extra cmpxchg can harm slowpath performance.
> >>
> >>This patch introduces the new mayhalt flag to indicate if the other
> >>spinning CPU is close to being halted or not. The current threshold
> >>for x86 is 2k cpu_relax() calls. If this flag is not set, the other
> >>spinning CPU will have at least 2k more cpu_relax() calls before
> >>it can enter the halt state. This should give enough time for the
> >>setting of the locked flag in struct mcs_spinlock to propagate to
> >>that CPU without using atomic op.
> >Yuck! I'm not at all sure you can make assumptions like that. And the
> >worst part is, if it goes wrong the borkage is subtle and painful.
> 
> I do think the code is OK. However, you are right that if my reasoning is
> incorrect, the resulting bug will be really subtle. 

So I do not think its correct, imagine the fabrics used for the 4096 cpu
SGI machine, now add some serious traffic to them. There is no saying
your random 2k relax loop will be enough to propagate the change.

Equally, another arch (this is generic code) might have starvation
issues on its inter-cpu fabric and delay the store just long enough.

The thing is, one should _never_ rely on timing for correctness, _ever_.

> So I am going to
> withdraw this particular patch as it has no functional impact to the overall
> patch series. Please let me know if you have any other comments on other
> parts of the series and I will send send out a new series without this
> particular patch.

Please wait a little while, I've queued the 'basic' patches, once that
settles in tip we can look at the others.

Also, I have some local changes (sorry, I could not help mysef) I should
post, I've been somewhat delayed by illness.
