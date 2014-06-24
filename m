From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 03/11] qspinlock: Add pending bit
Date: Tue, 24 Jun 2014 10:24:22 +0200
Message-ID: <20140624082422.GM13930@laptop.programming.kicks-ass.net>
References: <20140615124657.264658593@chello.nl>
	<20140615130153.196728583@chello.nl>
	<20140617203615.GA29634@laptop.dumpdata.com>
	<53A0AA6D.1070708@hp.com>
	<20140617210729.GB31817@laptop.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20140617210729.GB31817@laptop.dumpdata.com>
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
Cc: Waiman Long <waiman.long@hp.com>, linux-arch@vger.kernel.org, riel@redhat.com, gleb@redhat.com, kvm@vger.kernel.org, boris.ostrovsky@oracle.com, scott.norton@hp.com, raghavendra.kt@linux.vnet.ibm.com, paolo.bonzini@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chegu_vinod@hp.com, david.vrabel@citrix.com, oleg@redhat.com, xen-devel@lists.xenproject.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jun 17, 2014 at 05:07:29PM -0400, Konrad Rzeszutek Wilk wrote:
> > We are trying to make the fastpath as simple as possible as it may be
> > inlined. The complexity of the queue spinlock is in the slowpath.
> 
> Sure, but then it shouldn't be called slowpath anymore as it is not
> slow.

Its common terminology to call the inline part the fast path and the
out-of-line call on failure the slow path.
