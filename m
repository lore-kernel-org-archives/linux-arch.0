Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g9t1613g.houston.hp.com ([15.240.0.71]:51723 "EHLO
	g9t1613g.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069AbbDASyy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 1 Apr 2015 14:54:54 -0400
Message-ID: <551C3EF5.6090809@hp.com>
Date: Wed, 01 Apr 2015 14:54:45 -0400
From: Waiman Long <waiman.long@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH 8/9] qspinlock: Generic paravirt support
References: <20150316131613.720617163@infradead.org> <20150316133112.278511476@infradead.org> <5509E51D.7040909@hp.com> <20150319101242.GM21418@twins.programming.kicks-ass.net> <20150319122536.GD11574@worktop.ger.corp.intel.com> <551C1ACE.4090408@hp.com> <20150401171223.GO23123@twins.programming.kicks-ass.net> <20150401174239.GO24151@twins.programming.kicks-ass.net> <20150401181744.GE32047@worktop.ger.corp.intel.com>
In-Reply-To: <20150401181744.GE32047@worktop.ger.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, paolo.bonzini@gmail.com, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, paulmck@linux.vnet.ibm.com, riel@redhat.com, torvalds@linux-foundation.org, raghavendra.kt@linux.vnet.ibm.com, david.vrabel@citrix.com, oleg@redhat.com, scott.norton@hp.com, doug.hatch@hp.com, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, luto@amacapital.net
Message-ID: <20150401185445.VplMUzpvMKe9X5GUiSWMorf2I6yAGIr8OpM7V8NSV54@z>

On 04/01/2015 02:17 PM, Peter Zijlstra wrote:
> On Wed, Apr 01, 2015 at 07:42:39PM +0200, Peter Zijlstra wrote:
>>> Hohumm.. time to think more I think ;-)
>> So bear with me, I've not really pondered this well so it could be full
>> of holes (again).
>>
>> After the cmpxchg(&l->locked, _Q_LOCKED_VAL, _Q_SLOW_VAL) succeeds the
>> spin_unlock() must do the hash lookup, right? We can make the lookup
>> unhash.
>>
>> If the cmpxchg() fails the unlock will not do the lookup and we must
>> unhash.
> The idea being that the result is that any lookup is guaranteed to find
> an entry, which reduces our worst case lookup cost to whatever the worst
> case insertion cost was.
>

I think it doesn't matter who did the unhashing. Multiple independent 
locks can be hashed to the same value. Since they can be unhashed 
independently, there is no way to know whether you have checked all the 
possible buckets.

-Longman
