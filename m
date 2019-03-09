Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35521 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfCISOk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 9 Mar 2019 13:14:40 -0500
Received: by mail-lj1-f194.google.com with SMTP id t13so687706lji.2
        for <linux-arch@vger.kernel.org>; Sat, 09 Mar 2019 10:14:39 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id f1sm232963lfc.48.2019.03.09.10.14.37
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Mar 2019 10:14:37 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id u2so612745lfd.4
        for <linux-arch@vger.kernel.org>; Sat, 09 Mar 2019 10:14:37 -0800 (PST)
MIME-Version: 1.0
References: <20190306191244.8691-1-cyphar@cyphar.com> <20190306191244.8691-3-cyphar@cyphar.com>
 <CAHk-=wgGKWRTgSYKkgMEf1QOg0PZSpmBha+2LCHCBOar0e8cug@mail.gmail.com> <20190309172631.ygfdhrn4rcwkgfmk@brauner.io>
In-Reply-To: <20190309172631.ygfdhrn4rcwkgfmk@brauner.io>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 9 Mar 2019 10:08:08 -0800
Message-ID: <CAHk-=whMuk-b6rzhbF2=vVNOuEZk8-opRJ1fD07a9ztQ+V97Aw@mail.gmail.com>
Subject: Re: [PATCH RESEND v5 2/5] namei: O_BENEATH-style path resolution flags
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christian Brauner <christian@brauner.io>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>, David Drysdale <drysdale@google.com>, Andy Lutomirski <luto@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, Jann Horn <jannh@google.com>, Chanho Min <chanho.min@lge.com>, Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>, containers@lists.linux-foundation.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20190309180808.bhQ0bo5LbrdQz_FkRPrKbDmb99VkrcpKmPjOIgZOCyA@z>

On Sat, Mar 9, 2019 at 9:26 AM Christian Brauner <christian@brauner.io> wrote:
>
> Aside from that I want to point out that it is non-trivial to do this in
> user space.

Oh, absolutely agreed. It's easy to do it in the kernel, and doing it
anywhere else ends up having horrible races that the kernel has to
deal with and has long solved anyway.

I've only seen this (2/5) patch, so I won't comment on the other ones,
but this still makes sense to me.

Al, comments?

                  Linus
