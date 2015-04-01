Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:56809 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753004AbbDASR7 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 1 Apr 2015 14:17:59 -0400
Date: Wed, 1 Apr 2015 20:17:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 8/9] qspinlock: Generic paravirt support
Message-ID: <20150401181744.GE32047@worktop.ger.corp.intel.com>
References: <20150316131613.720617163@infradead.org>
 <20150316133112.278511476@infradead.org>
 <5509E51D.7040909@hp.com>
 <20150319101242.GM21418@twins.programming.kicks-ass.net>
 <20150319122536.GD11574@worktop.ger.corp.intel.com>
 <551C1ACE.4090408@hp.com>
 <20150401171223.GO23123@twins.programming.kicks-ass.net>
 <20150401174239.GO24151@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150401174239.GO24151@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Waiman Long <waiman.long@hp.com>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, paolo.bonzini@gmail.com, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, paulmck@linux.vnet.ibm.com, riel@redhat.com, torvalds@linux-foundation.org, raghavendra.kt@linux.vnet.ibm.com, david.vrabel@citrix.com, oleg@redhat.com, scott.norton@hp.com, doug.hatch@hp.com, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, luto@amacapital.net
Message-ID: <20150401181744.QEVzmq3a6oHbu6iny5GV9GXbmhRdi2tba_MYmwWgNZ0@z>

On Wed, Apr 01, 2015 at 07:42:39PM +0200, Peter Zijlstra wrote:
> > Hohumm.. time to think more I think ;-)
> 
> So bear with me, I've not really pondered this well so it could be full
> of holes (again).
> 
> After the cmpxchg(&l->locked, _Q_LOCKED_VAL, _Q_SLOW_VAL) succeeds the
> spin_unlock() must do the hash lookup, right? We can make the lookup
> unhash.
> 
> If the cmpxchg() fails the unlock will not do the lookup and we must
> unhash.

The idea being that the result is that any lookup is guaranteed to find
an entry, which reduces our worst case lookup cost to whatever the worst
case insertion cost was.

