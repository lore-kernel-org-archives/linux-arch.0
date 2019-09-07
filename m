Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38414 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389011AbfIGRFT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 7 Sep 2019 13:05:19 -0400
Received: by mail-lf1-f67.google.com with SMTP id c12so7446291lfh.5
        for <linux-arch@vger.kernel.org>; Sat, 07 Sep 2019 10:05:17 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id r8sm1811918lfm.71.2019.09.07.10.05.15
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Sep 2019 10:05:16 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id t8so7417190lfc.13
        for <linux-arch@vger.kernel.org>; Sat, 07 Sep 2019 10:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190904201933.10736-1-cyphar@cyphar.com> <20190904201933.10736-12-cyphar@cyphar.com>
 <7236f382d72130f2afbbe8940e72cc67e5c6dce0.camel@kernel.org>
In-Reply-To: <7236f382d72130f2afbbe8940e72cc67e5c6dce0.camel@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 7 Sep 2019 09:58:23 -0700
Message-ID: <CAHk-=whZx97Nm-gUK0ppofj2RA2LLz2vmaDUTKSSV-+yYB9q_Q@mail.gmail.com>
Subject: Re: [PATCH v12 11/12] open: openat2(2) syscall
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Al Viro <viro@zeniv.linux.org.uk>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Christian Brauner <christian@brauner.io>, Eric Biederman <ebiederm@xmission.com>, Andy Lutomirski <luto@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>, David Drysdale <drysdale@google.com>, Chanho Min <chanho.min@lge.com>, Oleg Nesterov <oleg@redhat.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Aleksa Sarai <asarai@suse.de>, Linux Containers <containers@lists.linux-foundation.org>, alpha <linux-alpha@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-ia64@vger.kernel.org, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390 <linux-s390@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, linux-xtensa@linux-xtensa.org, sparclinux@vger.kernel.org
Message-ID: <20190907165823.hcQzdcdSW2F05JVHsEsixyF4CQyqaP0FpG8q8_oUrts@z>

On Sat, Sep 7, 2019 at 5:40 AM Jeff Layton <jlayton@kernel.org> wrote:
>
> After thinking about this a bit, I wonder if we might be better served
> with a new set of OA2_* flags instead of repurposing the O_* flags?

I'd hate to have yet _another_ set of translation functions, and
another chance of people just getting it wrong either in user space or
the kernel.

So no. Let's not make another set of flags that has no sane way to
have type-safety to avoid more confusion.

The new flags that _only_ work with openat2() might be named with a
prefix/suffix to mark that, but I'm not sure it's a huge deal.

                 Linus
