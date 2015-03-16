From: David Vrabel <david.vrabel@citrix.com>
Subject: Re: [Xen-devel] [PATCH 0/9] qspinlock stuff -v15
Date: Mon, 16 Mar 2015 14:08:58 +0000
Message-ID: <5506E3FA.7040304@citrix.com>
References: <20150316131613.720617163@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150316131613.720617163@infradead.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Peter Zijlstra <peterz@infradead.org>, Waiman.Long@hp.com
Cc: linux-arch@vger.kernel.org, riel@redhat.com, x86@kernel.org, kvm@vger.kernel.org, oleg@redhat.com, scott.norton@hp.com, raghavendra.kt@linux.vnet.ibm.com, paolo.bonzini@gmail.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, doug.hatch@hp.com, hpa@zytor.com, luto@amacapital.net, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com, paulmck@linux.vnet.ibm.com, torvalds@linux-foundation.org, tglx@linutronix.de, david.vrabel@citrix.com
List-Id: linux-arch.vger.kernel.org

On 16/03/15 13:16, Peter Zijlstra wrote:
> Hi Waiman,
> 
> As promised; here is the paravirt stuff I did during the trip to BOS last week.
> 
> All the !paravirt patches are more or less the same as before (the only real
> change is the copyright lines in the first patch).
> 
> The paravirt stuff is 'simple' and KVM only -- the Xen code was a little more
> convoluted and I've no real way to test that but it should be stright fwd to
> make work.
> 
> I ran this using the virtme tool (thanks Andy) on my laptop with a 4x
> overcommit on vcpus (16 vcpus as compared to the 4 my laptop actually has) and
> it both booted and survived a hackbench run (perf bench sched messaging -g 20
> -l 5000).
> 
> So while the paravirt code isn't the most optimal code ever conceived it does work.
> 
> Also, the paravirt patching includes replacing the call with "movb $0, %arg1"
> for the native case, which should greatly reduce the cost of having
> CONFIG_PARAVIRT_SPINLOCKS enabled on actual hardware.
> 
> I feel that if someone were to do a Xen patch we can go ahead and merge this
> stuff (finally!).

I can look at this.  It looks pretty straight-forward.

> These patches do not implement the paravirt spinlock debug stats currently
> implemented (separately) by KVM and Xen, but that should not be too hard to do
> on top and in the 'generic' code -- no reason to duplicate all that.

I think this is fine.

David
