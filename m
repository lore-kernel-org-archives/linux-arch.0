Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45921 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729345AbeIRRrx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Sep 2018 13:47:53 -0400
Received: by mail-yw1-f65.google.com with SMTP id p206-v6so651217ywg.12
        for <linux-arch@vger.kernel.org>; Tue, 18 Sep 2018 05:15:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1PCnHy1JX4T21LjOr3ZGAVLdqxQaPYfLHAgM-9Y5yxVg@mail.gmail.com>
References: <1536913980-4811-1-git-send-email-firoz.khan@linaro.org>
 <1536913980-4811-3-git-send-email-firoz.khan@linaro.org> <CAK8P3a1PCnHy1JX4T21LjOr3ZGAVLdqxQaPYfLHAgM-9Y5yxVg@mail.gmail.com>
From: Firoz Khan <firoz.khan@linaro.org>
Date: Tue, 18 Sep 2018 17:45:32 +0530
Message-ID: <CALxhOngVYQRwbcUg6c_3LcKAEoBwyN1B478LqRGmWEGL004--w@mail.gmail.com>
Subject: Re: [PATCH 2/3] powerpc: Add system call table generation support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Ram Pai <linuxram@us.ibm.com>, Breno Leitao <leitao@debian.org>, Boqun Feng <boqun.feng@gmail.com>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-ID: <20180918121532.H_63PUXKOWjXjtaMri432VGyjGSjQYsBaJ5PTpxhWIQ@z>

On 14 September 2018 at 15:31, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Sep 14, 2018 at 10:33 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
>> ---
>>  arch/powerpc/kernel/syscalls/Makefile       |  51 ++++
>>  arch/powerpc/kernel/syscalls/syscall_32.tbl | 378 ++++++++++++++++++++++++++++
>>  arch/powerpc/kernel/syscalls/syscall_64.tbl | 372 +++++++++++++++++++++++++++
>>  arch/powerpc/kernel/syscalls/syscallhdr.sh  |  37 +++
>>  arch/powerpc/kernel/syscalls/syscalltbl.sh  |  38 +++
>
> I think you should only need a single .tbl  input file here.

Yes, we can do that way also.As I mentioned, it will add
more complexity in the script.

 The script has to be smart enough to parse the
.tbl if we add more thing in the .tble file. It need more
logic in the scripts. This is not common. So if you keep
separate .tbl we can avoid this.

ABI flag is serving *nothing* in all other architecture including
SPARC.

But as I told in the cover letter, I followed x86/arm/
s390 architecture's system table generation implementation.
They are keeping ABI flag. In our case we can delete this
flag completely from all architectures.

Most of the architecture these 32/64 similarity is absent.
So it would be better keep separate files to maintain a
generic script across all architecture.

>
>
>> +
>> +systbl_abi_syscall_table_32 := 32
>> +$(out)/syscall_table_32.h: $(syscall32) $(systbl)
>> +       $(call if_changed,systbl)
>> +
>> +systbl_abi_syscall_table_64 := 64
>> +$(out)/syscall_table_64.h: $(syscall64) $(systbl)
>> +       $(call if_changed,systbl)
>> +
>> +systbl_abi_syscall_table_c32 := c32
>> +$(out)/syscall_table_c32.h: $(syscall32) $(systbl)
>> +       $(call if_changed,systbl)
>
> And here you need a fourth output file for the SPU table on ppc64.

Hmm. Let me have a look where things went wrong.

>
>> +383     common  statx                           sys_statx
>> +384     common  pkey_alloc                      sys_pkey_alloc
>> +385     common  pkey_free                       sys_pkey_free
>> +386     common  pkey_mprotect                   sys_pkey_mprotect
>
> This also misses rseq and io_pgetevents.

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
