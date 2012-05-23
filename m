From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Arch maintainers Ahoy!
Date: Wed, 23 May 2012 11:46:54 -0700
Message-ID: <CA+55aFy78h5z1fnW+TovTQ4wUBauUW4i7=Z583tbQVMhsWvTAQ@mail.gmail.com>
References: <CA+55aFxWaB4eeYgdvhTJ2RegM53WxJZFC4HfV=shNn7ZDdG9CQ@mail.gmail.com>
 <20120523.141647.2252460119413470634.davem@davemloft.net> <CA+55aFxcRc_zR9HtFAtrT1exGP2DspP0aA6T49Ph3kZEHHyQWw@mail.gmail.com>
 <20120523.143543.366370918467441501.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:48779 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757259Ab2EWSrQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 23 May 2012 14:47:16 -0400
Received: by weyu7 with SMTP id u7so4844337wey.19
        for <linux-arch@vger.kernel.org>; Wed, 23 May 2012 11:47:14 -0700 (PDT)
In-Reply-To: <20120523.143543.366370918467441501.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: James.Bottomley@hansenpartnership.com, geert@linux-m68k.org, linux-arch@vger.kernel.org

On Wed, May 23, 2012 at 11:35 AM, David Miller <davem@davemloft.net> wrote:
>
> FWIW, when I code this end case in assembler on sparc64 I just go for
> a bunch of conditional moves, so I'll try to come up with something
> similar to the above that gcc will emit reasonably.

.. and yes, it's possible that the keep-it-simple-and-stupid code you
posted first will actually generate better code if gcc can change it
all to cmov's.

                   Linus
