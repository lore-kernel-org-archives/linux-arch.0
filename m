From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: RE: [patch 0/4] [RFC] true vs. system idle cputime
Date: Thu, 09 Oct 2008 10:03:58 +0200
Message-ID: <1223539438.17171.3.camel@localhost>
References: <20081008161958.767142939@de.ibm.com>
	 <57C9024A16AD2D4C97DC78E552063EA353175370@orsmsx505.amr.corp.intel.com>
Reply-To: schwidefsky@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate4.de.ibm.com ([195.212.29.153]:33992 "EHLO
	mtagate4.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755529AbYJIILy (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Oct 2008 04:11:54 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.8/8.13.8) with ESMTP id m998Bq0V170798
	for <linux-arch@vger.kernel.org>; Thu, 9 Oct 2008 08:11:52 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id m998Bqcl1544240
	for <linux-arch@vger.kernel.org>; Thu, 9 Oct 2008 10:11:52 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m998Bl6N015148
	for <linux-arch@vger.kernel.org>; Thu, 9 Oct 2008 10:11:49 +0200
In-Reply-To: <57C9024A16AD2D4C97DC78E552063EA353175370@orsmsx505.amr.corp.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Jeremy Fitzhardinge <jeremy@xensource.com>, Chris Wright <chrisw@sous-sol.org>, Michael Neuling <mikey@neuling.org>

On Wed, 2008-10-08 at 14:22 -0700, Luck, Tony wrote:
> > There is one change in patch #2 that might require a change on powerpc
> > and/or ia64. The generic TICK_ONESHOT/NO_HZ code calculates the number
> > of ticks spent with a disabled HZ timer and accounts this as idle time.
> 
> Your patches apply, build and boot cleanly on ia64.
> 
> At the moment ia64 doesn't do NO_HZ (exisiting cpus only support a C1
> state, which we can enter/leave pretty quickly ... so power saving
> for NO_HZ is negligible) ... so your code change isn't an issue for
> ia64.

Thanks for checking.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
