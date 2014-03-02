From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v5 3/8] qspinlock,
	x86: Add x86 specific optimization	for 2 contending tasks
Date: Sun, 2 Mar 2014 14:16:38 +0100
Message-ID: <20140302131638.GB13206@redhat.com>
References: <1393475567-4453-1-git-send-email-Waiman.Long@hp.com>
	<1393475567-4453-4-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xen.org>
Content-Disposition: inline
In-Reply-To: <1393475567-4453-4-git-send-email-Waiman.Long@hp.com>
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

On 02/26, Waiman Long wrote:
>
> @@ -144,7 +317,7 @@ static __always_inline int queue_spin_setlock(struct qspinlock *lock)
>  	int qlcode = atomic_read(lock->qlcode);
>  
>  	if (!(qlcode & _QSPINLOCK_LOCKED) && (atomic_cmpxchg(&lock->qlcode,
> -		qlcode, qlcode|_QSPINLOCK_LOCKED) == qlcode))
> +		qlcode, code|_QSPINLOCK_LOCKED) == qlcode))

Hmm. didn't read the patch, but this change looks like accidental typo...

Oleg.
