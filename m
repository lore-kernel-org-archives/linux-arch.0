Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33434 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfEaX5z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 31 May 2019 19:57:55 -0400
Received: by mail-pl1-f196.google.com with SMTP id g21so4621811plq.0
        for <linux-arch@vger.kernel.org>; Fri, 31 May 2019 16:57:54 -0700 (PDT)
Date: Fri, 31 May 2019 16:57:53 -0700 (PDT)
Subject: Re: [PATCH 3/5] asm-generic: Register fchmodat4 as syscall 428
In-Reply-To: <CAK8P3a2=xko56LbwV4tyhyyyX+tw+EV-NGavYEYj0q61t=mnwg@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-d362e451-72d2-4893-a749-8469359b65ea@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, luto@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Message-ID: <20190531235753.QqNI7Nzodw1e6zwvECsSpHaI1C2nZzyxnhdz-oCOr68@z>

On Fri, 31 May 2019 12:56:39 PDT (-0700), Arnd Bergmann wrote:
> On Fri, May 31, 2019 at 9:23 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>
> As usual, each patch needs a changelog text. I would prefer having a single
> patch here that changes /all/ system call tables at once, rather than doing one
> at a time like we used to.

Works for me.  That also gives me something to write about it the text :)

> In linux-next, we are at number 434 now, and there are a couple of other
> new system calls being proposed right now (more than usual), so you may
> have to change the number a few times.

OK, no problem.  It'll be a bit easier to handle the number that way.

> Note: most architectures use .tbl files now, the exceptions are
> include/uapi/asm-generic/unistd.h and arch/arm64/include/asm/unistd32.h,
> and the latter also requires changing __NR_compat_syscalls in asm/unistd.h.
>
> Numbers should now be the same across architectures, except for alpha,
> which has a +110 offset. We have discussed ways to have a single
> file to modify for a new call on all architectures, but no patches yet.

OK, thanks.  I'll wait a bit for feedback, but unless there's anything else
I'll go ahead and finish this.
