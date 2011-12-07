From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 3/5 V5] Add ioctl for KVMCLOCK_GUEST_STOPPED
Date: Wed, 07 Dec 2011 16:34:08 +0200
Message-ID: <4EDF7960.4080104@redhat.com>
References: <1323116344-17911-1-git-send-email-emunson@mgebm.net> <1323116344-17911-4-git-send-email-emunson@mgebm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:62109 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755955Ab1LGOeY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 7 Dec 2011 09:34:24 -0500
In-Reply-To: <1323116344-17911-4-git-send-email-emunson@mgebm.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric B Munson <emunson@mgebm.net>
Cc: mingo@redhat.com, hpa@zytor.com, arnd@arndb.de, ryanh@linux.vnet.ibm.com, aliguori@us.ibm.com, mtosatti@redhat.com, jeremy.fitzhardinge@citrix.com, levinsasha928@gmail.com, Jan Kiszka <jan.kiszka@siemens.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org

On 12/05/2011 10:19 PM, Eric B Munson wrote:
> Now that we have a flag that will tell the guest it was suspended, create an
> interface for that communication using a KVM ioctl.
>
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
>

You could also do this purely from userspace by reading the kvmclock msr
and updating it.  However, it's better to do this in the kernel to avoid
distributing responsibility for kvmclock across too many cooks.

-- 
error compiling committee.c: too many arguments to function
