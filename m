From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 0/5 V4]  Avoid soft lockup message when KVM is stopped by
 host
Date: Thu, 1 Dec 2011 19:25:58 -0200
Message-ID: <20111201212558.GC25290@amt.cnet>
References: <1322602539-27004-1-git-send-email-emunson@mgebm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:16774 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754243Ab1LAV1O (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 1 Dec 2011 16:27:14 -0500
Content-Disposition: inline
In-Reply-To: <1322602539-27004-1-git-send-email-emunson@mgebm.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric B Munson <emunson@mgebm.net>
Cc: avi@redhat.com, mingo@redhat.com, hpa@zytor.com, arnd@arndb.de, ryanh@linux.vnet.ibm.com, aliguori@us.ibm.com, jeremy.fitzhardinge@citrix.com, kvm@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org

On Tue, Nov 29, 2011 at 04:35:34PM -0500, Eric B Munson wrote:
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

Looks good to me.
