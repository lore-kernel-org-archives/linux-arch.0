From: Michal Simek <monstr@monstr.eu>
Subject: Re: [PATCHES v3] pci/of: Generic PCI <-> OF matching
Date: Tue, 19 Apr 2011 07:58:20 +0200
Message-ID: <4DAD247C.5080200@monstr.eu>
References: <1302495170-973-1-git-send-email-benh@kernel.crashing.org>
Reply-To: monstr@monstr.eu
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:48069 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889Ab1DSF7q (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 Apr 2011 01:59:46 -0400
In-Reply-To: <1302495170-973-1-git-send-email-benh@kernel.crashing.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, bheglaas@google.com, tglx@linutronix.de, bigeasy@linutronix.de

Benjamin Herrenschmidt wrote:
> Here's a new batch. This time, I'm reasonably confident I build-tested the
> right commit-id's on sparc :-)
> 
> To sort out the sparc problem I took a slightly different approach than
> discussed. I made the new code be of_pci.c (which I enabled on sparc)
> and put the old stuff into of_pci_irq.c (which should still be disabled
> there).
> 
> I've also consolidated pci_bus_to_OF_node() while at it.
> 

Acked-by: Michal Simek <monstr@monstr.eu>

Michal


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
