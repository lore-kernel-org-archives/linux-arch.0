Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ns.amrita.ac.in ([203.197.150.194]:20879 "EHLO
	bhadra.amrita.ac.in") by vger.kernel.org with ESMTP id S964974AbWAXFFi
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 24 Jan 2006 00:05:38 -0500
Message-ID: <43D5B80F.3050705@arl.amrita.edu>
Date: Tue, 24 Jan 2006 10:45:59 +0530
From: Harish K Harshan <harish@arl.amrita.edu>
MIME-Version: 1.0
Subject: DMA Transfer Problem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Hello,

  Im having problems with DMA transfer on Linux, for an ADC card. The 
card is AxiomTek AX5621H (ISA), and can use DMA channels 1 and 3. I 
tried both the channels, but the DMA transfers are irregular (i.e.) at 
different speeds (which of course is not acceptable, since that 
application is time critical). The device driver (which I wrote) seems 
to work fine for all the other systems I tried it on. But this problem 
occurs only on one particular model of computer (Chino-Laxsons Pentium-4 
boards). I tried another system with the same configuration, but the 
same resulted. After some time of execution, I get the kernel panic 
screen, which says the CPU context is corrupt. Please help me with this 
problem, as I need to get this driver working somehow on the P4 systems. 
I tried the Redhat-9 kernel (2.4.20-8) and the debian kernel too 
(2.2.20).... gave the same results.

Thanks in advance,
Harish.
