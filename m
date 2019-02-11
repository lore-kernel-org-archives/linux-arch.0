From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] locking/rwsem: Remove arch specific rwsem files
Date: Mon, 11 Feb 2019 11:57:29 +0100
Message-ID: <20190211105729.GH32534@hirez.programming.kicks-ass.net>
References: <1549850450-10171-1-git-send-email-longman@redhat.com>
 <20190211093601.GT32511@hirez.programming.kicks-ass.net>
 <20190211094044.GG32534@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190211094044.GG32534@hirez.programming.kicks-ass.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Waiman Long <longman@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org, Davidlohr Bueso <dave@stgolabs.net>, linux-ia64@vger.kernel.org, Tim Chen <tim.c.chen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, linux-hexagon@vger.kernel.org, x86@kernel.org, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org, Andrew Morton <akpm@linux-foundation.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

On Mon, Feb 11, 2019 at 10:40:44AM +0100, Peter Zijlstra wrote:
> On Mon, Feb 11, 2019 at 10:36:01AM +0100, Peter Zijlstra wrote:
> > On Sun, Feb 10, 2019 at 09:00:50PM -0500, Waiman Long wrote:
> > > +static inline int __down_read_trylock(struct rw_semaphore *sem)
> > > +{
> > > +	long tmp;
> > > +
> > > +	while ((tmp = atomic_long_read(&sem->count)) >= 0) {
> > > +		if (tmp == atomic_long_cmpxchg_acquire(&sem->count, tmp,
> > > +				   tmp + RWSEM_ACTIVE_READ_BIAS)) {
> > > +			return 1;
> > 
> > That really wants to be:
> > 
> > 		if (atomic_long_try_cmpxchg_acquire(&sem->count, &tmp,
> > 						    tmp + RWSEM_ACTIVE_READ_BIAS))
> > 
> > > +		}
> > > +	}
> > > +	return 0;
> > > +}
> 
> Also, the is the one case where LL/SC can actually do 'better'. Do you
> have benchmarks for say PowerPC or ARM64 ?

Ah, I see they already used asm-generic/rwsem.h which has similar code
to the above.
