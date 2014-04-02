From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v8 10/10] pvqspinlock,
 x86: Enable qspinlock PV support for XEN
Date: Wed, 02 Apr 2014 16:38:47 -0400
Message-ID: <533C7557.60908@hp.com>
References: <1396445259-27670-1-git-send-email-Waiman.Long@hp.com>
	<1396445259-27670-11-git-send-email-Waiman.Long@hp.com>
	<20140402143932.GA13097@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <20140402143932.GA13097@phenom.dumpdata.com>
List-Unsubscribe: <http://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <http://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Sender: xen-devel-bounces@lists.xen.org
Errors-To: xen-devel-bounces@lists.xen.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-arch@vger.kernel.org, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Chegu Vinod <chegu_vinod@hp.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, Aswin Chandramouleeswaran <aswin@hp.com>
List-Id: linux-arch.vger.kernel.org

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
