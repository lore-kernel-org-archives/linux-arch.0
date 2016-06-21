From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: Re: linux-next: Tree for Jun 21
Date: Tue, 21 Jun 2016 09:55:15 +0100
Message-ID: <20160621085515.GA2888@sudip-tp>
References: <20160621154638.1169904b@canb.auug.org.au>
 <5768E650.2080506@gmail.com>
 <20160621075828.GL30154@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160621075828.GL30154@twins.programming.kicks-ass.net>
Sender: linux-next-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Chris Metcalf <cmetcalf@mellanox.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
