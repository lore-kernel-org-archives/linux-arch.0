From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 2/5 V5] Add functions to check if the host has stopped
 the vm
Date: Wed, 07 Dec 2011 16:31:33 +0200
Message-ID: <4EDF78C5.8060908@redhat.com>
References: <1323116344-17911-1-git-send-email-emunson@mgebm.net> <1323116344-17911-3-git-send-email-emunson@mgebm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59086 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756019Ab1LGObt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 7 Dec 2011 09:31:49 -0500
In-Reply-To: <1323116344-17911-3-git-send-email-emunson@mgebm.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric B Munson <emunson@mgebm.net>
Cc: mingo@redhat.com, hpa@zytor.com, arnd@arndb.de, ryanh@linux.vnet.ibm.com, aliguori@us.ibm.com, mtosatti@redhat.com, jeremy.fitzhardinge@citrix.com, levinsasha928@gmail.com, Jan Kiszka <jan.kiszka@siemens.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org

On 12/05/2011 10:19 PM, Eric B Munson wrote:
> When a host stops or suspends a VM it will set a flag to show this.  The
> watchdog will use these functions to determine if a softlockup is real, or the
> result of a suspended VM.
>  
> +bool kvm_check_and_clear_guest_paused(int cpu)
> +{
> +	bool ret = false;
> +	struct pvclock_vcpu_time_info *src;
> +
> +	/*
> +	 * per_cpu() is safe here because this function is only called from
> +	 * timer functions where preemption is already disabled.
> +	 */
> +	WARN_ON(!in_atomic());
> +	src = &per_cpu(hv_clock, cpu);

__get_cpu_var(); drop the cpu argument

> +	if ((src->flags & PVCLOCK_GUEST_STOPPED) != 0) {
> +		src->flags = src->flags & (~PVCLOCK_GUEST_STOPPED);

Isn't this racy?  Between reading and writing src->flags, we can exit to
the hypervisor and add/remove new flags.  The write then overrides those
new flags.

> +		ret = true;
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(kvm_check_and_clear_guest_paused);
> +
>  static struct clocksource kvm_clock = {
>  	.name = "kvm-clock",
>  	.read = kvm_clock_get_cycles,


-- 
error compiling committee.c: too many arguments to function
