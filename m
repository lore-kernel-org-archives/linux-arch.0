From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 3/4 V13] Add ioctl for KVM_KVMCLOCK_CTRL
Date: Sat, 18 Feb 2012 12:30:59 +0200
Message-ID: <4F3F7DE3.9000009@redhat.com>
References: <1329423541-11677-1-git-send-email-emunson@mgebm.net> <1329423541-11677-4-git-send-email-emunson@mgebm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1329423541-11677-4-git-send-email-emunson@mgebm.net>
Sender: kvm-owner@vger.kernel.org
To: Eric B Munson <emunson@mgebm.net>
Cc: mingo@redhat.com, hpa@zytor.com, ryanh@linux.vnet.ibm.com, aliguori@us.ibm.com, mtosatti@redhat.com, kvm@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 02/16/2012 10:19 PM, Eric B Munson wrote:
> Now that we have a flag that will tell the guest it was suspended, create an
> interface for that communication using a KVM ioctl.
> +4.70 KVM_KVMCLOCK_CTRL
> +
> +Capability: KVM_CAP_KVMCLOCK_CTRL
> +Architectures: Any that implement pvclocks (currently x86 only)
> +Type: vcpu ioctl
> +Parameters: None
> +Returns: 0 on success, -1 on error
> +
> +This signals to the host kernel that the specified guest is being paused by
> +userspace.  The host will set a flag in the pvclock structure that is checked
> +from the soft lockup watchdog.  The flag is part of the pvclock structure that
> +is shared between guest and host, specifically the second bit of the flags
> +field of the pvclock_vcpu_time_info structure.  It will be set exclusively by
> +the host and read/cleared exclusively by the guest.  The guest operation of
> +checking and clearing the flag must an atomic operation so use of the function
> +check_and_clear_guest_paused() is encouraged, but it could also be done with
> +load-link/store-conditional.  There are two cases where the guest will clear
> +the flag: when the soft lockup watchdog timer resets itself or when a soft
> +lockup is detected.  This ioctl can be called any time after pausing
> +the vcpu, but before it is resumed.
> +
>

Sorry to see this go into v15, but this splits the pvclock abi
documentation into two pieces.  Please update the master in msr.txt.

Also don't use guest terms (like check_and_clear_guest_paused()) - this
documentation should be usable by other OS writers without resorting to
reading the Linux kernel source.

-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.

