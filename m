From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] Kconfig: remove HAVE_LATENCYTOP_SUPPORT
Date: Fri, 20 Nov 2015 10:51:37 +1100
Message-ID: <1447977097.2262.5.camel@ellerman.id.au>
References: <1447956664-2553-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:49472 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759290AbbKSXvj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 19 Nov 2015 18:51:39 -0500
In-Reply-To: <1447956664-2553-1-git-send-email-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>, linux-arch@vger.kernel.org
Cc: Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@arm.linux.org.uk>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, Helge Deller <deller@gmx.de>, "David S. Miller" <davem@davemloft.net>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Ingo Molnar <mingo@redhat.com>, Andrew Morton <akpm@linux-foundation.org>

On Thu, 2015-11-19 at 18:11 +0000, Will Deacon wrote:
> As illustrated by a3afe70b83fd ("[S390] latencytop s390 support."),
> HAVE_LATENCYTOP_SUPPORT is defined by an architecture to advertise an
> implementation of save_stack_trace_tsk.
> 
> However, as of 9212ddb5eada ("stacktrace: provide save_stack_trace_tsk()
> weak alias") a dummy implementation is provided if STACKTRACE=y.
> Given that LATENCYTOP already depends on STACKTRACE_SUPPORT and selects
> STACKTRACE, we can remove HAVE_LATENCYTOP_SUPPORT altogether.
> 
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: James Hogan <james.hogan@imgtec.com>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  arch/powerpc/Kconfig    | 3 ---

LGTM.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
