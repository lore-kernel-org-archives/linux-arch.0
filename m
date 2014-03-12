From: Christoffer Dall <christoffer.dall@linaro.org>
Subject: Re: [PATCH v3 10/52] arm, kvm: Fix CPU hotplug callback registration
Date: Wed, 12 Mar 2014 16:21:27 -0700
Message-ID: <20140312232127.GC24808@cbox>
References: <20140310203312.10746.310.stgit@srivatsabhat.in.ibm.com>
 <20140310203538.10746.25364.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20140310203538.10746.25364.stgit@srivatsabhat.in.ibm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: ego@linux.vnet.ibm.com, kvm@vger.kernel.org, peterz@infradead.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org, walken@google.com, kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org, linux@arm.linux.org.uk, mingo@kernel.org, marc.zyngier@arm.com, paulmck@linux.vnet.ibm.com, linux-pm@vger.kernel.org, Gleb Natapov <gleb@kernel.org>, rusty@rustcorp.com.au, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, rjw@rjwysocki.net, oleg@redhat.com, tj@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, akpm@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

On Tue, Mar 11, 2014 at 02:05:38AM +0530, Srivatsa S. Bhat wrote:
> Subsystems that want to register CPU hotplug callbacks, as well as perform
> initialization for the CPUs that are already online, often do it as shown
> below:
> 
> 	get_online_cpus();
> 
> 	for_each_online_cpu(cpu)
> 		init_cpu(cpu);
> 
> 	register_cpu_notifier(&foobar_cpu_notifier);
> 
> 	put_online_cpus();
> 
> This is wrong, since it is prone to ABBA deadlocks involving the
> cpu_add_remove_lock and the cpu_hotplug.lock (when running concurrently
> with CPU hotplug operations).
> 
> Instead, the correct and race-free way of performing the callback
> registration is:
> 
> 	cpu_notifier_register_begin();
> 
> 	for_each_online_cpu(cpu)
> 		init_cpu(cpu);
> 
> 	/* Note the use of the double underscored version of the API */
> 	__register_cpu_notifier(&foobar_cpu_notifier);
> 
> 	cpu_notifier_register_done();
> 
> 
> Fix the kvm code in arm by using this latter form of callback registration.
> 
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Gleb Natapov <gleb@kernel.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: kvmarm@lists.cs.columbia.edu
> Cc: kvm@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> ---
> 
>  arch/arm/kvm/arm.c |    7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index bd18bb8..f0e50a0 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -1051,21 +1051,26 @@ int kvm_arch_init(void *opaque)
>  		}
>  	}
>  
> +	cpu_notifier_register_begin();
> +
>  	err = init_hyp_mode();
>  	if (err)
>  		goto out_err;
>  
> -	err = register_cpu_notifier(&hyp_init_cpu_nb);
> +	err = __register_cpu_notifier(&hyp_init_cpu_nb);
>  	if (err) {
>  		kvm_err("Cannot register HYP init CPU notifier (%d)\n", err);
>  		goto out_err;
>  	}
>  
> +	cpu_notifier_register_done();
> +
>  	hyp_cpu_pm_init();
>  
>  	kvm_coproc_table_init();
>  	return 0;
>  out_err:
> +	cpu_notifier_register_done();
>  	return err;
>  }
>  
> 

Just so we're clear, the existing code was simply racy as not prone to
deadlocks, right?

This makes it clear that the test above for compatible CPUs can be quite
easily evaded by using CPU hotplug, but we don't really have a good
solution for handling that yet...  Hmmm, grumble grumble, I guess if you
hotplug unsupported CPUs on a KVM/ARM system for now, stuff will break.

In any case:
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
