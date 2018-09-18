Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40786 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727252AbeIRR35 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Sep 2018 13:29:57 -0400
Received: by mail-yw1-f67.google.com with SMTP id z143-v6so641716ywa.7
        for <linux-arch@vger.kernel.org>; Tue, 18 Sep 2018 04:57:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAK8P3a221wz4iqwoKcof2ioVWzHmUCOwt8Y5cdVPvZEEtHcycQ@mail.gmail.com>
References: <1536914314-5026-1-git-send-email-firoz.khan@linaro.org>
 <1536914314-5026-3-git-send-email-firoz.khan@linaro.org> <CAK8P3a221wz4iqwoKcof2ioVWzHmUCOwt8Y5cdVPvZEEtHcycQ@mail.gmail.com>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Tue, 18 Sep 2018 17:27:40 +0530
Message-ID: <CALxhOnjxFiWd_rTKnUo4dAYZZgqi_AqVsCj1AB8yHL-KwvMpQQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] mips: Add system call table generation support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20180918115740.EZtX0UU3aPnJQzB478jgOQIxCxhRzyJhQv_akynkqSw@z>

On 14 September 2018 at 15:28, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Sep 14, 2018 at 10:39 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>>
>> The system call tables are in different format in all
>> architecture and it will be difficult to manually add or
>> modify the system calls in the respective files. To make
>> it easy by keeping a script and which'll generate the
>> header file and syscall table file so this change will
>> unify them across all architectures.
>>
>> The system call table generation script is added in
>> syscalls directory which contain the script to generate
>> both uapi header file system call table generation file
>> and syscall_32/64.tbl file which'll be the input for the
>> scripts.
>
> I think it would be best to name the files
> o32/n64/n32 instead of 32/64/n32

This is an easy fix. I'll make it in the next version.

>
> It would also be helpful to mention why the n32/n64
> files cannot be combined into one nfile here.

Sure.

>
>
>> +364     32      pkey_alloc                      sys_pkey_alloc
>> +365     32      pkey_free                       sys_pkey_free
>> +366     32      statx                           sys_statx
>
> You missed the additon of rseq and io_pgetevetns here.

As I mentioned in the cover letter:
"I started working system call table generation on 4.17-rc1. I used
marcin's script - https://github.com/hrw/syscalls-table to generate
the syscall.tbl file. And this will be the input to the system call
table generation script. But there are couple system call got add
in the latest rc release. If run Marcin's script on latest release,
It will generate a new syscall.tbl. But I still use the old file -
syscall.tbl and once all review got over I'll update syscall.tbl
alone w.r.to the tip of the kernel. The impact of this thing, few
of the system call won't work."

Hopefully, the next version does have this change. Thanks!

- Firoz
