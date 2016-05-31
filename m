Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:35325 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752345AbcEaG4H (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 31 May 2016 02:56:07 -0400
MIME-Version: 1.0
In-Reply-To: <20160530203207.GY3451@piout.net>
References: <1464634684-1248135-1-git-send-email-arnd@arndb.de>
	<20160530203207.GY3451@piout.net>
Date: Tue, 31 May 2016 08:56:05 +0200
Message-ID: <CAMuHMdV5mcKZcBz=v7Pn2pbDiuwMpQYs-70e6NmH6CZ88=JNzA@mail.gmail.com>
Subject: Re: [PATCH v4 00/16] genrtc removal
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg KH <gregkh@linuxfoundation.org>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Rich Felker <dalias@libc.org>, David Howells <dhowells@redhat.com>, alpha <linux-alpha@vger.kernel.org>, Alessandro Zummo <a.zummo@towertech.it>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Parisc List <linux-parisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Linux-sh list <linux-sh@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, RTCLINUX <rtc-linux@googlegroups.com>, Linux-Arch <linux-arch@vger.kernel.org>
Message-ID: <20160531065605.PCyxASaSfu6b2i7Tzrn7RmgWWfZfq4JZpArvGA4jRoY@z>

Allo Alexandre,

On Mon, May 30, 2016 at 10:32 PM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 30/05/2016 at 20:57:48 +0200, Arnd Bergmann wrote :
>> This is the promised resend of the removal of the genrtc driver and some
>> related code, now that we are at a good time to merge this for the coming
>> merge window.
>>
>
> Thanks a lot!
>
> I'm applying the series right now so it sits in linux-next for a while
> before the next merge window.
>
> I would still happily take any acks, Reviewed-by or Tested-by tags.

Looks like Arnd forgot to include these when reposting:

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

For the m68k bits:
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
