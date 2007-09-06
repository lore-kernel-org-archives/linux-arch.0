Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:43726 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752335AbXIFOzm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 6 Sep 2007 10:55:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18144.5337.528165.411507@cargo.ozlabs.ibm.com>
Date: Fri, 7 Sep 2007 00:55:21 +1000
From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Removal of dma_cache_(wback|inv|wback_inv) functions
In-Reply-To: <20070906113918.GA1585@linux-mips.org>
References: <20070904115615.GA14986@linux-mips.org>
	<20070904124212.GR14130@parisc-linux.org>
	<20070906113918.GA1585@linux-mips.org>
Sender: linux-arch-owner@vger.kernel.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Matthew Wilcox <matthew@wil.cx>, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Ralf Baechle writes:

> So this is looking ok?  I got an ACK from Paul Mundt for SH.

Acked-by: Paul Mackerras <paulus@samba.org>

for the powerpc/ppc bits.
