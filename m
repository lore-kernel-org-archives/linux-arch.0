From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH 0/9] qspinlock stuff -v15
Date: Mon, 30 Mar 2015 12:43:39 -0400
Message-ID: <55197D3B.4020701@hp.com>
References: <20150316131613.720617163@infradead.org>
	<20150325194739.GK25884@l.oracle.com> <551978E8.30904@hp.com>
	<20150330162933.GC23123@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150330162933.GC23123@twins.programming.kicks-ass.net>
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
Cc: linux-arch@vger.kernel.org, riel@redhat.com, x86@kernel.org, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, scott.norton@hp.com, raghavendra.kt@linux.vnet.ibm.com, paolo.bonzini@gmail.com, oleg@redhat.com, linux-kernel@vger.kernel.org, mingo@redhat.com, david.vrabel@citrix.com, hpa@zytor.com, luto@amacapital.net, xen-devel@lists.xenproject.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, boris.ostrovsky@oracle.com, virtualization@lists.linux-foundation.org, doug.hatch@hp.com
List-Id: linux-arch.vger.kernel.org

On 03/30/2015 12:29 PM, Peter Zijlstra wrote:
> On Mon, Mar 30, 2015 at 12:25:12PM -0400, Waiman Long wrote:
>> I did it differently in my PV portion of the qspinlock patch. Instead of
>> just waking up the CPU, the new lock holder will check if the new queue head
>> has been halted. If so, it will set the slowpath flag for the halted queue
>> head in the lock so as to wake it up at unlock time. This should eliminate
>> your concern of dong twice as many VMEXIT in an overcommitted scenario.
> We can still do that on top of all this right? As you might have
> realized I'm a fan of gradual complexity :-)

Of course. I am just saying that the concern can be addressed with some 
additional code change.

-Longman
