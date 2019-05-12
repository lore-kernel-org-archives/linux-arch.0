Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35848 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfELKui (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 May 2019 06:50:38 -0400
Received: by mail-lj1-f196.google.com with SMTP id z1so8510494ljb.3
        for <linux-arch@vger.kernel.org>; Sun, 12 May 2019 03:50:37 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id l14sm2511100ljj.15.2019.05.12.03.50.35
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 03:50:35 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id u27so6976973lfg.10
        for <linux-arch@vger.kernel.org>; Sun, 12 May 2019 03:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190506165439.9155-1-cyphar@cyphar.com> <20190506165439.9155-6-cyphar@cyphar.com>
 <CAG48ez0-CiODf6UBHWTaog97prx=VAd3HgHvEjdGNz344m1xKw@mail.gmail.com>
 <20190506191735.nmzf7kwfh7b6e2tf@yavin> <20190510204141.GB253532@google.com>
 <CALCETrW2nn=omqJb4p+m-BDsCOhg+YZQ3ELd4BdhODV3G44gfA@mail.gmail.com>
 <20190510225527.GA59914@google.com> <C60DC580-854D-478D-AF23-5F29FB7C3E50@amacapital.net>
 <CAHk-=wh1JJD_RabMaFfinsAQp1vHGJOQ1rKqihafY=r7yHc8sQ@mail.gmail.com>
 <CALCETrUOj=4VWp=B=QT0BQ8X_Ds_b+pt68oDwfjGb+K0StXmWA@mail.gmail.com>
 <CAHk-=wg3+3GfHsHdB4o78jNiPh_5ShrzxBuTN-Y8EZfiFMhCvw@mail.gmail.com> <9CD2B97D-A6BD-43BE-9040-B410D996A195@amacapital.net>
In-Reply-To: <9CD2B97D-A6BD-43BE-9040-B410D996A195@amacapital.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 12 May 2019 06:44:06 -0400
Message-ID: <CAHk-=wh3dT7=SMjvSZreXSu36Cg7gsfSipLhfTz5ioDKXV5uHg@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] binfmt_*: scope path resolution of interpreters
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Andrew Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>, Aleksa Sarai <cyphar@cyphar.com>, Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, Kees Cook <keescook@chromium.org>, Christian Brauner <christian@brauner.io>, Tycho Andersen <tycho@tycho.ws>, David Drysdale <drysdale@google.com>, Chanho Min <chanho.min@lge.com>, Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>, Linux Containers <containers@lists.linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20190512104406.TtuNBXagcvogtTkODW53I3VWEWTp8s5avcu5yA_f42k@z>

On Sat, May 11, 2019 at 7:37 PM Andy Lutomirski <luto@amacapital.net> wrote:
>
> I bet this will break something that already exists. An execveat() flag to turn off /proc/self/exe would do the trick, though.

Thinking more about it, I suspect it is (once again) wrong to let the
thing that does the execve() control that bit.

Generally, the less we allow people to affect the lifetime and
environment of a suid executable, the better off we are.

But maybe we could limit /proc/*/exe to at least not honor suid'ness
of the target? Or does chrome/runc depend on that too?

             Linus
