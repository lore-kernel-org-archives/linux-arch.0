Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from atlrel6.hp.com ([156.153.255.205]:46297 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1030431AbWAXREm (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Tue, 24 Jan 2006 12:04:42 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: DMA Transfer Problem
Date: Tue, 24 Jan 2006 10:04:14 -0700
References: <43D5B80F.3050705@arl.amrita.edu>
In-Reply-To: <43D5B80F.3050705@arl.amrita.edu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601241004.14529.bjorn.helgaas@hp.com>
Sender: linux-arch-owner@vger.kernel.org
To: Harish K Harshan <harish@arl.amrita.edu>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Monday 23 January 2006 22:15, Harish K Harshan wrote:
>   Im having problems with DMA transfer on Linux, for an ADC card. The 
> card is AxiomTek AX5621H (ISA), and can use DMA channels 1 and 3. I 
> tried both the channels, but the DMA transfers are irregular (i.e.) at 
> different speeds (which of course is not acceptable, since that 
> application is time critical). The device driver (which I wrote) seems 
> to work fine for all the other systems I tried it on. But this problem 
> occurs only on one particular model of computer (Chino-Laxsons Pentium-4 
> boards). I tried another system with the same configuration, but the 
> same resulted. After some time of execution, I get the kernel panic 
> screen, which says the CPU context is corrupt. Please help me with this 
> problem, as I need to get this driver working somehow on the P4 systems. 
> I tried the Redhat-9 kernel (2.4.20-8) and the debian kernel too 
> (2.2.20).... gave the same results.

You posted to the wrong list.  linux-arch is for issue that affect
architecture maintainers specifically.  linux-kernel@vger.kernel.org
is the list you want.

You also seem to be asking for help with a driver that's not in
the kernel tree, with ancient kernels that few developers use
anymore, and with only vague details about the actual problem,
so chances are slim that anybody will be interested or able to
help you.  If you publish the driver as open-source and reproduce
the problem with a more recent kernel, you'll probably get more help.
