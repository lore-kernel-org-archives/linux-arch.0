From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: x86: faster strncpy_from_user()
Date: Tue, 10 Apr 2012 17:57:07 -0700
Message-ID: <CA+55aFw9-cVKP4MUpO6pCLbpHavrB1qbJ1NeiXEBbNupZ0iYKA@mail.gmail.com>
References: <1334097321.3040.62.camel@pasglop> <20120410.192550.1904257005034151185.davem@davemloft.net>
 <CA+55aFwAQ13t6HwPVmvntwPvDq_kK6=W9e8KLahtfGwKr=2YCQ@mail.gmail.com>
 <20120410.204322.1625218582933057448.davem@davemloft.net> <CA+55aFwVbGzk1Nwj1uk=R_XPPEkF2wZ_K8zhbmPZjy39r4rYDQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:35289 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756820Ab2DKA52 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Apr 2012 20:57:28 -0400
Received: by wibhj6 with SMTP id hj6so3878002wib.1
        for <linux-arch@vger.kernel.org>; Tue, 10 Apr 2012 17:57:27 -0700 (PDT)
In-Reply-To: <CA+55aFwVbGzk1Nwj1uk=R_XPPEkF2wZ_K8zhbmPZjy39r4rYDQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: benh@kernel.crashing.org, mingo@kernel.org, hpa@zytor.com, x86@kernel.org, linux-arch@vger.kernel.org

On Tue, Apr 10, 2012 at 5:50 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> .. and you don't have a double shift, right? So you'd need to do two
> shifts and the or for each word.

Actually, if sparc has a "rotate" instruction, you can do with a
single shift (rotate) per word loop.

You need to set up a mask register based on the alignment, and
pre-load the first word, but if you do have a rotate you can rotate
and then use "and mask" first to generate the "high bits" of the
current word, and then use the "andn mask" to generate the low bits of
the next word. So then you just need a single rotate per loop, and
some (very minor) loop prep.

Of course, RISC people tended to throw out rotate too, so maybe you
don't have even that.

                 Linus
