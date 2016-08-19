From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] ARC: uaccess: get_user to zero out dest in cause of fault
Date: Fri, 19 Aug 2016 15:00:47 -0700
Message-ID: <CA+55aFyvBd+sMTC-NsEG4QzVApmy0UhSfpoVOP58m-Zg2wumPQ@mail.gmail.com>
References: <1471633802-2936-1-git-send-email-vgupta@synopsys.com> <20160819212428.GR2356@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:36274 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754305AbcHSWAs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 19 Aug 2016 18:00:48 -0400
In-Reply-To: <20160819212428.GR2356@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>

On Fri, Aug 19, 2016 at 2:24 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>         * x86-only get_user_ex().  Does *not* return anything, uses per-process
> flag to indicate errors, the entire sequence is bracketed by uaccess_try()
> and uaccess_catch(err), the latter dumps the flag into err.

I really don't want people to copy that pattern.

It's absolutely horrendous if you start taking faults, and you'll take
fault after fault after fault - in kernel space too. Yes, faults are
very very rare, but still, the interface is bad.

I'd much rather other architectures used the "unsafe_get_user()"
model, which currently only "strncpy_from_user()" and friends use. If
gcc ever ends up supporting "asm goto" with outputs, that interface is
actually able to generate pretty much optimal code.

And "unsafe_put_user()" can actually generate "perfect" code *today*,
because it doesn't have outputs, so "asm goto" actually works right
now. You can make it do the branch-out directly from the exception
case. It's not used right now, but as a replacement for the nasty
"put_user_ex()" model, it's actually much much better.

(I have some experimental patches that actually use "asm goto" in
"unsafe_put_user()" to get that nice code generation, but they only
work if your gcc version supports "asm goto", which some older
versions of gcc does not)

> Suggestions?

Please see "unsafe_put_user(x, ptr, error_label)" as the future. No,
right now it ends up doing the same old thing, but that is _fixable_
unlike the other strange special cases.

Side note: the "error-label" form was introduced in this merge window,
exactly because I wanted to have an interface that is optimizable in
the future.

See commit 1bd4403d86a1 ("unsafe_[get|put]_user: change interface to
use a error target label")

            Linus
