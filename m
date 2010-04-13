From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [GIT PULL] perf fix
Date: Wed, 14 Apr 2010 00:51:03 +0200
Message-ID: <20100413225103.GB4720@elte.hu>
References: <1270734746.2215.56.camel@edumazet-laptop>
 <1270747919-16685-1-git-send-regression-fweisbec@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:39560 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750854Ab0DMWvO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 13 Apr 2010 18:51:14 -0400
Content-Disposition: inline
In-Reply-To: <1270747919-16685-1-git-send-regression-fweisbec@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Eric Dumazet <eric.dumazet@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Arnaldo Carvalho de Melo <acme@redhat.com>, Paul Mackerras <paulus@samba.org>, David Miller <davem@davemloft.net>, Archs <linux-arch@vger.kernel.org>


* Frederic Weisbecker <fweisbec@gmail.com> wrote:

> Ingo,
> 
> Please pull the perf/urgent branch that can be found at:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/frederic/random-tracing.git
> 	perf/urgent
> 
> Thanks,
> 	Frederic
> ---
> 
> Frederic Weisbecker (1):
>       perf: Fix unsafe frame rewinding with hot regs fetching
> 
> 
>  arch/x86/kernel/dumpstack.h |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)

Pulled, thanks a lot Frederic!

	Ingo
