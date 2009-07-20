From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH/RFC] kbuild: use INSTALLKERNEL to select customized	installkernel
 script
Date: Mon, 20 Jul 2009 13:19:59 -0700
Message-ID: <4A64D16F.4080701@zytor.com>
References: <20090720201137.GB6854@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:51594 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbZGTUl2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jul 2009 16:41:28 -0400
In-Reply-To: <20090720201137.GB6854@merkur.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ian Campbell <icampbell@arcom.com>, Russell King <linux@arm.linux.org.uk>, Mike Frysinger <vapier@gentoo.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Hirokazu Takata <takata@linux-m32r.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Kyle McMartin <kyle@mcmartin.ca>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>

Sam Ravnborg wrote:
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

Fine with me.

Acked-by: H. Peter Anvin <hpa@zytor.com>

	-hpa
