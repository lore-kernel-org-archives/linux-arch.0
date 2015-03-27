From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/9] qspinlock stuff -v15
Date: Fri, 27 Mar 2015 12:10:48 +0530
Message-ID: <5514FB70.4010600@linux.vnet.ibm.com>
References: <20150316131613.720617163@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150316131613.720617163@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Waiman.Long@hp.com, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, paolo.bonzini@gmail.com, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com, paulmck@linux.vnet.ibm.com, riel@redhat.com, torvalds@linux-foundation.org, david.vrabel@citrix.com, oleg@redhat.com, scott.norton@hp.com, doug.hatch@hp.com, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, luto@amacapital.net
List-Id: linux-arch.vger.kernel.org

On 03/16/2015 06:46 PM, Peter Zijlstra wrote:
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
>
> These patches do not implement the paravirt spinlock debug stats currently
> implemented (separately) by KVM and Xen, but that should not be too hard to do
> on top and in the 'generic' code -- no reason to duplicate all that.
>
> Of course; once this lands people can look at improving the paravirt nonsense.
>

last time I had reported some hangs in kvm case, and I can confirm that
the current set of patches works fine.

Feel free to add
Tested-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com> #kvm pv

As far as performance is concerned (with my 16core +ht machine having
16vcpu guests [ even w/ , w/o the lfsr hash patchset ]), I do not see
any significant observations to report, though I understand that we
could see much more benefit with large number of vcpus because of
possible reduction in cache bouncing.
