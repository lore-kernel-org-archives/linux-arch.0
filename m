From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: What's in asm-generic.git
Date: Fri, 11 Dec 2009 14:58:28 +0100
Message-ID: <10f740e80912110558g6c453d18ifeb4e02d5bd51973@mail.gmail.com>
References: <OF24184D8B.2F7F8AA9-ON48257685.002069EF-48257685.00207E45@sunplusct.com>
	 <200912102225.05280.arnd@arndb.de>
	 <10f740e80912110454u172fc2cfye30da6ca0e0f0af0@mail.gmail.com>
	 <200912111406.33424.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:2724 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756295AbZLKN6W (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Dec 2009 08:58:22 -0500
In-Reply-To: <200912111406.33424.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mike Frysinger <vapier.adi@gmail.com>, liqin.chen@sunplusct.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Dec 11, 2009 at 14:06, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 11 December 2009, Geert Uytterhoeven wrote:
>> 10+ architectures already have sys_[sg]et_thread_area of have reserved
>> entries for it.
>
> No, those are just the ones that blindly copied the unistd.h file from i386.
> As I said, only i386 and mips implement it, and I would assume that this
> is unlikely to change.

M68k will have it in the near future...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
