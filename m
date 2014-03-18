From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v6 05/11] pvqspinlock, x86: Allow unfair spinlock in a
	PV guest
Date: Tue, 18 Mar 2014 09:14:45 +0100
Message-ID: <53280075.1020804@redhat.com>
References: <1394650498-30118-1-git-send-email-Waiman.Long@hp.com>	<1394650498-30118-6-git-send-email-Waiman.Long@hp.com>	<53218E7A.8090707@citrix.com>
	<5321AF96.6070909@redhat.com>
	<20140317190511.GB11707@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140317190511.GB11707@phenom.dumpdata.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, Gleb Natapov <gleb@redhat.com>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Scott J Norton <scott.norton@hp.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Thomas Gleixner <tglx@linutronix.de>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu Vinod <chegu_vinod@hp.com>, Waiman Long <Waiman.Long@hp.com>, Oleg Nesterov <oleg@redhat.com>
List-Id: linux-arch.vger.kernel.org

Il 17/03/2014 20:05, Konrad Rzeszutek Wilk ha scritto:
>> > Measurements were done by Gleb for two guests running 2.6.32 with 16
>> > vcpus each, on a 16-core system.  One guest ran with unfair locks,
>> > one guest ran with fair locks.  Two kernel compilations ("time make
> And when you say fair locks are you saying PV ticketlocks or generic
> ticketlocks?

Generic, of course.

> You should see the same values with the PV ticketlock. It is not clear
> to me if this testing did include that variant of locks?

Yes, PV is fine.  But up to this point of the series, we are concerned 
about spinlock performance when running on an overcommitted hypervisor 
that doesn't support PV spinlocks.

Paolo
