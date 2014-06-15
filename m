From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v11 09/16] qspinlock, x86: Allow unfair spinlock in a
	virtual guest
Date: Sun, 15 Jun 2014 15:14:16 +0200
Message-ID: <20140615131416.GI11371@laptop.programming.kicks-ass.net>
References: <1401464642-33890-1-git-send-email-Waiman.Long@hp.com>
	<1401464642-33890-10-git-send-email-Waiman.Long@hp.com>
	<20140611105402.GL3213@twins.programming.kicks-ass.net>
	<53990473.7020802@hp.com>
	<20140612055016.GP6758@twins.programming.kicks-ass.net>
	<539A16CC.6040104@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <539A16CC.6040104@hp.com>
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
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Chegu Vinod <chegu_vinod@hp.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Jun 12, 2014 at 05:08:28PM -0400, Waiman Long wrote:
> >Native performance is king, try your very utmost bestest to preserve
> >that, paravirt is a distant second and nobody sane should care about the
> >virt case at all.
> 
> The patch won't affect native performance unless the kernel is built with
> VIRT_UNFAIR_LOCKS selected. The same is also true when PARAVIRT_SPINLOCKS is
> selected. There is no way around that.

VIRT_UNFAIR_LOCKS is an impossible switch to have; a distro cannot make
the right choice.

> I do agree that I may over-engineer on this patch,

Simple things first, then add complexity.
