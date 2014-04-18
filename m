From: Waiman Long <waiman.long@hp.com>
Subject: Re: [PATCH v9 05/19] qspinlock: Optimize for smaller NR_CPUS
Date: Fri, 18 Apr 2014 17:40:15 -0400
Message-ID: <53519BBF.7060506@hp.com>
References: <1397747051-15401-1-git-send-email-Waiman.Long@hp.com>
	<1397747051-15401-6-git-send-email-Waiman.Long@hp.com>
	<20140417155649.GR11096@twins.programming.kicks-ass.net>
	<53504BB3.4010009@hp.com>
	<20140418082716.GZ11096@twins.programming.kicks-ass.net>
	<53516672.3010701@hp.com>
	<20140418190519.GA11182@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140418190519.GA11182@twins.programming.kicks-ass.net>
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

On 04/18/2014 03:05 PM, Peter Zijlstra wrote:
> On Fri, Apr 18, 2014 at 01:52:50PM -0400, Waiman Long wrote:
>> I am confused by your notation.
> Nah, I think I was confused :-) Make the 1 _Q_LOCKED_VAL though, as
> that's the proper constant to use.

Everyone gets confused once in a while:-) I have plenty of that myself.

I will change 1 to _Q_LOCKED_VAL as suggested.

-Longman
