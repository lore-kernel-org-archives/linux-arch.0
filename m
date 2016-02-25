From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Interesting csd deadlock on ARC
Date: Thu, 25 Feb 2016 14:30:46 +0000
Message-ID: <20160225143046.GR19428@n2100.arm.linux.org.uk>
References: <56C6BA82.1060909@synopsys.com>
 <56CBEC66.2030401@synopsys.com>
 <20160223095824.GH6356@twins.programming.kicks-ass.net>
 <56CD36CD.2080303@synopsys.com>
 <20160225140654.GL6357@twins.programming.kicks-ass.net>
 <56CF0E6B.5020903@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:48986 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932401AbcBYOa6 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 25 Feb 2016 09:30:58 -0500
Content-Disposition: inline
In-Reply-To: <56CF0E6B.5020903@synopsys.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Will Deacon <Will.Deacon@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Marc Zyngier <marc.zyngier@arm.com>, Frederic Weisbecker <fweisbec@gmail.com>, lkml <linux-kernel@vger.kernel.org>, Noam Camus <noamc@ezchip.com>, arcml <linux-snps-arc@lists.infradead.org>

On Thu, Feb 25, 2016 at 07:53:39PM +0530, Vineet Gupta wrote:
> But then ARM CONFIG_SMP on UP hardware will still crap out because there
> is no way to send IPI to self. Same as the bug in above discussion. I'm
> surprised they way ARM guys worked around it.

We haven't worked around it - the code which provoked the oops that was
seen (in the cpufreq code) was changed not to call it, which has the
effect of making the problem "go away", at least for now.

We still have the problem that if it does get called on UP, it'll blow
up - and I don't see any point in complicating the code for something
that never happens right now.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
