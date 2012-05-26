From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Mostly portable strnlen_user()
Date: Fri, 25 May 2012 22:06:31 -0700
Message-ID: <CA+55aFxLLDuUK+Pde_F=gweYgyLzJQLrgU-2iZAo+FbXus+Njw@mail.gmail.com>
References: <CA+55aFxDyPCEFbOFaPbXF556NbtakuC0RcoUKhCa5k2EsqJ8CQ@mail.gmail.com>
 <20120526.001552.1171433126500742038.davem@davemloft.net> <CA+55aFxukJSo7srOcfedqCSz1wiZhjz4=F8Tj96=uOqWxYqq+A@mail.gmail.com>
 <20120526.004459.1494543364832806830.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:57829 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751102Ab2EZFGw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 26 May 2012 01:06:52 -0400
Received: by weyu7 with SMTP id u7so949959wey.19
        for <linux-arch@vger.kernel.org>; Fri, 25 May 2012 22:06:51 -0700 (PDT)
In-Reply-To: <20120526.004459.1494543364832806830.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org

On Fri, May 25, 2012 at 9:44 PM, David Miller <davem@davemloft.net> wrote:
>
> Ok, with the following patch, it seems to work on sparc too.

Good. I'll combine things and then split them up a bit differently (ie
a "create generic version" patch and then separate "start using
generic version" patches for x86 and sparc).

> diff --git a/arch/sparc/include/asm/word-at-a-time.h b/arch/sparc/include/asm/word-at-a-time.h
> new file mode 100644
> index 0000000..b522cc3
> --- /dev/null
> +++ b/arch/sparc/include/asm/word-at-a-time.h
> @@ -0,0 +1 @@
> +#include <asm-generic/word-at-a-time.h>

This part *should* be unnecessary, I already did the

   generic-y += word-at-a-time.h

in arch/sparc/include/asm/Kbuild. Can you verify? Or did something go wrong?

                    Linus
