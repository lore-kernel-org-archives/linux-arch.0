From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 6/8] char/genrtc: parisc: use asm-generic/rtc.h
Date: Wed, 27 Apr 2016 13:21:16 +0200
Message-ID: <18012781.hPTzXnRcSP@wuerfel>
References: <1461707052-1337718-1-git-send-email-arnd@arndb.de> <1461707052-1337718-7-git-send-email-arnd@arndb.de> <3034953.EvqV1iv2Ef@caliban.sf-tec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:60218 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448AbcD0LXE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 27 Apr 2016 07:23:04 -0400
In-Reply-To: <3034953.EvqV1iv2Ef@caliban.sf-tec.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, tony.luck@intel.com, geert@linux-m68k.org, jejb@parisc-linux.org, deller@gmx.de, benh@kernel.crashing.org, mpe@ellerman.id.au, dalias@libc.org, dhowells@redhat.com, yasutake.koichi@jp.panasonic.com, rth@twiddle.net, ink@jurassic.park.msu.ru, linux-alpha@vger.kernel.org, x86@kernel.org, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, rtc-linux@googlegroups.com, linux-arch@vger.kernel.org

On Wednesday 27 April 2016 00:07:47 Rolf Eike Beer wrote:
> Arnd Bergmann wrote:
> > The asm-generic/rtc.h header can now be included by
> > architectures that provide their own set_rtc_time/get_rtc_time
> > macros, letting us remove most of the common contents in
> > the powerpc implementation.
> 
> parisc in this case.
> 

Fixed, thanks!

	Arnd
