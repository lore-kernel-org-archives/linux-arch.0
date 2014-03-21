From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v7 02/11] qspinlock,
	x86: Enable x86-64 to use queue spinlock
Date: Thu, 20 Mar 2014 23:36:29 -0400
Message-ID: <532BB3BD.80905@hp.com>
References: <1395260049-30839-1-git-send-email-Waiman.Long@hp.com>
	<1395260049-30839-3-git-send-email-Waiman.Long@hp.com>
	<20140319202405.GA11210@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140319202405.GA11210@phenom.dumpdata.com>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, virtualization@lists.linux-foundation.org, Andi Kleen <andi@firstfloor.org>, "H. Peter Anvin" <hpa@zytor.com>, Michel Lespinasse <walken@google.com>, Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org, Gleb Natapov <gleb@redhat.com>, x86@kernel.org, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Rik van Riel <riel@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Scott J Norton <scott.norton@hp.com>, Steven Rostedt <rostedt@goodmis.org>, Chris Wright <chrisw@sous-sol.org>, Oleg Nesterov <oleg@redhat.com>, Alok Kataria <akataria@vmware.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Chegu Vinod <chegu_vinod@hp.com>, Boris Ostrovsky <boris.ostrovsky>
List-Id: linux-arch.vger.kernel.org

On 03/19/2014 04:24 PM, Konrad Rzeszutek Wilk wrote:
> On Wed, Mar 19, 2014 at 04:14:00PM -0400, Waiman Long wrote:
>> This patch makes the necessary changes at the x86 architecture
>> specific layer to enable the use of queue spinlock for x86-64. As
>> x86-32 machines are typically not multi-socket. The benefit of queue
>> spinlock may not be apparent. So queue spinlock is not enabled.
>>
>> Currently, there is some incompatibilities between the para-virtualized
>> spinlock code (which hard-codes the use of ticket spinlock) and the
>> queue spinlock. Therefore, the use of queue spinlock is disabled when
>> the para-virtualized spinlock is enabled.
> And how does this patch do that? I think that comment is obsolete?

This comment is true wrt patch 2. As you add more patches on top, the 
limitation is removed.

-Longman
