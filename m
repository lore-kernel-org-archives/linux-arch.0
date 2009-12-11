From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: What's in asm-generic.git
Date: Fri, 11 Dec 2009 13:54:01 +0100
Message-ID: <10f740e80912110454u172fc2cfye30da6ca0e0f0af0@mail.gmail.com>
References: <OF24184D8B.2F7F8AA9-ON48257685.002069EF-48257685.00207E45@sunplusct.com>
	 <200912102210.12124.arnd@arndb.de>
	 <8bd0f97a0912101317v8143e67w9e2f1224111ac0d7@mail.gmail.com>
	 <200912102225.05280.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ew0-f209.google.com ([209.85.219.209]:50953 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752919AbZLKMx4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 11 Dec 2009 07:53:56 -0500
In-Reply-To: <200912102225.05280.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mike Frysinger <vapier.adi@gmail.com>, liqin.chen@sunplusct.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Dec 10, 2009 at 22:25, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 10 December 2009, Mike Frysinger wrote:
>> > I have found now that sys_accept4 was missing. sys_set_thread_area=
 however
>> > is only defined on x86 and mips. Since you don't currently impleme=
nt this
>> > on score, maybe it would be more appropriate to handle it like the=
 other
>> > architectures do, rather than adding it to asm-generic/unistd.h?
>>
>> isnt the point of asm-generic/unistd.h to collect all common syscall=
s
>> ? =C2=A0if there's syscalls that ideally should be handled by everyo=
ne but
>> currently doesnt, then it's easy to define it in the header but have
>> the actual entry.S leave it as a hole ...
>
> Well, sys_thread_area is not a common syscall but rather an exception=
=2E
> I haven't looked at how glibc does implents TLS on different architec=
tures,
> but I think this is commonly done purely in user space without the
> need for a syscall.

10+ architectures already have sys_[sg]et_thread_area of have reserved
entries for it.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
							    -- Linus Torvalds
