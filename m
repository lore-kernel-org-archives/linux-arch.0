From: Will Deacon <will.deacon@arm.com>
Subject: Re: [RFC PATCH 00/16] Remove unused arch_*_relax operations from
 spinlocks
Date: Mon, 24 Jun 2013 12:58:25 +0100
Message-ID: <20130624115825.GJ23779@mudshark.cambridge.arm.com>
References: <1371835057-19335-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:35837 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751621Ab3FXL65 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 24 Jun 2013 07:58:57 -0400
Content-Disposition: inline
In-Reply-To: <1371835057-19335-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Cc: catalin.marinas@arm.com, benh@kernel.crashing.org, tony.luck@intel.com, takata@linux-m32r.org, schwidefsky@de.ibm.com, lethal@linux-sh.org, tglx@linutronix.de, davem@davemloft.net, deller@gmx.de

On Fri, Jun 21, 2013 at 06:17:21PM +0100, Will Deacon wrote:
> This is an RFC cleanup series removing the unused
> arch_{spin,read,write}_relax macros from (nearly) all architectures that
> define them. The macros have no users in core code and are typically
> synonymous with cpu_relax(), the notable exceptions being PowerPC (where
> the thing is still unused) and S390.

So the `no users in core code' part isn't quite true...

With GENERIC_LOCKBREAK (arm64, ia64, m32r, parisc, powerpc, s390, sh and
sparc), we can actually spit out arch_*_relax calls in kernel/spinlock.c
using some macro concatenation that defeated my grep-fu.

This only makes a difference on powerpc and s390, so we could either:

  (1) conditionally define the relax macros as cpu_relax in spinlock.c (so
      the two guys above can have their special versions)

  (2) Replace the calls with calls to cpu_relax() (although powerpc seems to
      want to know who owns the lock in order to relax)

  (3) Leave the current code alone for architectures that may select
      GENERIC_LOCKBREAK

Any other ideas/preferences?

Will
