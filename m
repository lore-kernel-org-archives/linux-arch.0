From: "Carlos O'Donell" <carlos@systemhalted.org>
Subject: Re: [parisc] double restarts on multiple signal arrivals
Date: Fri, 18 May 2012 21:36:47 -0400
Message-ID: <CADZpyix9s+086K7W5Bd1mx15go+927rp+ihBOX43gBBsYEtTBg@mail.gmail.com>
References: <20120518175833.GQ22082@ZenIV.linux.org.uk>
	<CAP6odjiS+oH7ajnHcyBJwm9bCTZxDJ7w02JeCuWW_UF3Fm49xw@mail.gmail.com>
	<20120518195610.GV22082@ZenIV.linux.org.uk>
	<CAP6odjgyK3af7yqHAFTTs38SSNM9H49oWiH=a4byp4MerirE0g@mail.gmail.com>
	<CADZpyixTTcNd0GekBg=UeWMf3eR+Casn6r7cLkcfnaH1Mihk=w@mail.gmail.com>
	<20120518222422.GX22082@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39203 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753547Ab2ESBgs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 18 May 2012 21:36:48 -0400
In-Reply-To: <20120518222422.GX22082@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Grant Grundler <grantgrundler@gmail.com>, John David Anglin <dave.anglin@bell.net>, linux-parisc@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, linux-arch@vger.kernel.org

On Fri, May 18, 2012 at 6:24 PM, Al Viro <viro@zeniv.linux.org.uk> wrot=
e:
> On Fri, May 18, 2012 at 04:15:42PM -0400, Carlos O'Donell wrote:
>
>> I've hit "Mark as unread" twice on this thread now because I *am*
>> interested in this conversation.
>>
>> However, I must confess that the original email reads like a rant
>> without a clear explanation of exactly what you think is wrong.
>>
>> I'm familiar with the PARISC signal code because I worked on the
>> 32/64-bit compat support for the frame layout, I also helped Randolp=
h
>> work on the syscall restart logic.
>>
>> What I don't understand is what's wrong with it now, and your subjec=
t
>> begins to hint at the problem.
>>
>> Can you describe in more detail exactly what problem we need to solv=
e?
>
> Sure. =A0Have e.g. read(2) on a pipe called when you happen to have -=
512 in
> r28 and have two signals arrive at once while inside that read(). =A0=
Both
> with user handlers. =A0Both with SA_RESTART.
>
> When we enter the kernel, we have pt_regs created on kernel stack and
> filled with the values we had in registers. =A0Among other things, th=
e
> value of r28 is stored in regs->orig_r28. =A0Note that arguments and =
the
> syscall number are all passed through other registers, so setting the
> arguments for syscall did not overwrite the value we used to have in
> r28. =A0It's still -512.
>
> We find which C function to call (sys_read) and go there, with return
> address set to syscall_exit.
>
> sys_read() ends up calling pipe_read(), which finds pipe empty and go=
es
> to sleep. =A0The signals arrive and pipe_read() is woken up. =A0It se=
es that
> =A0 =A0 =A0 =A0* signal_pending() is true
> =A0 =A0 =A0 =A0* nothing has been read yet
> so it return -ERESTARSYS. =A0sys_read() returns what it got from pipe=
_read().
>
> Now we are at syscall_exit. =A0We set r1 to pt_regs created on stack =
when
> we entered the syscall. =A0Return value of sys_read() is taken from r=
28 and
> stored into regs->gr[28]. =A0We check TIF_NEED_RESCHED and it's not s=
et.
> We'd reached syscall_check_sig and check TIF_SIGPENDING, which is set=
=2E
> We go through syscall_do_signal and reach the call of
> do_notify_resume(regs, 1), which calls do_signal(regs, 1).
>
> There we call get_signal_to_deliver() and get one of those two signal=
s
> dequeued and returned. =A0Note that TIF_SIGPENDING is still set - the=
re is
> the second signal left. =A0We got positive signr, so we do not leave =
the
> loop yet. =A0in_syscall is 1, so we call syscall_restart().
>
> We check regs->gr[28], which is -ERESTARTSYS. =A0SA_RESTART is set in
> sa_flags, so we fall through to the next case, which is
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0regs->gr[31] -=3D 8; /* delayed branch=
ing */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Preserve original r28. */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0regs->gr[28] =3D regs->orig_r28;
> Note that ERESTARTSYS is 512, so the second assignment does nothing -=
 we
