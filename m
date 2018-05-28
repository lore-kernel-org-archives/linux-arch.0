Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:45338 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753984AbeE1JT4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 May 2018 05:19:56 -0400
MIME-Version: 1.0
In-Reply-To: <20180420145514.GP3094@brightrain.aerifal.cx>
References: <87604mhrnb.fsf@xmission.com> <20180420143811.9994-16-ebiederm@xmission.com>
 <20180420145514.GP3094@brightrain.aerifal.cx>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 28 May 2018 11:19:55 +0200
Message-ID: <CAMuHMdXxL+k_SitLXV1LJDHJmCY1HiUnZSk7MM64rcgs75nLiw@mail.gmail.com>
Subject: Re: [REVIEW][PATCH 16/22] signal/sh: Use force_sig_fault where appropriate
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Rich Felker <dalias@libc.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Linux-Arch <linux-arch@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Linux-sh list <linux-sh@vger.kernel.org>
Message-ID: <20180528091955.q9T5b45YXZ37bwbgCEhR-kQpBEIIIxvDht9owvM3ls8@z>

On Fri, Apr 20, 2018 at 4:55 PM, Rich Felker <dalias@libc.org> wrote:
> On Fri, Apr 20, 2018 at 09:38:05AM -0500, Eric W. Biederman wrote:
>> Filling in struct siginfo before calling force_sig_info a tedious and
>> error prone process, where once in a great while the wrong fields
>> are filled out, and siginfo has been inconsistently cleared.
>>
>> Simplify this process by using the helper force_sig_fault.  Which
>> takes as a parameters all of the information it needs, ensures
>> all of the fiddly bits of filling in struct siginfo are done properly
>> and then calls force_sig_info.
>>
>> In short about a 5 line reduction in code for every time force_sig_info
>> is called, which makes the calling function clearer.
>>
>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>> Cc: Rich Felker <dalias@libc.org>
>> Cc: linux-sh@vger.kernel.org
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

>> --- a/arch/sh/kernel/traps_32.c
>> +++ b/arch/sh/kernel/traps_32.c

>> @@ -599,20 +593,17 @@ int is_dsp_inst(struct pt_regs *regs)
>>  #ifdef CONFIG_CPU_SH2A
>>  asmlinkage void do_divide_error(unsigned long r4)
>>  {
>> -     siginfo_t info;
>> +     int code;
>>
>> -     clear_siginfo(&info);
>>       switch (r4) {
>>       case TRAP_DIVZERO_ERROR:
>> -             info.si_code = FPE_INTDIV;
>> +             code = FPE_INTDIV;
>>               break;
>>       case TRAP_DIVOVF_ERROR:
>> -             info.si_code = FPE_INTOVF;
>> +             code = FPE_INTOVF;
>>               break;
>>       }
>> -
>> -     info.si_signo = SIGFPE;
>> -     force_sig_info(info.si_signo, &info, current);
>> +     force_sig_fault(SIGFPE, code, NULL, current);

/kisskb/src/arch/sh/kernel/traps_32.c:606:17: error: 'code' may be
used uninitialized in this function [-Werror=uninitialized]

http://kisskb.ellerman.id.au/kisskb/buildresult/13366052/
http://kisskb.ellerman.id.au/kisskb/buildresult/13366048/
http://kisskb.ellerman.id.au/kisskb/buildresult/13366072/

>>  }

> Acked-by: Rich Felker <dalias@libc.org>


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
