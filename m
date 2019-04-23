Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35596 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfDWXiz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Apr 2019 19:38:55 -0400
Received: by mail-lf1-f68.google.com with SMTP id j20so13091271lfh.2
        for <linux-arch@vger.kernel.org>; Tue, 23 Apr 2019 16:38:54 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id f18sm3986750lfh.39.2019.04.23.16.38.51
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 16:38:51 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id w23so13065696lfc.9
        for <linux-arch@vger.kernel.org>; Tue, 23 Apr 2019 16:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAQwHRJL=3yD_7P2mMSVnwZbayww+dHC22+v4oTpMZv58w@mail.gmail.com>
 <CALCETrVSM0vrMVr2y0ECAQ=tNGvBs=im2Kxongq-jvdzUBevbg@mail.gmail.com>
In-Reply-To: <CALCETrVSM0vrMVr2y0ECAQ=tNGvBs=im2Kxongq-jvdzUBevbg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 23 Apr 2019 16:38:35 -0700
Message-ID: <CAHk-=wiV2gLQkp6JFQYewL1uzgWnwEK9fKWP3AfZbcu2Lv_GrQ@mail.gmail.com>
Subject: Re: Does vdso_install attempt to re-compile objects under root privilege?
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Message-ID: <20190423233835.GBuN-narGDi5ZxHc3XTJ2OVjgeQqqMsprIbS6NfcGAg@z>

On Tue, Apr 23, 2019 at 11:47 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> Hmm.  I suppose an alternative would be for vdso_install to fail if
> the vdso isn't built?

I absolutely abhor even the concept of building the kernel as root,
and I think it should be actively disallowed. Our build system is
good, but it's good as in "clever and complex" rather than necessarily
good as in "very secure".

So anybody who builds the kernel as root is doing something seriously
wrong, in my opinion.

That's partly exactly _because_ we have a lot of magical and very
powerful build rules, and complicated implicit things going on.

For example, our dependencies aren't even about just the files in the
kernel repository itself, we have clever things like "if the compiler
has been updated and features or version changes, we'll automatically
rebuild, because it's part of our clever build system checks".

But that is also part of the reason why I absolutely do *not* want any
root-building to happen, because our build setup is simply way too
clever.

If root builds stuff, you'll end up with root-owned generated
subdirectories or various config files etc, and even if you don't have
security issues, it can complicate the build later as a regular user.

I've had the build occasionally fail in odd ways, because some
root-owned file was now no longer removable (usually it's the
auto-generated header files in the directory, and the root-generated
and owned directory is now not writable by the developer any more).
And every time it happens, I shudder.

So all of that simply boils down to "root should not be running those
complex rules for our config and dependency magic".

At the same time, "make install" obviously needs to be done as root.

All of which is why I opine that "make install" should never build
anything at all, it should purely be used as a "install previously
built files".

So yes, I'd much prefer just failing over trying to build as root (or
even trying to figure out dependencies as root).

> What's the ideal outcome here?

I'd basically like the rule for "make install" to be that it never
ever generates a single file in the build tree, so that there are
never any root-owned (or root-overwritten) files there.

So "make install" should even avoid all dependency checking, for the
simple reason that if you happen to do a system update between "make"
and "make install", our smart dependencies should never say "oh, the
compiler version has changed, so now I'll rebuild everything as root
just because 'make install'".

So I think the ideal outcome is just "fail if you can't find the files
to install".

                     Linus
