From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 11/13] ptrace: PTRACE_DETACH should do flush_ptrace_hw_breakpoint(child)
Date: Sun, 4 Aug 2013 23:16:47 -0500
Message-ID: <CAMP44s0iX_CRbCWWbrPURqKM+ksjG+8KFS56isSDG2Vs4CLjOQ@mail.gmail.com>
References: <20130513151631.GA6215@redhat.com>
	<20130513151737.GA6297@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:35738 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938Ab3HEEQt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 5 Aug 2013 00:16:49 -0400
In-Reply-To: <20130513151737.GA6297@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@elte.hu>, Jan Kratochvil <jan.kratochvil@redhat.com>, Michael Neuling <mikey@neuling.org>, Paul Mackerras <paulus@samba.org>, Paul Mundt <lethal@linux-sh.org>, Prasad <prasad@linux.vnet.ibm.com>, Russell King <linux@arm.linux.org.uk>, Will Deacon <will.deacon@arm.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, May 13, 2013 at 10:17 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> Change ptrace_detach() to call flush_ptrace_hw_breakpoint(child).
> This frees the slots for non-ptrace PERF_TYPE_BREAKPOINT users, and
> this ensures that the tracee won't be killed by SIGTRAP triggered by
> the active breakpoints.

There is something wrong with this patch. I've bisected an issue I've
seen in v3.11-rcx kernels while running Starcraft II through wine,
it's crashes 100% of the time, I revert this patch, and there's no
crash any more.

-- 
Felipe Contreras
