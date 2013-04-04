From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 3/7] dump_stack: consolidate dump_stack()
 implementations and unify their behaviors
Date: Thu, 4 Apr 2013 09:13:09 +0200
Message-ID: <20130404091309.5c9da9d3@mschwide>
References: <1365016497-32033-1-git-send-email-tj@kernel.org>
	<1365016497-32033-4-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e06smtp14.uk.ibm.com ([195.75.94.110]:46254 "EHLO
	e06smtp14.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763346Ab3DDHN0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 4 Apr 2013 03:13:26 -0400
Received: from /spool/local
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <schwidefsky@de.ibm.com>;
	Thu, 4 Apr 2013 08:08:54 +0100
In-Reply-To: <1365016497-32033-4-git-send-email-tj@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, mingo@redhat.com, x86@kernel.org, rth@twiddle.net, linux@arm.linux.org.uk, msalter@redhat.com, starvik@axis.com, dhowells@redhat.com, tony.luck@intel.com, benh@kernel.crashing.org, takata@linux-m32r.org, geert@linux-m68k.org, james.hogan@imgtec.com, monstr@monstr.eu, ralf@linux-mips.org, jonas@southpole.se, rkuo@codeaurora.org, liqin.chen@sunplusct.com, davem@davemloft.net, lethal@linux-sh.org, vgupta@synopsys.com, chris@zankel.net, cmetcalf@tilera.com, ysato@users.sourceforge.jp, gxt@mprc.pku.edu.cn, jdike@addtoit.com, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Mike Frysinger <vapier@gentoo.org>, uclinux-dist-devel@blackfin.uclinux.org, Fengguang Wu <fengguang.wu@intel.com>

On Wed,  3 Apr 2013 12:14:53 -0700
Tejun Heo <tj@kernel.org> wrote:

> v2: CPU number added to the generic debug info as requested by s390
>     folks and dropped the s390 specific dump_stack().  This loses %ksp
>     from the debug message which the maintainers think isn't important
>     enough to keep the s390-specific dump_stack() implementation.
> 
>     dump_stack_print_info() is moved to kernel/printk.c from
>     lib/dump_stack.c.  Because linkage is per objecct file,
>     dump_stack_print_info() living in the same lib file as generic
>     dump_stack() means that archs which implement custom dump_stack()
>     - at this point, only blackfin - can't use dump_stack_print_info()
>     as that will bring in the generic version of dump_stack() too.  v1
>     The v1 patch broke build on blackfin due to this issue.  The build
>     breakage was reported by Fengguang Wu.

For the s390 changes:
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
