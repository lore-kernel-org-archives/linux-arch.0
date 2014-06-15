From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 00/11] qspinlock with paravirt support
Date: Sun, 15 Jun 2014 14:46:57 +0200
Message-ID: <20140615124657.264658593@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Waiman.Long@hp.com, tglx@linutronix.de, mingo@kernel.org
Cc: linux-arch@vger.kernel.org, riel@redhat.com, gleb@redhat.com, kvm@vger.kernel.org, konrad.wilk@oracle.com, Peter Zijlstra <peterz@infradead.org>, scott.norton@hp.com, raghavendra.kt@linux.vnet.ibm.com, paolo.bonzini@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, chegu_vinod@hp.com, david.vrabel@citrix.com, oleg@redhat.com, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

Since Waiman seems incapable of doing simple things; here's my take on the
paravirt crap.

The first few patches are taken from Waiman's latest series, but the virt
support is completely new. Its primary aim is to not mess up the native code.

I've not stress tested it, but the virt and paravirt (kvm) cases boot on simple
smp guests. I've not done Xen, but the patch should be simple and similar.

I ripped out all the unfair nonsense as its not at all required for paravirt
and optimizations that make paravirt better at the cost of code clarity and/or
native performance are just not worth it.

Also; if we were to ever add some of that unfair nonsense you do so _after_ you
got the simple things working.

The thing I'm least sure about is the head tracking, I chose to do something
different from what Waiman did, because his is O(nr_cpus) and had the
assumption that guests have small nr_cpus. AFAIK this is not at all true. The
biggest problem I have with what I did is that it contains wait loops itself.
