From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Mostly portable strnlen_user()
Date: Sat, 26 May 2012 11:39:10 -0700
Message-ID: <CA+55aFxpEnd2efoU9S208L9HaOD8cvRZ38uCXr=nrhLmwgHZuw@mail.gmail.com>
References: <CA+55aFxYO-fb9K-_g8X85tK8-sGxUHy1R8X3Hes3fb-+0bhXLw@mail.gmail.com>
 <20120525.224318.1418525735588086513.davem@davemloft.net> <CA+55aFxDyPCEFbOFaPbXF556NbtakuC0RcoUKhCa5k2EsqJ8CQ@mail.gmail.com>
 <20120526.001552.1171433126500742038.davem@davemloft.net> <CA+55aFxukJSo7srOcfedqCSz1wiZhjz4=F8Tj96=uOqWxYqq+A@mail.gmail.com>
 <CACM3HyFDY96F5kfsVCRQbx+8J+BUDCWXPqQVuLwOXRefS0Gcvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:64936 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191Ab2EZSjb (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 26 May 2012 14:39:31 -0400
Received: by wibhn6 with SMTP id hn6so531166wib.1
        for <linux-arch@vger.kernel.org>; Sat, 26 May 2012 11:39:30 -0700 (PDT)
In-Reply-To: <CACM3HyFDY96F5kfsVCRQbx+8J+BUDCWXPqQVuLwOXRefS0Gcvg@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jonas Bonn <jonas@southpole.se>, David Miller <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org

On Sat, May 26, 2012 at 1:32 AM, Jonas Bonn <jonas@southpole.se> wrote:
>
> I gave this a try on OpenRISC... works fine here, too.

Ok, guys, there's a "generic-string-functions" branch in my regular
git repositories that has the cleaned-up commit series.

Can you guys double-check that everything looks good, and Jonas, I
assume you could just do a patch to remove the openrisc
str[n]len_user() functions, and then add the "select
GENERIC_STRNLEN_USER". Quite frankly, I could probably do it for you,
but I'm not going to generate a random patch for some architecture
I've never in my life compiled anything for.

David - I committed the sparc strnlen_user removal with you as author,
but without any sign-off. I don't really care, I can sign off on that
patch that just removes code, and I didn't want to add a sign-off line
for you that you had never actually sent. But it's attributed to you
anyway, since it actually came from you.

Further testing would be good, but I feel pretty comfy about it. It
looks fine, and when I once tried to boot a kernel with a broken
strnlen (due to incorrect byte-endian-testing, not actually incorrect
code otherwise), it didn't get very far at all. So this is actually
code that gets a fair amount of coverage testing from not even doing
anything special.

Other big-endian architectures could easily also test this out by
adding the appropriate few lines:

 - arch Kconfig file:
        select GENERIC_STRNCPY_FROM_USER
        select GENERIC_STRNLEN_USER

 - arch/include/asm/Kbuild:
        generic-y += word-at-a-time.h

 - remove your own strncpy_from_user/strnlen_user functions, and
replace them with the appropriate declaration in <asm/uaccess.h>

NOTE NOTE NOTE for arch people. The "asm-generic" header file is
*only* for big-endian machines. Little-endian can do a simpler version
of it. See the x86 file for an example (it looks more complex, but
that's largely because it (a) has the optimized find_zero() and (b)
also supports dcache hashing, which requires the
load_unaligned_zeropad() and zero_bytemask() functions.

You can literally copy the x86 version for other little-endian
architectures, and remove the load_unaligned_zeropad() function.
However, you *probably* also want to tweak the zero-finding logic,
especially if you have a slow multiplier or if you have a good
population-count function.

Also see the explanations in commit 36126f8f2ed8 ("word-at-a-time:
make the interfaces truly generic") which talks about the interfaces
and tries to explain why they look the way they do.

Comments? The diffstat for the series looks quite nice:

 23 files changed, 259 insertions(+), 490 deletions(-)

and the end result is actually much better code than what it used to
be before (not that I can really comment on the sparc code, since I
didn't really look at the asm, but I'm assuming it didn't do all the
clever word-wise stuff. And I *know* the x86 code didn't).

                      Linus
