From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH/RFC] kbuild: use INSTALLKERNEL to select customized	installkernel
 script
Date: Mon, 20 Jul 2009 18:22:43 -0700
Message-ID: <4A651863.6090009@zytor.com>
References: <20090720201137.GB6854@merkur.ravnborg.org> <20090720221120.GG11151@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:44493 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415AbZGUBpk (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 20 Jul 2009 21:45:40 -0400
In-Reply-To: <20090720221120.GG11151@n2100.arm.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-arch@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ian Campbell <icampbell@arcom.com>, Mike Frysinger <vapier@gentoo.org>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Hirokazu Takata <takata@linux-m32r.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Kyle McMartin <kyle@mcmartin.ca>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>

Russell King - ARM Linux wrote:
> 
> That's a good thing in some ways and a bad thing in others.  Having
> it guarantee to fail if you try installing an ARM kernel onto an
> x86 machine is definitely a good thing.  That said, it's not something
> I've ever accidentally done.
> 

I guess we could have it error out if you are building a non-native
architecture but don't set CROSS_COMPILE.  Either that or we could
default $INSTALLKERNEL to $(CROSS_COMPILE)installkernel, which would be
backwards compatible.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
