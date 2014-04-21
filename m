From: Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH 16/28] nios2: System calls handling
Date: Tue, 22 Apr 2014 01:32:15 +0800
Message-ID: <CAFiDJ5-e=vRLxyKuzSQO0vg4HBHessv3xE9SdCQ9zFOqYOreZg@mail.gmail.com>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>
	<1397824031-4892-13-git-send-email-lftan@altera.com>
	<20140419160947.GA27776@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20140419160947.GA27776@amd.pavel.ucw.cz>
Sender: linux-doc-owner@vger.kernel.org
To: Pavel Machek <pavel@denx.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, cltang@codesourcery.com, mtk.manpages@gmail.com
List-Id: linux-arch.vger.kernel.org

On Sun, Apr 20, 2014 at 12:09 AM, Pavel Machek <pavel@denx.de> wrote:
>> +/* Additional Nios II specific syscalls. */
>> +#define __NR_cacheflush (__NR_arch_specific_syscall)
>> +__SYSCALL(__NR_cacheflush, sys_cacheflush)
>
> I guess you should Cc: Michael Kerrisk on this one.
CC him this email.

>
> Also... explanation why you need this syscall while other
> architectures live happily without it would be nice.
This syscall exist in nios2 port since old days and some users already
used it for sometimes.
Like mentioned by Greet, 12 our of 28 architectures provide such a syscall.

>> +/* sys_cacheflush -- flush the processor cache. */
>> +asmlinkage int sys_cacheflush(unsigned long addr, unsigned long len,
>> +                             unsigned int op)
>> +{
>> +     struct vm_area_struct *vma;
>> +
>> +     if (len == 0)
>> +             return 0;
>
> op is being ignored? You should remove it... or if (op) return -EINVAL
> if you want future extensions.
Yes, op argument is being ignored. Okay, will add the return -EINVAL
if op is non-zero.

Thanks.

Regards
Ley Foon
