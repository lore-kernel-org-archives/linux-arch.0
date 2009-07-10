From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 0/2] cond_resched() optimization
Date: Sat, 11 Jul 2009 02:34:12 +0400
Message-ID: <20090710223412.GA920@oksana.dev.rtsoft.ru>
References: <20090710125755.559739294@chello.nl>
Reply-To: avorontsov@ru.mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ru.mvista.com ([213.79.90.228]:56033 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756833AbZGJWeO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Fri, 10 Jul 2009 18:34:14 -0400
Content-Disposition: inline
In-Reply-To: <20090710125755.559739294@chello.nl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Matt Mackall <mpm@selenic.com>, Andrew Morton <akpm@linux-foundation.org>, oleg@redhat.com, mingo@elte.hu

On Fri, Jul 10, 2009 at 02:57:55PM +0200, Peter Zijlstra wrote:
> Matt suggested, whereupon Linus sayeth:
> 
>  "This looks like a good patch. Please make it so"
> 
> Compile and boot tested on x86_64 only.

Tested on ppc32, boots fine.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
