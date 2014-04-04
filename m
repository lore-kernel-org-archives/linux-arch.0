From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v8 01/10] qspinlock: A generic 4-byte queue spinlock
	implementation
Date: Fri, 04 Apr 2014 10:59:09 -0400
Message-ID: <533EC8BD.8080601@hp.com>
References: <1396445259-27670-1-git-send-email-Waiman.Long@hp.com>
	<1396445259-27670-2-git-send-email-Waiman.Long@hp.com>
	<20140404130012.GE10526@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140404130012.GE10526@twins.programming.kicks-ass.net>
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
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Chegu Vinod <chegu_vinod@hp.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>
List-Id: linux-arch.vger.kernel.org

On 04/04/2014 09:00 AM, Peter Zijlstra wrote:
> So I'm just not ever going to pick up this patch; I spend a week trying
> to reverse engineer this; I posted a 7 patch series creating the
> equivalent, but in a gradual and readable fashion:
>
>    http://lkml.kernel.org/r/20140310154236.038181843@infradead.org
>
> You keep on ignoring that; I'll keep on ignoring your patches.
>
> I might at some point rewrite some of your pv stuff on top to get this
> moving again, but I'm not really motivated to work with you atm.

Peter, I am sorry that I have focused recently on making the qspinlock 
patch works with virtualization and it is easier for me to based off on 
my patch initially. Now the PV part is almost done, I will apply them on 
top of your patch. Hopefully, I will get a new patch out sometime next week.

I am really sorry if you have bad feeling about it. I do not mean to 
discredit you on your effort to make the qspinlock patch better. I 
really appreciate your input and would like to work with you on this 
patch as well as other future patches.

-Longman
