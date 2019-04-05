Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41724 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbfDEBYi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Apr 2019 21:24:38 -0400
Received: by mail-lf1-f67.google.com with SMTP id 10so3134283lfr.8
        for <linux-arch@vger.kernel.org>; Thu, 04 Apr 2019 18:24:36 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id o17sm4352454ljc.66.2019.04.04.18.24.33
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 18:24:33 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id t4so3784951ljc.2
        for <linux-arch@vger.kernel.org>; Thu, 04 Apr 2019 18:24:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190401134104.676620247@goodmis.org> <20190404092803.1bffd135@gandalf.local.home>
In-Reply-To: <20190404092803.1bffd135@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 4 Apr 2019 15:24:16 -1000
Message-ID: <CAHk-=wh1wv_g2cW07OG1n5oHFXxZUc2192ZQ+6p5Cj+46FDQVQ@mail.gmail.com>
Subject: Re: [PATCH 0/6 v3] sycalls: Remove args i and n from syscall_get_arguments()
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@amacapital.net>, Roland McGrath <roland@hack.frob.com>, Oleg Nesterov <oleg@redhat.com>, linux-arch <linux-arch@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Andy Lutomirski <luto@kernel.org>, Kees Cook <keescook@chromium.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "Dmitry V. Levin" <ldv@altlinux.org>, Palmer Dabbelt <palmer@sifive.com>
Message-ID: <20190405012416.R0iM-qqzEoy8ZjC8DMT0MY2Y4woMBf0MiksN0jxHpbM@z>

On Thu, Apr 4, 2019 at 3:28 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Is this something that can go into this -rc release or would you want
> me to wait till the next merge window?
>
> The reason I ask, is that there's two arch patches in this series that
> have stable tags attached to them. But I moved things around such that
> they are applied before the global arch patches are and can be applied
> independently.
>
> Should I move those two patches up front and just add those to this
> release cycle, or would you like the entire series now?

I think I can take the entire series. It's removing code and fixing a
couple of bugs in the process. Even if not all changes are pure fixes,
it looks good to me.

I assume you've actually used this and can trace system calls with
arguments properly, so that it's all tested at least on x86-64?

                    Linus
