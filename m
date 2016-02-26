From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Fw: Getting an early start on C++ standards issues...
Date: Fri, 26 Feb 2016 13:33:46 -0800
Message-ID: <20160226213346.GL3522@linux.vnet.ibm.com>
References: <20160226145057.GA6734@linux.vnet.ibm.com>
 <20160226152238.GE29125@arm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e19.ny.us.ibm.com ([129.33.205.209]:46368 "EHLO
	e19.ny.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755261AbcBZVds (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 26 Feb 2016 16:33:48 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Fri, 26 Feb 2016 16:33:47 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com [9.57.198.27])
	by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 0D84538C8046
	for <linux-arch@vger.kernel.org>; Fri, 26 Feb 2016 16:33:46 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u1QLXjHv34603052
	for <linux-arch@vger.kernel.org>; Fri, 26 Feb 2016 21:33:45 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u1QLXi7H006626
	for <linux-arch@vger.kernel.org>; Fri, 26 Feb 2016 16:33:45 -0500
Content-Disposition: inline
In-Reply-To: <20160226152238.GE29125@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: ralf@linux-mips.org, tony.luck@intel.com, fenghua.yu@intel.com, linux-arch@vger.kernel.org

On Fri, Feb 26, 2016 at 03:22:38PM +0000, Will Deacon wrote:
> On Fri, Feb 26, 2016 at 06:50:57AM -0800, Paul E. McKenney wrote:
> > Hello!
> 
> Hi Paul,
> 
> > Do ARM, MIPS, and IA64 data/address/control dependencies apply to loads
> > and stores from vector instructions?  The use case appears to be that the
> > dependency chain is headed by a normal load instruction, and a dependency
> > to a later vector load/store is desired.
> > 
> > Any other weakly ordered architectures with vector instructions?
> 
> We certainly have instructions that don't honour address dependencies,
> for example LDNP (load non-temporal pair), and these could be used by
> variants of memcpy. x86 has something similar with MOVNTDQA[1].
> 
> It's highly likely that we'd consider similar relaxations for extensions
> to our vector instructions in future revisions of the ARM architecture,
> so I don't think we should generally rely on address dependencies
> providing order for vectorised code.

Thank you for the information, Will!

							Thanx, Paul

> Will
> 
> [1] http://www.felixcloutier.com/x86/MOVNTDQA.html
> 
