From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 08/10] Use __kernel_ulong_t in struct msqid64_ds
Date: Fri, 18 May 2012 21:31:29 +0000
Message-ID: <201205182131.29353.arnd@arndb.de>
References: <1337292816-10839-1-git-send-email-hjl.tools@gmail.com> <CA+55aFwyem9KoPMhYkE-vcaUDqgP9g7arHbmD-mMHMSKXaRBOw@mail.gmail.com> <CA+55aFx4sEQT=U4DBULeo9=3piOx_pQUws92ovKV5bKsu3hQQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:61649 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967553Ab2ERVbf (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 May 2012 17:31:35 -0400
In-Reply-To: <CA+55aFx4sEQT=U4DBULeo9=3piOx_pQUws92ovKV5bKsu3hQQQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, David Daney <ddaney.cavm@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, "H.J. Lu" <hjl.tools@gmail.com>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de

On Friday 18 May 2012, Linus Torvalds wrote:
> For example, instead of this horrible crap:
> 
>           __kernel_time_t msg_stime;      /* last msgsnd time */
>   #if __BITS_PER_LONG != 64
>           unsigned long   __unused1;
>   #endif
> 
> which is just nasty, we could have something much cleaner like this:
> 
>   #define align_64_entry(type,name) \
>               union { type name; __u64 __align_##name; }
> 
> and then just use
> 
>            align_64_entry(__kernel_time_t msg_stime);
> 
> without any preprocessor #if/#ifdef crap anywhere.
> 
> It would keep the current state for the (apparently broken) case of
> 64-bit kernel and 32-bit user space with big-endian architectures, but
> it would also just magically work if __kernel_time_t is 64-bit
> despite "long" being 32-bit.
> 
> So it would fix the x32 case, as far as I can tell.
> 
> Note: totally untested. Maybe there's some reason why my anonymous
> union trick wouldn't work.

When the header files were written, we still allowed them to be included
by programs that were written for older non-gcc compilers.

We already rely on 'long long' being a valid type these days, so we could
probably extend the requirement to cover anonymous unions as well, but
there may be cases where some code includes this file and needs to get
built with -std=something-old that doesn't allow anonymous unions.

As another historical background on this header, note that some big-endian
architectures put the padding before the variable but others don't,
presumably because the person doing the architecture port didn't understand
the intention or didn't care.

However, in the kernel we *always* copy the fields one by one for compat
mode, even for the architectures that have identical layout between 32 and
64 bit, and at least one libc implementation that I've seen (IIRC uClibc)
hardcodes the data structure to be the same as x86, with the padding
after the 'long', for all architectures. When I introduced the asm-generic
version of this, we had a discussion about whether we should try to use
the version with the "correct" padding but in the end decided to just use
the x86 version because that is what most big-endian architectures do
anyway.

	Arnd
