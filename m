Return-Path: <wli@holomorphy.com>
Received: from holomorphy.com ([207.189.100.168]:57251 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264065AbUDVOGa (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Apr 2004 10:06:30 -0400
Date: Thu, 22 Apr 2004 07:06:24 -0700
From: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [Patch] SMP call function cleanup
Message-ID: <20040422140624.GW743@holomorphy.com>
References: <1082636511.1332.34.camel@halo> <20040422122818.GR743@holomorphy.com> <20040422123703.GY22027@krispykreme> <1082638779.1778.16.camel@mulgrave> <20040422132443.GV743@holomorphy.com> <1082641576.1714.36.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082641576.1714.36.camel@mulgrave>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Anton Blanchard <anton@samba.org>, Jan Glauber <glauber@gmx.de>, linux-arch@vger.kernel.org, schwidefsky@de.ibm.com
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2004-04-22 at 09:24, William Lee Irwin III wrote:
>> 	for_each_cpu_mask(cpu, foo->mask)
>> 		on_one_cpu(cpu, bar, ...);

On Thu, Apr 22, 2004 at 09:46:16AM -0400, James Bottomley wrote:
> But the key is 'anyone in need of'.  What I'd like is for you to
> demonstrate a need of execute on cpumask before it gets added to the
> API.  Murphy's law says that when given a choice people invariably make
> the wrong one, so lets not introduce choice into the api unless it's
> absolutely necessary.

I remembered what cw told me. It was for ia64 repairing the suboptimal
situation where flush_tlb_mm() does the wrong thing and flushes on all
cpus regardless of mm->cpu_vm_mask. So we can drop this rather easily,
as even when it's resolved, that will be pure arch code that will have
the native IPI API's visible to it.

zwane wanted it for some 100% lockless timer code, but I think that's
dead or not getting merged in the near future, so the same applies.


-- wli
