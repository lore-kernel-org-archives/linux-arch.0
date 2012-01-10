From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: why doesn't x86_32 have the accept4() syscall?
Date: Tue, 10 Jan 2012 18:00:18 +0100
Message-ID: <CAMuHMdXsDckAud4oaMwzNthVdOfZebCwCMeKf=jav7hF1DUTQw@mail.gmail.com>
References: <CA+8MBbLe5uC4gMg9vySTWYUsNv=P-9spnNbKsFAZqQCT_Wk+YQ@mail.gmail.com>
	<20120109.133640.1785167474272651414.davem@davemloft.net>
	<20120110160317.GC7180@jl-vm1.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:37845 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932088Ab2AJRAT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 10 Jan 2012 12:00:19 -0500
Received: by werm1 with SMTP id m1so3644163wer.19
        for <linux-arch@vger.kernel.org>; Tue, 10 Jan 2012 09:00:18 -0800 (PST)
In-Reply-To: <20120110160317.GC7180@jl-vm1.vm.bytemark.co.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: David Miller <davem@davemloft.net>, tony.luck@intel.com, linux-arch@vger.kernel.org

On Tue, Jan 10, 2012 at 17:03, Jamie Lokier <jamie@shareable.org> wrote=
:
> David Miller wrote:
>> Because accept4() has been provided via the sys_socketcall() indirec=
t
>> operation, for this socket system call and several others the native
>> direct syscalls were never added to the x86 32-bit table and probabl=
y
>> never will be.
>
> Hi David,
>
> Is there any reason why it was added via sys_socketcall() - isn't tha=
t
> just a waste of a few cycles and kernel size, compared with a direct
> pointer in the syscall table?
>
> I see sendmmsg() and recvmmsg() got proper syscall slots on x86
> 32-bit, and are in sys_socketcall() as well, which seems a bit pointl=
ess.

IIRC, PPC is trying to deprecate sys_socketcall(), and recently added s=
eparate
syscalls for all socket calls.

Whether other architectures should follow suit is indeed a good questio=
n...

Gr{oetje,eeting}s,

=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=C2=A0 -- Linus Torvalds
