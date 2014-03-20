From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v7 06/11] pvqspinlock, x86: Allow unfair queue spinlock
	in a KVM guest
Date: Thu, 20 Mar 2014 23:40:08 +0100
Message-ID: <532B6E48.2070205@redhat.com>
References: <1395260049-30839-1-git-send-email-Waiman.Long@hp.com>	<1395260049-30839-7-git-send-email-Waiman.Long@hp.com>	<532B6543.7050707@redhat.com>
	<532B6BC8.8010502@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <532B6BC8.8010502@zytor.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "H. Peter Anvin" <hpa@zytor.com>, Waiman Long <Waiman.Long@hp.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, Aswin Chandramouleeswaran <aswin@hp.com>, Andi Kleen <andi@firstfloor.org>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, Gleb Natapov <gleb@redhat.com>, x86@kernel.org, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Scott J Norton <scott.norton@hp.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, virtualization@lists.linux-foundation.org, Chegu Vinod <chegu_vinod@hp.com>, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, David Vrabel <david.vrabel@citrix.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

Il 20/03/2014 23:29, H. Peter Anvin ha scritto:
> > No!  Please do what I asked you to do.  You are not handling Hyper-V or
> > VMWare.  Just use X86_FEATURE_HYPERVISOR and it will cover all
> > hypervisors that actually follow Intel's guidelines.
>
> And for those that don't, we should turn on X86_FEATURE_HYPERVISOR in
> the Linux enumeration code as we do for other features we detect
> independently.

Yeah, but all the hypervisors we detect right now are fine.  Not 
surprising, since Microsoft won't certify Windows on your hypervisor 
unless you set the bit, and KVM/Xen/VMware are all certified (Hyper-V 
does not go through the same certification, but sets it anyway).

I got a second-hand report that VirtualBox doesn't set it---and I 
haven't verified that yet---but we don't even try to detect vbox right now.

Paolo
