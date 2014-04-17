From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v9 05/19] qspinlock: Optimize for smaller NR_CPUS
Date: Thu, 17 Apr 2014 17:33:06 -0400
Message-ID: <53504892.60404@hp.com>
References: <1397747051-15401-1-git-send-email-Waiman.Long@hp.com>
	<1397747051-15401-6-git-send-email-Waiman.Long@hp.com>
	<20140417155115.GQ11096@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140417155115.GQ11096@twins.programming.kicks-ass.net>
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
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Chegu Vinod <chegu_vinod@hp.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>
List-Id: linux-arch.vger.kernel.org

On 04/17/2014 11:51 AM, Peter Zijlstra wrote:
> On Thu, Apr 17, 2014 at 11:03:57AM -0400, Waiman Long wrote:
>> @@ -48,6 +53,9 @@
>>    * We can further change the first spinner to spin on a bit in the lock word
>>    * instead of its node; whereby avoiding the need to carry a node from lock to
>>    * unlock, and preserving API.
>> + *
>> + * N.B. The current implementation only supports architectures that allow
>> + *      atomic operations on smaller 8-bit and 16-bit data types.
>>    */
> Only for the _Q_PENDING_BITS == 8 case, the other case should still be
> fine.

Yes, but _Q_PENDING_BITS is controlled by NR_CPUS which, for almost all 
the distributions, is less than 16K which means _Q_PENDING_BITS will 
always be set to 8, especially for non-x86 architectures.

-Longman
