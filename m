Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.citrix.com ([66.165.176.89]:48430 "EHLO SMTP.CITRIX.COM"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754448AbbCPOJL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 16 Mar 2015 10:09:11 -0400
Message-ID: <5506E3FA.7040304@citrix.com>
Date: Mon, 16 Mar 2015 14:08:58 +0000
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
Subject: Re: [Xen-devel] [PATCH 0/9] qspinlock stuff -v15
References: <20150316131613.720617163@infradead.org>
In-Reply-To: <20150316131613.720617163@infradead.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Waiman.Long@hp.com
Cc: raghavendra.kt@linux.vnet.ibm.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com, boris.ostrovsky@oracle.com, linux-arch@vger.kernel.org, x86@kernel.org, mingo@redhat.com, doug.hatch@hp.com, xen-devel@lists.xenproject.org, paulmck@linux.vnet.ibm.com, riel@redhat.com, scott.norton@hp.com, paolo.bonzini@gmail.com, tglx@linutronix.de, virtualization@lists.linux-foundation.org, oleg@redhat.com, luto@amacapital.net, david.vrabel@citrix.com, torvalds@linux-foundation.org
Message-ID: <20150316140858.eb_4cnCYkIpLPL_oO8D6bapXLvQykD3zIzSZ1llv9aQ@z>

On 16/03/15 13:16, Peter Zijlstra wrote:
> Hi Waiman,
> 
> As promised; here is the paravirt stuff I did during the trip to BOS last week.
> 
> All the !paravirt patches are more or less the same as before (the only real
> change is the copyright lines in the first patch).
> 
> The paravirt stuff is 'simple' and KVM only -- the Xen code was a little more
> convoluted and I've no real way to test that but it should be stright fwd to
> make work.
> 
> I ran this using the virtme tool (thanks Andy) on my laptop with a 4x
> overcommit on vcpus (16 vcpus as compared to the 4 my laptop actually has) and
> it both booted and survived a hackbench run (perf bench sched messaging -g 20
> -l 5000).
> 
> So while the paravirt code isn't the most optimal code ever conceived it does work.
> 
> Also, the paravirt patching includes replacing the call with "movb $0, %arg1"
> for the native case, which should greatly reduce the cost of having
> CONFIG_PARAVIRT_SPINLOCKS enabled on actual hardware.
> 
> I feel that if someone were to do a Xen patch we can go ahead and merge this
> stuff (finally!).

I can look at this.  It looks pretty straight-forward.

> These patches do not implement the paravirt spinlock debug stats currently
> implemented (separately) by KVM and Xen, but that should not be too hard to do
> on top and in the 'generic' code -- no reason to duplicate all that.

I think this is fine.

David
