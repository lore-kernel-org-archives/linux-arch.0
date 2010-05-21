From: Kyle McMartin <kyle@mcmartin.ca>
Subject: Re: [PATCH 1/4] arch: local64_t
Date: Fri, 21 May 2010 10:47:46 -0400
Message-ID: <20100521144746.GB27233@bombadil.infradead.org>
References: <20100521134205.781916350@chello.nl> <20100521135944.884367426@chello.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([18.85.46.34]:52675 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755793Ab0EUOr6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 21 May 2010 10:47:58 -0400
Content-Disposition: inline
In-Reply-To: <20100521135944.884367426@chello.nl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: Ingo Molnar <mingo@elte.hu>, Paul Mackerras <paulus@samba.org>, Arnaldo Carvalho de Melo <acme@infradead.org>, Frederic Weisbecker <fweisbec@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, David Miller <davem@davemloft.net>, Paul Mundt <lethal@linux-sh.org>, Will Deacon <will.deacon@arm.com>, Deng-Cheng Zhu <dengcheng.zhu@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-arch@vger.kernel.org

On Fri, May 21, 2010 at 03:42:06PM +0200, Peter Zijlstra wrote:
> Implements local64_t.
> 
> On 64bit, local_t is of size long, and thus we make local64_t an alias.
> On 32bit, we fall back to atomic64_t.
> 
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Cc: linux-arch@vger.kernel.org
> LKML-Reference: <new-submission>

Header looks good.

Acked-by: Kyle McMartin <kyle@mcmartin.ca>
