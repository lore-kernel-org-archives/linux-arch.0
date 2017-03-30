From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][CFT][PATCHSET v1] uaccess unification
Date: Thu, 30 Mar 2017 10:18:23 -0700
Message-ID: <CA+55aFzsGSKzbQjWAPxFvc=HeXyr6stk1KsB-1xGCKALgazYuQ@mail.gmail.com>
References: <20170329055706.GH29622@ZenIV.linux.org.uk> <20170330162241.GG7909@n2100.armlinux.org.uk>
 <20170330164342.GR29622@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:36676 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932582AbdC3RSZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Mar 2017 13:18:25 -0400
In-Reply-To: <20170330164342.GR29622@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Russell King - ARM Linux <linux@armlinux.org.uk>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Richard Henderson <rth@twiddle.net>, Will Deacon <will.deacon@arm.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Vineet Gupta <vgupta@synopsys.com>, Steven Miao <realmz6@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, Mark Salter <msalter@redhat.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Richard Kuo <rkuo@codeaurora.org>, Tony Luck <tony.luck@intel.com>, Geert Uytterhoeven <geert@linux-m68k.org>, James Hogan <james.hogan@imgtec.com>, Michal Simek <monstr@monstr.eu>, David Howells <dhowells@redhat.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole>

On Thu, Mar 30, 2017 at 9:43 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Thu, Mar 30, 2017 at 05:22:41PM +0100, Russell King - ARM Linux wrote:
> How would the following affect things?
>
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index e68604ae3ced..d24d338f0682 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -184,7 +184,7 @@ static size_t copy_page_to_iter_iovec(struct page *page, size_t offset, size_t b
>
>         kaddr = kmap(page);
>         from = kaddr + offset;
> -       left = __copy_to_user(buf, from, copy);
> +       left = __copy_to_user_inatomic(buf, from, copy);

This is all going in the wrong direction entirely.

That "__copy_to_user()" code was bad from the beginning: it should
never have had the double underscores. I objected to it at the time.

Now you're making it go from bad to insane. You're apparently
mis-using "inatomic" because of subtle issues that have nothing to do
with "inatomic" - you want to get rid of a might_sleep() warning, but
you don't actuially want inatomic behavior, so the thing will still
sleep.

This all very subtle already depends on people having checked the
"struct iov_iter" beforehand. We should *remove* subtle stuff like
that, not add yet more layers of subtlety and possible future bugs
when somebody calls copy_page_to_iter() without having properly
validated the iter.

These are not theoretical issues. We've _had_ these exact bugs when
people didn't validate the stuff they created by hand and bypassed the
normal IO paths.

Trying to optimize away an access_ok() or a might_fault() is *not* a
valid reason to completely break our security model, and create code
that makes no sense (claiming it is atomic when it isn't).

                  Linus
