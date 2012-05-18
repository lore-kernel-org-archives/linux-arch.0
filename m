From: "Carlos O'Donell" <carlos@systemhalted.org>
Subject: Re: [parisc] double restarts on multiple signal arrivals
Date: Fri, 18 May 2012 16:15:42 -0400
Message-ID: <CADZpyixTTcNd0GekBg=UeWMf3eR+Casn6r7cLkcfnaH1Mihk=w@mail.gmail.com>
References: <20120518175833.GQ22082@ZenIV.linux.org.uk>
	<CAP6odjiS+oH7ajnHcyBJwm9bCTZxDJ7w02JeCuWW_UF3Fm49xw@mail.gmail.com>
	<20120518195610.GV22082@ZenIV.linux.org.uk>
	<CAP6odjgyK3af7yqHAFTTs38SSNM9H49oWiH=a4byp4MerirE0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:45473 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932822Ab2ERUPn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 May 2012 16:15:43 -0400
In-Reply-To: <CAP6odjgyK3af7yqHAFTTs38SSNM9H49oWiH=a4byp4MerirE0g@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Grant Grundler <grantgrundler@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, John David Anglin <dave.anglin@bell.net>, linux-parisc@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org

On Fri, May 18, 2012 at 4:12 PM, Grant Grundler <grantgrundler@gmail.co=
m> wrote:
> +patofiero,anglin
>
> On Fri, May 18, 2012 at 12:56 PM, Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>> On Fri, May 18, 2012 at 11:05:46AM -0700, Grant Grundler wrote:
>>> On Fri, May 18, 2012 at 10:58 AM, Al Viro <viro@zeniv.linux.org.uk>=
 wrote:
>>> ...
>>> >?Except for that mess with multiple
>>> > pending signals, the value we have in r28 on syscall entry doesn'=
t
>>> > seem to affect the syscall behaviour... ?Some HPUX compat fun?
>>>
>>> We stopped trying to support HPUX compat support probably 8 or so
>>> years ago. Since HP didn't care, no one else did either. =A0So no n=
eed
>>> to consider it now.
>>
>> BTW, what should we put into the trampolines of subsequent sigframes
>> when we are building more that one?
>
> Sorry - I only knew about the state of the HPUX support...Carlos and
> Dave (and a few others) understand the syscall interface. I've includ=
e
> them directly and hopefully they can respond soon.

I've hit "Mark as unread" twice on this thread now because I *am*
interested in this conversation.

However, I must confess that the original email reads like a rant
without a clear explanation of exactly what you think is wrong.

I'm familiar with the PARISC signal code because I worked on the
32/64-bit compat support for the frame layout, I also helped Randolph
work on the syscall restart logic.

What I don't understand is what's wrong with it now, and your subject
begins to hint at the problem.

Can you describe in more detail exactly what problem we need to solve?

Cheers,
Carlos.
