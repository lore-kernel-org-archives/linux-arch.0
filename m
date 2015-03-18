From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH 0/9] qspinlock stuff -v15
Date: Wed, 18 Mar 2015 16:36:35 -0400
Message-ID: <5509E1D3.7040109@hp.com>
References: <20150316131613.720617163@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54]:58036 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750719AbbCRUgm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 18 Mar 2015 16:36:42 -0400
In-Reply-To: <20150316131613.720617163@infradead.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, paolo.bonzini@gmail.com, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, paulmck@linux.vnet.ibm.com, riel@redhat.com, torvalds@linux-foundation.org, raghavendra.kt@linux.vnet.ibm.com, david.vrabel@citrix.com, oleg@redhat.com, scott.norton@hp.com, doug.hatch@hp.com, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, luto@amacapital.net

On 03/16/2015 09:16 AM, Peter Zijlstra wrote:
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
>
> These patches do not implement the paravirt spinlock debug stats currently
> implemented (separately) by KVM and Xen, but that should not be too hard to do
> on top and in the 'generic' code -- no reason to duplicate all that.
>
> Of course; once this lands people can look at improving the paravirt nonsense.
>

Thanks for sending this out. I have no problem with the !paravirt patch. 
I do have some comments on the paravirt one which I will reply individually.

Cheers,
Longman
