From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v10 08/19] qspinlock: Make a new qnode structure to support
	virtualization
Date: Fri, 09 May 2014 21:08:56 -0400
Message-ID: <536D7C28.8010609@hp.com>
References: <1399474907-22206-1-git-send-email-Waiman.Long@hp.com>
	<1399474907-22206-9-git-send-email-Waiman.Long@hp.com>
	<20140508190459.GQ2844@laptop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140508190459.GQ2844@laptop.programming.kicks-ass.net>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Chegu Vinod <chegu_vinod@hp.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: linux-arch.vger.kernel.org

On 05/08/2014 03:04 PM, Peter Zijlstra wrote:
> On Wed, May 07, 2014 at 11:01:36AM -0400, Waiman Long wrote:
>>   /*
>> + * To have additional features for better virtualization support, it is
>> + * necessary to store additional data in the queue node structure. So
>> + * a new queue node structure will have to be defined and used here.
>> + */
>> +struct qnode {
>> +	struct mcs_spinlock mcs;
>> +};
> You can ditch this entire patch; its pointless, just add a new
> DEFINE_PER_CPU for the para-virt muck.

Yes, I can certainly merge it to the next one in the series. I break it 
out to make each individual patch smaller, more single-purpose and 
easier to review.

-Longman
