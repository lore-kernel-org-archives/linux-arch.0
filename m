Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vk1-f196.google.com ([209.85.221.196]:39403 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfDWUTq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 23 Apr 2019 16:19:46 -0400
Received: by mail-vk1-f196.google.com with SMTP id s80so3508423vke.6
        for <linux-arch@vger.kernel.org>; Tue, 23 Apr 2019 13:19:46 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id j11sm5184078vkj.13.2019.04.23.13.19.44
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 13:19:45 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id g127so9069085vsd.6
        for <linux-arch@vger.kernel.org>; Tue, 23 Apr 2019 13:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190320143717.2523-1-cyphar@cyphar.com> <CALCETrV-Q4qZXGeavBPQbF6-VVz7hqvjRkbhFeYmbGiQgu5Omg@mail.gmail.com>
 <20190325130429.dbrgjxnvq3w5cpb3@yavin>
In-Reply-To: <20190325130429.dbrgjxnvq3w5cpb3@yavin>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 23 Apr 2019 13:13:52 -0700
Message-ID: <CAGXu5jKPrarixQkWWXOBCu6kRRpQd0aaJsPJbvsAyh0Wvc620A@mail.gmail.com>
Subject: Re: [PATCH RESEND v5 0/5] namei: vfs flags to restrict path resolution
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>, Andy Lutomirski <luto@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Jann Horn <jannh@google.com>, Christian Brauner <christian@brauner.io>, David Drysdale <drysdale@google.com>, Tycho Andersen <tycho@tycho.ws>, Kees Cook <keescook@chromium.org>, Linux Containers <containers@lists.linux-foundation.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, Chanho Min <chanho.min@lge.com>, Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20190423201352.e-xR6Y_KvKPZ-JBNIkonEFY3zKXQBDaUJDVf5DrZt64@z>

On Mon, Mar 25, 2019 at 6:05 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> On 2019-03-21, Andy Lutomirski <luto@kernel.org> wrote:
> > On Wed, Mar 20, 2019 at 7:38 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
> > > Now that the holiday break is over, it's time to re-send this patch
> > > series (with a few additions, due to new information we got from
> > > CVE-2019-5736 -- which this patchset mostly protected against but had
> > > some holes with regards to #!-style scripts).
> >
> > I generally like this, but, as Linus pointed out, it will be
> > unfortunate if application authors see this as just another
> > non-portable weird Linux API and don't use it.  Would it be worthwhile
> > to put some thought into making it an API that other OSes might be
> > willing to implement?  As it stands, the openat(2) flags are getting
> > rather crazy in this patch set.

I think many of the issues are specific to Linux (and Linux containers
especially), so I'm not sure this should get blocked because we want
something more portable.

This series provides solutions to so many different race and confusion
issues, I'd really like to see it land. What's the next step here? Is
this planned to go directly to Linus for v5.2, or is it going to live
in -mm for a while? I'd really like to see this moving forward.

Thanks for continuing to work on it!

-Kees
