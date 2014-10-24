From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v12 00/11] qspinlock: a 4-byte queue spinlock with PV
	support
Date: Fri, 24 Oct 2014 10:57:00 +0200
Message-ID: <20141024085659.GW21513@worktop.programming.kicks-ass.net>
References: <1413483040-58399-1-git-send-email-Waiman.Long@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1413483040-58399-1-git-send-email-Waiman.Long@hp.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman Long <Waiman.Long@hp.com>
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Douglas Hatch <doug.hatch@hp.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Oct 16, 2014 at 02:10:29PM -0400, Waiman Long wrote:
> v11->v12:
>  - Based on PeterZ's version of the qspinlock patch
>    (https://lkml.org/lkml/2014/6/15/63).
>  - Incorporated many of the review comments from Konrad Wilk and
>    Paolo Bonzini.
>  - The pvqspinlock code is largely from my previous version with
>    PeterZ's way of going from queue tail to head and his idea of
>    using callee saved calls to KVM and XEN codes.

Thanks for taking the time to refresh this.. I would prefer you use a
little more of the PV techniques I outlined in my latest PV patch to
further reduce the overhead of PV enabled kernels on real hardware.

This is an important use case, because distro kernels will have to
enable PV support while their majority of installations will be on
physical hardware.

Other than that I see no reason not to move this forward.
