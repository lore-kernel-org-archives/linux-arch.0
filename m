From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: x86: faster strncpy_from_user()
Date: Tue, 10 Apr 2012 17:34:14 -0700
Message-ID: <CA+55aFwAQ13t6HwPVmvntwPvDq_kK6=W9e8KLahtfGwKr=2YCQ@mail.gmail.com>
References: <CA+55aFy8J5Ns4P514g7Ow4WhJXO+pjPBozYuCinYB+FQUKjZ6A@mail.gmail.com>
 <1334097321.3040.62.camel@pasglop> <20120410.192550.1904257005034151185.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:51836 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759830Ab2DKAeg (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Apr 2012 20:34:36 -0400
Received: by wejx9 with SMTP id x9so223912wej.19
        for <linux-arch@vger.kernel.org>; Tue, 10 Apr 2012 17:34:34 -0700 (PDT)
In-Reply-To: <20120410.192550.1904257005034151185.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: benh@kernel.crashing.org, mingo@kernel.org, hpa@zytor.com, x86@kernel.org, linux-arch@vger.kernel.org

On Tue, Apr 10, 2012 at 4:25 PM, David Miller <davem@davemloft.net> wrote:
>
> Although that would be a neat trick, making the hashing function work
> in a way such that if we simply rewound the initial pointer to be
> aligned, put 0xff into the alignment bytes, and the hash would still
> compute properly.

I cannot imagine any worthwhile hash that works like that.

Any hash that magically works with aligned data implies basically
throwing away all the actual real bits of information in a file name,
notably all the "where are the letters" information.

So the hashing really *does* need unaligned loads (or the
shift-things-by-hand to emulate it).

Sparc has "faligndata", no? Power generally does unaligned loads
"reasonably ok", although I seem to recall some horrible 7-cycle
micro-trap on at least some micro-architecture (and a page-crossing
fault fixup in software, but that's not going to happen in practice:
the pathname is allocated from a page in getname())

                      Linus
