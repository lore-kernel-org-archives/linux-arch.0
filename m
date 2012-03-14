From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH 2/4 V16] Add functions to check if the host has stopped
 the vm
Date: Wed, 14 Mar 2012 11:12:35 +0100
Message-ID: <4F606F13.1040704@siemens.com>
References: <1331408248-6781-1-git-send-email-emunson@mgebm.net> <1331408248-6781-3-git-send-email-emunson@mgebm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1331408248-6781-3-git-send-email-emunson@mgebm.net>
Sender: kvm-owner@vger.kernel.org
To: Eric B Munson <emunson@mgebm.net>
Cc: avi@redhat.com, mingo@redhat.com, hpa@zytor.com, ryanh@linux.vnet.ibm.com, aliguori@us.ibm.com, mtosatti@redhat.com, kvm@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 2012-03-10 20:37, Eric B Munson wrote:
> When a host stops or suspends a VM it will set a flag to show this.  =
The
> watchdog will use these functions to determine if a softlockup is rea=
l, or the
> result of a suspended VM.
>=20

=2E..

> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> index f8492da..4ba090c 100644
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c
> @@ -22,6 +22,7 @@
>  #include <asm/msr.h>
>  #include <asm/apic.h>
>  #include <linux/percpu.h>
> +#include <linux/hardirq.h>
> =20
>  #include <asm/x86_init.h>
>  #include <asm/reboot.h>
> @@ -114,6 +115,26 @@ static void kvm_get_preset_lpj(void)
>  	preset_lpj =3D lpj;
>  }
> =20
> +bool kvm_check_and_clear_guest_paused(void)
> +{
> +	bool ret =3D false;
> +	struct pvclock_vcpu_time_info *src;
> +
> +	/*
> +	 * per_cpu() is safe here because this function is only called from
> +	 * timer functions where preemption is already disabled.
> +	 */
> +	WARN_ON(!in_atomic());
> +	src =3D &__get_cpu_var(hv_clock);
> +	if ((src->flags & PVCLOCK_GUEST_STOPPED) !=3D 0) {
> +		__this_cpu_and(hv_clock.flags, ~PVCLOCK_GUEST_STOPPED);
> +		ret =3D true;
> +	}
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(kvm_check_and_clear_guest_paused);

Which module is going to use this? I failed to find it, but I may have
missed something.

The actual reason for this reply: this patches causes a compiler warnin=
g
here, likely due to lacking include for EXPORT_SYMBOL_GPL:

  CC      arch/x86/kernel/kvmclock.o
/data/linux-kvm/arch/x86/kernel/kvmclock.c:136:1: warning: data
definition has no type or storage class
/data/linux-kvm/arch/x86/kernel/kvmclock.c:136:1: warning: type default=
s
to =E2=80=98int=E2=80=99 in declaration of =E2=80=98EXPORT_SYMBOL_GPL=E2=
=80=99
/data/linux-kvm/arch/x86/kernel/kvmclock.c:136:1: warning: parameter
names (without types) in function declaration

Jan

--=20
Siemens AG, Corporate Technology, CT T DE IT 1
Corporate Competence Center Embedded Linux
