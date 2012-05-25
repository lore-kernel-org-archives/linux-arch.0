From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Mostly portable strnlen_user()
Date: Fri, 25 May 2012 16:37:40 -0700
Message-ID: <CA+55aFxyno-mCNsJZzpW+5HAc0KA477ZeHGZ6=ONLcnHWiHaEA@mail.gmail.com>
References: <alpine.LFD.2.02.1205251528570.26378@i5.linux-foundation.org>
 <20120525.190625.1306293406531703607.davem@davemloft.net> <CA+55aFwNN0vBukJkEbsHNUGz7daJZ4gksCNV=Qw6j-XfcZ2HTA@mail.gmail.com>
 <20120525.191407.1171512018515372695.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:47028 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755340Ab2EYXiB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 25 May 2012 19:38:01 -0400
Received: by wibhm6 with SMTP id hm6so5032wib.1
        for <linux-arch@vger.kernel.org>; Fri, 25 May 2012 16:38:00 -0700 (PDT)
In-Reply-To: <20120525.191407.1171512018515372695.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org

On Fri, May 25, 2012 at 4:14 PM, David Miller <davem@davemloft.net> wro=
te:
>
> I suppose then I'd need to make BE's has_zero() a macro instead of a
> function. =A0Either that or we pass a pointer to this opaque typedef
> thing.

Gcc is *usually* pretty good about optimizing small structures on the
stack, even if you pass a pointer (if the pointer then always gets
dereferenced within that function). So I think you could try the
"pointer to opaque thing" approach and see.

But yeah, the macro approach obviously puts much less reliance on the
optimizer getting things right, so it might be the way to go if it
turns out that gcc screws up code generation.

                  Linus
