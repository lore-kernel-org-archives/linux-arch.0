From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH 00/19] unify init_task
Date: Thu, 11 Dec 2008 15:26:38 +0100
Message-ID: <200812111526.39175.arnd@arndb.de>
References: <cover.1228966585.git.kyle@mcmartin.ca> <200812111421.46688.arnd@arndb.de> <Pine.LNX.4.64.0812111501360.13379@anakin>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:51604 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755834AbYLKO0m (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 11 Dec 2008 09:26:42 -0500
In-Reply-To: <Pine.LNX.4.64.0812111501360.13379@anakin>
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kyle McMartin <kyle@mcmartin.ca>, linux-arch@vger.kernel.org

On Thursday 11 December 2008, Geert Uytterhoeven wrote:
> Wondering, would it harm a lot having the aligned(THREAD_SIZE) everywhere?

No real harm, but some architectures don't require alignment of thread_info,
and they might waste a few kb because of the forced alignment.

The easier solution should be to force the alignment in
arch/{sparc,m68k}/vmlinux.lds.S, like the other architectures have it.

m68k-sun3 currently aligns thread_info to PAGE_SIZE, m68k aligns it
to 8192. AFAICT, you can simply replace both with THREAD_SIZE.

	Arnd <><
