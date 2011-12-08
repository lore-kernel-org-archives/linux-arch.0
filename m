From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 0/5 V5] Avoid soft lockup message when KVM is stopped by
 host
Date: Thu, 8 Dec 2011 17:04:22 +0530
Message-ID: <20111208113422.GA27919@amit-x200.redhat.com>
References: <1323116344-17911-1-git-send-email-emunson@mgebm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:22320 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750715Ab1LHLfL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 8 Dec 2011 06:35:11 -0500
Content-Disposition: inline
In-Reply-To: <1323116344-17911-1-git-send-email-emunson@mgebm.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Eric B Munson <emunson@mgebm.net>
Cc: avi@redhat.com, mingo@redhat.com, hpa@zytor.com, arnd@arndb.de, ryanh@linux.vnet.ibm.com, aliguori@us.ibm.com, mtosatti@redhat.com, jeremy.fitzhardinge@citrix.com, levinsasha928@gmail.com, Jan Kiszka <jan.kiszka@siemens.com>, kvm@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org

On (Mon) 05 Dec 2011 [15:18:59], Eric B Munson wrote:
> When a guest kernel is stopped by the host hypervisor it can look like a soft
> lockup to the guest kernel.  This false warning can mask later soft lockup
> warnings which may be real.  This patch series adds a method for a host
> hypervisor to communicate to a guest kernel that it is being stopped.  The
> final patch in the series has the watchdog check this flag when it goes to
> issue a soft lockup warning and skip the warning if the guest knows it was
> stopped.

Guest S4 would need similar treatment, and I think the code in the two
approaches can be shared.  Just something to consider.

		Amit
