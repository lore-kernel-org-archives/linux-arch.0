Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ftp.linux-mips.org ([194.74.144.162]:47133 "EHLO
	ftp.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbXKUNuc (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 21 Nov 2007 08:50:32 -0500
Received: from localhost.localdomain ([127.0.0.1]:44454 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20043662AbXKUNub (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 21 Nov 2007 13:50:31 +0000
Date: Wed, 21 Nov 2007 13:50:16 +0000
From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [rfc] io memory barriers, and getting rid of mmiowb
Message-ID: <20071121135016.GB15318@linux-mips.org>
References: <20071120160220.GA22196@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071120160220.GA22196@wotan.suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Nick Piggin <npiggin@suse.de>, dhowells@redhat.com
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
List-ID: <linux-arch.vger.kernel.org>

On Tue, Nov 20, 2007 at 05:02:20PM +0100, Nick Piggin wrote:

> + TYPE	    FULL		    CACHEABLE (SMP CONDITIONAL) IO
> + =========  ======================= =========================== ============
> + GENERAL    mb()		    smp_mb()			io_mb()
> + WRITE	    wmb()		    smp_wmb()			io_wmb()
> + READ	    rmb()		    smp_rmb()			io_rmb()
> + DATA DEP.  read_barrier_depends()  smp_read_barrier_depends()

A while ago I went through the kernel looking at the uses mb(), wmb() and
rmb() and found that every use was either fishy or should have been a
smp_mb(), smp_wmb() or wmp_rmb().  Which leads me to the question if there
is any need for the non-smp_ variants left or can we just bury them?

  Ralf
