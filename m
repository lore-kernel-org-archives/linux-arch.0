From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Fw: Getting an early start on C++ standards issues...
Date: Fri, 26 Feb 2016 06:50:57 -0800
Message-ID: <20160226145057.GA6734@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from e37.co.us.ibm.com ([32.97.110.158]:54537 "EHLO
	e37.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752174AbcBZOvD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 26 Feb 2016 09:51:03 -0500
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-arch@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Fri, 26 Feb 2016 07:51:02 -0700
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com [9.57.198.24])
	by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id D0D411FF0025
	for <linux-arch@vger.kernel.org>; Fri, 26 Feb 2016 07:39:08 -0700 (MST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id u1QEowu532047184
	for <linux-arch@vger.kernel.org>; Fri, 26 Feb 2016 14:50:58 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id u1QEowi1027103
	for <linux-arch@vger.kernel.org>; Fri, 26 Feb 2016 09:50:58 -0500
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: will.deacon@arm.com, ralf@linux-mips.org, tony.luck@intel.com, fenghua.yu@intel.com
Cc: linux-arch@vger.kernel.org

Hello!

Do ARM, MIPS, and IA64 data/address/control dependencies apply to loads
and stores from vector instructions?  The use case appears to be that the
dependency chain is headed by a normal load instruction, and a dependency
to a later vector load/store is desired.

Any other weakly ordered architectures with vector instructions?

							Thanx, Paul

Original query from Torvald Riegel and Richard Biener:

> > I'm not sure I understand you correctly.  Do you have a brief example,
> > perhaps?  For mo_consume and its data dependencies, if there might be a
> > dependence, the compiler would have to preserve it; but I guess that
> > both a vectorized loop an one that accessses each element separately
> > would preserve dependences because it's doing those accesses, and they
> > depend on the input data.
> > OTOH, peraps HW vector instructions don't get the ordering guarantees
> > from data dependences -- Paul, do you know of any such cases?
> 
> A brief example would be for
> 
>  void foo (int *a, int *b, int n)
> {
>   for (int i = 0; i < n; ++i)
>    a[i] = b[i];
> }
> 
> which we can vectorize like
> 
>   if (a + n < b || b + n < a)
>    {
>       vectorized loop
>    }
>   else
>     {
>        not vectorized loop
>     }
> 
> note how we're not establishing equivalences between pointers but
> non-dependence vs. possible dependence.
