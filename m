From: "Carlos O'Donell" <carlos@systemhalted.org>
Subject: Re: [parisc] double restarts on multiple signal arrivals
Date: Sun, 20 May 2012 16:38:20 -0400
Message-ID: <CADZpyizTP7n3kaPurqoeWPcEkhBK+UKY5j+30=RrMzM5w74xvQ@mail.gmail.com>
References: <20120518175833.GQ22082@ZenIV.linux.org.uk>
	<CAP6odjiS+oH7ajnHcyBJwm9bCTZxDJ7w02JeCuWW_UF3Fm49xw@mail.gmail.com>
	<20120518195610.GV22082@ZenIV.linux.org.uk>
	<CAP6odjgyK3af7yqHAFTTs38SSNM9H49oWiH=a4byp4MerirE0g@mail.gmail.com>
	<CADZpyixTTcNd0GekBg=UeWMf3eR+Casn6r7cLkcfnaH1Mihk=w@mail.gmail.com>
	<20120518222422.GX22082@ZenIV.linux.org.uk>
	<20120520084042.GA25447@ZenIV.linux.org.uk>
	<20120520090444.GA26841@ZenIV.linux.org.uk>
	<BLU0-SMTP98435C9101767076C00E7A971C0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:58397 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752453Ab2ETUiV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sun, 20 May 2012 16:38:21 -0400
In-Reply-To: <BLU0-SMTP98435C9101767076C00E7A971C0@phx.gbl>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: John David Anglin <dave.anglin@bell.net>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Grant Grundler <grantgrundler@gmail.com>, linux-parisc@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org

On Sun, May 20, 2012 at 2:46 PM, John David Anglin <dave.anglin@bell.ne=
t> wrote:
> On 20-May-12, at 5:04 AM, Al Viro wrote:
>
>> Actually, looks like I am missing something, but it's not particular=
y
>> subtle.
>> SYSCALL_TRACE is needed for do_syscall_trace_enter() to do anything;
>> any of SYSCALL_TRACE/SINGLESTEP/BLOCKSTEP is makes
>> do_syscall_trace_leave()
>> do things. =A0So checking one bit in flags is not enough - any of th=
ose 3 is
>> a reason for taking the slow path. =A0The point still stands, though=
 -
>> =A0 =A0 =A0 =A0mfctl =A0 %cr30, %r1
>> =A0 =A0 =A0 =A0LDREG =A0 TI_FLAGS(%r1),%r1
>> =A0 =A0 =A0 =A0ldi =A0 =A0 (_TIF_SYSCALL_TRACE | _TIF_SINGLESTEP | _=
TIF_BLOCKSTEP),
>> %r19
>> =A0 =A0 =A0 and,COND(=3D) %r19, %r1, %r0
>> =A0 =A0 =A0 =A0b,n =A0 =A0 .Ltracesys
>> would still be no worse on the fast path and would not hit the slow =
path
>> in
>> a lot of cases when the current code does it for no apparent reason.
>>
>> Comments?
>
>
> This looks good to me. =A0There is similar code in entry.S.
>
> I added the above change to my patch set for stable 3.3.6. =A0System =
still
> boots. =A0I singled stepped /bin/ls through a directory listing and i=
t seemed
> to work.

I'm running this through the ringer on my local system.

I'll send out an update when I'm done testing.

Cheers,
Carlos.
