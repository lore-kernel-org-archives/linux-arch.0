From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 08/10] Use __kernel_ulong_t in struct msqid64_ds
Date: Thu, 17 May 2012 17:22:24 -0700
Message-ID: <CA+55aFwyem9KoPMhYkE-vcaUDqgP9g7arHbmD-mMHMSKXaRBOw@mail.gmail.com>
References: <1337292816-10839-1-git-send-email-hjl.tools@gmail.com>
 <1337292816-10839-9-git-send-email-hjl.tools@gmail.com> <4FB58EFD.7010302@zytor.com>
 <CA+55aFy+XOc350sVuLKDHAaKtz9GdLcVmjxs98N8XLTK4zmMYg@mail.gmail.com> <4FB59474.2020505@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:48431 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932973Ab2ERAWr (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 17 May 2012 20:22:47 -0400
In-Reply-To: <4FB59474.2020505@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: David Daney <ddaney.cavm@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, "H.J. Lu" <hjl.tools@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de

On Thu, May 17, 2012 at 5:14 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>
> The "logical" thing to do here seems to just use __s64, but I have no
> idea if that would suddenly break bigendian architectures...

Well, it would break the case of a 32-bit kernel and 32-bit user land.

So the thing is, that the __BITS_PER_LONG games there currently work
for two cases:

 - when the kernel and user land agree on either 32-bit or 64-bit
(this is probably the common MIPS/PPC case)

 - when the kernel is 64-bit, user-land is 32-bit, and we're little-endian

Using __s64 would actually break old 32-bit big-endian cases, because
the 32-bit binaries would continue to read the first 32 bits, while a
32-bit kernel would consider the first 32 bits to be the *high* bits
of the __s64 value.

That's why I think it's unfixable. It started out broken, and I
presume that 32-bit user land on a 64-bit MIPS/PPC thing either do not
work, or there's some compat crap (like special user-land headers)
fixing things up. Or they just don't use that buggered msqid64_ds
thing at all.

                             Linus
