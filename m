From: Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH 16/28] nios2: System calls handling
Date: Tue, 22 Apr 2014 01:23:52 +0800
Message-ID: <CAFiDJ5_ExhQAqMa5WMyug0Gz3KTVQhfZvonyCuErKBU4icu4tw@mail.gmail.com>
References: <1397824031-4892-1-git-send-email-lftan@altera.com>
	<1397824031-4892-13-git-send-email-lftan@altera.com>
	<CAMuHMdXvLLNXQXYRD71Uv7F-Fh_E6EmF7_OvBUYF513cMfy8sw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdXvLLNXQXYRD71Uv7F-Fh_E6EmF7_OvBUYF513cMfy8sw@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, cltang@codesourcery.com, Pavel Machek <pavel@denx.de>
List-Id: linux-arch.vger.kernel.org

On Sun, Apr 20, 2014 at 4:12 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>> +        */
>> +       vma = find_vma(current->mm, addr);
>> +       if (vma == NULL || addr < vma->vm_start || addr + len > vma->vm_end)
>> +               return -EFAULT;
>> +
>> +       /* Ignore the scope and cache arguments. */
>
> This function doesn't have scope and cache arguments
> (sys_cacheflush() on m68k does have them ;-)

Missed out the comment after rename the arguments.:) Will update the
comment above.

> On Sat, Apr 19, 2014 at 6:09 PM, Pavel Machek <pavel@denx.de> wrote:
>> Also... explanation why you need this syscall while other
>> architectures live happily without it would be nice.
>
> 12 our of 28 architectures provide such a syscall...
>
> Is flushing the cache a privileged operation on nios2?
Yes.

Thanks.

Regards
Ley Foon
