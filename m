From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/5] sparc32: make show_stack() acquire %fp if @_ksp is
 not specified
Date: Fri, 29 Mar 2013 23:29:31 -0400 (EDT)
Message-ID: <20130329.232931.1102770871482547907.davem@davemloft.net>
References: <1364610428-2074-1-git-send-email-tj@kernel.org>
	<1364610428-2074-3-git-send-email-tj@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:59995 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757662Ab3C3D3f (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 29 Mar 2013 23:29:35 -0400
In-Reply-To: <1364610428-2074-3-git-send-email-tj@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: tj@kernel.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, mingo@redhat.com, x86@kernel.org, rth@twiddle.net, linux@arm.linux.org.uk, msalter@redhat.com, starvik@axis.com, dhowells@redhat.com, tony.luck@intel.com, benh@kernel.crashing.org, takata@linux-m32r.org, geert@linux-m68k.org, james.hogan@imgtec.com, monstr@monstr.eu, ralf@linux-mips.org, jonas@southpole.se, rkuo@codeaurora.org, schwidefsky@de.ibm.com, liqin.chen@sunplusct.com, lethal@linux-sh.org, vgupta@synopsys.com, chris@zankel.net, cmetcalf@tilera.com, ysato@users.sourceforge.jp, gxt@mprc.pku.edu.cn, jdike@addtoit.com

From: Tejun Heo <tj@kernel.org>
Date: Fri, 29 Mar 2013 19:27:05 -0700

> show_stack(current or NULL, NULL) is used by arch-independent code to
> dump backtrace of the current task; however, sparc32 show_stack()
> doesn't implement it and wouldn't print any backtrace when NULL @_ksp
> is specfied.
> 
> Make show_stack() acquire and use %fp if @tsk is NULL or current and
> @_ksp is NULL.  This makes %fp fetching in dump_stack() unnecessary.
> Make it use NULL for @_ksp instead.
> 
> Only compile tested.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>

Acked-by: David S. Miller <davem@davemloft.net>
