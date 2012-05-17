From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 01/10] Use __kernel_long_t in struct timex
Date: Thu, 17 May 2012 15:58:26 -0700
Message-ID: <CA+55aFzVpx94YyC3N2rJaNYLnwUmgNDvzSJnbq1ByNhETY4q9g@mail.gmail.com>
References: <1337292816-10839-1-git-send-email-hjl.tools@gmail.com>
 <1337292816-10839-2-git-send-email-hjl.tools@gmail.com> <CA+55aFx98qvVg1JhMV0JjgNGb++xtir5ocseY3xgQNc3qAtWdQ@mail.gmail.com>
 <4FB57EB2.4050208@zytor.com> <CA+55aFzztct_HzmGiit=9SwwM4_YPuXbjwMdJpM1JHMXGBNqaA@mail.gmail.com>
 <4FB581D5.9010606@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:51041 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760557Ab2EQW6s (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 May 2012 18:58:48 -0400
In-Reply-To: <4FB581D5.9010606@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de

On Thu, May 17, 2012 at 3:55 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>
> I would suggest __slong and __ulong then, to keep with the __[su]*
> namespace, or does the extra "s" look too much like crap?

I do think I could live with it. Maybe we can make x32 do

   typedef __s64 __slong;
   typedef __u64 __ulong;

and at least not make the "we're declaring a 'long' as a 'long long'"?

                     Linus
