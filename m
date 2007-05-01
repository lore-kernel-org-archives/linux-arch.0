Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:3179 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965528AbXEAHo0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 1 May 2007 03:44:26 -0400
Date: Tue, 1 May 2007 08:44:19 +0100
From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: You might need vmalloc_sync_all()
Message-ID: <20070501074419.GA8120@flint.arm.linux.org.uk>
References: <20070501042655.GL25929@bingen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070501042655.GL25929@bingen.suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Tue, May 01, 2007 at 06:26:55AM +0200, Andi Kleen wrote:
> 
> Since someone mentioned again.
> 
> Right now only x86 implements vmalloc_sync_all(). But iff:
> 
> - Your module mappings might require a page fault calling C 
> code in kernel

Yes, just like x86.

> - You got a pagefault notifier at the beginning of the page fault
> handler

What's this?

> Apparently at least ARM has this problem.

Is there a bug report?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
