Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.ocgnet.org ([64.20.243.3]:60871 "EHLO smtp.ocgnet.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751285AbXINDaV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 13 Sep 2007 23:30:21 -0400
Date: Fri, 14 Sep 2007 12:30:05 +0900
From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [patch 6/7] Use extended crashkernel command line on sh
Message-ID: <20070914033005.GA3445@linux-sh.org>
References: <20070913161428.343951643@strauss.suse.de> <20070913161430.416849478@strauss.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070913161430.416849478@strauss.suse.de>
Sender: linux-arch-owner@vger.kernel.org
To: Bernhard Walle <bwalle@suse.de>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxsh-dev@lists.sourceforge.net
List-ID: <linux-arch.vger.kernel.org>

On Thu, Sep 13, 2007 at 06:14:34PM +0200, Bernhard Walle wrote:
> This patch removes the crashkernel parsing from arch/sh/kernel/machine_kexec.c
> and calls the generic function, introduced in the generic patch, in
> setup_bootmem_allocator().
> 
> This is necessary because the amount of System RAM must be known in this
> function now because of the new syntax.
> 
> NOTE: Due to the lack of a SH processor, this patch is untested (and
> uncompiled). Because the code in that area is quite similar as i386/x86_64
> (contrary to PPC and IA64), it should compile and work. However, if someone of
> the SH people could test for me and provide feedback, that would be very nice.
> 
> Signed-off-by: Bernhard Walle <bwalle@suse.de>
> 
Works fine on SH.

Acked-by: Paul Mundt <lethal@linux-sh.org>
