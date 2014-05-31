From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC 06/32] isofs: fix timestamps beyond 2027
Date: Sat, 31 May 2014 09:59:56 +0200
Message-ID: <CAMuHMdXn2wzhU6f-qVsFAoVZQOciRbi8ZBdjQpHQf96qRC2kww@mail.gmail.com>
References: <1401480116-1973111-1-git-send-email-arnd@arndb.de>
	<1401480116-1973111-7-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:63638 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187AbaEaH75 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 31 May 2014 03:59:57 -0400
In-Reply-To: <1401480116-1973111-7-git-send-email-arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "Joseph S. Myers" <joseph@codesourcery.com>, John Stultz <john.stultz@linaro.org>, Christoph Hellwig <hch@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ley Foon Tan <lftan@altera.com>, "H. Peter Anvin" <hpa@zytor.com>, Linux FS Devel <linux-fsdevel@vger.kernel.org>

On Fri, May 30, 2014 at 10:01 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> isofs uses a 'char' variable to load the number of years since
> 1900 for an inode timestamp. On architectures that use a signed
> char type by default, this results in an invalid date for
> anything beyond 2027.
>
> This adds a cast to 'u8' for the year number, which should extend
> the shelf life of the file system until 2155.

Oops, the CD archive of my scanned Napoleon manuscripts no longer has the
right file date? ;-)

Are there any practical uses of representating dates between 1772 and 1900
on CD/DVD?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
