From: Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH 16/28] nios2: System calls handling
Date: Fri, 25 Apr 2014 00:23:21 +0800
Message-ID: <CAFiDJ58uhQNzzZfpC8k1V628sFD9+GrAAEnHgHM6k1NtxKNGgw@mail.gmail.com>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>
	<1397824031-4892-13-git-send-email-lftan@altera.com>
	<201404221430.40237.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <201404221430.40237.arnd@arndb.de>
Sender: linux-doc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, cltang@codesourcery.com
List-Id: linux-arch.vger.kernel.org

On Tue, Apr 22, 2014 at 8:30 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 18 April 2014, Ley Foon Tan wrote:
>
>> +
>> + #define sys_mmap2 sys_mmap_pgoff
>> +
>
> You use sys_mmap_pgoff here, but
>
>> +asmlinkage long sys_mmap(unsigned long addr, unsigned long len,
>> +                     unsigned long prot, unsigned long flags,
>> +                     unsigned long fd, unsigned long offset)
>> +{
>> +     if (offset & ~PAGE_MASK)
>> +             return -EINVAL;
>> +
>> +     return sys_mmap_pgoff(addr, len, prot, flags, fd, offset >> PAGE_SHIFT);
>> +}
>
> define a separate sys_mmap() here. Doing the former should be enough.
> so you can just drop the sys_mmap definition.
Okay, will drop the sys_mmap.

Thanks.
Regards
Ley Foon
