From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH/RFC] kbuild: use INSTALLKERNEL to select customized
	installkernel script
Date: Mon, 20 Jul 2009 23:11:20 +0100
Message-ID: <20090720221120.GG11151@n2100.arm.linux.org.uk>
References: <20090720201137.GB6854@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35373 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754034AbZGTWLk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jul 2009 18:11:40 -0400
Content-Disposition: inline
In-Reply-To: <20090720201137.GB6854@merkur.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ian Campbell <icampbell@arcom.com>, Mike Frysinger <vapier@gentoo.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Hirokazu Takata <takata@linux-m32r.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Kyle McMartin <kyle@mcmartin.ca>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>

On Mon, Jul 20, 2009 at 10:11:37PM +0200, Sam Ravnborg wrote:
> While working on a patch to save ARCH and CROSS_COMPILE
> Peter Z noticed that it would cause "make install" to fail
> if we used the setting of CROSS_COMPILE from build time.

That's a good thing in some ways and a bad thing in others.  Having
it guarantee to fail if you try installing an ARM kernel onto an
x86 machine is definitely a good thing.  That said, it's not something
I've ever accidentally done.

However, having a cross-built kernel shared via NFS onto the target
machine where you want to 'make install' it and have it pick up the
CROSS_COMPILE setting is a bad thing.

I'm not sure there's any one right answer with this... so...

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
