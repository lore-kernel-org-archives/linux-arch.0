From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [RFC 01/32] fs: introduce new 'struct inode_time'
Date: Sat, 31 May 2014 15:46:42 +0200
Message-ID: <87wqd2f4cd.fsf@igel.home>
References: <1401480116-1973111-1-git-send-email-arnd@arndb.de>
	<1401480116-1973111-2-git-send-email-arnd@arndb.de>
	<CAMuHMdVgch4REGcYWFZXVToX2b8iCinFVV10Bz3VoeiZy_yBtg@mail.gmail.com>
	<m2tx86l4ux.fsf@linux-m68k.org>
	<CAMuHMdXPQQpu_6k+Y6o=1u-u9EkkanKdGYp6-=BavyYHUH3AuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:35450 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756514AbaEaNqu (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 31 May 2014 09:46:50 -0400
In-Reply-To: <CAMuHMdXPQQpu_6k+Y6o=1u-u9EkkanKdGYp6-=BavyYHUH3AuA@mail.gmail.com>
	(Geert Uytterhoeven's message of "Sat, 31 May 2014 15:19:48 +0200")
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "Joseph S. Myers" <joseph@codesourcery.com>, John Stultz <john.stultz@linaro.org>, Christoph Hellwig <hch@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ley Foon Tan <lftan@altera.com>, "H. Peter Anvin" <hpa@zytor.com>, Linux FS Devel <linux-fsdevel@vger.kernel.org>

Geert Uytterhoeven <geert@linux-m68k.org> writes:

> "int" is signed, right? Or do you mean a bitfield needs an explicit "signed"
> keyword to be signed?

Yes, see 6.7.2#5.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
