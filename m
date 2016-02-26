From: Will Deacon <will.deacon@arm.com>
Subject: Re: Fw: Getting an early start on C++ standards issues...
Date: Fri, 26 Feb 2016 15:22:38 +0000
Message-ID: <20160226152238.GE29125@arm.com>
References: <20160226145057.GA6734@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60253 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754638AbcBZPW3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Fri, 26 Feb 2016 10:22:29 -0500
Content-Disposition: inline
In-Reply-To: <20160226145057.GA6734@linux.vnet.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: ralf@linux-mips.org, tony.luck@intel.com, fenghua.yu@intel.com, linux-arch@vger.kernel.org

On Fri, Feb 26, 2016 at 06:50:57AM -0800, Paul E. McKenney wrote:
> Hello!

Hi Paul,

> Do ARM, MIPS, and IA64 data/address/control dependencies apply to loads
> and stores from vector instructions?  The use case appears to be that the
> dependency chain is headed by a normal load instruction, and a dependency
> to a later vector load/store is desired.
> 
> Any other weakly ordered architectures with vector instructions?

We certainly have instructions that don't honour address dependencies,
for example LDNP (load non-temporal pair), and these could be used by
variants of memcpy. x86 has something similar with MOVNTDQA[1].

It's highly likely that we'd consider similar relaxations for extensions
to our vector instructions in future revisions of the ARM architecture,
so I don't think we should generally rely on address dependencies
providing order for vectorised code.

Will

[1] http://www.felixcloutier.com/x86/MOVNTDQA.html
