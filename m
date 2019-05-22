Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729649AbfEVRBd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 May 2019 13:01:33 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 016822184E
        for <linux-arch@vger.kernel.org>; Wed, 22 May 2019 17:01:33 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id t5so2987468wmh.3
        for <linux-arch@vger.kernel.org>; Wed, 22 May 2019 10:01:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190520133305.11925-1-cyphar@cyphar.com> <20190520133305.11925-2-cyphar@cyphar.com>
In-Reply-To: <20190520133305.11925-2-cyphar@cyphar.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 22 May 2019 10:01:17 -0700
Message-ID: <CALCETrVCwe49q5mu=f6jTYNSgosQSjjY5chukMPo6eZtQGqo5g@mail.gmail.com>
Subject: Re: [PATCH RFC v8 01/10] namei: obey trailing magic-link DAC permissions
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, Andy Lutomirski <luto@kernel.org>, Christian Brauner <christian@brauner.io>, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>, David Drysdale <drysdale@google.com>, Chanho Min <chanho.min@lge.com>, Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Containers <containers@lists.linux-foundation.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20190522170117.zTRFq4vsbYLfD_gTaytJGbV_emp8VGcD-drv4EsToLg@z>

On Mon, May 20, 2019 at 6:34 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
> One final exception is given, which is that non-O_PATH file descriptors
> are given re-open rights equivalent to the permissions available at
> open-time. This allows for O_RDONLY file descriptors to be re-opened
> O_RDWR as long as the user had MAY_WRITE access at the time of opening
> the O_RDONLY descriptor. This is necessary to avoid breaking userspace
> (some of the kernel's own selftests depended on this "feature").

Can you clarify this exception a bit?  I'd like to make sure it's not
such a huge exception that it invalidates the whole point of the
patch.  If you open a file for execute, by actually exec()ing it or by
using something like the proposed O_MAYEXEC, and you have
inode_permission to write, do you still end up with FMODE_PATH_WRITE?
The code looks like it does, and this seems like it might be a
mistake.  Is there any way for user code to read out these new file
mode bits?

What are actual examples of uses for this exception?  Breaking
selftests is not, in and of itself, a huge problem.
