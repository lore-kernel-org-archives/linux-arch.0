From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] spin loop primitives for busy waiting
Date: Fri, 12 May 2017 08:56:23 -0700
Message-ID: <CA+55aFyZKwHdtfjZOpo2ReEeyLG24Qpik4UzqyM3V63mxBujKQ@mail.gmail.com>
References: <20170511165727.17847-1-npiggin@gmail.com> <CA+55aFzS9ENQnRoTbLMd_nFwwjuU+s9yj0tZcLSYDDjnwqTKrg@mail.gmail.com>
 <063D6719AE5E284EB5DD2968C1650D6DCFFE9D65@AcuExch.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:36218 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757262AbdELP4a (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 May 2017 11:56:30 -0400
Received: by mail-it0-f45.google.com with SMTP id o5so13099817ith.1
        for <linux-arch@vger.kernel.org>; Fri, 12 May 2017 08:56:29 -0700 (PDT)
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DCFFE9D65@AcuExch.aculab.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Laight <David.Laight@aculab.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>

On Fri, May 12, 2017 at 5:58 AM, David Laight <David.Laight@aculab.com> wrote:
>
> At least some versions of gcc convert while (cond) do {body}
> into if (cond) do {body} while (cond) even when 'cond'
> is a non-trivial expression and 'body' is trivial.

Afaik pretty much all versions of gcc do that, unless you use -Os
(which we have effectively stopped doing because it causes so many
other problems in stupid instruction choices etc).

> The code-bloat is silly.
> No point enforcing the 'optimisation' here.

Actually, for places where we expect cold code and the loop to be
often run zero times, it actually makes sense. When we can make the
initial "if()" be unlikely, and gcc can then generate the unlikely
code all out of line, then the while -> if+do-while construction makes
sense.

It's the "normal" while loops that it's sad how big code gcc
generates, considering that most of our loop counts are vert small
(but generally nonzero).

               Linus
