From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v8 01/10] qspinlock: A generic 4-byte queue spinlock
	implementation
Date: Fri, 4 Apr 2014 19:53:35 +0200
Message-ID: <20140404175335.GA25949@gmail.com>
References: <1396445259-27670-1-git-send-email-Waiman.Long@hp.com>
	<1396445259-27670-2-git-send-email-Waiman.Long@hp.com>
	<20140404130012.GE10526@twins.programming.kicks-ass.net>
	<533EC8BD.8080601@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <533EC8BD.8080601@hp.com>
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
Cc: x86@kernel.org, Gleb Natapov <gleb@redhat.com>, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, "H. Peter Anvin" <hpa@zytor.com>, linux-arch@vger.kernel.org, kvm@vger.kernel.org, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, Paolo Bonzini <paolo.bonzini@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu Vinod <chegu_vinod@hp.com>, linux-kernel@vger.kernel.org, David Vrabel <david.vrabel@citrix.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-arch.vger.kernel.org


* Waiman Long <waiman.long@hp.com> wrote:

> On 04/04/2014 09:00 AM, Peter Zijlstra wrote:
> >
> > So I'm just not ever going to pick up this patch; I spend a week 
> > trying to reverse engineer this; I posted a 7 patch series 
> > creating the equivalent, but in a gradual and readable fashion:
> >
> >   http://lkml.kernel.org/r/20140310154236.038181843@infradead.org
> >
> > You keep on ignoring that; I'll keep on ignoring your patches.
> >
> > I might at some point rewrite some of your pv stuff on top to get 
> > this moving again, but I'm not really motivated to work with you 
> > atm.
> 
> Peter, I am sorry that I have focused recently on making the 
> qspinlock patch works with virtualization and it is easier for me to 
> based off on my patch initially. Now the PV part is almost done, I 
> will apply them on top of your patch. Hopefully, I will get a new 
> patch out sometime next week.

Note that it's not "a patch" that PeterZ posted, but a series of 7 
finegrained patches, each properly documented and commented. Please 
preserve that work, build on top of it, and don't just ignore it!

Thanks,

	Ingo
