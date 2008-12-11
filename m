From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 00/19] unify init_task
Date: Thu, 11 Dec 2008 14:21:46 +0100
Message-ID: <200812111421.46688.arnd@arndb.de>
References: <cover.1228966585.git.kyle@mcmartin.ca> <Pine.LNX.4.64.0812110956410.7310@anakin>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:56891 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755455AbYLKNVx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Dec 2008 08:21:53 -0500
In-Reply-To: <Pine.LNX.4.64.0812110956410.7310@anakin>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kyle McMartin <kyle@mcmartin.ca>, linux-arch@vger.kernel.org

On Thursday 11 December 2008, Geert Uytterhoeven wrote:

> > Unconverted architectures so far are m68k (because it doesn't use an explicit
> > init_task.c), ia64 (because it faffs about with init_thread_union), and
> > sparc{,64} (which appear to rely on some magic.)
> 
> m68k just has the same code as anyone else embedded in
> arch/m68k/kernel/process.c.

There is an extra aligned(THREAD_SIZE))) attribute in the m68k thread_info
definition, just like sparc and mips. Are you sure that removing it is
safe on m68k?

	Arnd <><
