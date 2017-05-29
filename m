From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] kbuild: provide THIN_ARCHIVES option for all architectures
Date: Mon, 29 May 2017 10:03:19 -0700
Message-ID: <CA+55aFyM8c1h7S+x95qvv84jphu9=XSXZop=gVp7xc5tf3JJMQ@mail.gmail.com>
References: <20170529081103.29999-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f182.google.com ([209.85.223.182]:36501 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750844AbdE2RDU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 May 2017 13:03:20 -0400
In-Reply-To: <20170529081103.29999-1-npiggin@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>

On Mon, May 29, 2017 at 1:11 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> The next step will be to have archs always select THIN_ARCHIVES
> when they are known to work. Then remove the option entirely.

Honestly, why even do that?

If we really think that thin archives is the way to go, and it's known
to work on ppc, x86 and arm, why not just do it unconditionally?

I hate our kconfig process as-is, and asking about odd binutils things
that nobody knows the answer to is just rude. Plus it will actually be
really really painful to find problems triggered by this, because it
will be some magical config detail that nobody thinks of.

In contrast, if we just enable this unconditionally,  and it causes
problems, they will show up the culprit trivially with "git bisect".

So either thin archives work or they don't. Don't make it some painful
drawn-out process that actually makes it harder to test rather than
easier.

                          Linus
