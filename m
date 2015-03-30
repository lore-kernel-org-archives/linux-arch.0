Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g2t1383g.austin.hp.com ([15.217.136.92]:41766 "EHLO
	g2t1383g.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003AbbC3Qnq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 30 Mar 2015 12:43:46 -0400
Message-ID: <55197D3B.4020701@hp.com>
Date: Mon, 30 Mar 2015 12:43:39 -0400
From: Waiman Long <waiman.long@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH 0/9] qspinlock stuff -v15
References: <20150316131613.720617163@infradead.org> <20150325194739.GK25884@l.oracle.com> <551978E8.30904@hp.com> <20150330162933.GC23123@twins.programming.kicks-ass.net>
In-Reply-To: <20150330162933.GC23123@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, paolo.bonzini@gmail.com, boris.ostrovsky@oracle.com, paulmck@linux.vnet.ibm.com, riel@redhat.com, torvalds@linux-foundation.org, raghavendra.kt@linux.vnet.ibm.com, david.vrabel@citrix.com, oleg@redhat.com, scott.norton@hp.com, doug.hatch@hp.com, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, luto@amacapital.net
Message-ID: <20150330164339.hgOJzvTB4z6AeBLVom2DXnl2hNNfZAKwDRFNW2sagmI@z>

On 03/30/2015 12:29 PM, Peter Zijlstra wrote:
> On Mon, Mar 30, 2015 at 12:25:12PM -0400, Waiman Long wrote:
>> I did it differently in my PV portion of the qspinlock patch. Instead of
>> just waking up the CPU, the new lock holder will check if the new queue head
>> has been halted. If so, it will set the slowpath flag for the halted queue
>> head in the lock so as to wake it up at unlock time. This should eliminate
>> your concern of dong twice as many VMEXIT in an overcommitted scenario.
> We can still do that on top of all this right? As you might have
> realized I'm a fan of gradual complexity :-)

Of course. I am just saying that the concern can be addressed with some 
additional code change.

-Longman
