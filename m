From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] include/asm-generic/io.h: add dummy fuctions to support
 'COMPILE_TEST' in 'asm-generic'.
Date: Wed, 03 Jul 2013 22:29:35 -0400
Message-ID: <1372904975.22688.142.camel@gandalf.local.home>
References: <51CA8AB8.7080504@asianux.com>
	  <CAMuHMdW58CZ0m-10ibs2Vyh8exqP1nSH+-ZOr5J58tx=uorM+Q@mail.gmail.com>
	  <51D375AA.5060300@asianux.com> <201307031014.12583.arnd@arndb.de>
	  <51D3E440.7090105@asianux.com> <51D4C87E.5070605@asianux.com>
	  <20130704011221.GA11230@kroah.com> <51D4D4A0.6080401@asianux.com>
	 <1372903390.22688.139.camel@gandalf.local.home>
	 <51D4D9A4.3020402@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:26931 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932206Ab3GDC3l (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jul 2013 22:29:41 -0400
In-Reply-To: <51D4D9A4.3020402@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chen Gang F T <chen.gang.flying.transformer@gmail.com>
Cc: Chen Gang <gang.chen@asianux.com>, Greg KH <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, David Sharp <dhsharp@google.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, Ingo Molnar <mingo@kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, uml-user <user-mode-linux-user@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Mark Brown <broonie@kernel.org>, David Miller <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Jiri Kosina <trivial@kernel.org>, Jiri Slaby <jslaby@suse.cz>

On Thu, 2013-07-04 at 10:10 +0800, Chen Gang F T wrote:

> Select "COMPILE_TEST=y" with allmodconfig, but can not pass compiling in
> many architectures, one of the most reasons is "HW does not support".
> 
> 'asm-generic' is really existent for a long time, and make an important
> role for both architectures and modules.
> 

The purpose of asm-generic is to add a standard infrastructure that some
archs may be able to optimize. It's not so that all archs can compile
all modules.

I'm still confused by what you are trying to accomplish.

-- Steve
