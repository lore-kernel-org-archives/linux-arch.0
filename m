From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [git pull] uaccess-related bits of vfs.git
Date: Sat, 13 May 2017 09:17:20 -0700
Message-ID: <CA+55aFygN42JbLoSsjjiX9NFY4d1QitvSE8wPQES=JOJ448z8A@mail.gmail.com>
References: <CA+55aFww=ZG0wPad3ELg+ibScr0eWuSxvhGLFaF+PO9kfkSkdw@mail.gmail.com>
 <20170501034536.GX29622@ZenIV.linux.org.uk> <CA+55aFwJXjvYQ7WLmh3z62KQ08XCR89Qh-koC=UTYW+enK6OPQ@mail.gmail.com>
 <20170513065745.GV390@ZenIV.linux.org.uk> <CA+55aFzrcX=B-m5SN1ajEopKbTLj1WcpKZWgdDTwYqoOBPJwaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:36790 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752010AbdEMQRW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 13 May 2017 12:17:22 -0400
In-Reply-To: <CA+55aFzrcX=B-m5SN1ajEopKbTLj1WcpKZWgdDTwYqoOBPJwaQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>, the arch/x86 maintainers <x86@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>

Oops.

*Really* adding the x86 guys now.

Blush.

            Linus

On Sat, May 13, 2017 at 9:15 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, May 12, 2017 at 11:57 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>>
>> First, some stats: there's a thousand-odd callers of __get_user().  Out of
>> those, about 70% are in arch/, mostly in sigframe-related code.
>
> Sure. And they can be trivially converted, and none of them should care at all.
>
>> IOW, we have
>>         * most of users in arch/* (heavily dominated by signal-related code,
>> both loads and stores).  Those need careful massage; maybe unsafe-based
>> solution, maybe something else, but it's obviously per-architecture work
>> and these paths are sensitive.
>
> Why are they sensitive?
>
> Why not just do this:
>
>   git grep -l '\<__\(\(get\)\|\(put\)\)_user(' -- arch/x86
> :^arch/x86/include/asm/uaccess.h
>         | xargs sed -i 's/__\(\(\(get\)\|\(put\)\)_user(\)/\1/g'
>
> which converts all the x86 uses in one go.
>
> Anybody who *relies* on not checking the address_limit is so broken as
> to be not even funny. And anything that is so performance-sensitive
> that anybody can even measure the effect of the above we can convert
> later.
>
> Sure, do it in pieces (eg each architecture separately, then
> "drivers", then "networking", then whatever, until all done), just so
> that *if* something actually depends on semantics (and that really
> shouldn't be the case), we have at least some information from a
> bisect.
>
> But I don't see the excuse for not just doing it. If nobody notices,
> it's an obvious improvement. And if somebody *does* notice, we know
> how to do it properly with unsafe_xyz_user(), because "__xyz_user()"
> most definitely isn't it.
>
> An example of something that *should* be converted is
> "csum_partial_copy_from_user()", but it really does need to use
> "user_access_begin()" and friends, because right now it's using
> stac/clac for each 16-bit word. That's *expensive*, and it's expensive
> whether you use __get_user() or get_user().
>
> Adding x86 people just to see how they react to the above "patch".
>
> For me, in my fairly minimal personal config, the above cleanup patch
> shrinks the text size of the resulting kernel by 1.7kB. Yes, most of
> it is the out-of-line code, but still..
>
> Interestingly, the signal handling code didn't change at all. It looks
> like only the 32-bit code uses __put_user() for the frame setup. The
> regular code uses put_user_try/put_user_catch, which is the
> x86-specific early try at the unsafe versions, but it would actually
> be improved by using "unsafe_put_user()" and my patch to make that use
> "asm goto".
>
>                            Linus
>
> PS. That "patch" depends on modern git - with older versions of git
> you need to do the path negation with ":!pattern", and then you need
> to quote it too since '!' is special for shell.
