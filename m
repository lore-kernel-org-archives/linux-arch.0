From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v11 14/16] pvqspinlock: Add qspinlock para-virtualization
	support
Date: Tue, 17 Jun 2014 16:59:15 -0400
Message-ID: <20140617205915.GC29634@laptop.dumpdata.com>
References: <1401464642-33890-1-git-send-email-Waiman.Long@hp.com>
	<1401464642-33890-15-git-send-email-Waiman.Long@hp.com>
	<20140612081731.GM3213@twins.programming.kicks-ass.net>
	<539A1229.1050309@hp.com>
	<20140615131654.GJ11371@laptop.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20140615131654.GJ11371@laptop.programming.kicks-ass.net>
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
Cc: Waiman Long <waiman.long@hp.com>, linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Chegu Vinod <chegu_vinod@hp.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>
List-Id: linux-arch.vger.kernel.org

On Sun, Jun 15, 2014 at 03:16:54PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 12, 2014 at 04:48:41PM -0400, Waiman Long wrote:
> > I don't have a good understanding of the kernel alternatives mechanism.
> 
> I didn't either; I do now, cost me a whole day reading up on
> alternative/paravirt code patching.
> 
> See the patches I just send out; I got the 'native' case with paravirt
> enabled to be one NOP worse than the native case without paravirt -- for
> queue_spin_unlock.
> 
> The lock slowpath is several nops and some pointless movs more expensive.

You could use the asm goto which would optimize the fast path to be the
'native' case. That way you wouldn't have the the nops and movs in the
path.

(And asm goto also uses the alternative_asm macros).
