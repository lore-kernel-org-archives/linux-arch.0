Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56658 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752029Ab1LVKHD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Dec 2011 05:07:03 -0500
Message-ID: <4EF30136.2060100@redhat.com>
Date: Thu, 22 Dec 2011 12:06:46 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH 3/4 V7] Add ioctl for KVMCLOCK_GUEST_STOPPED
References: <1323978126-13222-1-git-send-email-emunson@mgebm.net> <1323978126-13222-4-git-send-email-emunson@mgebm.net>
In-Reply-To: <1323978126-13222-4-git-send-email-emunson@mgebm.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric B Munson <emunson@mgebm.net>
Cc: mingo@redhat.com, hpa@zytor.com, arnd@arndb.de, ryanh@linux.vnet.ibm.com, aliguori@us.ibm.com, mtosatti@redhat.com, jeremy.fitzhardinge@citrix.com, kvm@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20111222100646.w6jy92u6NI6RKm7u7ckXvkvKMc0I-PX_NhZ-d9duB3g@z>

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

