From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCHSET tip:x86/memblock] memblock: Kill early_node_map[],
 take 2
Date: Tue, 06 Dec 2011 07:26:53 +1100
Message-ID: <1323116813.660.20.camel@pasglop>
References: <1322508685-32532-1-git-send-email-tj@kernel.org>
	 <20111205163148.GA25909@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:38489 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932174Ab1LEU2D (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 5 Dec 2011 15:28:03 -0500
In-Reply-To: <20111205163148.GA25909@elte.hu>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Tejun Heo <tj@kernel.org>, yinghai@kernel.org, hpa@zytor.com, tony.luck@intel.com, ralf@linux-mips.org, schwidefsky@de.ibm.com, liqin.chen@sunplusct.com, lethal@linux-sh.org, davem@davemloft.net, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com, jonas@southpole.se, lennox.wu@gmail.com

On Mon, 2011-12-05 at 17:31 +0100, Ingo Molnar wrote:
> * Tejun Heo <tj@kernel.org> wrote:
> 
> > Hello,
> > 
> > This patchset was posted quite a while ago but got lost during the
> > korg disturbance and I forgot about it too.  Thankfully, benh pinged
> > me about testing this patchset yesterday, so here's the refreshed
> > version.
> 
> A bit scary - you should get it into linux-next i suspect - if 
> that works out then we could then put it into tip:core/memblock 
> if there are no objections from anyone.
> 
> It's not really an x86 tree and most of the changes are 
> affecting non-x86 architectures, right?

They do look nice tho. I've asked some folks familiar with NUMA stuff
here at IBM to give them a spin on power, haven't heard back yet.

Cheers,
Ben.
