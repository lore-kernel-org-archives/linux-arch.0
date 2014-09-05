From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: Post-merge-window ping (Re: [PATCH v4 0/5] x86: two-phase syscall
 tracing and seccomp fastpath)
Date: Fri, 5 Sep 2014 14:14:20 -0700
Message-ID: <CALCETrXFD=D=W6pjQfhzzWU-ZOZzkJ=ZMxF5=sKxFx7NAg7xng@mail.gmail.com>
References: <CALCETrUaZ8w92g96SmFEZDE0Jr+0Moeo+S24-TyW8crrK5reSg@mail.gmail.com>
 <540A1800.3000005@zytor.com> <540A2080.8050404@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:46268 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750940AbaIEVOm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 5 Sep 2014 17:14:42 -0400
Received: by mail-la0-f45.google.com with SMTP id pn19so14573541lab.4
        for <linux-arch@vger.kernel.org>; Fri, 05 Sep 2014 14:14:40 -0700 (PDT)
In-Reply-To: <540A2080.8050404@zytor.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>, Will Drewry <wad@chromium.org>, Oleg Nesterov <oleg@redhat.com>, X86 ML <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-arch <linux-arch@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, Alexei Starovoitov <ast@plumgrid.com>, Frederic Weisbecker <fweisbec@gmail.com>

On Fri, Sep 5, 2014 at 1:43 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> On 09/05/2014 01:07 PM, H. Peter Anvin wrote:
>> On 08/26/2014 06:32 PM, Andy Lutomirski wrote:
>>> On Mon, Jul 28, 2014 at 8:38 PM, Andy Lutomirski <luto@amacapital.n=
et> wrote:
>>>> This applies to:
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git secco=
mp-fastpath
>>>>
>>>> Gitweb:
>>>> https://git.kernel.org/cgit/linux/kernel/git/kees/linux.git/log/?h=
=3Dseccomp/fastpath
>>>
>>> Hi all-
>>>
>>> AFAIK the only thing that's changed since I submitted it is that th=
e
>>> 3.17 merge window is closed.  Kees rebased the tree this applies to=
,
>>> but I think the patches all still apply.  What, if anything, do I n=
eed
>>> to do to help this along for 3.18?
>>>
>>
>> Just put this stuff in a branch and running through my personal test
>> battery now.
>>
>
> ... and they fail build testing.  Specifically, both i386 and x86-64
> allnoconfig fail with:

OK, that's embarrassing.  Also, this has been sitting on
git.kernel.org forever and kbuild never spotted it either.  Hmm.

Anyway, updates coming.

--Andy

>
> arch/x86/kernel/ptrace.c: In function =E2=80=98syscall_trace_enter_ph=
ase2=E2=80=99:
>   LD      fs/quota/built-in.o
> ../arch/x86/kernel/ptrace.c:1579:2: error: implicit declaration of
> function =E2=80=98seccomp_phase2=E2=80=99 [-Werror=3Dimplicit-functio=
n-declaration]
>   if (phase1_result > 1 && seccomp_phase2(phase1_result)) {
>   ^
> cc1: some warnings being treated as errors
>   CC      arch/x86/kernel/step.o
> make[4]: *** [arch/x86/kernel/ptrace.o] Error 1
>
>         -hpa
>
>



--=20
Andy Lutomirski
AMA Capital Management, LLC
