Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:22481 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1753485AbWKFRNG
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 6 Nov 2006 12:13:06 -0500
Received: from localhost.localdomain ([127.0.0.1]:32431 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038431AbWKFRNF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 6 Nov 2006 17:13:05 +0000
Date: Mon, 6 Nov 2006 17:13:28 +0000
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Which architectures need 64-bit resources?
Message-ID: <20061106171328.GB20439@linux-mips.org>
References: <20061106122337.GK27140@parisc-linux.org> <20061106160206.GA10447@linux-mips.org> <20061106163243.GN27140@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061106163243.GN27140@parisc-linux.org>
Sender: linux-arch-owner@vger.kernel.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-arch@vger.kernel.org, Vivek Goyal <vgoyal@in.ibm.com>
List-ID: <linux-arch.vger.kernel.org>

On Mon, Nov 06, 2006 at 09:32:43AM -0700, Matthew Wilcox wrote:

> Here's a proposed patch (which needs buy-in from the ARM, MIPS and
> PowerPC guys, plus anyone who knows about x86-32 machines with 64-bit
> IO).  Grepping the arch/*/configs/* doesn't show anyone else using it by
> default.
> 
> I got the info for ARM from Vince Sanders, and made my best guess for
> MIPS & PPC.  This patch is entirely untested.

The MIPS segment looks good, so feel free to add an Acked-by me.

  Ralf
