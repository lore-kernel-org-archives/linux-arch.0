From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v5 1/8] qspinlock: Introducing a 4-byte queue spinlock
	implementation
Date: Tue, 04 Mar 2014 09:58:14 -0500
Message-ID: <5315EA06.2090305@hp.com>
References: <1393475567-4453-1-git-send-email-Waiman.Long@hp.com>
	<1393475567-4453-2-git-send-email-Waiman.Long@hp.com>
	<20140302133140.GA13830@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140302133140.GA13830@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Gleb Natapov <gleb@redhat.com>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu Vinod <chegu_vinod@hp.com>
List-Id: linux-arch.vger.kernel.org

On 03/02/2014 08:31 AM, Oleg Nesterov wrote:
> Forgot to ask...
>
> On 02/26, Waiman Long wrote:
>> +notify_next:
>> +	/*
>> +	 * Wait, if needed, until the next one in queue set up the next field
>> +	 */
>> +	while (!(next = ACCESS_ONCE(node->next)))
>> +		arch_mutex_cpu_relax();
>> +	/*
>> +	 * The next one in queue is now at the head
>> +	 */
>> +	smp_store_release(&next->wait, false);
> Do we really need smp_store_release()? It seems that we can rely on the
> control dependency here. And afaics there is no need to serialise this
> store with other changes in *lock, plus they all have mb's anyway.
>
> Oleg.
>

I am just following the current logic in the mcs_spin_unlock function. 
It is probably true that we don't need the release semantic in this 
particular case.

-Longman
