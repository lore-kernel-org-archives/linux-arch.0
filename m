Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:51687 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754899Ab1DSMQx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 19 Apr 2011 08:16:53 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: Writable sys_call_table (was: Re: [uClinux-dev] [PATCH] m68k: Merge mmu and non-mmu versions of sys_call_table)
Date: Tue, 19 Apr 2011 14:16:35 +0200
References: <BANLkTimbHgmUvisE7+TCkgthejNi_zdojQ@mail.gmail.com> <alpine.OSX.2.00.1104191807210.373@ibook.intranet> <m2k4eqfocu.fsf@igel.home>
In-Reply-To: <m2k4eqfocu.fsf@igel.home>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <201104191416.35746.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Finn Thain <fthain@telegraphics.com.au>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Ungerer <gerg@snapgear.com>, Gavin Lambert <gavinl@compacsort.com>, uClinux development list <uclinux-dev@uclinux.org>, Philippe De Muyter <phdm@macqel.be>, Linux/m68k <linux-m68k@lists.linux-m68k.org>, linux-arch@vger.kernel.org
Message-ID: <20110419121635.iwrIqBL9gYD4nHo8y_kLcAHLqVz7boJ4sPd_bF3Lmoo@z>

On Tuesday 19 April 2011, Andreas Schwab wrote:
> Finn Thain <fthain@telegraphics.com.au> writes:
> 
> > Wouldn't that require const void * const sys_call_table[] ?
> 
> No, the right signature would be void (*const sys_call_table[])(void)
> since this is an array of function pointers.
> 

But it's not an array of pointers to function with signature
void f(void). It's an array of void pointers that we assign
to function pointers of various types.

	Arnd
