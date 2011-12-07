From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 0/5 V5] Avoid soft lockup message when KVM is stopped
 by host
Date: Wed, 07 Dec 2011 16:41:17 +0200
Message-ID: <4EDF7B0D.4060001@redhat.com>
References: <1323116344-17911-1-git-send-email-emunson@mgebm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:25394 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755798Ab1LGOle (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 7 Dec 2011 09:41:34 -0500
In-Reply-To: <1323116344-17911-1-git-send-email-emunson@mgebm.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric B Munson <emunson@mgebm.net>
Cc: mingo@redhat.com, hpa@zytor.com, arnd@arndb.de, ryanh@linux.vnet.ibm.com, aliguori@us.ibm.com, mtosatti@redhat.com, jeremy.fitzhardinge@citrix.com, levinsasha928@gmail.com, Jan Kiszka <jan.kiszka@siemens.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org

On 12/05/2011 10:18 PM, Eric B Munson wrote:
> Changes from V4:
> Rename KVM_GUEST_PAUSED to KVMCLOCK_GUEST_PAUSED
> Add description of KVMCLOCK_GUEST_PAUSED ioctl to api.txt
>
> Changes from V3:
> Include CC's on patch 3
> Drop clear flag ioctl and have the watchdog clear the flag when it is reset
>
> Changes from V2:
> A new kvm functions defined in kvm_para.h, the only change to pvclock is the
> initial flag definition
>
> Changes from V1:
> (Thanks Marcelo)
> Host code has all been moved to arch/x86/kvm/x86.c
> KVM_PAUSE_GUEST was renamed to KVM_GUEST_PAUSED
>
> When a guest kernel is stopped by the host hypervisor it can look like a soft
> lockup to the guest kernel.  This false warning can mask later soft lockup
> warnings which may be real.  This patch series adds a method for a host
> hypervisor to communicate to a guest kernel that it is being stopped.  The
> final patch in the series has the watchdog check this flag when it goes to
> issue a soft lockup warning and skip the warning if the guest knows it was
> stopped.
>
> It was attempted to solve this in Qemu, but the side effects of saving and
> restoring the clock and tsc for each vcpu put the wall clock of the guest behind
> by the amount of time of the pause.  This forces a guest to have ntp running
> in order to keep the wall clock accurate.

Having this controlled from userspace means it doesn't work for SIGSTOP
or for long scheduling delays.  What about doing this automatically
based on preempt notifiers?


-- 
error compiling committee.c: too many arguments to function
