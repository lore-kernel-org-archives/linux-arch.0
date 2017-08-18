From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH 0/5] add support for relative references in special sections
Date: Fri, 18 Aug 2017 07:33:13 +0100
Message-ID: <CAKv+Gu9H8Ahb3mB=2AB11Z8COpHyDvVe6Gbk4Zto49h3=O1jQw@mail.gmail.com>
References: <20170814105231.14608-1-ard.biesheuvel@linaro.org>
 <20170818055655.GA495@jagdpanzerIV.localdomain> <CAKv+Gu9MBz68SMpQFbw33qvOwbGYYVO=5HHuLESUtsa0qsBP5g@mail.gmail.com>
 <20170818062944.GB495@jagdpanzerIV.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:33850 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750729AbdHRGdO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Aug 2017 02:33:14 -0400
Received: by mail-io0-f172.google.com with SMTP id o9so30386069iod.1
        for <linux-arch@vger.kernel.org>; Thu, 17 Aug 2017 23:33:14 -0700 (PDT)
In-Reply-To: <20170818062944.GB495@jagdpanzerIV.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Thomas Garnier <thgarnie@google.com>, Thomas Gleixner <tglx@linutronix.de>, "Serge E. Hallyn" <serge@hallyn.com>, Bjorn Helgaas <bhelgaas@google.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Catalin Marinas <catalin.marinas@arm.com>, Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@redhat.com>, James Morris <james.l.morris@oracle.com>, Andrew Morton <akpm@linux-foundation.org>

On 18 August 2017 at 07:29, Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
> Hi Ard,
>
> On (08/18/17 07:12), Ard Biesheuvel wrote:
>> Hi Sergey,
>>
>> Thanks for taking a look
>>
>> On 18 August 2017 at 06:56, Sergey Senozhatsky
>> <sergey.senozhatsky.work@gmail.com> wrote:
>> > On (08/14/17 11:52), Ard Biesheuvel wrote:
>> >> This adds support for emitting special sections such as initcall arrays,
>> >> PCI fixups and tracepoints as relative references rather than absolute
>> >> references. This reduces the size by 50% on 64-bit architectures, but
>> >> more importantly, it removes the need for carrying relocation metadata
>> >> for these sections in relocatables kernels (e.g., for KASLR) that need
>> >> to fix up these absolute references at boot time. On arm64, this reduces
>> >> the vmlinux footprint of such a reference by 8x (8 byte absolute reference
>> >> + 24 byte RELA entry vs 4 byte relative reference)
>> > [..]
>> >
>> > a side note,
>> > checkpatch complaints quite a lot.
>> >
> [..]
>> I will clean up the meaningful ones in v2, but please don't expect
>> this series to be checkpatch clean: it simply doesn't deal with inline
>> asm very well, and some of this code predates checkpatch by a decade,
>> and I'd rather not mix up rather tricky functional changes with
>> checkpatch cleanup duty.
>
> sure. thanks.
>
> I'm running two x86 boxes with the patch set applied, for
> several days, with no issues being observed. it does save
> some memory (well, several pages in my case) even on "tiny"
> kernels configs.
>

That is good to hear. Thanks.
