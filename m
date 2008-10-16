From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [patch 2/4] idle cputime accounting
Date: Thu, 16 Oct 2008 11:08:28 +0200
Message-ID: <1224148108.9617.5.camel@localhost>
References: <20081008161958.767142939@de.ibm.com>
	 <20081008162144.500130264@de.ibm.com>
	 <18678.51741.878923.169870@cargo.ozlabs.ibm.com>
	 <1224139369.6228.8.camel@localhost>
Reply-To: schwidefsky@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mtagate4.de.ibm.com ([195.212.29.153]:36408 "EHLO
	mtagate4.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755153AbYJPJNN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 16 Oct 2008 05:13:13 -0400
Received: from d12nrmr1607.megacenter.de.ibm.com (d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.8/8.13.8) with ESMTP id m9G9DAB7179384
	for <linux-arch@vger.kernel.org>; Thu, 16 Oct 2008 09:13:10 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id m9G9D9GC3776632
	for <linux-arch@vger.kernel.org>; Thu, 16 Oct 2008 11:13:10 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id m9G9D8vs029093
	for <linux-arch@vger.kernel.org>; Thu, 16 Oct 2008 11:13:09 +0200
In-Reply-To: <1224139369.6228.8.camel@localhost>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
Cc: linux-arch@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>, Jeremy Fitzhardinge <jeremy@xensource.com>, Chris Wright <chrisw@sous-sol.org>, Michael Neuling <mikey@neuling.org>

On Thu, 2008-10-16 at 08:42 +0200, Martin Schwidefsky wrote:
> > Finally, with this patch I get the following compilation error on
> > powerpc:
> > 
> > arch/powerpc/kernel/process.c: In function '__switch_to':
> > arch/powerpc/kernel/process.c:400: error: implicit declaration of
> function 'account_process_tick'
> > make[2]: *** [arch/powerpc/kernel/process.o] Error 1
> > make[1]: *** [arch/powerpc/kernel] Error 2
> 
> This is with CONFIG_VIRT_CPU_ACCOUNTING=y?

Ok, the include for kernel_stat.h has been missing in
arch/powerpc/kernel/process.c. All the other call sites already have the
include.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
