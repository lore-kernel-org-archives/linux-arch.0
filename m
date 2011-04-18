Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:60480 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754659Ab1DRQVI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 18 Apr 2011 12:21:08 -0400
From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: Writable sys_call_table (was: Re: [uClinux-dev] [PATCH] m68k: Merge mmu and non-mmu versions of sys_call_table)
References: <BANLkTimbHgmUvisE7+TCkgthejNi_zdojQ@mail.gmail.com>
	<201104181649.31492.arnd@arndb.de>
Date: Mon, 18 Apr 2011 18:21:02 +0200
In-Reply-To: <201104181649.31492.arnd@arndb.de> (Arnd Bergmann's message of
	"Mon, 18 Apr 2011 16:49:31 +0200")
Message-ID: <m2y637bkep.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Greg Ungerer <gerg@snapgear.com>, Gavin Lambert <gavinl@compacsort.com>, uClinux development list <uclinux-dev@uclinux.org>, Philippe De Muyter <phdm@macqel.be>, Linux/m68k <linux-m68k@lists.linux-m68k.org>, linux-arch@vger.kernel.org
Message-ID: <20110418162102.05UeqzaaBX74uZz5U6y-cESnE8znqCaGD4NRugzqzgw@z>

Arnd Bergmann <arnd@arndb.de> writes:

> diff --git a/arch/score/kernel/sys_call_table.c b/arch/score/kernel/sys_call_table.c
> index 287369b..7be73dc 100644
> --- a/arch/score/kernel/sys_call_table.c
> +++ b/arch/score/kernel/sys_call_table.c
> @@ -7,6 +7,6 @@
>  #undef __SYSCALL
>  #define __SYSCALL(nr, call) [nr] = (call),
>  
> -void *sys_call_table[__NR_syscalls] = {
> +const void *sys_call_table[__NR_syscalls] = {

That's not making it read-only.  You need to move the const to the other
side of the pointer.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
