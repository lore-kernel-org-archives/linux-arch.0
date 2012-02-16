From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 3/4 V13] Add ioctl for KVM_KVMCLOCK_CTRL
Date: Thu, 16 Feb 2012 16:11:40 +0200
Message-ID: <4F3D0E9C.8030302@redhat.com>
References: <1328713666-11424-1-git-send-email-emunson@mgebm.net> <1328713666-11424-4-git-send-email-emunson@mgebm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56860 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751085Ab2BPOLy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 16 Feb 2012 09:11:54 -0500
In-Reply-To: <1328713666-11424-4-git-send-email-emunson@mgebm.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric B Munson <emunson@mgebm.net>
Cc: mingo@redhat.com, hpa@zytor.com, ryanh@linux.vnet.ibm.com, aliguori@us.ibm.com, mtosatti@redhat.com, kvm@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org

On 02/08/2012 05:07 PM, Eric B Munson wrote:
> Now that we have a flag that will tell the guest it was suspended, create an
> interface for that communication using a KVM ioctl.
>
> +
> +Capability: KVM_CAP_KVMCLOCK_CTRL
> +Architectures: Any that implement pvclocks (currently x86 only)
> +Type: vcpu ioctl
> +Parameters: None
> +Returns: 0 on success, -1 on error
> +
> +This signals to the host kernel that the specified guest is being paused by
> +userspace.  The host will set a flag in the pvclock structure that is checked
> +from the soft lockup watchdog.  

This needs to be expanded.  There is a protocol between the host and
guest that needs to be documented, including the requirement to use a
single instruction (or ll/sc) to clear the flag.  See
Documentation/virtual/kvm/msr.txt

> This ioctl can be called during pause or
> +unpause.
> +

After pausing the vcpu, but before resuming it.


-- 
error compiling committee.c: too many arguments to function
