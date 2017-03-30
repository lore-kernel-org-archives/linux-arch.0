From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][CFT][PATCHSET v1] uaccess unification
Date: Thu, 30 Mar 2017 12:19:35 -0700
Message-ID: <CA+55aFwktbgtL_x4gKqcJU6=FrkokneLRQ30HtDhuR2WErG83w@mail.gmail.com>
References: <20170329055706.GH29622@ZenIV.linux.org.uk> <20170330162241.GG7909@n2100.armlinux.org.uk>
 <20170330164342.GR29622@ZenIV.linux.org.uk> <CA+55aFzsGSKzbQjWAPxFvc=HeXyr6stk1KsB-1xGCKALgazYuQ@mail.gmail.com>
 <20170330184824.GS29622@ZenIV.linux.org.uk> <20170330185427.GT29622@ZenIV.linux.org.uk>
 <CA+55aFx2u6iUzJV1ZH4w_o6tTZesSGoOxMrOtJB8aXScou6zPg@mail.gmail.com> <20170330191009.GU29622@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:36299 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934299AbdC3TTh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Mar 2017 15:19:37 -0400
In-Reply-To: <20170330191009.GU29622@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Will Deacon <will.deacon@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Steven Miao <realmz6@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Mark Salter <msalter@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole>

On Thu, Mar 30, 2017 at 12:10 PM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> That they very definitely should not.  And not because of access_ok() or
> might_fault() - this is one place where zero-padding is absolutely wrong.
> So unless you are going to take it out of copy_from_user() and pray
> that random shit ioctls in random shit drivers check the return value
> properly, copy_from_user() is no-go here.

Actually, that is a great example of why you should *not* use
__copy_from_user().

If the reason is lack of zero-padding, that doesn't mean that suddenly
we shouldn't check the range. And it doesn't mean that it shouldn't
document why it does it.

So dammit, just add something like this to lib/iovec.c:

    static inline unsigned long copy_from_user_nozero(void *to, const
void __user *from, size_t len)
    {
        if (!access_ok(from, len))
            return len;
        return __copy_from_user(to, from, len);
    }

which now isn't insecure, and also magically documents *why* you don't
just use the plain copy_from_user().

                 Linus
