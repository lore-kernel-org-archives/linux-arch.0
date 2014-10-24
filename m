From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v12 09/11] pvqspinlock, x86: Add para-virtualization
	support
Date: Sat, 25 Oct 2014 00:04:23 +0200
Message-ID: <20141024220423.GB10501@worktop.programming.kicks-ass.net>
References: <1413483040-58399-1-git-send-email-Waiman.Long@hp.com>
	<1413483040-58399-10-git-send-email-Waiman.Long@hp.com>
	<20141024084738.GU21513@worktop.programming.kicks-ass.net>
	<544ABC47.2000700@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <544ABC47.2000700@hp.com>
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
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Douglas Hatch <doug.hatch@hp.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Oct 24, 2014 at 04:53:27PM -0400, Waiman Long wrote:
> The additional register pressure may just cause a few more register moves
> which should be negligible in the overall performance . The additional
> icache pressure, however, may have some impact on performance. I was trying
> to balance the performance of the pv and non-pv versions so that we won't
> penalize the pv code too much for a bit more performance in the non-pv code.
> Doing it your way will add a lot of function call and register
> saving/restoring to the pv code.

If people care about performance they should not be using virt crap :-)

I only really care about bare metal.
