From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v9 05/19] qspinlock: Optimize for smaller NR_CPUS
Date: Sat, 19 Apr 2014 11:24:42 +0200
Message-ID: <20140419092442.GB2102@gmail.com>
References: <1397747051-15401-1-git-send-email-Waiman.Long@hp.com>
	<1397747051-15401-6-git-send-email-Waiman.Long@hp.com>
	<20140417155844.GS11096@twins.programming.kicks-ass.net>
	<53504C4E.8060800@hp.com> <20140418074616.GB13517@gmail.com>
	<53515232.50905@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <53515232.50905@hp.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <waiman.long@hp.com>
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Peter Zijlstra <peterz@infradead.org>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Chegu Vinod <chegu_vinod@hp.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>
List-Id: linux-arch.vger.kernel.org


* Waiman Long <waiman.long@hp.com> wrote:

> On 04/18/2014 03:46 AM, Ingo Molnar wrote:
> >* Waiman Long<waiman.long@hp.com>  wrote:
> >
> >>On 04/17/2014 11:58 AM, Peter Zijlstra wrote:
> >>>On Thu, Apr 17, 2014 at 11:03:57AM -0400, Waiman Long wrote:
> >>>>+static __always_inline void
> >>>>+clear_pending_set_locked(struct qspinlock *lock, u32 val)
> >>>>+{
> >>>>+	struct __qspinlock *l = (void *)lock;
> >>>>+
> >>>>+	ACCESS_ONCE(l->locked_pending) = 1;
> >>>>+}
> >>>>@@ -157,8 +251,13 @@ static inline int trylock_pending(struct qspinlock *lock, u32 *pval)
> >>>>  	 * we're pending, wait for the owner to go away.
> >>>>  	 *
> >>>>  	 * *,1,1 ->   *,1,0
> >>>>+	 *
> >>>>+	 * this wait loop must be a load-acquire such that we match the
> >>>>+	 * store-release that clears the locked bit and create lock
> >>>>+	 * sequentiality; this because not all try_clear_pending_set_locked()
> >>>>+	 * implementations imply full barriers.
> >>>You renamed the function referred in the above comment.
> >>>
> >>Sorry, will fix the comments.
> >I suggest not renaming the function instead.
> >try_clear_pending_set_locked() tells the intent in a clearer fashion.
> >
> >Thanks,
> >
> >	Ingo
> 
> I usually use the word "try" if there is a possibility of failure. 
> However, the function will always succeed, albeit by waiting a bit 
> in some cases. That is why I remove "try" from the name.

Fair enough!

Thanks,

	Ingo
