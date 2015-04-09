From: Rik van Riel <riel@redhat.com>
Subject: Re: [PATCH v15 16/16] unfair qspinlock: a queue based unfair lock
Date: Thu, 09 Apr 2015 09:16:24 -0400
Message-ID: <55267BA8.9060009@redhat.com>
References: <1428517939-27968-1-git-send-email-Waiman.Long@hp.com> <20150409070146.GL27490@worktop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59915 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753860AbbDINRf (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 9 Apr 2015 09:17:35 -0400
In-Reply-To: <20150409070146.GL27490@worktop.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Waiman Long <Waiman.Long@hp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, Daniel J Blueman <daniel@numascale.com>, Scott J Norton <scott.norton@hp.com>, Douglas Hatch <doug.hatch@hp.com>

On 04/09/2015 03:01 AM, Peter Zijlstra wrote:
> On Wed, Apr 08, 2015 at 02:32:19PM -0400, Waiman Long wrote:
>> For a virtual guest with the qspinlock patch, a simple unfair byte lock
>> will be used if PV spinlock is not configured in or the hypervisor
>> isn't either KVM or Xen. The byte lock works fine with small guest
>> of just a few vCPUs. On a much larger guest, however, byte lock can
>> have serious performance problem.
> 
> Who cares?

There are some people out there running guests with dozens
of vCPUs. If the code exists to make those setups run better,
is there a good reason not to use it?

Having said that, only KVM and Xen seem to support very
large guests, and PV spinlock is available there.

I believe both VMware and Hyperv have a 32 VCPU limit, anyway.

-- 
All rights reversed
