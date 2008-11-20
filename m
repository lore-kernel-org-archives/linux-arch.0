Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:30263 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752470AbYKTWlI (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 20 Nov 2008 17:41:08 -0500
Received: by fg-out-1718.google.com with SMTP id 19so511712fgg.17
        for <linux-arch@vger.kernel.org>; Thu, 20 Nov 2008 14:41:05 -0800 (PST)
Message-ID: <cfd18e0f0811201441i3801ad3blb9f142a7a0381634@mail.gmail.com>
Date: Thu, 20 Nov 2008 17:41:04 -0500
From: "Michael Kerrisk" <mtk.manpages@googlemail.com>
Reply-To: mtk.manpages@gmail.com
Subject: Re: [patch 05/35] reintroduce accept4
In-Reply-To: <alpine.LFD.2.00.0811201412040.21698@nehalem.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200811192336.mAJNaE3R030021@imap1.linux-foundation.org>
	 <Pine.LNX.4.64.0811202259360.12975@anakin>
	 <alpine.LFD.2.00.0811201412040.21698@nehalem.linux-foundation.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, akpm@linux-foundation.org, drepper@redhat.com, linux-api@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20081120224104.T0qXwAIeDptmqn2E5EtZBrAu6zFMsgdVEh2z-UB_z7Y@z>

On Thu, Nov 20, 2008 at 5:14 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> On Thu, 20 Nov 2008, Geert Uytterhoeven wrote:
>
>> On Wed, 19 Nov 2008, akpm@linux-foundation.org wrote:
>> > From: Ulrich Drepper <drepper@redhat.com>
>> >
>> > Introduce a new accept4() system call.  The addition of this system call
>>
>> > /* test_accept4.c
>>
>> > #ifdef __x86_64__
>> > #define SYS_accept4 288
>> > #elif __i386__
>>         ^^^^^^^^
>>       defined(__i386__)

Whoops.

>> > #define USE_SOCKETCALL 1
>> > #define SYS_ACCEPT4 18
>> > #else
>> > #error "Sorry -- don't know the syscall # on this architecture"
>> > #endif
>>
>> Anyway, it's just a test program. Succeeded on m68k using socketcall.
>
> It _should_ work even without the 'defined()'. Didn't it?

It did.  I successfully used it for testing on i386.

> Unknown symbols should expand to '0' in preprocessor value evaluation. Of
> course, the compiler may warn about the practice, but it shouldn't be
> technically wrong.


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
git://git.kernel.org/pub/scm/docs/man-pages/man-pages.git
man-pages online: http://www.kernel.org/doc/man-pages/online_pages.html
Found a bug? http://www.kernel.org/doc/man-pages/reporting_bugs.html
