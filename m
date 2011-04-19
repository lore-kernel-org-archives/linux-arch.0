From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Writable sys_call_table (was: Re: [uClinux-dev] [PATCH] m68k: Merge mmu and non-mmu versions of sys_call_table)
Date: Tue, 19 Apr 2011 15:25:45 +0200
Message-ID: <m2fwpefk4m.fsf@igel.home>
References: <BANLkTimbHgmUvisE7+TCkgthejNi_zdojQ@mail.gmail.com>
	<alpine.OSX.2.00.1104191807210.373@ibook.intranet>
	<m2k4eqfocu.fsf@igel.home> <201104191416.35746.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:34088 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405Ab1DSNZs (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 Apr 2011 09:25:48 -0400
In-Reply-To: <201104191416.35746.arnd@arndb.de> (Arnd Bergmann's message of
	"Tue, 19 Apr 2011 14:16:35 +0200")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Finn Thain <fthain@telegraphics.com.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Ungerer <gerg@snapgear.com>, Gavin Lambert <gavinl@compacsort.com>, uClinux development list <uclinux-dev@uclinux.org>, Philippe De Muyter <phdm@macqel.be>, Linux/m68k <linux-m68k@lists.linux-m68k.org>, linux-arch@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> But it's not an array of pointers to function with signature
> void f(void).

It does not matter which kind of function pointer you use since all
function pointers are alike (unlike data pointers).

> It's an array of void pointers that we assign to function pointers of
> various types.

It is an array of function pointers.  It is only void * because that
suppresses a warning (it is only accessed through assembly, so any type
the size of a pointer would do).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
