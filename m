From: Grant Grundler <grantgrundler@gmail.com>
Subject: Re: [parisc] double restarts on multiple signal arrivals
Date: Fri, 18 May 2012 13:12:13 -0700
Message-ID: <CAP6odjgyK3af7yqHAFTTs38SSNM9H49oWiH=a4byp4MerirE0g@mail.gmail.com>
References: <20120518175833.GQ22082@ZenIV.linux.org.uk>
	<CAP6odjiS+oH7ajnHcyBJwm9bCTZxDJ7w02JeCuWW_UF3Fm49xw@mail.gmail.com>
	<20120518195610.GV22082@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:50466 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967324Ab2ERUMO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 May 2012 16:12:14 -0400
In-Reply-To: <20120518195610.GV22082@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>, Carlos O'Donell <carlos@systemhalted.org>, John David Anglin <dave.anglin@bell.net>
Cc: linux-parisc@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org

+patofiero,anglin

On Fri, May 18, 2012 at 12:56 PM, Al Viro <viro@zeniv.linux.org.uk> wro=
te:
> On Fri, May 18, 2012 at 11:05:46AM -0700, Grant Grundler wrote:
>> On Fri, May 18, 2012 at 10:58 AM, Al Viro <viro@zeniv.linux.org.uk> =
wrote:
>> ...
>> >?Except for that mess with multiple
>> > pending signals, the value we have in r28 on syscall entry doesn't
>> > seem to affect the syscall behaviour... ?Some HPUX compat fun?
>>
>> We stopped trying to support HPUX compat support probably 8 or so
>> years ago. Since HP didn't care, no one else did either. =A0So no ne=
ed
>> to consider it now.
>
> BTW, what should we put into the trampolines of subsequent sigframes
> when we are building more that one?

Sorry - I only knew about the state of the HPUX support...Carlos and
Dave (and a few others) understand the syscall interface. I've include
them directly and hopefully they can respond soon.

cheers,
grant

> =A0I.e. suppose we are in a syscall
> and see two signals. =A0We build a sigframe for the first one, with
> r25 =3D 1, call rt_sigreturn() in it. =A0Return address of original s=
yscall
> is stored into sigcontext of that frame, our return address set to th=
e
> entry point of handler1. =A0Now we see the second signal and build an=
other
> sigframe. =A0That one will have the entry point of the first handler =
stored
> in sigframe and we'll set the things up so that return to userland wi=
ll
> land us in the entry of handler2. =A0Fine, but... what should we have=
 in r25
> for rt_sigreturn() in the second trampoline?
>
> We return to userland and find ourselves in the beginning of handler2=
=2E
> It's executed and eventually we return from it. =A0We are at the begi=
nning
> of the second trampoline now. =A0rt_sigreturn() is called, restores t=
he
> registers from the second sigcontext and returns to userland. =A0We a=
re at
> the beginning of handler1. =A0It is executed and returns. =A0We are a=
t the
> beginning of the first trampoline. =A0rt_sigreturn() _there_ restores=
 the
> original registers from the first sigcontext and we finally return to=
 the
> insn right after the original syscall (or to the syscall itself if we
> took a syscall restart).
>
> That final rt_sigreturn() will go through syscall_exit; OK, no proble=
m
> with that. =A0But should the earlier one (done after return from hand=
ler2()
> and landing us at the entry of handler1) go through syscall_exit or
> through syscall_exit_rfi?
