Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39450 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbfEJUKm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 May 2019 16:10:42 -0400
Received: by mail-ed1-f68.google.com with SMTP id e24so6673136edq.6
        for <linux-arch@vger.kernel.org>; Fri, 10 May 2019 13:10:41 -0700 (PDT)
Date: Fri, 10 May 2019 22:10:32 +0200
From: Jann Horn <jannh@google.com>
Subject: Re: [PATCH v6 5/6] binfmt_*: scope path resolution of interpreters
Message-ID: <20190510201032.GA253532@google.com>
References: <20190506165439.9155-1-cyphar@cyphar.com>
 <20190506165439.9155-6-cyphar@cyphar.com>
 <CAG48ez0-CiODf6UBHWTaog97prx=VAd3HgHvEjdGNz344m1xKw@mail.gmail.com>
 <87o94d6aql.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o94d6aql.fsf@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Aleksa Sarai <cyphar@cyphar.com>, Andy Lutomirski <luto@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, Kees Cook <keescook@chromium.org>, Christian Brauner <christian@brauner.io>, Tycho Andersen <tycho@tycho.ws>, David Drysdale <drysdale@google.com>, Chanho Min <chanho.min@lge.com>, Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>, Linus Torvalds <torvalds@linux-foundation.org>, containers@lists.linux-foundation.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20190510201032.TgL6UjlABqyKThw5TfgdWpUe0_Jo8d7b7zFzZpVLefE@z>

On Tue, May 07, 2019 at 07:38:58PM -0500, Eric W. Biederman wrote:
> Jann Horn <jannh@google.com> writes:
> > In my opinion, CVE-2019-5736 points out two different problems:
> >
> > The big problem: The __ptrace_may_access() logic has a special-case
> > short-circuit for "introspection" that you can't opt out of;
> 
> Once upon a time in a galaxy far far away I fixed a bug where we missing
> ptrace_may_access checks on various proc files and systems using selinux
> stopped working.  At the time selinux did not allow ptrace like access
> to yourself.  The "introspection" special case was the quick and simple
> work-around.
> 
> There is nothing fundamental in having the "introspection" special case
> except that various lsms have probably grown to depend upon it being
> there.  I expect without difficulty we could move the check down
> into the various lsms.  Which would get that check out of the core
> kernel code.

Oh, if that's an option, that would be great, I think.


But this means, for example, that a non-root, non-dumpable process can't
open /proc/self/maps anymore, or open /proc/self/fd/*, and things like
that, without making itself dumpable. I would be surprised if there is
no code out there that relies on that.
