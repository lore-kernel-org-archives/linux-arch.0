Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44362 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfAGSCp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Jan 2019 13:02:45 -0500
Received: by mail-lf1-f68.google.com with SMTP id z13so938648lfe.11
        for <linux-arch@vger.kernel.org>; Mon, 07 Jan 2019 10:02:43 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 1-v6sm13596134lju.61.2019.01.07.10.02.40
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 10:02:40 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id y14so929439lfg.13
        for <linux-arch@vger.kernel.org>; Mon, 07 Jan 2019 10:02:40 -0800 (PST)
MIME-Version: 1.0
References: <20190106180927.GA11993@roeck-us.net> <CAHk-=whyNbpBtPyoS=wh4nVgBtUBpihcOT+LFdEw369kYjATaQ@mail.gmail.com>
 <CAHk-=wiSVm6j1Ga8gra6hSQQSK8WF5bW4DtRi4V7mCtCUkTaQw@mail.gmail.com> <78e3717b-0604-3d5f-38b8-c523e392fc76@roeck-us.net>
In-Reply-To: <78e3717b-0604-3d5f-38b8-c523e392fc76@roeck-us.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 7 Jan 2019 10:02:23 -0800
Message-ID: <CAHk-=wg45nXe50ORC7reBJqsFGUPELtbk5p7ijkE9=fs1wGLAQ@mail.gmail.com>
Subject: Re: [PATCH] make 'user_access_begin()' do 'access_ok()'
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Matt Turner <mattst88@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Paul Burton <paul.burton@mips.com>, Greentime Hu <green.hu@gmail.com>, Ley Foon Tan <lftan@altera.com>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-kernel@vger.kenrel.org, linux-arch <linux-arch@vger.kernel.org>

On Sun, Jan 6, 2019 at 8:05 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> Of the above, my test system boots images for the following architectures
> in qemu.
>
> - mips (32/64 bit, big/little endian)
> - nios2
> - openrisc
> - xtensa (mmu and nommu)

So most of those are "only" the "macro arguments used twice" problem
(although openrisc also does the "arguments not quoted right"). That
doesn't cause problems with the new commit, it's an independent issue
that could cause random problems elsewhere

The nios2 access_ok() case is the same bug as alpha has, but it turns
out to be hidden by the fact that the user/kernel limit is at
0x80000000, but nios2 does:

    # define TASK_SIZE           0x7FFF0000UL

so it doesn't actually allow anything close to the top of the user
address space anyway. So the access_ok() check uses a different limit
than the TASK_SIZE, which is odd, but does hide the "last byte of the
user address space" bug.

That may be intentional, and regardless, it's generally a good idea to
not allow mapping of the last page in the address space, exactly to
avoid the border conditions.

MIPS has some of the same "saved by mistake" behavior, but in that
case it really looks to be pure luck, not design. In particular,
MIPS32 has

  #ifdef CONFIG_32BIT
  #ifdef CONFIG_KVM_GUEST
  /* User space process size is limited to 1GB in KVM Guest Mode */
  #define TASK_SIZE       0x3fff8000UL
  #else
  /*
   * User space process size: 2GB. This is hardcoded into a few places,
   * so don't change it unless you know what you are doing.
   */
  #define TASK_SIZE       0x80000000UL
  #endif

and I suspect you tested MIPS32 with that KVM_GUEST config option.

Because MIPS32 with TASK_SIZE 0x80000000UL really looks like it has
the off-by-one error that I think makes access_ok() fail for the "last
byte of the user address space" case.

HOWEVER. MIPS32 is actually going to boot for that case with the
recent patches for a simple other accidental reason: despite the
access_ok() bug, it will never trigger it in strncpy_from_user(). Why?
Because MIPS doesn't use the generic version, but its own hardcoded
assembler one.

I suspect the MIPS assembler version is actually *worse* than the
generic one (it looks like it does things one byte at a time), but it
hides the bug in access_ok()...

The other architctures you tested only have the "technically wrong,
but works" bugs that don't matter for the new stricter access_ok()
tests.

                Linus
