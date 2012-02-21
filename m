From: Andrew Lutomirski <luto@mit.edu>
Subject: Re: [PATCH 30/30] x32: Add x32 VDSO support
Date: Tue, 21 Feb 2012 10:54:32 -0800
Message-ID: <CAObL_7GqT-CSB6uBoDvKymodEzUi3tY0DJv0U=xzYbaJS7A1nA@mail.gmail.com>
References: <1329696488-16970-1-git-send-email-hpa@zytor.com>
 <1329696488-16970-31-git-send-email-hpa@zytor.com> <4F42E171.9080005@mit.edu>
 <4F431665.3010004@zytor.com> <CAObL_7Hy8Y0PWrcZdRSGRcEt+aoma7ax4XU44f-gdHEGoWBzTg@mail.gmail.com>
 <4F43D98D.1020406@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:49099 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753562Ab2BUSyw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 21 Feb 2012 13:54:52 -0500
In-Reply-To: <4F43D98D.1020406@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mingo@kernel.org, tglx@linutronix.de, torvalds@linux-foundation.org, akpm@linux-foundation.org, hjl.tools@gmail.com

On Tue, Feb 21, 2012 at 9:51 AM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 02/21/2012 08:52 AM, Andrew Lutomirski wrote:
>>>
>>>
>>> What about non-glibc?
>>
>>
>> IMO non-glibc users should just call __vdso_clock_gettime, etc.
>> Currently, code like:
>>
>> if (clock_gettime(whatever) =3D=3D -1)
>> =A0 handle_the_error();
>>
>> is correct when linked against glibc but incorrect when linked
>> directly against the vdso.
>>
>
> The issue is what uclibc, Bionic, etc. actually do.

AFAICS Bionic only works on x86-32 and calls clock_gettime via
hardcoded int 0x80, written in assembly (!).  uclibc calls
__vdso_getcpu and does not seem to use the other vdso calls.  On a
cursory inspection, klibc uses neither the vsyscall page nor the vdso.

I doubt that there's any existing libc replacement that uses the
non-prefixed vdso entries and that already works on x32 -- that would
be impressive.  I'm not suggesting changing anything in the x86-64
vdso.

uclibc hardcodes a call to the vsyscall gettimeofday implementation in
its locking primitives, which probably gives terrible performance, but
that's a separate issue.  I think do_emulate_vsyscall should send a
segfault if called by an x32 task -- there's some security benefit to
doing so, and there's unlikely to be any downside.

--Andy
