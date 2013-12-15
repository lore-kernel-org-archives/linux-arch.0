From: Jiang Liu <liuj97@gmail.com>
Subject: Re: [RFC PATCH v3 19/19] smp, x86: kill SMP single function call
	interrupt
Date: Sun, 15 Dec 2013 23:49:27 +0800
Message-ID: <52ADCF87.5010209@gmail.com>
References: <1386173591-28514-1-git-send-email-liuj97@gmail.com>
	<1386173591-28514-20-git-send-email-liuj97@gmail.com>
	<20131211221011.GA26423@breakpoint.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20131211221011.GA26423@breakpoint.cc>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Gleb Natapov <gleb@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Wang YanQing <udknight@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, Yang Zhang <yang.z.zhang@Intel.com>, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@elte.hu>, Shaohua Li <shli@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Steven Rostedt <rostedt@goodmis.org>, xen-devel@lists.xensource.com, Al Viro <viro@zeniv.linux.org.uk>, Jiri Kosina <trivial@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, virtualization@lists.linux-foundation.org, Seiji Aguchi <seiji.aguchi@hds.com>, linux-kernel@vger.kernel.org, David
List-Id: linux-arch.vger.kernel.org

Hi Sebastian,
	Thanks for your review.
	The patch applies to the mainstream kernel, so seems there's difference
between tip and the mainstream kernel. I will try to find the
difference.
	And there's another patch for Xen, but I found the mail tile is
wrong:( Please refer to:
	http://www.kernelhub.org/?msg=373208&p=2

	Should I merge the patch for xen with the patch for native x86?
Is there any dependency between them?

Thanks!
Gerry

On 12/12/2013 06:10 AM, Sebastian Andrzej Siewior wrote:
> On 05.12.13, Jiang Liu wrote:
> 
> I like this in general however
> 
>> diff --git a/arch/x86/xen/smp.c b/arch/x86/xen/smp.c
>> index 7cf1689..f241792 100644
>> --- a/arch/x86/xen/smp.c
>> +++ b/arch/x86/xen/smp.c
>> @@ -560,7 +560,6 @@ static inline int xen_map_vector(int vector)
>>  		xen_vector = XEN_RESCHEDULE_VECTOR;
>>  		break;
>>  	case CALL_FUNCTION_VECTOR:
>> -	case CALL_FUNCTION_SINGLE_VECTOR:
>>  		xen_vector = XEN_CALL_FUNCTION_VECTOR;
>>  		break;
>>  	case IRQ_WORK_VECTOR:
> 
> This chunk does not apply again tip's master branch, the code looks
> different. You need to also kill XEN_CALL_FUNCTION_SINGLE_VECTOR which
> is either part of a different patch or against a different tree. I
> haven't seen a note in 0/19 or this patch description so I'm confused
> here :)
> 
> Sebastian
> 
