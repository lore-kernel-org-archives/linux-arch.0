From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 3/4 V7] Add ioctl for KVMCLOCK_GUEST_STOPPED
Date: Thu, 22 Dec 2011 12:11:02 +0200
Message-ID: <4EF30236.1040204@redhat.com>
References: <1323978126-13222-1-git-send-email-emunson@mgebm.net> <1323978126-13222-4-git-send-email-emunson@mgebm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1323978126-13222-4-git-send-email-emunson@mgebm.net>
Sender: kvm-owner@vger.kernel.org
To: Eric B Munson <emunson@mgebm.net>
Cc: mingo@redhat.com, hpa@zytor.com, arnd@arndb.de, ryanh@linux.vnet.ibm.com, aliguori@us.ibm.com, mtosatti@redhat.com, jeremy.fitzhardinge@citrix.com, kvm@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 12/15/2011 09:42 PM, Eric B Munson wrote:
> Now that we have a flag that will tell the guest it was suspended, create an
> interface for that communication using a KVM ioctl.
>
>  
> +int kvm_set_guest_paused(struct kvm_vcpu *vcpu);

Please avoid the needless forward declaration.

> +
>  extern bool tdp_enabled;
>  
>  u64 vcpu_tsc_khz(struct kvm_vcpu *vcpu);
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index c38efd7..1dab5fd 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3295,6 +3295,10 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  
>  		goto out;
>  	}
> +	case KVMCLOCK_GUEST_PAUSED: {
> +		r = kvm_set_guest_paused(vcpu);
> +		break;
> +	}
>  	default:
>  		r = -EINVAL;
>  	}
> @@ -6117,6 +6121,22 @@ int kvm_task_switch(struct kvm_vcpu *vcpu, u16 tss_selector, int reason,
>  }
>  EXPORT_SYMBOL_GPL(kvm_task_switch);
>  
> +/*
> + * kvm_set_guest_paused() indicates to the guest kernel that it has been
> + * stopped by the hypervisor.  This function will be called from the host only.
> + * EINVAL is returned when the host attempts to set the flag for a guest that
> + * does not support pv clocks.
> + */
> +int kvm_set_guest_paused(struct kvm_vcpu *vcpu)
> +{
> +	struct pvclock_vcpu_time_info *src = &vcpu->arch.hv_clock;
> +	if (!vcpu->arch.time_page)
> +		return -EINVAL;
> +	src->flags |= PVCLOCK_GUEST_STOPPED;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(kvm_set_guest_paused);
> +
>

You're writing to a page without mark_page_dirty(), this breaks live
migration.

-- 
error compiling committee.c: too many arguments to function

