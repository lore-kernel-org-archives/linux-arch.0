From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] move PIT_TICK_RATE to linux/timex.h
Date: Tue, 12 May 2009 02:36:35 +0200
Message-ID: <200905120236.36242.arnd@arndb.de>
References: <20090511222702.352192505@arndb.de> <200905112255.37215.arnd@arndb.de> <20090511170146.143a1551.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:56169 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569AbZELAhz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 11 May 2009 20:37:55 -0400
In-Reply-To: <20090511170146.143a1551.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, x86@kernel.org, rth@twiddle.net, ralf@linux-mips.org, tiwai@suse.de, dmitry.torokhov@gmail.com, mingo@elte.hu, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk

On Tuesday 12 May 2009, Andrew Morton wrote:
> So the type got changed in arch/x86/include/asm/timex.h. =A0Did you c=
heck
> whether that changes anything? I did a quick check and didn't see any
> obvious problems..

I did not check if the object file changes, just checked that the
macro is not used in assembly code, which would break.

Note that for Alpha, the actual value changed from 1193182UL to
1193180UL. This is unlikely to make a difference, and probably
can only improve accuracy. There was a discussion on the correct
value of CLOCK_TICK_RATE a few years ago, after which every existing
instance was getting changed to 1193182. According to the specification=
,
it should be 1193181.818181...

	Arnd <><
