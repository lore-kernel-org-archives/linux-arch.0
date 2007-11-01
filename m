Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from outmail1.freedom2surf.net ([194.106.33.237]:45810 "EHLO
	outmail1.freedom2surf.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754068AbXKAPgQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 1 Nov 2007 11:36:16 -0400
Subject: Re: DMA API Re: Remove dma_coherent_mem interface
From: ian <spyro@f2s.com>
In-Reply-To: <20071101100717.GA26906@linux-sh.org>
References: <1193864605.25899.253.camel@wirenth>
	 <20071031213447.GF15111@parisc-linux.org>
	 <1193910526.25899.278.camel@wirenth>  <20071101100717.GA26906@linux-sh.org>
Content-Type: text/plain
Date: Thu, 01 Nov 2007 15:33:15 +0000
Message-Id: <1193931195.25899.280.camel@wirenth>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-arch@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, linux-scsi@vger.kernel.org, jejb@steeleye.com, kernel-discuss@handhelds.org
List-ID: <linux-arch.vger.kernel.org>

On Thu, 2007-11-01 at 19:07 +0900, Paul Mundt wrote:
> Indeed. The SH case for OHCI on MFDs is the same. So that's at least 2
> users. 

three if you count James SCSI card.

