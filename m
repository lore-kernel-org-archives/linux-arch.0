Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728604AbfCURGx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 Mar 2019 13:06:53 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86BA42192D
        for <linux-arch@vger.kernel.org>; Thu, 21 Mar 2019 17:06:52 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id z6so2487280wmi.0
        for <linux-arch@vger.kernel.org>; Thu, 21 Mar 2019 10:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190320143717.2523-1-cyphar@cyphar.com>
In-Reply-To: <20190320143717.2523-1-cyphar@cyphar.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 21 Mar 2019 10:06:38 -0700
Message-ID: <CALCETrV-Q4qZXGeavBPQbF6-VVz7hqvjRkbhFeYmbGiQgu5Omg@mail.gmail.com>
Subject: Re: [PATCH RESEND v5 0/5] namei: vfs flags to restrict path resolution
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Andy Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>, Christian Brauner <christian@brauner.io>, David Drysdale <drysdale@google.com>, Tycho Andersen <tycho@tycho.ws>, Kees Cook <keescook@chromium.org>, Linux Containers <containers@lists.linux-foundation.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, Chanho Min <chanho.min@lge.com>, Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20190321170638.6XWLbXl0WnaEl4KVaMHmSR4cIS_X8yfjZh8GY5-38cw@z>

On Wed, Mar 20, 2019 at 7:38 AM Aleksa Sarai <cyphar@cyphar.com> wrote:
>
> Now that the holiday break is over, it's time to re-send this patch
> series (with a few additions, due to new information we got from
> CVE-2019-5736 -- which this patchset mostly protected against but had
> some holes with regards to #!-style scripts).

I generally like this, but, as Linus pointed out, it will be
unfortunate if application authors see this as just another
non-portable weird Linux API and don't use it.  Would it be worthwhile
to put some thought into making it an API that other OSes might be
willing to implement?  As it stands, the openat(2) flags are getting
rather crazy in this patch set.

Aleksa had a resolveat(2) proposal that really didn't seem too bad.
