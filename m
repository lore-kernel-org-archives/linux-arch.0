From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC v6 10/11] pvqspinlock, x86: Enable qspinlock PV support
	for KVM
Date: Tue, 18 Mar 2014 09:18:13 +0100
Message-ID: <53280145.5050809@redhat.com>
References: <1394650498-30118-1-git-send-email-Waiman.Long@hp.com>	<1394650498-30118-11-git-send-email-Waiman.Long@hp.com>	<5321B9BE.7050209@redhat.com>	<5322035B.5000205@hp.com>
	<5322C0F7.2090604@redhat.com> <53273532.1010003@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <53273532.1010003@hp.com>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, linux-kernel@vger, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, Gleb Natapov <gleb@redhat.com>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Scott J Norton <scott.norton@hp.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Thomas Gleixner <tglx@linutronix.de>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu Vinod <chegu_vinod@hp.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Oleg Nesterov <oleg@redhat.co>
List-Id: linux-arch.vger.kernel.org

Il 17/03/2014 18:47, Waiman Long ha scritto:
>> Yeah, what I mean is that the patches that enable paravirtualization
>> should also take care of decreasing the unfair-lock jump label when
>> paravirtualization is enabled.
>
> As there are people who don't like unfair lock at all, I prefer to give
> them the option to turn this on or off instead of forcing them to always
> use unfair lock in a PV guest.

I understand, but this is virtualization after all.  A bad scheduler 
decision means no progress at all.  That's much worse than unfairness.

And also, KVM and Xen will stay fair, so if you want fairness just pick 
a hypervisor that supports it.

Paolo
