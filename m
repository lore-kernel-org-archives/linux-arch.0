From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH -v2 2/2] genericirq: change ack/mask in irq_chip to take
 irq_desc instead of irq
Date: Wed, 24 Feb 2010 14:07:45 -0800
Message-ID: <4B85A331.7040909@kernel.org>
References: <1266029390-30907-1-git-send-email-yinghai@kernel.org>	<m1zl3dre9e.fsf@fess.ebiederm.org> <4B7676BB.8030608@kernel.org>	<m1ljexpcjp.fsf@fess.ebiederm.org> <4B772A54.1000000@kernel.org>	<m16360ohi2.fsf@fess.ebiederm.org> <4B773CEB.9010609@kernel.org>	<m1sk94mzg0.fsf@fess.ebiederm.org> <4B7CA9A1.3020806@kernel.org>	<4B7CAADD.2060000@kernel.org> <m1mxz6v4pm.fsf@fess.ebiederm.org>	<4B83781B.20307@kernel.org> <4B837930.2050907@kernel.org> <m1ljei5n9q.fsf@fess.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <m1ljei5n9q.fsf@fess.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Eric W. Biederman" <ebiederm@xmission.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, Suresh Siddha <suresh.b.siddha@intel.com>, linux-kernel@vger.kernel.org, Jeremy Fitzhardinge <jeremy@goop.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 02/24/2010 01:36 PM, Eric W. Biederman wrote:
> Yinghai Lu <yinghai@kernel.org> writes:
> 
>> will have
>> void            (*ack)(struct irq_desc *desc);
>> void            (*mask)(struct irq_desc *desc);
>> void            (*mask_ack)(struct irq_desc *desc);
>> void            (*unmask)(struct irq_desc *desc);
>> void            (*eoi)(struct irq_desc *desc);
>>
>> so for sparseirq with raidix tree, we don't call extra irq_to_desc, and could use desc directly
> 
> Overall this looks pretty decent.  This look pretty complete.
> How many platforms did you manage to compile test this on?

x86 only.

any guide to setup cross compiling for 22 archs ?
on x86_64 platform please

Thanks

Yinghai Lu
