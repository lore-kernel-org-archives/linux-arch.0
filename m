Return-Path: <SRS0=ZlxX=AT=vger.kernel.org=linux-doc-owner@kernel.org>
Subject: Re: [PATCH v19 09/12] arch: Wire up landlock() syscall
References: <20200707180955.53024-1-mic@digikod.net>
 <20200707180955.53024-10-mic@digikod.net>
 <CAK8P3a0docCqHkEn9C7=e0GC_ieN1dsYgKQ9PbUmSZYxh9MRnw@mail.gmail.com>
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <8d2dab03-289e-2872-db66-ce80ce5c189f@digikod.net>
Date: Wed, 8 Jul 2020 09:31:26 +0200
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0docCqHkEn9C7=e0GC_ieN1dsYgKQ9PbUmSZYxh9MRnw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-doc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@amacapital.net>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Casey Schaufler <casey@schaufler-ca.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Michael Kerrisk <mtk.manpages@gmail.com>, =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mickael.salaun@ssi.gouv.fr>, Richard Weinberger <richard@nod.at>, "Serge E . Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>, Kernel Hardening <kernel-hardening@lists.openwall.com>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200708073126._p4CRTT1kCLgJiJMiEGdU3hyMoZ276BfsbnD8KdFzC8@z>


On 08/07/2020 09:22, Arnd Bergmann wrote:
> On Tue, Jul 7, 2020 at 8:10 PM Mickaël Salaün <mic@digikod.net> wrote:
> 
>> index f4a01305d9a6..a63a411a74d5 100644
>> --- a/include/uapi/asm-generic/unistd.h
>> +++ b/include/uapi/asm-generic/unistd.h
>> @@ -857,9 +857,11 @@ __SYSCALL(__NR_openat2, sys_openat2)
>>  __SYSCALL(__NR_pidfd_getfd, sys_pidfd_getfd)
>>  #define __NR_faccessat2 439
>>  __SYSCALL(__NR_faccessat2, sys_faccessat2)
>> +#define __NR_landlock 440
>> +__SYSCALL(__NR_landlock, sys_landlock)
>>
>>  #undef __NR_syscalls
>> -#define __NR_syscalls 440
>> +#define __NR_syscalls 441
> 
> In linux-next, we already have:
> 
> +#define __NR_watch_mount 440
> +#define __NR_watch_sb 441
> +#define __NR_fsinfo 442
> +#define __NR_process_madvise 443
> 
> You may want to increase the number again.
> 
>       Arnd
> 

OK, I'll rebase the next series on linux-next. Do you know if there is
other syscalls on their way to linux-next?

Are the other parts of arch/syscall OK for you?
