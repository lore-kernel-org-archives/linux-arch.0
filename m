Return-Path: <linux-arch-owner+james.bottomley=40steeleye.com-S262775AbUKRN11@vger.kernel.org>
Received: from mtagate4.de.ibm.com ([195.212.29.153]:15849 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S262772AbUKRN10
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 18 Nov 2004 08:27:26 -0500
Received: from d12nrmr1507.megacenter.de.ibm.com (d12nrmr1507.megacenter.de.ibm.com [9.149.167.1])
	by mtagate4.de.ibm.com (8.12.10/8.12.10) with ESMTP id iAIDRMvU136070
	for <linux-arch@vger.kernel.org>; Thu, 18 Nov 2004 13:27:23 GMT
Received: from d12ml062.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com [9.149.165.228])
	by d12nrmr1507.megacenter.de.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id iAIDRKYl093328
	for <linux-arch@vger.kernel.org>; Thu, 18 Nov 2004 14:27:20 +0100
Subject: Unknown traps.
Message-ID: <OFE35549E9.20C1C2B2-ON42256F50.00448A0C-42256F50.0049E9FE@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Thu, 18 Nov 2004 15:27:20 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>





Hi,
while working on a deficiency in the illegal operation handler for
s390 (only emits a force_sig instead of a force_sig_info) I stumbled
over something odd: How are unknown traps handled properly?

Of the architectures where I have some clue what they are doing:

i386: doesn't handle unknown traps (idt_table entries with {0,0})
ia64: does a force_sig with SIGILL.
parisc: does a force_sig_info with SIGBUS/BUS_OBJERR.
ppc: doesn't handle unknown traps (?).
s390: does a force_sig with SIGSEGV.
sparc: does a force_sig_info with SIGILL/ILL_ILLTRP.
x86_64: doesn't handle unknown traps (idt_table entries with {0,0})

What is correct? For s390 I'd like to do a force_sig_info of some
kind, SIGBUS/BUS_OBJERR is a likely choice.

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH
