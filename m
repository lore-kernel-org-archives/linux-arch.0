From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v5 1/8] qspinlock: Introducing a 4-byte
	queue spinlock	implementation
Date: Sun, 2 Mar 2014 14:31:40 +0100
Message-ID: <20140302133140.GA13830@redhat.com>
References: <1393475567-4453-1-git-send-email-Waiman.Long@hp.com>
	<1393475567-4453-2-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xen.org>
Content-Disposition: inline
In-Reply-To: <1393475567-4453-2-git-send-email-Waiman.Long@hp.com>
List-Unsubscribe: <http://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <http://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Sender: xen-devel-bounces@lists.xen.org
Errors-To: xen-devel-bounces@lists.xen.org
To: Waiman Long <Waiman.Long@hp.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Gleb Natapov <gleb@redhat.com>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Scott J Norton <scott.norton@hp.com>, Rusty Russell <rusty@rustcorp.com.au>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu Vinod <chegu_vinod@hp.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-kernel
List-Id: linux-arch.vger.kernel.org

Forgot to ask...

On 02/26, Waiman Long wrote:
>
> +notify_next:
> +	/*
> +	 * Wait, if needed, until the next one in queue set up the next field
> +	 */
> +	while (!(next = ACCESS_ONCE(node->next)))
> +		arch_mutex_cpu_relax();
> +	/*
> +	 * The next one in queue is now at the head
> +	 */
> +	smp_store_release(&next->wait, false);

Do we really need smp_store_release()? It seems that we can rely on the
control dependency here. And afaics there is no need to serialise this
store with other changes in *lock, plus they all have mb's anyway.

Oleg.
