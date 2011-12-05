Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fallback.mail.elte.hu ([157.181.151.13]:45520 "EHLO
	fallback.mail.elte.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754506Ab1LEQnl (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 5 Dec 2011 11:43:41 -0500
Date: Mon, 5 Dec 2011 17:31:48 +0100
From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCHSET tip:x86/memblock] memblock: Kill early_node_map[],
 take 2
Message-ID: <20111205163148.GA25909@elte.hu>
References: <1322508685-32532-1-git-send-email-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1322508685-32532-1-git-send-email-tj@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: benh@kernel.crashing.org, yinghai@kernel.org, hpa@zytor.com, tony.luck@intel.com, ralf@linux-mips.org, schwidefsky@de.ibm.com, liqin.chen@sunplusct.com, lethal@linux-sh.org, davem@davemloft.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, jonas@southpole.se, lennox.wu@gmail.com
Message-ID: <20111205163148.NhDjlrKRD8ePDwl304eAGgkzSDsbFYxjfAeYyObEsWs@z>


* Tejun Heo <tj@kernel.org> wrote:

> Hello,
> 
> This patchset was posted quite a while ago but got lost during the
> korg disturbance and I forgot about it too.  Thankfully, benh pinged
> me about testing this patchset yesterday, so here's the refreshed
> version.

A bit scary - you should get it into linux-next i suspect - if 
that works out then we could then put it into tip:core/memblock 
if there are no objections from anyone.

It's not really an x86 tree and most of the changes are 
affecting non-x86 architectures, right?

Thanks,

	Ingo
