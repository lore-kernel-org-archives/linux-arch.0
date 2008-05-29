From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: MMIO and gcc re-ordering issue
Date: Thu, 29 May 2008 11:46:34 +0100
Message-ID: <20080529114634.048ea9a0@core>
References: <1211852026.3286.36.camel@pasglop>
	<alpine.LFD.1.10.0805271451100.2958@woody.linux-foundation.org>
	<1211926779.3286.104.camel@pasglop>
	<200805290910.07207.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:56094 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750974AbYE2LBQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 29 May 2008 07:01:16 -0400
In-Reply-To: <200805290910.07207.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: benh@kernel.crashing.org, Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, scottwood@freescale.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, tpiepho@freescale.com

> It's not exactly a well-established interface. Only five architecture=
s
> define these functions, and there is not a single user in the kernel
> source outside of these architecture's io.h files.

That is because the drivers using them had them removed (eg I=C2=B2O) -=
 mostly
because "it didn't compile on power pc" 8(


Alan
