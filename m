From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: x86: faster strncpy_from_user()
Date: Tue, 10 Apr 2012 17:50:57 -0700
Message-ID: <CA+55aFwVbGzk1Nwj1uk=R_XPPEkF2wZ_K8zhbmPZjy39r4rYDQ@mail.gmail.com>
References: <1334097321.3040.62.camel@pasglop> <20120410.192550.1904257005034151185.davem@davemloft.net>
 <CA+55aFwAQ13t6HwPVmvntwPvDq_kK6=W9e8KLahtfGwKr=2YCQ@mail.gmail.com> <20120410.204322.1625218582933057448.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:43242 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756357Ab2DKAvT (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Apr 2012 20:51:19 -0400
Received: by wibhj6 with SMTP id hj6so3874891wib.1
        for <linux-arch@vger.kernel.org>; Tue, 10 Apr 2012 17:51:18 -0700 (PDT)
In-Reply-To: <20120410.204322.1625218582933057448.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: benh@kernel.crashing.org, mingo@kernel.org, hpa@zytor.com, x86@kernel.org, linux-arch@vger.kernel.org

On Tue, Apr 10, 2012 at 5:43 PM, David Miller <davem@davemloft.net> wrote:
> From: Linus Torvalds <torvalds@linux-foundation.org>
> Date: Tue, 10 Apr 2012 17:34:14 -0700
>
>> Sparc has "faligndata", no?
>
> It's an FPU instruction :-)

Ok.

> The barrel shift would be the fastest on sparc.

.. and you don't have a double shift, right? So you'd need to do two
shifts and the or for each word.

At which point it is probably pointless to even bother on sparc32,
since you only get four bytes per loop. But on 64-bit it presumably
ends up being at least a slight win.

                        Linus
