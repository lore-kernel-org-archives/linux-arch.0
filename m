From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] include/asm-generic/io.h: add dummy fuctions to support
 'COMPILE_TEST' in 'asm-generic'.
Date: Wed, 03 Jul 2013 22:03:10 -0400
Message-ID: <1372903390.22688.139.camel@gandalf.local.home>
References: <51CA8AB8.7080504@asianux.com>
	 <CAMuHMdW58CZ0m-10ibs2Vyh8exqP1nSH+-ZOr5J58tx=uorM+Q@mail.gmail.com>
	 <51D375AA.5060300@asianux.com> <201307031014.12583.arnd@arndb.de>
	 <51D3E440.7090105@asianux.com> <51D4C87E.5070605@asianux.com>
	 <20130704011221.GA11230@kroah.com> <51D4D4A0.6080401@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:27090 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932206Ab3GDCDL (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jul 2013 22:03:11 -0400
In-Reply-To: <51D4D4A0.6080401@asianux.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chen Gang <gang.chen@asianux.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, David Sharp <dhsharp@google.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, Ingo Molnar <mingo@kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, uml-user <user-mode-linux-user@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, Mark Brown <broonie@kernel.org>, David Miller <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Jiri Kosina <trivial@kernel.org>, Jiri Slaby <jslaby@suse.cz>

On Thu, 2013-07-04 at 09:49 +0800, Chen Gang wrote:

> Hmm... at least, it is neither architectures issue nor modules issue.
> 
> So we have to look for who have duty for it, since it is a 'generic'
> issue for many architectures and modules, we have to find it in
> 'generic' area (e.g. "./include/*").
> 
> At least now, it seems only "asm-generic/*" can play the unlucky role !!
> 
> Or, do you think it is still the modules issue themselves ?

What problem are you trying to solve? asm-generic has been around for a
long time, and so has allmodconfig. I'm unaware of any issues with
either of them.

But as my last email got blocked because your ISP thinks my ISP is a
spambot (it's road runner, which I'm sure there are spammers), you wont
get this anyway.

-- Steve
