From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 0/9] qspinlock stuff -v15
Date: Mon, 16 Mar 2015 14:16:13 +0100
Message-ID: <20150316131613.720617163@infradead.org>
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
To: Waiman.Long@hp.com
Cc: raghavendra.kt@linux.vnet.ibm.com, kvm@vger.kernel.org, peterz@infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com, boris.ostrovsky@oracle.com, linux-arch@vger.kernel.org, x86@kernel.org, mingo@redhat.com, doug.hatch@hp.com, xen-devel@lists.xenproject.org, paulmck@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, scott.norton@hp.com, paolo.bonzini@gmail.com, tglx@linutronix.de, virtualization@lists.linux-foundation.org, oleg@redhat.com, luto@amacapital.net, david.vrabel@citrix.com, torvalds@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

Hi Waiman,

As promised; here is the paravirt stuff I did during the trip to BOS last week.

All the !paravirt patches are more or less the same as before (the only real
change is the copyright lines in the first patch).

The paravirt stuff is 'simple' and KVM only -- the Xen code was a little more
convoluted and I've no real way to test that but it should be stright fwd to
make work.

I ran this using the virtme tool (thanks Andy) on my laptop with a 4x
overcommit on vcpus (16 vcpus as compared to the 4 my laptop actually has) and
it both booted and survived a hackbench run (perf bench sched messaging -g 20
-l 5000).

So while the paravirt code isn't the most optimal code ever conceived it does work.

Also, the paravirt patching includes replacing the call with "movb $0, %arg1"
for the native case, which should greatly reduce the cost of having
CONFIG_PARAVIRT_SPINLOCKS enabled on actual hardware.

I feel that if someone were to do a Xen patch we can go ahead and merge this
stuff (finally!).

These patches do not implement the paravirt spinlock debug stats currently
implemented (separately) by KVM and Xen, but that should not be too hard to do
on top and in the 'generic' code -- no reason to duplicate all that.

Of course; once this lands people can look at improving the paravirt nonsense.
