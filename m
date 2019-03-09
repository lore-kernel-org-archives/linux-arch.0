Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34959 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbfCIRHw (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 9 Mar 2019 12:07:52 -0500
Received: by mail-lj1-f196.google.com with SMTP id t13so603372lji.2
        for <linux-arch@vger.kernel.org>; Sat, 09 Mar 2019 09:07:51 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id p3sm205494lfc.64.2019.03.09.09.07.49
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Mar 2019 09:07:49 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id v16so580060ljg.13
        for <linux-arch@vger.kernel.org>; Sat, 09 Mar 2019 09:07:49 -0800 (PST)
MIME-Version: 1.0
References: <20190306191244.8691-1-cyphar@cyphar.com> <20190306191244.8691-3-cyphar@cyphar.com>
In-Reply-To: <20190306191244.8691-3-cyphar@cyphar.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 9 Mar 2019 09:00:58 -0800
Message-ID: <CAHk-=wgGKWRTgSYKkgMEf1QOg0PZSpmBha+2LCHCBOar0e8cug@mail.gmail.com>
Subject: Re: [PATCH RESEND v5 2/5] namei: O_BENEATH-style path resolution flags
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Christian Brauner <christian@brauner.io>, Kees Cook <keescook@chromium.org>, David Drysdale <drysdale@google.com>, Andy Lutomirski <luto@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, Jann Horn <jannh@google.com>, Chanho Min <chanho.min@lge.com>, Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>, containers@lists.linux-foundation.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20190309170058.Yc6tkTshc31z9jObiGcdCecKMzRtL7UM288H9i_d0QU@z>

On Wed, Mar 6, 2019 at 11:14 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> This is a refresh of Al's AT_NO_JUMPS patchset[1] (which was a variation
> on David Drysdale's O_BENEATH patchset[2], which in turn was based on
> the Capsicum project[3]). Input from Linus and Andy in the AT_NO_JUMPS
> thread[4] determined most of the API changes made in this refresh.

So I still think this is likely a good idea...  BUT.

The absolutely huge BUT here is "are user space people actually
interested in using it, or do they already have other solutions to
this anyway?"

The intent is obviously to make it easy and cheap to to the simple
pathname lookup in a controlled manner, and then let user space fall
back to "let's check things much more carefully" for paths that look
iffy.

But maybe the people who care already have their own solutions, and/or
need something more anyway (ie samba looking up all names in user
space first _anyway_ due to ICASE issues or whatever)?

So this is easy and straightforward to do in the kernel, and it
_feels_ like something that can be useful, and I'm not all that
concerned about the maintenance overhead either because of the trivial
semantics.

But I'd still like to actually have some user space person say "yeah,
we'd actually use this" since quite often non-portable solutions don't
really end up being used simply because it's not worth the maintenance
headache in user space..

                     Linus
