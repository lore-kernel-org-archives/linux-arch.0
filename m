From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH/RFC] kbuild: use INSTALLKERNEL to select customized installkernel script
Date: Tue, 21 Jul 2009 05:49:42 +0900
Message-ID: <20090720204942.GA31774@linux-sh.org>
References: <20090720201137.GB6854@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:54801 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750907AbZGTUuV (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jul 2009 16:50:21 -0400
Content-Disposition: inline
In-Reply-To: <20090720201137.GB6854@merkur.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ian Campbell <icampbell@arcom.com>, Russell King <linux@arm.linux.org.uk>, Mike Frysinger <vapier@gentoo.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Hirokazu Takata <takata@linux-m32r.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Kyle McMartin <kyle@mcmartin.ca>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

On Mon, Jul 20, 2009 at 10:11:37PM +0200, Sam Ravnborg wrote:
> 
> While working on a patch to save ARCH and CROSS_COMPILE
> Peter Z noticed that it would cause "make install" to fail
> if we used the setting of CROSS_COMPILE from build time.
> 
> I took a closer look at it and the final conclusion was that
> we should not use CROSS_COMPILE to select installkernel script,
> so I redid that in the following patch.
> 
> The patch has also appeared on linux-kernel and linux-kbuild in
> the thread: "[PATCH] kbuild: save ARCH & CROSS_COMPILE when building a kernel"
> 
> I decided to post it here so relevant arch maintainers has been notified,
> and thus given the option to comment on it.
> 
> Assuming this is not NACK'ed I will include the patch in kbuild-next.git
> 
Looks good to me.

Acked-by: Paul Mundt <lethal@linux-sh.org>
