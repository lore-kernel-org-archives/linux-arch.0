Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:34584 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbbDAVDc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 1 Apr 2015 17:03:32 -0400
Date: Wed, 1 Apr 2015 23:03:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 8/9] qspinlock: Generic paravirt support
Message-ID: <20150401210317.GZ27490@worktop.programming.kicks-ass.net>
References: <5509E51D.7040909@hp.com>
 <20150319101242.GM21418@twins.programming.kicks-ass.net>
 <20150319122536.GD11574@worktop.ger.corp.intel.com>
 <551C1ACE.4090408@hp.com>
 <20150401171223.GO23123@twins.programming.kicks-ass.net>
 <20150401174239.GO24151@twins.programming.kicks-ass.net>
 <20150401181744.GE32047@worktop.ger.corp.intel.com>
 <551C3EF5.6090809@hp.com>
 <20150401184858.GA9791@dyad.arnhem.chello.nl>
 <551C4E02.8030806@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <551C4E02.8030806@hp.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <waiman.long@hp.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, paolo.bonzini@gmail.com, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, paulmck@linux.vnet.ibm.com, riel@redhat.com, torvalds@linux-foundation.org, raghavendra.kt@linux.vnet.ibm.com, david.vrabel@citrix.com, oleg@redhat.com, scott.norton@hp.com, doug.hatch@hp.com, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, luto@amacapital.net
Message-ID: <20150401210317.9lybBCt3tuA177rII6I-t3anr3ErewLauAVnMc_bR90@z>

On Wed, Apr 01, 2015 at 03:58:58PM -0400, Waiman Long wrote:
> On 04/01/2015 02:48 PM, Peter Zijlstra wrote:

> I am sorry that I don't quite get what you mean here. My point is that in
> the hashing step, a cpu will need to scan an empty bucket to put the lock
> in. In the interim, an previously used bucket before the empty one may get
> freed. In the lookup step for that lock, the scanning will stop because of
> an empty bucket in front of the target one.

Right, that's broken. So we need to do something else to limit the
lookup, because without that break, a lookup that needs to iterate the
entire array in order to determine -ENOENT, which is expensive.

So my alternative proposal is that IFF we can guarantee that every
lookup will succeed -- the entry we're looking for is always there, we
don't need the break on empty but can probe until we find the entry.
This will be bound in cost to the same number if probes we required for
insertion and avoids the full array scan.

Now I think we can indeed do this, if as said earlier we do not clear
the bucket on insert if the cmpxchg succeeds, in that case the unlock
will observe _Q_SLOW_VAL and do the lookup, the lookup will then find
the entry. And we then need the unlock to clear the entry.

Does that explain this? Or should I try again with code?
