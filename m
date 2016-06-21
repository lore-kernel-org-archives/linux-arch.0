Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:35883 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbcFUIz3 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jun 2016 04:55:29 -0400
Date: Tue, 21 Jun 2016 09:55:15 +0100
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: linux-next: Tree for Jun 21
Message-ID: <20160621085515.GA2888@sudip-tp>
References: <20160621154638.1169904b@canb.auug.org.au>
 <5768E650.2080506@gmail.com>
 <20160621075828.GL30154@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160621075828.GL30154@twins.programming.kicks-ass.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Chris Metcalf <cmetcalf@mellanox.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20160621085515.gXTm2fkDMHooPrE67bXeGjI4GdX12gDB3_uVg4uqKX4@z>

On Tue, Jun 21, 2016 at 09:58:28AM +0200, Peter Zijlstra wrote:
> On Tue, Jun 21, 2016 at 08:01:36AM +0100, Sudip Mukherjee wrote:
> 
> > tilepro defconfig is failing while doing "make prepare" and bisect shows the
> > first bad commit as:
> > 
> > 1af5de9af138 ("locking/atomic, arch/tile: Implement
> > atomic{,64}_fetch_{add,sub,and,or,xor}()")
> > 
> > You can find today's build log at:
> > https://travis-ci.org/sudipm-mukherjee/parport/jobs/139112570
> > 
> > Please do let me know if i can help in any way to debug/solve this.
> 
> I cannot reproduce, I tried both tip/master (which carries the patch you
> fingered) and next/master.

Thats strange.
The log I gave is for next-20160621.
BTW, I am using gcc-5.3.0

regards
sudip
