From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v7 10/11] pvqspinlock, x86: Enable qspinlock PV support
	for KVM
Date: Fri, 21 Mar 2014 17:41:34 -0400
Message-ID: <532CB20E.6060603@hp.com>
References: <1395260049-30839-1-git-send-email-Waiman.Long@hp.com>
	<1395260049-30839-11-git-send-email-Waiman.Long@hp.com>
	<532B668A.4010208@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <532B668A.4010208@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, Gleb Natapov <gleb@redhat.com>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Scott J Norton <scott.norton@hp.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Thomas Gleixner <tglx@linutronix.de>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu Vinod <chegu_vinod@hp.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.
List-Id: linux-arch.vger.kernel.org

On 03/20/2014 06:07 PM, Paolo Bonzini wrote:
> Il 19/03/2014 21:14, Waiman Long ha scritto:
>> This patch adds the necessary KVM specific code to allow KVM to support
>> the sleeping and CPU kicking operations needed by the queue spinlock PV
>> code.
>
> The remaining problem of this patch is that you cannot get the 
> generically optimal configuration: qspinlock on baremetal, PV 
> qspinlock on KVM/Xen, unfair qspinlock on VMware/Hyper-V.  You really 
> need to disable unfair locks in kvm_spinlock_init.
>
> Paolo
>

So you are suggesting that it is not a good idea to have both unfair 
lock & PV be enabled together. Right?

In order to disable unfair locks in kvm_spinlock_init(), it has to run 
after the unfair lock init code. Do you guys know what determine the 
init function execution sequence?

-Longman
