From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v10 18/19] pvqspinlock, x86: Enable PV qspinlock PV for KVM
Date: Thu, 08 May 2014 13:54:07 -0400
Message-ID: <536BC4BF.9030603@hp.com>
References: <1399474907-22206-1-git-send-email-Waiman.Long@hp.com>
	<1399474907-22206-19-git-send-email-Waiman.Long@hp.com>
	<20140507190706.GA16333@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140507190706.GA16333@phenom.dumpdata.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Chegu Vinod <chegu_vinod@hp.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: linux-arch.vger.kernel.org

On 05/07/2014 03:07 PM, Konrad Rzeszutek Wilk wrote:
>> Raghavendra KT had done some performance testing on this patch with
>> the following results:
>>
>> Overall we are seeing good improvement for pv-unfair version.
>>
>> System: 32 cpu sandybridge with HT on (4 node with 32 GB each)
>> Guest : 8GB with 16 vcpu/VM.
>> Average was taken over 8-10 data points.
>>
>> Base = 3.15-rc2  with PRAVIRT_SPINLOCK = y
>>
>> A = 3.15-rc2 + qspinlock v9 patch with QUEUE_SPINLOCK = y
>> PRAVIRT_SPINLOCK = y PARAVIRT_UNFAIR_LOCKS = y (unfair lock)
>>
>> B =  3.15-rc2 + qspinlock v9 patch with QUEUE_SPINLOCK = y
>> PRAVIRT_SPINLOCK = n PARAVIRT_UNFAIR_LOCKS = n
>> (queue spinlock without paravirt)
>>
>> C = 3.15-rc2 + qspinlock v9 patch with  QUEUE_SPINLOCK = y
>> PRAVIRT_SPINLOCK = y  PARAVIRT_UNFAIR_LOCKS = n
>> (queue spinlock with paravirt)
> Could you do s/PRAVIRT/PARAVIRT/ please?
>

Sorry for the typo, I didn't check the text carefully enough when I 
cut-and-paste it from Raghavendra's email.

>> Ebizzy %improvements
>> ====================
>> overcommit  A            B            C
>> 0.5x     4.4265        2.0611       1.5824
>> 1.0x     0.9015       -7.7828       4.5443
>> 1.5x    46.1162       -2.9845      -3.5046
>> 2.0x    99.8150       -2.7116       4.7461
> Considering B sucks

Yes, I don't expect the plain qspinlock code will perform well in a 
guest without either unfair or pvspinlock support.

-Longman
