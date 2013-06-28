From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [RFC PATCH 00/16] Remove unused arch_*_relax operations from
 spinlocks
Date: Fri, 28 Jun 2013 09:31:03 +0200
Message-ID: <20130628093103.216d4d6e@mschwide>
References: <1371835057-19335-1-git-send-email-will.deacon@arm.com>
	<20130624115825.GJ23779@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp14.uk.ibm.com ([195.75.94.110]:41998 "EHLO
	e06smtp14.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168Ab3F1HbQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 28 Jun 2013 03:31:16 -0400
Received: from /spool/local
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <schwidefsky@de.ibm.com>;
	Fri, 28 Jun 2013 08:23:43 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 774C517D805C
	for <linux-arch@vger.kernel.org>; Fri, 28 Jun 2013 08:32:39 +0100 (BST)
Received: from d06av07.portsmouth.uk.ibm.com (d06av07.portsmouth.uk.ibm.com [9.149.37.248])
	by b06cxnps4075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id r5S7UxYE44630090
	for <linux-arch@vger.kernel.org>; Fri, 28 Jun 2013 07:30:59 GMT
Received: from d06av07.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av07.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id r5S7V9FE013168
	for <linux-arch@vger.kernel.org>; Fri, 28 Jun 2013 03:31:10 -0400
In-Reply-To: <20130624115825.GJ23779@mudshark.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, catalin.marinas@arm.com, benh@kernel.crashing.org, tony.luck@intel.com, takata@linux-m32r.org, lethal@linux-sh.org, tglx@linutronix.de, davem@davemloft.net, deller@gmx.de

On Mon, 24 Jun 2013 12:58:25 +0100
Will Deacon <will.deacon@arm.com> wrote:

> On Fri, Jun 21, 2013 at 06:17:21PM +0100, Will Deacon wrote:
> > This is an RFC cleanup series removing the unused
> > arch_{spin,read,write}_relax macros from (nearly) all architectures that
> > define them. The macros have no users in core code and are typically
> > synonymous with cpu_relax(), the notable exceptions being PowerPC (where
> > the thing is still unused) and S390.
> 
> So the `no users in core code' part isn't quite true...
> 
> With GENERIC_LOCKBREAK (arm64, ia64, m32r, parisc, powerpc, s390, sh and
> sparc), we can actually spit out arch_*_relax calls in kernel/spinlock.c
> using some macro concatenation that defeated my grep-fu.
> 
> This only makes a difference on powerpc and s390, so we could either:
> 
>   (1) conditionally define the relax macros as cpu_relax in spinlock.c (so
>       the two guys above can have their special versions)
> 
>   (2) Replace the calls with calls to cpu_relax() (although powerpc seems to
>       want to know who owns the lock in order to relax)
> 
>   (3) Leave the current code alone for architectures that may select
>       GENERIC_LOCKBREAK
> 
> Any other ideas/preferences?

Yeah, we never came around to implement arch_read/write_relax. We can remove
the two defines for s390, if we want to add some logic there we can just re-add
an appropriate definition. As powerpc is optimizing their read/write locks
with GENERIC_LOCKBREAK=y we should leave the ability to override the relax
function as it is, no?

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
