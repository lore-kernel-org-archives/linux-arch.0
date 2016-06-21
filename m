Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:61170 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783AbcFUJdT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jun 2016 05:33:19 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/5] vmlinux.lds.h: replace config_enabled() with IS_ENABLED()
Date: Tue, 21 Jun 2016 11:25:15 +0200
Message-ID: <9339659.lz6OGfeSnb@wuerfel>
In-Reply-To: <CAK7LNAR4mdwQqsf4xhtsMA7FEuAqNMEzE+6HkYCW30qLbKb1=A@mail.gmail.com>
References: <1465883938-25194-1-git-send-email-yamada.masahiro@socionext.com> <576855FD.6020202@suse.cz> <CAK7LNAR4mdwQqsf4xhtsMA7FEuAqNMEzE+6HkYCW30qLbKb1=A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <mmarek@suse.cz>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Rusty Russell <rusty@rustcorp.com.au>, Michal Simek <michal.simek@xilinx.com>, Linus Torvalds <torvalds@linux-foundation.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, linux-arch@vger.kernel.org
Message-ID: <20160621092515.1S0Dm8UAxRjCpMvjiEdHlphOA67usw6mydKO_c_2fBA@z>

On Tuesday, June 21, 2016 8:20:10 AM CEST Masahiro Yamada wrote:
> 2016-06-21 5:45 GMT+09:00 Michal Marek <mmarek@suse.cz>:
> > Dne 14.6.2016 v 07:58 Masahiro Yamada napsal(a):
> >> The use of config_enabled() against config options is ambiguous.
> >>
> >> Now, IS_ENABLED() is implemented purely with macro expansion, so
> >> let's replace config_enabled() with IS_ENABLED().
> >>
> >> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >
> > I applied the whole series to kbuild.git#kbuild.
> >
> 
> This series was applied by Andrew Morton last week.
> 
> I do not want to double it.  Could you drop it?

Andrew usually drops patches from his tree when they show up in
another maintainer tree.

	Arnd

