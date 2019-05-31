Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43912 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbfEaXgn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 May 2019 19:36:43 -0400
Received: by mail-pf1-f194.google.com with SMTP id c6so7082564pfa.10
        for <linux-arch@vger.kernel.org>; Fri, 31 May 2019 16:36:42 -0700 (PDT)
Date: Fri, 31 May 2019 16:36:41 -0700 (PDT)
Subject: Re: [PATCH 2/5] Add fchmodat4(), a new syscall
In-Reply-To: <CAK8P3a3HPeVq29k3Zk5rSk4bddiUQFrdEgDZUgdNnYZK+8QpGw@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-234d2802-9483-43be-af69-5bd04721b932@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Message-ID: <20190531233641.2IWgjMFD0WS8uFm0s6ByyKiWlC04UC4m3IDyN-A4v94@z>

On Fri, 31 May 2019 12:51:00 PDT (-0700), Arnd Bergmann wrote:
> On Fri, May 31, 2019 at 9:23 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> man 3p says that fchmodat() takes a flags argument, but the Linux
>> syscall does not.  There doesn't appear to be a good userspace
>> workaround for this issue but the implementation in the kernel is pretty
>> straight-forward.  The specific use case where the missing flags came up
>> was WRT a fuse filesystem implemenation, but the functionality is pretty
>> generic so I'm assuming there would be other use cases.
>>
>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>> ---
>>  fs/open.c                | 21 +++++++++++++++++++--
>>  include/linux/syscalls.h |  5 +++++
>>  2 files changed, 24 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/open.c b/fs/open.c
>> index a00350018a47..cfad7684e8d3 100644
>> --- a/fs/open.c
>> +++ b/fs/open.c
>> @@ -568,11 +568,17 @@ SYSCALL_DEFINE2(fchmod, unsigned int, fd, umode_t, mode)
>>         return ksys_fchmod(fd, mode);
>>  }
>>
>> -int do_fchmodat(int dfd, const char __user *filename, umode_t mode)
>> +int do_fchmodat4(int dfd, const char __user *filename, umode_t mode, int flags)
> ...
>> +
>> +int do_fchmodat(int dfd, const char __user *filename, umode_t mode)
>> +{
>> +       return do_fchmodat4(dfd, filename, mode, 0);
>> +}
>> +
>
> There is only one external caller of do_fchmodat(), so just change that
> to pass the extra argument here, and keep a single do_fchmodat()
> function used by the sys_fchmod(), sys_fchmod4(), sys_chmod()
> and ksys_chmod().

OK, I'll roll that up into a v2.
