Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:49527 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756112AbbBFUNE (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 6 Feb 2015 15:13:04 -0500
Received: by mail-lb0-f172.google.com with SMTP id l4so20076126lbv.3
        for <linux-arch@vger.kernel.org>; Fri, 06 Feb 2015 12:13:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAGXu5jJXspS_34KBJ5VxvyKuj4bA+zg267dNiEkqR1LuvjoA1Q@mail.gmail.com>
References: <cover.1409954077.git.luto@amacapital.net> <2df320a600020fda055fccf2b668145729dd0c04.1409954077.git.luto@amacapital.net>
 <20150205211916.GA31367@altlinux.org> <CAGXu5j+aXxt55LsxxbNkfGGF719ubXBZ2JAFwUPNARwKMVFgng@mail.gmail.com>
 <20150205214027.GB31367@altlinux.org> <CALCETrXFzcXngHsX=_72hYZqms32Zf7oFYDBgC3XNw7zOGdDCA@mail.gmail.com>
 <CAGXu5jJtHT9o8WMoynifN13=uZoARt4G9iVcgZsc9xYOBEwWsg@mail.gmail.com>
 <20150205233945.GA31540@altlinux.org> <CAGXu5jLTH+mUF0JxeR2qA_r=ocWjPHPSK2OPgE0Fu_JKoQyQ9w@mail.gmail.com>
 <CALCETrXsCUje+_V=Ud+TB4A2jH2M7yqyoCFMLEyxOD6pd7Di5w@mail.gmail.com>
 <20150206023249.GB31540@altlinux.org> <CALCETrWTnqKDoatK+5FN=yYDOeENoW5=r5YMToYKhZ8Zfv5wWA@mail.gmail.com>
 <CAGXu5j+nopAMFukwMu=Cy0GOapziOLTb-ryJhA-aywk_uerg9A@mail.gmail.com>
 <CALCETrVaF+3ETn5nfcbvyWKUYb71jNXK-zo9V6uOK0cEW4TCNQ@mail.gmail.com> <CAGXu5jJXspS_34KBJ5VxvyKuj4bA+zg267dNiEkqR1LuvjoA1Q@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 6 Feb 2015 12:12:41 -0800
Message-ID: <CALCETrUmMA9sK4SJCSiF24iAiPLMBf=-JBw6TcLV+aLt_eN=Sw@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] x86: Split syscall_trace_enter into two phases
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: "Dmitry V. Levin" <ldv@altlinux.org>, LKML <linux-kernel@vger.kernel.org>, Will Drewry <wad@chromium.org>, Oleg Nesterov <oleg@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-arch <linux-arch@vger.kernel.org>, linux-security-module <linux-security-module@vger.kernel.org>, Alexei Starovoitov <ast@plumgrid.com>, "H. Peter Anvin" <hpa@zytor.com>, Frederic Weisbecker <fweisbec@gmail.com>, Michael Kerrisk-manpages <mtk.manpages@gmail.com>
Message-ID: <20150206201241.ATDHFCw5mW7_m_zBGiM7TS97NWI4Wr0dfZjJ__Iperk@z>

On Fri, Feb 6, 2015 at 12:07 PM, Kees Cook <keescook@chromium.org> wrote:
> On Fri, Feb 6, 2015 at 11:32 AM, Andy Lutomirski <luto@amacapital.net> wrote:
>> On Fri, Feb 6, 2015 at 11:23 AM, Kees Cook <keescook@chromium.org> wrote:
>>> And especially since a ptracer
>>> can change syscalls during syscall-enter-stop to any syscall it wants,
>>> bypassing seccomp. This condition is already documented.
>>
>> If a ptracer (using PTRACE_SYSCALL) were to get the entry callback
>> before seccomp, then this oddity would go away, which might be a good
>> thing.  A ptracer could change the syscall, but seccomp would based on
>> what the ptracer changed the syscall to.
>
> I want kill events to trigger immediately. I don't want to leave the
> ptrace surface available on a SECCOMP_RET_KILL. So maybe it can be
> seccomp phase 1, then ptrace, then seccomp phase 2? And pass more
> information between phases to determine how things should behave
> beyond just "skip"?

I thought so too, originally, but I'm far less convinced now, for two reasons:

1. I think that a lot of filters these days use RET_ERRNO heavily, so
this won't benefit them.

2. I'm not convinced it really reduces the attack surface for anyone.
Unless your filter is literally "return SECCOMP_RET_KILL", then the
seccomp-filtered task can always cause the ptracer to get a pair of
syscall notifications.  Also, the task can send itself signals (using
page faults, breakpoints, etc) and cause ptrace events via other
paths.

--Andy
