Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g5t1627.atlanta.hp.com ([15.192.137.10]:23922 "EHLO
	g5t1627.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbaDRSH0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 Apr 2014 14:07:26 -0400
Message-ID: <535169CA.8060209@hp.com>
Date: Fri, 18 Apr 2014 14:07:06 -0400
From: Waiman Long <waiman.long@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH v9 06/19] qspinlock: prolong the stay in the pending bit
 path
References: <1397747051-15401-1-git-send-email-Waiman.Long@hp.com> <1397747051-15401-7-git-send-email-Waiman.Long@hp.com> <20140417163640.GT11096@twins.programming.kicks-ass.net> <535083DC.2040406@hp.com> <20140418083342.GA11096@twins.programming.kicks-ass.net>
In-Reply-To: <20140418083342.GA11096@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, Gleb Natapov <gleb@redhat.com>, Scott J Norton <scott.norton@hp.com>, Chegu Vinod <chegu_vinod@hp.com>
Message-ID: <20140418180706.9epoXl5R0Iyl8IA0UUAPXevRtUMZnygvOL9bpBNubM8@z>

On 04/18/2014 04:33 AM, Peter Zijlstra wrote:
> On Thu, Apr 17, 2014 at 09:46:04PM -0400, Waiman Long wrote:
>> BTW, I didn't test out your atomic_test_and_set() change. Did it provide a
>> noticeable performance benefit when compared with cmpxchg()?
> I've not tested that I think. I had a hard time showing that cmpxchg
> loops were slower, but once I did, I simply replaced all cmpxchg loops
> with unconditional ops where possible.
>
> The machine that was big enough to show it lived in a lab half way
> around the world and using it was a right pain in the ass, so I didn't
> use it more than I absolutely had to.

Thank for letting me know about it. The cmpxchg() slowdown that I 
observed happens when it is heavily contended. In other words, if many 
CPUs are trying to grab it at roughly the same time. If there is just a 
few contending CPUs, the difference shouldn't be too big.

-Longman
