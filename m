Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g4t3425.houston.hp.com ([15.201.208.53]:25990 "EHLO
	g4t3425.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbbDIVwp (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Apr 2015 17:52:45 -0400
Message-ID: <5526F4A2.7040604@hp.com>
Date: Thu, 09 Apr 2015 17:52:34 -0400
From: Waiman Long <waiman.long@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH v15 16/16] unfair qspinlock: a queue based unfair lock
References: <1428517939-27968-1-git-send-email-Waiman.Long@hp.com> <20150409070146.GL27490@worktop.programming.kicks-ass.net> <55267BA8.9060009@redhat.com> <20150409141348.GX5029@twins.programming.kicks-ass.net>
In-Reply-To: <20150409141348.GX5029@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, Daniel J Blueman <daniel@numascale.com>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>
Message-ID: <20150409215234.LC_x7hMisypDcW2wWA5_cHeZryvk8OP_CtDEUAiVLMk@z>

On 04/09/2015 10:13 AM, Peter Zijlstra wrote:
> On Thu, Apr 09, 2015 at 09:16:24AM -0400, Rik van Riel wrote:
>> On 04/09/2015 03:01 AM, Peter Zijlstra wrote:
>>> On Wed, Apr 08, 2015 at 02:32:19PM -0400, Waiman Long wrote:
>>>> For a virtual guest with the qspinlock patch, a simple unfair byte lock
>>>> will be used if PV spinlock is not configured in or the hypervisor
>>>> isn't either KVM or Xen. The byte lock works fine with small guest
>>>> of just a few vCPUs. On a much larger guest, however, byte lock can
>>>> have serious performance problem.
>>> Who cares?
>> There are some people out there running guests with dozens
>> of vCPUs. If the code exists to make those setups run better,
>> is there a good reason not to use it?
> Well use paravirt, !paravirt stuff sucks performance wise anyhow.
>
> The question really is: is the added complexity worth the maintenance
> burden. And I'm just not convinced !paravirt virt is a performance
> critical target.

I am just thinking that the unfair qspinlock is better performing than 
the simple byte lock. However, my current priority is to get native and 
PV qspinlock upstream. The unfair qspinlock can certainly wait.

Cheers,
Longman
