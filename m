From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 5/7] x86: Split syscall_trace_enter into two phases
Date: Wed, 16 Jul 2014 14:15:44 -0700
Message-ID: <CALCETrWuWxZANoKAR=FG55EOHtzvTHmc3euMdtf8yfibtK-QYw@mail.gmail.com>
References: <cover.1405452484.git.luto@amacapital.net> <bd4e2efb7cd97f2bf9d4f1e2065f16c9091d799a.1405452484.git.luto@amacapital.net>
 <CAGXu5jJornzMJjyPXVZB_eYi-FRet=bXcJWJDa1vnB_oU9ZA_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:37608 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbaGPVQG (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 16 Jul 2014 17:16:06 -0400
Received: by mail-la0-f43.google.com with SMTP id hr17so1093282lab.30
        for <linux-arch@vger.kernel.org>; Wed, 16 Jul 2014 14:16:04 -0700 (PDT)
In-Reply-To: <CAGXu5jJornzMJjyPXVZB_eYi-FRet=bXcJWJDa1vnB_oU9ZA_Q@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Will Drewry <wad@chromium.org>, James Morris <james.l.morris@oracle.com>, Oleg Nesterov <oleg@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux MIPS Mailing List <linux-mips@linux-mips.org>, linux-arch <linux-arch@vger.kernel.org>, linux-security-module <linux-security-module@vger.kernel.org>, Alexei Starovoitov <ast@plumgrid.com>

On Wed, Jul 16, 2014 at 1:21 PM, Kees Cook <keescook@chromium.org> wrote:
> On Tue, Jul 15, 2014 at 12:32 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>>
>> +
>> +               ret = seccomp_phase1(&sd);
>> +               if (ret == SECCOMP_PHASE1_SKIP) {
>> +                       regs->orig_ax = -ENOSYS;
>
> Before, seccomp didn't touch orig_ax on a skip. I don't see any
> problem with this, and it's probably more clear this way, but are you
> sure there aren't unexpected side-effects from this?

It's necessary to cause the syscall to be skipped -- see syscall_trace_enter.

That being said, setting it to -ENOSYS is nonsense and probably
confused you at least as much as it confused me.  It should be
regs->orig_ax = -1.

--Andy
