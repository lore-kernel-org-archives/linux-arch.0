From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 12/16] asm-generic: siginfo: remove obsolete #ifdefs
Date: Thu, 15 Mar 2018 13:07:59 -0500
Message-ID: <87fu51b4ao.fsf@xmission.com>
References: <20180314143529.1456168-1-arnd@arndb.de>
        <20180314144614.1632190-1-arnd@arndb.de>
        <20180314144614.1632190-2-arnd@arndb.de> <87po45hcuy.fsf@xmission.com>
        <CAK8P3a1GL2N=emTbSgNGHxOrXtG6BxqRGMg00-tZqKg6-0O5=w@mail.gmail.com>
        <87o9jpbmcy.fsf@xmission.com>
        <CAK8P3a2ii0aQ6sSB_B_KeMWw51Y8mbX0eL6EPj5fQ8b8bJqmUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a2ii0aQ6sSB_B_KeMWw51Y8mbX0eL6EPj5fQ8b8bJqmUQ@mail.gmail.com>
        (Arnd Bergmann's message of "Thu, 15 Mar 2018 13:50:36 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-arch.vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Thu, Mar 15, 2018 at 12:37 PM, Eric W. Biederman
> <ebiederm@xmission.com> wrote:
>>> On Thu, Mar 15, 2018 at 11:06 AM, Eric W. Biederman
>
>>> That seems reasonable. If you send me a patch with a proper
>>> changelog (I don't think I could explain this well enough), I'll
>>> add it to the series.
>>
>> I just realized you can also remove the #ifdefs for BUS_MCEERR_AR,
>> BUS_MCEERR_AO, and SEGV_BNDERR.  As those si_codes are now always
>> defined.  That description I expect you can handle.
>
> My existing patch already does this, and I've added a note to the changelog
> as well now.

I did not see the changes to kernel/signal.c and fs/signalfd.c that
remove the #ifdef BUS_MCERR_AR etc.  Did I miss that patch.

>> For a description of the above change how does this sound?
>>
>> Unlike system call numbers the assignment of si_codes has never had a
>> reason to be made per architecture.  Some architectures have had unique
>> conditions to report and reporting those conditions needed new si_codes.
>> Nothing has ever needed si_codes to have different values on different
>> architectures.  The si_code space is vast so even with defining all
>> si_codes on all architectures there is no danger in running out of
>> si_code values.
>>
>> The history of the si_codes BUS_MCEERR_AR, BUS_MCEER_AO, SEGV_BNDERR,
>> and SEGV_PKUERR show that a need of one architecture frequently becomes
>> a need of another architecture which makes sharing si_codes between
>> architectures a positive benefit and something to be encouraged.
>>
>> Where there are no conflicts with the historical ia64 arch specific
>> si_codes and any other si_codes make them generic si_codes.  We might
>> need them on another architecture someday.
>>
>> This leaves only the good example of arch generic si_codes in the kernel
>> for future architectures and architecture enhancments to follow.
>> Without bad examples to follow it should be easy to avoid the mistakes
>> of the past.
>
> Ok, done. I've listed you as 'Suggested-by' for that patch. Since the
> changelog is way more work than the actual change, I would have
> made you the author of that patch, but I don't have a Signed-off-by
> from you for it.

For however much it helps.

Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Eric
