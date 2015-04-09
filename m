From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v15 16/16] unfair qspinlock: a queue based unfair lock
Date: Thu, 9 Apr 2015 16:13:48 +0200
Message-ID: <20150409141348.GX5029@twins.programming.kicks-ass.net>
References: <1428517939-27968-1-git-send-email-Waiman.Long@hp.com>
	<20150409070146.GL27490@worktop.programming.kicks-ass.net>
	<55267BA8.9060009@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <55267BA8.9060009@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rik van Riel <riel@redhat.com>
Cc: Waiman Long <Waiman.Long@hp.com>, linux-arch@vger.kernel.org, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Oleg Nesterov <oleg@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Daniel J Blueman <daniel@numascale.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Scott J Norton <scott.norton@hp.com>, Ingo Molnar <mingo@redhat.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Douglas Hatch <doug.hatch@hp.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Apr 09, 2015 at 09:16:24AM -0400, Rik van Riel wrote:
> On 04/09/2015 03:01 AM, Peter Zijlstra wrote:
> > On Wed, Apr 08, 2015 at 02:32:19PM -0400, Waiman Long wrote:
> >> For a virtual guest with the qspinlock patch, a simple unfair byte lock
> >> will be used if PV spinlock is not configured in or the hypervisor
> >> isn't either KVM or Xen. The byte lock works fine with small guest
> >> of just a few vCPUs. On a much larger guest, however, byte lock can
> >> have serious performance problem.
> > 
> > Who cares?
> 
> There are some people out there running guests with dozens
> of vCPUs. If the code exists to make those setups run better,
> is there a good reason not to use it?

Well use paravirt, !paravirt stuff sucks performance wise anyhow.

The question really is: is the added complexity worth the maintenance
burden. And I'm just not convinced !paravirt virt is a performance
critical target.

> Having said that, only KVM and Xen seem to support very
> large guests, and PV spinlock is available there.
> 
> I believe both VMware and Hyperv have a 32 VCPU limit, anyway.

Don't we have Hyperv paravirt drivers? They could add support for
paravirt spinlocks too.
