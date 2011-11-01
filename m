Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from e3.ny.us.ibm.com ([32.97.182.143]:45709 "EHLO e3.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750900Ab1KATbB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 1 Nov 2011 15:31:01 -0400
Received: from /spool/local
	by e3.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <aliguori@us.ibm.com>;
	Tue, 1 Nov 2011 15:29:19 -0400
Message-ID: <4EB0485F.8010406@us.ibm.com>
Date: Tue, 01 Nov 2011 14:28:31 -0500
From: Anthony Liguori <aliguori@us.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH 2/6 V2] Add functions to check if the host has stopped
 the vm
References: <1320091650-24682-1-git-send-email-emunson@mgebm.net> <1320091650-24682-3-git-send-email-emunson@mgebm.net>
In-Reply-To: <1320091650-24682-3-git-send-email-emunson@mgebm.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric B Munson <emunson@mgebm.net>
Cc: avi@redhat.com, mingo@redhat.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-arch@vger.kernel.org, ryanh@linux.vnet.ibm.com
Message-ID: <20111101192831.Hw5MGX4McyroLf8oAPx-7YxhLAVVpGdKTS3VRCsd3ow@z>

On 10/31/2011 03:07 PM, Eric B Munson wrote:
> When a host stops or suspends a VM it will set a flag to show this.  The
> watchdog will use these functions to determine if a softlockup is real, or the
> result of a suspended VM.
>
> Signed-off-by: Eric B Munson<emunson@mgebm.net>
> ---
>   arch/x86/include/asm/pvclock.h |    2 ++
>   arch/x86/kernel/kvmclock.c     |   19 +++++++++++++++++++
>   2 files changed, 21 insertions(+), 0 deletions(-)
>
> diff --git a/arch/x86/include/asm/pvclock.h b/arch/x86/include/asm/pvclock.h
> index c59cc97..7d3ba41 100644
> --- a/arch/x86/include/asm/pvclock.h
> +++ b/arch/x86/include/asm/pvclock.h
> @@ -13,6 +13,8 @@ void pvclock_read_wallclock(struct pvclock_wall_clock *wall,
>   			    struct timespec *ts);
>   void pvclock_resume(void);
>
> +bool kvm_check_and_clear_host_stopped(int cpu);

A kvm-specific function shouldn't be declared in pvclock.h as this is shared 
code between KVM and Xen.

> +
>   /*
>    * Scale a 64-bit delta by scaling and multiplying by a 32-bit fraction,
>    * yielding a 64-bit result.
> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> index c1a0188..8ddcfaf 100644
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c
> @@ -113,6 +113,25 @@ static void kvm_get_preset_lpj(void)
>   	preset_lpj = lpj;
>   }
>
> +bool kvm_check_and_clear_host_stopped(int cpu)
> +{
> +	bool ret = false;
> +	struct pvclock_vcpu_time_info *src;
> +
> +	/*
> +	 * per_cpu() is safe here because this function is only called from
> +	 * timer functions where preemption is already disabled.
> +	 */
> +	WARN_ON(!in_atomic());
> +	src =&per_cpu(hv_clock, cpu);
> +	if ((src->flags&  PVCLOCK_GUEST_STOPPED) != 0) {
> +		src->flags = src->flags&  (~PVCLOCK_GUEST_STOPPED);
> +		ret = true;
> +	}

It would be helpful to separate out the patches for guest enablement from host 
enablement.  This is a guest function, correct?

Don't you need an atomic getandset here?  Can the host clear this flag or only 
set it?

It's ashame we don't have a proper pvclock spec in Documentation/.  I would 
suggest at least adding a description of how this bit works in the first patch.

Regards,

Anthony Liguori

> +
> +	return ret;
> +}
> +
>   static struct clocksource kvm_clock = {
>   	.name = "kvm-clock",
>   	.read = kvm_clock_get_cycles,

