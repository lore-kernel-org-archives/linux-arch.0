From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH 0/4 V13] Avoid soft lockup message when KVM is stopped by
 host
Date: Tue, 14 Feb 2012 13:38:36 -0200
Message-ID: <20120214153836.GA21106@amt.cnet>
References: <1328713666-11424-1-git-send-email-emunson@mgebm.net>
 <20120214152931.GA6881@mgebm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:10357 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751428Ab2BNPlN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 14 Feb 2012 10:41:13 -0500
Content-Disposition: inline
In-Reply-To: <20120214152931.GA6881@mgebm.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric B Munson <emunson@mgebm.net>
Cc: avi@redhat.com, mingo@redhat.com, hpa@zytor.com, ryanh@linux.vnet.ibm.com, aliguori@us.ibm.com, kvm@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org

On Tue, Feb 14, 2012 at 10:29:31AM -0500, Eric B Munson wrote:
> On Wed, 08 Feb 2012, Eric B Munson wrote:
> 
> > 
> > When a guest kernel is stopped by the host hypervisor it can look like a soft
> > lockup to the guest kernel.  This false warning can mask later soft lockup
> > warnings which may be real.  This patch series adds a method for a host
> > hypervisor to communicate to a guest kernel that it is being stopped.  The
> > final patch in the series has the watchdog check this flag when it goes to
> > issue a soft lockup warning and skip the warning if the guest knows it was
> > stopped.
> > 
> > It was attempted to solve this in Qemu, but the side effects of saving and
> > restoring the clock and tsc for each vcpu put the wall clock of the guest behind
> > by the amount of time of the pause.  This forces a guest to have ntp running
> > in order to keep the wall clock accurate.
> 
> Avi,
> 
> Is this set fit for merging or is there something else you want changed?

Eric,

On Message-ID: <20120210160536.GA23363@amt.cnet>, i asked:

How is the stub getting included for other architectures again?
