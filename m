From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 04/11] qspinlock: Extract out the exchange of tail code
	word
Date: Tue, 24 Jun 2014 12:47:02 +0200
Message-ID: <20140624104702.GO13930@laptop.programming.kicks-ass.net>
References: <20140615124657.264658593@chello.nl>
	<20140615130153.376621956@chello.nl>
	<20140617205525.GB29634@laptop.dumpdata.com>
	<53A17A09.6010007@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <53A17A09.6010007@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Waiman.Long@hp.com, linux-arch@vger.kernel.org, riel@redhat.com, gleb@redhat.com, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, boris.ostrovsky@oracle.com, scott.norton@hp.com, raghavendra.kt@linux.vnet.ibm.com, paolo.bonzini@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chegu_vinod@hp.com, david.vrabel@citrix.com, oleg@redhat.com, xen-devel@lists.xenproject.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org

On Wed, Jun 18, 2014 at 01:37:45PM +0200, Paolo Bonzini wrote:
> However, I *do* agree with you that it's simpler to just squash this patch
> into 01/11.

So I explicitly broke out these optimizations into separate patches so
that we can see them independently and agree they're idempotent wrt the
state machine.

The initial patches by Waiman were totally unreadable, partly because
the optimizations made the code terribly complex.

Luckily waiman then dropped the most horrible optimizations
(optimization for the very large nr_cpus case, were we cannot have a
pending byte), so the end result isn't quite as complex as it used to
be.
