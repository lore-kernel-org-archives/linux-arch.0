From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Mostly portable strnlen_user()
Date: Fri, 25 May 2012 16:11:36 -0700
Message-ID: <CA+55aFwNN0vBukJkEbsHNUGz7daJZ4gksCNV=Qw6j-XfcZ2HTA@mail.gmail.com>
References: <alpine.LFD.2.02.1205251528570.26378@i5.linux-foundation.org> <20120525.190625.1306293406531703607.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:48167 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752201Ab2EYXL5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 25 May 2012 19:11:57 -0400
Received: by weyu7 with SMTP id u7so866300wey.19
        for <linux-arch@vger.kernel.org>; Fri, 25 May 2012 16:11:56 -0700 (PDT)
In-Reply-To: <20120525.190625.1306293406531703607.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org

On Fri, May 25, 2012 at 4:06 PM, David Miller <davem@davemloft.net> wro=
te:
>
> Maybe something like:
>
> #define HAS_ZERO_CONST_DECLARE =A0...
> #define HAS_ZERO_VAR_DECLARE =A0 =A0...
> #define HAS_ZERO_ARGS =A0 =A0 =A0 =A0 =A0 ...

Ugh. I'd rather then have a opaque typedef that may be a single word
or a couple of words. Then it just declares that (without knowing what
it is), and passes it around to the "find zeroes" and "get length from
mask" functions.

=46or x86, it would be that single "mask" variable, for sparc it would
be a struct of the "v" and "rhs" variables.

Hmm?

                             Linus
