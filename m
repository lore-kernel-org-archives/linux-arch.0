From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v8 01/10] qspinlock: A generic 4-byte queue spinlock
	implementation
Date: Mon, 7 Apr 2014 16:09:53 +0200
Message-ID: <20140407140953.GK10526@twins.programming.kicks-ass.net>
References: <1396445259-27670-1-git-send-email-Waiman.Long@hp.com>
	<1396445259-27670-2-git-send-email-Waiman.Long@hp.com>
	<20140404130012.GE10526@twins.programming.kicks-ass.net>
	<20140404165727.GQ19478@phenom.dumpdata.com>
	<533EE700.4080408@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <533EE700.4080408@hp.com>
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
Cc: x86@kernel.org, Gleb Natapov <gleb@redhat.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Marcos Matsunaga <Marcos.Matsunaga@oracle.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, Paolo Bonzini <paolo.bonzini@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, virtualization@lists.linux-foundation.org, Chegu Vinod <chegu_vinod@hp.com>, linux-kernel@vger.kernel.org, David Vrabel <david.vrabel@citrix.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

On Fri, Apr 04, 2014 at 01:08:16PM -0400, Waiman Long wrote:
> Peter's patch is a rewrite of my patches 1-4, there is no PV or unfair lock
> support in there.

Yes, because your patches were unreadable and entirely non obvious.

And while I appreciate that its not entirely your fault; the subject is
hard, you didn't even try to make it better and explain things in a
normal gradual fashion.

So what I did was start with a 'simple' correct implementation (although
I could have started simpler still I suppose and added 3-4 more patches)
and then added each optimization on top and explained the what and why
for them.

The result is similar code, but the path is ever so much easier to
understand and review.

And no, it doesn't have PV support; I spend the whole week trying to
reverse engineer your patch 1; whereas if you'd presented it in the form
I posted I might have agreed in a day or so.

I still have to look at the PV bits; but seeing how you have shown no
interest in writing coherent and understandable patch sets I'm less
inclined to go stare at them for another few weeks and rewrite that code
too.

Also; theres a few subtle but important differences between the patch
sets. Your series only makes x86_64 use the qspinlocks; the very last we
want is i386 and x86_64 to use different spinlock implementations; we
want less differences between them, not more.

You stuff a whole lot of code into arch/x86 for no reason what so ever.

Prior to that; I also rewrote your benchmark thing; using jiffies for
timing is just vile. Not to mention you require a full kernel build and
reboot (which is just stupid slow on big machines) to test anything.
