From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v8 01/10] qspinlock: A generic 4-byte queue spinlock
	implementation
Date: Mon, 7 Apr 2014 16:16:36 +0200
Message-ID: <20140407141636.GM10526@twins.programming.kicks-ass.net>
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
Cc: linux-arch@vger.kernel.org, Rik van Riel <riel@redhat.com>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>, Gleb Natapov <gleb@redhat.com>, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Aswin Chandramouleeswaran <aswin@hp.com>, Scott J Norton <scott.norton@hp.com>, x86@kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>, Chegu Vinod <chegu_vinod@hp.com>, David Vrabel <david.vrabel@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org, Thomas Gleixner <tglx@linutronix.de>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>
List-Id: linux-arch.vger.kernel.org

On Fri, Apr 04, 2014 at 10:59:09AM -0400, Waiman Long wrote:
> I am really sorry if you have bad feeling about it. I do not mean to
> discredit you on your effort to make the qspinlock patch better. I really
> appreciate your input and would like to work with you on this patch as well
> as other future patches.

OK.. that'd be great. Sorry if I sound somewhat cranky (well I am, of
course) partly this is because jet-lag and partly because I just get
grumpy from the Inbox after travel.
