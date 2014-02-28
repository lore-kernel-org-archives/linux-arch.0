From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v5 3/8] qspinlock, x86: Add x86 specific optimization for
	2 contending tasks
Date: Fri, 28 Feb 2014 18:37:12 +0100
Message-ID: <20140228173712.GZ6835@laptop.programming.kicks-ass.net>
References: <1393427668-60228-1-git-send-email-Waiman.Long@hp.com>
	<1393427668-60228-4-git-send-email-Waiman.Long@hp.com>
	<20140226162057.GW6835@laptop.programming.kicks-ass.net>
	<530FA32B.8010202@hp.com>
	<20140228092945.GG27965@twins.programming.kicks-ass.net>
	<CA+55aFyz-7NvwUN5q8xqSvHsufC4Z1NSCvnUYrKRAhBeVjUuDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFyz-7NvwUN5q8xqSvHsufC4Z1NSCvnUYrKRAhBeVjUuDA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Andi Kleen <andi@firstfloor.org>, Peter Anvin <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Alok Kataria <akataria@vmware.com>, linux-arch@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Daniel J Blueman <daniel@numascale.com>, xen-devel@lists.xenproject.org, Paul McKenney <paulmck@linux.vnet.ibm.com>, Alexander Fyodorov <halcy@yandex.ru>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, George Spelvin <linux@horizon.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, virtualization <virtualization@lists.linux-fou>
List-Id: linux-arch.vger.kernel.org

On Fri, Feb 28, 2014 at 08:25:24AM -0800, Linus Torvalds wrote:
> On Feb 28, 2014 1:30 AM, "Peter Zijlstra" <peterz@infradead.org> wrote:
> >
> > At low contention the cmpxchg won't have to be retried (much) so using
> > it won't be a problem and you get to have arbitrary atomic ops.
> 
> Peter, the difference between an atomic op and *no* atomic op is huge.

I know, I'm just asking what the difference is between the xchg() - and
atomic op, and an cmpxchg(), also an atomic op.

The xchg() makes the entire thing somewhat difficult. Needing to fixup
all kinds of states if we guessed wrong about what was in the variables.

> And Waiman posted numbers for the optimization. Why do you argue with
> handwaving and against numbers?

I've asked for his benchmark.. 
