From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 3/4 V7] Add ioctl for KVMCLOCK_GUEST_STOPPED
Date: Thu, 22 Dec 2011 12:06:46 +0200
Message-ID: <4EF30136.2060100@redhat.com>
References: <1323978126-13222-1-git-send-email-emunson@mgebm.net> <1323978126-13222-4-git-send-email-emunson@mgebm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1323978126-13222-4-git-send-email-emunson@mgebm.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric B Munson <emunson@mgebm.net>
Cc: mingo@redhat.com, hpa@zytor.com, arnd@arndb.de, ryanh@linux.vnet.ibm.com, aliguori@us.ibm.com, mtosatti@redhat.com, jeremy.fitzhardinge@citrix.com, kvm@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On 12/15/2011 09:42 PM, Eric B Munson wrote:
> Now that we have a flag that will tell the guest it was suspended, create an
> interface for that communication using a KVM ioctl.
>  
> +4.64 KVMCLOCK_GUEST_PAUSED
> +
> +Capability: basic
> +Architechtures: Any that implement pvclocks (currently x86 only)
> +Type: vcpu ioctl
> +Parameters: None
> +Returns: 0 on success, -1 on error
> +
> +This signals to the host kernel that the specified guest is being paused by
> +userspace.  The host will set a flag in the pvclock structure that is checked
> +from the soft lockup watchdog.
> +

This can be called during unpause, yes? The documentation should reflect
that.  I'm thinking of the SIGCONT handler here.

-- 
error compiling committee.c: too many arguments to function
