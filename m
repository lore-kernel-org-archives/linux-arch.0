Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from rcdn-iport-6.cisco.com ([173.37.86.77]:46312 "EHLO
        rcdn-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729266AbeJWFJD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Oct 2018 01:09:03 -0400
Subject: Re: [PATCH] kernel/signal: Signal-based pre-coredump notification
References: <e7ed306f-8992-9d00-bcab-5131159e8d89@cisco.com>
 <CAG48ez2ZPhnxudqgU7nC2ORvLnS0Ja-qhLSE5WAY361jst7XNw@mail.gmail.com>
 <c5a09a04-b4f2-876b-af83-30f7e527497e@cisco.com>
 <CAG48ez2ZD=dovBApR07wi_DzYjJvEyO-Pm35eLv9AyXv1tcAFQ@mail.gmail.com>
 <2631f765-8d7a-45ea-6aa4-d8a9bb00d56f@cisco.com>
 <CAG48ez27=w0oWFTYUeFc72-0DL0tf=NOzGCeZgtxFOePPPE5cA@mail.gmail.com>
From: Enke Chen <enkechen@cisco.com>
Message-ID: <14503a22-403e-3e39-cfd5-0b7a2f299986@cisco.com>
Date: Mon, 22 Oct 2018 13:48:51 -0700
MIME-Version: 1.0
In-Reply-To: <CAG48ez27=w0oWFTYUeFc72-0DL0tf=NOzGCeZgtxFOePPPE5cA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Khalid Aziz <khalid.aziz@oracle.com>, Kate Stewart <kstewart@linuxfoundation.org>, deller@gmx.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, christian@brauner.io, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Dave.Martin@arm.com, mchehab+samsung@kernel.org, Michal Hocko <mhocko@kernel.org>, Rik van Riel <riel@surriel.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, guro@fb.com, Marcos Souza <marcos.souza.org@gmail.com>, Oleg Nesterov <oleg@redhat.com>, linux@dominikbrodowski.net, Cyrill Gorcunov <gorcunov@openvz.org>, yang.shi@linux.alibaba.com, Kees Cook <keescook@chromium.org>, kernel list <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Victor Kamensky <kamensky@cisco.com>, xe-linux-external@cisco.com, sstrogin@cisco.com, Enke Chen <enkechen@cisco.com>
Message-ID: <20181022204851.ffZ6hp6Dt4oGEtGPm3XoxpgJ6qOnFGRKMd2JIYwZ87k@z>

Jann,

Thanks for the feedback. I will post a revised patch shortly.

On the related topic of "pdeath_signal", there are several inconsistencies
by preserving the flag across execve(2). The flag is cleared under several
conditions in different places. I will start a separate thread to see if
it can still be cleaned up.

     PR_SET_PDEATHSIG (since Linux 2.1.57)
              Set the parent death signal of the calling process to arg2
              (either a signal value in the range 1..maxsig, or 0 to clear).
              This is the signal that the calling process will get when its
              parent dies.  This value is cleared for the child of a fork(2)
              and (since Linux 2.4.36 / 2.6.23) when executing a set-user-ID
              or set-group-ID binary, or a binary that has associated
              capabilities (see capabilities(7)).  This value is preserved
              across execve(2).

-- Enke

On 10/22/18 8:40 AM, Jann Horn wrote:
> On Sat, Oct 20, 2018 at 1:01 AM Enke Chen <enkechen@cisco.com> wrote:
>> Regarding the security considerations, it seems simpler and more secure to
>> just clear the "pre-coredump signal" cross execve(2), and let the new program
>> decide for itself.  What do you think?
> 
> I don't have a problem with these semantics.
> 
> I could imagine someone being unhappy about the theoretical race
> window if they want to perform an in-place reexecution of a running
> service, but I don't know whether anyone actually cares about that.
> 
>> Changes to prctl(2):
>>
>> DESCRIPTION
>>
>>        PR_SET_PREDUMP_SIG (since Linux 4.20.x)
>>               This allows the calling process to receive a signal (arg2,
>>               if nonzero) from a child process prior to the coredump of
>>               the child process. arg2 must be SIGUSR1, or SIGUSR2, or
>>               SIGCHLD, or 0 (for clear).
>>
>>               When SIGCHLD is specified, the signal code is set to
>>               CLD_PREDUMP in such an SIGCHLD signal.
>>
>>               The value of the pre-coredump signal is cleared across
>>               execve(2), or for the child of a fork(2).
>>
>>        PR_GET_PREDUMP_SIG (since Linux 4.20.x)
>>               Return the current value of the pre-coredump signal for the
>>               calling process, in the location pointed to by (int *) arg2.
