Return-Path: <SRS0=fQTO=6M=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725803AbgD1EgY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Apr 2020 00:36:24 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FFAC03C1A9
        for <linux-arch@vger.kernel.org>; Mon, 27 Apr 2020 21:36:24 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a21so19993325ljb.9
        for <linux-arch@vger.kernel.org>; Mon, 27 Apr 2020 21:36:24 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id h28sm1155665lfe.80.2020.04.27.21.36.22
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 21:36:22 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id k28so15726343lfe.10
        for <linux-arch@vger.kernel.org>; Mon, 27 Apr 2020 21:36:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wga3O=BoKZXR27-CDnAFareWcMxXhpWerwtCffdaH6_ow@mail.gmail.com>
 <B7A115CB-0C8C-4719-B97B-74D94231CD1E@amacapital.net>
In-Reply-To: <B7A115CB-0C8C-4719-B97B-74D94231CD1E@amacapital.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2020 21:28:14 -0700
Message-ID: <CAHk-=whQzOsh9O2uhUO2VETD+hrzjKMpEJpzoUby5QHMcvgPKg@mail.gmail.com>
Subject: Re: [RFC v2] ptrace, pidfd: add pidfd_ptrace syscall
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Christian Brauner <christian.brauner@ubuntu.com>, Arnd Bergmann <arnd@arndb.de>, Hagen Paul Pfeifer <hagen@jauu.net>, "Eric W. Biederman" <ebiederm@xmission.com>, Jann Horn <jannh@google.com>, kernel list <linux-kernel@vger.kernel.org>, Florian Weimer <fweimer@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Brian Gerst <brgerst@gmail.com>, Sami Tolvanen <samitolvanen@google.com>, David Howells <dhowells@redhat.com>, Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Sargun Dhillon <sargun@sargun.me>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-ID: <20200428042814.I9Xfdz88uqmKzK-o3-OuKVq89GxmYOR2TJftItkgi-0@z>

On Mon, Apr 27, 2020 at 9:17 PM Andy Lutomirski <luto@amacapital.net> wrote=
:
>
> I hate to say this, but I=E2=80=99m not convinced that asking the gdb fol=
ks is
> the right approach. GDB has an ancient architecture and is
> *incredibly* buggy. I=E2=80=99m sure ptrace is somewhere on the pain poin=
t
> list, but I suspect it=E2=80=99s utterly dwarfed by everything else.

You may be right. However, if gdbn isn't going to use it, then I
seriously don't think it's worth changing much.

It might be worth looking at people who don't use ptrace() for
debugging, but for "incidental" reasons. IOW sandboxing, tracing,
things like that.

Maybe those people want things that are simpler and don't actually
need the kinds of hard serialization that ptrace() wants.

I'd rather add a few really simple things that might not be a full
complement of operations for a debugger, but exactly because they
aren't a full debugger, maybe they are things that we can tell are
obviously secure and simple?

               Linus
