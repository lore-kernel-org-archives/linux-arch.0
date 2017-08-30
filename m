Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:37895 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751357AbdH3NSz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Aug 2017 09:18:55 -0400
Received: by mail-io0-f179.google.com with SMTP id 81so4884204ioj.5
        for <linux-arch@vger.kernel.org>; Wed, 30 Aug 2017 06:18:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170830091753.27e2ba47@gandalf.local.home>
References: <20170819181035.969-1-ard.biesheuvel@linaro.org>
 <20170819181035.969-6-ard.biesheuvel@linaro.org> <20170820105144.3e8269e7@gandalf.local.home>
 <CAKv+Gu8ckETOwKN8onbFB6mDv64qa_gqcUmJ0sEJCn=9Ovq+2Q@mail.gmail.com> <20170830091753.27e2ba47@gandalf.local.home>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 30 Aug 2017 14:18:54 +0100
Message-ID: <CAKv+Gu_SWd2JBjCY8mrwi6VZKOyyCwzZ4ksPjWEdZYnrXc6DRA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] kernel: tracepoints: add support for relative references
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Garnier <thgarnie@google.com>, Thomas Gleixner <tglx@linutronix.de>, "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Catalin Marinas <catalin.marinas@arm.com>, Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>, James Morris <james.l.morris@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, Nicolas Pitre <nico@linaro.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Jessica Yu <jeyu@kernel.org>
Message-ID: <20170830131854.qfHBEojEFaAqmHK9oJ7cPvCQu46L3o9WtGT4RcfkEqg@z>

On 30 August 2017 at 14:17, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Wed, 30 Aug 2017 13:52:26 +0100
> Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
>> On 20 August 2017 at 15:51, Steven Rostedt <rostedt@goodmis.org> wrote:
>> > On Sat, 19 Aug 2017 19:10:35 +0100
>> > Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>> >
>> >> To avoid the need for relocating absolute references to tracepoint
>> >> structures at boot time when running relocatable kernels (which may
>> >> take a disproportionate amount of space), add the option to emit
>> >> these tables as relative references instead.
>> >>
>> >
>> > This patch looks fine. But I want to test the series before giving it
>> > my Acked-by. I wont be able to do that till Tuesday at the earliest.
>> >
>>
>> I guess this has slipped between the cracks?
>
> Yes it has. Thanks for the reminder. I'm quite overwhelmed after coming
> back from vacation, and getting pulled in various directions.
>
> I'll see if I can run it through some tests today.
>

Thanks, that would be much appreciated.
