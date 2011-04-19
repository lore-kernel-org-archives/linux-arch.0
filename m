From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Writable sys_call_table (was: Re: [uClinux-dev] [PATCH] m68k: Merge mmu and non-mmu versions of sys_call_table)
Date: Tue, 19 Apr 2011 13:54:25 +0200
Message-ID: <m2k4eqfocu.fsf@igel.home>
References: <BANLkTimbHgmUvisE7+TCkgthejNi_zdojQ@mail.gmail.com>
	<201104181649.31492.arnd@arndb.de> <m2y637bkep.fsf@igel.home>
	<201104190948.36517.arnd@arndb.de>
	<alpine.OSX.2.00.1104191807210.373@ibook.intranet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:50009 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752086Ab1DSLya (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 Apr 2011 07:54:30 -0400
In-Reply-To: <alpine.OSX.2.00.1104191807210.373@ibook.intranet> (Finn Thain's
	message of "Tue, 19 Apr 2011 18:12:41 +1000 (EST)")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Finn Thain <fthain@telegraphics.com.au>
Cc: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Ungerer <gerg@snapgear.com>, Gavin Lambert <gavinl@compacsort.com>, uClinux development list <uclinux-dev@uclinux.org>, Philippe De Muyter <phdm@macqel.be>, Linux/m68k <linux-m68k@lists.linux-m68k.org>, linux-arch@vger.kernel.org

Finn Thain <fthain@telegraphics.com.au> writes:

> Wouldn't that require const void * const sys_call_table[] ?

No, the right signature would be void (*const sys_call_table[])(void)
since this is an array of function pointers.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
