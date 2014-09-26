Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f175.google.com ([209.85.217.175]:50410 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753059AbaIZGld (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 26 Sep 2014 02:41:33 -0400
MIME-Version: 1.0
In-Reply-To: <CAFiDJ58Y1iQhkkS-OVwMBdowJnXKKbYfHttQibmBh_qa5vgOmQ@mail.gmail.com>
References: <1410168160-3624-1-git-send-email-lftan@altera.com>
	<3608975.MxU44B73lk@wuerfel>
	<CAFiDJ58h4VKrr-wHe6iD+aPB8QU=xLo03kW5k6QDpLW5Et0DGw@mail.gmail.com>
	<11277081.DWgcnnZv54@wuerfel>
	<CAFiDJ58Y1iQhkkS-OVwMBdowJnXKKbYfHttQibmBh_qa5vgOmQ@mail.gmail.com>
Date: Fri, 26 Sep 2014 08:41:31 +0200
Message-ID: <CAMuHMdX8MD9vynbehHjgVKryfUVAMJduhXjd2XBt58U=djO11Q@mail.gmail.com>
Subject: Re: [PATCH v3 01/29] asm-generic: add generic futex for !CONFIG_SMP
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ley Foon Tan <lftan@altera.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Chung-Lin Tang <cltang@codesourcery.com>, Thomas Gleixner <tglx@linutronix.de>
Message-ID: <20140926064131.HLinEX7IZcRXcFtDj4N5LWVucmaBBJVu2bE-5cTIB5g@z>

On Fri, Sep 26, 2014 at 4:22 AM, Ley Foon Tan <lftan@altera.com> wrote:
>> Randy Dunlap <rdunlap@infradead.org> is the maintainer listed for
>> Documentation, and I see you already have linux-doc@vger.kernel.org
>> on Cc here. Please make sure that Randy is on Cc for the documentation
>> patches as well. A lot of documentation patches go in without his
>> Ack, which I think is fine as long as someone else (i.e. you) is
>> responsible for maintaining that documentation later.
> Okay, will add Randy to CC list for Documentation patch.

Please change that to Jiri Kosina:

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=d671e42457e1fef70ad0df07084207078633a9e8

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
