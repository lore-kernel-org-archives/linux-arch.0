Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48918 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756889Ab0GRSY7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 18 Jul 2010 14:24:59 -0400
MIME-Version: 1.0
In-Reply-To: <201007181703.17022.vda.linux@googlemail.com>
References: <201007181703.17022.vda.linux@googlemail.com>
Date: Sun, 18 Jul 2010 20:24:53 +0200
Message-ID: <AANLkTin-9VsTJxGclRUrJIizn9aDZ6pjxmByBCWB0Hqr@mail.gmail.com>
Subject: Re: Testing of function/data-sections on linux-2.6.35-rc4
From: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Denys Vlasenko <vda.linux@googlemail.com>
Cc: Tim Abbott <tabbott@ksplice.com>, Tim Bird <tim.bird@am.sony.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, linux-kernel@vger.kernel.org, Matt Fleming <matt@console-pimps.org>, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>, Michal Marek <mmarek@suse.cz>, Parisc List <linux-parisc@vger.kernel.org>
Message-ID: <20100718182453.bX77F8DijfZb8LPsSAVwXcUVz4eP4OdQ3S_l3T5YswU@z>

On Sun, Jul 18, 2010 at 17:03, Denys Vlasenko <vda.linux@googlemail.com> wrote:
> I am sending this email from the machine which runs the kernel
> built with -ffunction-sections -fdata-sections --gc-sections.

(sorry for the previous HTML-email)

For the record, what are the metrics of this kernel vs. the standard one?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
