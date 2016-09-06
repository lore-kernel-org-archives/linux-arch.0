Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ua0-f180.google.com ([209.85.217.180]:33360 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756240AbcIFQkf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Sep 2016 12:40:35 -0400
Received: by mail-ua0-f180.google.com with SMTP id 31so53801933uao.0
        for <linux-arch@vger.kernel.org>; Tue, 06 Sep 2016 09:40:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160906161921.GB31384@pc.thejh.net>
References: <cover.1466466093.git.luto@kernel.org> <CA+55aFyahpuy94qqECj0ZA6oD3Vy0r=gY2cH8_dB1a-4XURV2Q@mail.gmail.com>
 <CALCETrUuG0-tGNQ5iAEO2_gaK1eUq7AoALoBeQKcOP8cvxr=eA@mail.gmail.com>
 <CA+55aFx480bxx7VAmFqdsVGHjoSav4eCvVpcx5ZSpBQuq+=1Mw@mail.gmail.com>
 <20160623143126.GA16664@redhat.com> <CA+55aFwBL5ArLXZ0+YggTbp6Qon+OM+Foihe0yrQOmRRvu96VQ@mail.gmail.com>
 <CALCETrU2B0QYBgTTSAFiK026Bx96+Bk=k64bhrDT+TiXsV7D4A@mail.gmail.com> <20160906161921.GB31384@pc.thejh.net>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 6 Sep 2016 09:40:08 -0700
Message-ID: <CALCETrVPhm37JJh+0qGjUBhxyDAF6R4ZpCX22UQvBzgYz6zzpw@mail.gmail.com>
Subject: Re: [PATCH v3 00/13] Virtually mapped stacks with guard pages (x86, core)
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jann Horn <jann@thejh.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, Andy Lutomirski <luto@kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Borislav Petkov <bp@alien8.de>, Nadav Amit <nadav.amit@gmail.com>, Kees Cook <keescook@chromium.org>, Brian Gerst <brgerst@gmail.com>, "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Message-ID: <20160906164008.yy52Or0FJd8PzFimMs_oXFe9f7BtQwNOxwfuam-GnVc@z>

On Tue, Sep 6, 2016 at 9:19 AM, Jann Horn <jann@thejh.net> wrote:
> On Thu, Jun 23, 2016 at 09:41:11AM -0700, Andy Lutomirski wrote:
>> 3. Free stacks immediately and cache them (really easy).
>
> Random note: task_current_syscall() (via /proc/$pid/syscall) will probably need additional
> locking when the stack is freed before the task.

Thanks.  I'm testing a patch now.

-- 
Andy Lutomirski
AMA Capital Management, LLC
