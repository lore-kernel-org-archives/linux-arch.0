Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54]:19140 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933194AbaDBUjK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 2 Apr 2014 16:39:10 -0400
Message-ID: <533C7557.60908@hp.com>
Date: Wed, 02 Apr 2014 16:38:47 -0400
From: Waiman Long <waiman.long@hp.com>
MIME-Version: 1.0
Subject: Re: [PATCH v8 10/10] pvqspinlock, x86: Enable qspinlock PV support
 for XEN
References: <1396445259-27670-1-git-send-email-Waiman.Long@hp.com> <1396445259-27670-11-git-send-email-Waiman.Long@hp.com> <20140402143932.GA13097@phenom.dumpdata.com>
In-Reply-To: <20140402143932.GA13097@phenom.dumpdata.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, David Vrabel <david.vrabel@citrix.com>, Oleg Nesterov <oleg@redhat.com>, Gleb Natapov <gleb@redhat.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Scott J Norton <scott.norton@hp.com>, Chegu Vinod <chegu_vinod@hp.com>
Message-ID: <20140402203847.dKlPM3WLJUe35ZyCihVvsP4IW7XpUxgmh_imVm5MK7I@z>

On 04/02/2014 10:39 AM, Konrad Rzeszutek Wilk wrote:
>> diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
>> index a70fdeb..451e392 100644
>> --- a/kernel/Kconfig.locks
>> +++ b/kernel/Kconfig.locks
>> @@ -229,4 +229,4 @@ config ARCH_USE_QUEUE_SPINLOCK
>>
>>   config QUEUE_SPINLOCK
>>   	def_bool y if ARCH_USE_QUEUE_SPINLOCK
>> -	depends on SMP&&  (!PARAVIRT_SPINLOCKS || !XEN)
>> +	depends on SMP
> If I read this correctly that means you cannot select any more the old
> ticketlocks? As in, if you select CONFIG_PARAVIRT on X86 it will automatically
> select ARCH_USE_QUEUE_SPINLOCK which will then enable this by default?
>
> Should the 'def_bool' be selectable?

My initial qspinlock patch allows it to be selectable, but there was 
comment that doing so would increase the testing matrix and so made it 
less desirable. That was why I made it the default for 64-bit code which 
are more likely to be used in large machines which benefit the most from 
this patch. 32-bit kernel will still use the ticket lock.

-Longman