> still have regs->gr[28] equal to -ERESTARTSYS. =A0We are done with
> syscall_restart().
>
> Now we call handle_signal(), which calls setup_rt_frame(). =A0sigfram=
e is
> allocated on userland stack and filled accordingly to the contents of=
 *regs.
> No errors occured, so we set regs->gr[31] to entry point of signal ha=
ndler,
> regs->gr[2] to address of sigreturn trampoline we'd created in the si=
gframe,
> regs->gr[26..24] to arguments of handler, and regs->gr[30] to new val=
ue of
> userland stack pointer.
>
> Back in handle_signal(), we adjust the set of blocked signals and ret=
urn 1.
> do_signal() sees that RESTORE_SIGMASK is not set and it's done - we r=
eturn
> to do_notify_resume() and from there back into entry.S.
>
> We reload registers from pt_regs and go to syscall_check_sig again. =A0=
There
> we reread the thread flags and see that SIGPENDING is still set - we =
have
> another signal to deal with. =A0We hit do_notify_resume() and do_sign=
al()
> again. =A0And again, in_syscall is 1.
>
> do_signal() gets the remaining pending signal from get_signal_to_deli=
ver().
> Again, we call syscall_restart(). =A0And neither regs->gr[28] nor reg=
s->orig_r28
> has been changed, so we hit the same case. =A0Assignment to regs->gr[=
28] is
> a no-op again. =A0But look what happened to regs->gr[31] - it got dec=
remented
> by 8. =A0So it points 8 bytes before the entry point of the first han=
dler now.
>
> We proceed to set the second sigframe up. =A0The registers are saved =
in
> sigcontext, adjusted so that they correspond to the call of the secon=
d
> handler with future return to the second trampoline and we return all=
 the
> way out to entry.S. =A0There we go to syscall_check_sig again, but th=
is
> time we have no pending signals left, so we reach syscall_restore and
> proceed to userland.
>
> Now we are in the second handler. =A0It's executed to the end and whe=
n it
> returns, we go to the address we had in r2. =A0I.e. the second trampo=
line.
> There we get r25 set to 1, r20 set to __NR_rt_sigreturn and we go to
> execute the syscall. =A0Which restores the registers from sigcontext =
and,
> since its in_syscall argument is 1, sets ->gr[31] to sc->sc_iaoq. =A0=
Which
> had been set by setup_rt_sigcontext() from regs->gr[31] at the moment=
 it
> had been called, i.e. the entry point of the first handler decremente=
d by 8.
> Then we proceed to return to userland. =A0And arrive there are the ri=
ght
> arguments for the first handler, but instruction pointer is 8 bytes t=
oo
> early. =A0Bad things happen, obviously.
>
> The point where the things go wrong is the second call of syscall_res=
tart().
> It should've done nothing. =A0We need to do syscall restarts only whe=
n building
> the first sigframe. =A0And usually it does work out that way, simply =
because
> the value you happened to have in r28 is probably not one of the 4 th=
at
> make syscall_restart() do things. =A0So after the first time around i=
t does
> nothing. =A0Very similar logics on x86 does, indeed, work in all case=
s.
> There the register used for return values happens to be the same as w=
e use
> to pass syscall number, so you can't arrange a call of syscall_restar=
t()
> analog that would trigger restart *and* leave the return value regist=
er
> unchanged - you'd need %eax to be -ERESTART<something> when you enter=
 the
> syscall and that would immediately result in regs->ax set to -ENOSYS.=
 =A0I.e.
> no restarts would be done. =A0However, on parisc that doesn't work - =
you can
> start with r28 being -ERESTARTSYS and get -ERESTARTSYS from syscall.
>
> And no, I don't have any good suggestions on how to fix it right now.=
 =A0Depends
> on how does gdb on parisc play with pt_regs, among other things...
>
> Sorry if the original posting sounded like a rant - I'd spent the las=
t month
> crawling through the assembler glue around signal hanlding all over a=
rch/*
> and that probably affected the tone. =A0Definitely had been affecting=
 the amount
> of spoken obscenities lately...

Thanks Al. This is description is a work of art, I wish all
reports looked like this. I'll go over this code tomorrow and
get back to you with my thoughts. I really appreciate the
thorough review.

Cheers,
Carlos.
