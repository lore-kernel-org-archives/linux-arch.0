From: Jann Horn <jannh@google.com>
Subject: Re: [PATCH 1/3] namei: implement O_BENEATH-style AT_* flags
Date: Mon, 1 Oct 2018 14:28:03 +0200
Message-ID: <CAG48ez17EQuJQAZUg5hDFXhkjnnVFh39=aD+j0FBdsoTONSGEA@mail.gmail.com>
References: <20180929103453.12025-1-cyphar@cyphar.com> <20180929103453.12025-2-cyphar@cyphar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180929103453.12025-2-cyphar@cyphar.com>
Sender: linux-kernel-owner@vger.kernel.org
To: cyphar@cyphar.com, Al Viro <viro@zeniv.linux.org.uk>, "Eric W. Biederman" <ebiederm@xmission.com>, Andy Lutomirski <luto@kernel.org>
Cc: jlayton@kernel.org, Bruce Fields <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, shuah@kernel.org, David Howells <dhowells@redhat.com>, christian@brauner.io, Tycho Andersen <tycho@tycho.ws>, kernel list <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>, linux-kselftest@vger.kernel.org, dev@opencontainers.org, containers@lists.linux-foundation.org
List-Id: linux-arch.vger.kernel.org

On Sat, Sep 29, 2018 at 4:28 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
> Add the following flags for path resolution. The primary justification
> for these flags is to allow for programs to be far more strict about how
> they want path resolution to handle symlinks, mountpoint crossings, and
> paths that escape the dirfd (through an absolute path or ".."
> shenanigans).
>
> This is of particular concern to container runtimes that want to be very
> careful about malicious root filesystems that a container's init might
> have screwed around with (and there is no real way to protect against
> this in userspace if you consider potential races against a malicious
> container's init).
>
> * AT_BENEATH: Disallow ".." or absolute paths (either in the path or
>   found during symlink resolution) to escape the starting point of name
>   resolution, though ".." is permitted in cases like "foo/../bar".
>   Relative symlinks are still allowed (as long as they don't escape the
>   starting point).

As I said on the other thread, I would strongly prefer an API that
behaves along the lines of David Drysdale's old patch
https://lore.kernel.org/lkml/1439458366-8223-2-git-send-email-drysdale@google.com/
: Forbid any use of "..". This would also be more straightforward to
implement safely. If that doesn't work for you, I would like it if you
could at least make that an option. I would like it if this API could
mitigate straightforward directory traversal bugs such as
https://bugs.chromium.org/p/project-zero/issues/detail?id=1583, where
a confused deputy attempts to access a path like
"/mnt/media_rw/../../data" while intending to access a directory under
"/mnt/media_rw".

> * AT_XDEV: Disallow mount-point crossing (both *down* into one, or *up*
>   from one). The primary "scoping" use is to blocking resolution that
>   crosses a bind-mount, which has a similar property to a symlink (in
>   the way that it allows for escape from the starting-point). Since it
>   is not possible to differentiate bind-mounts However since
>   bind-mounting requires privileges (in ways symlinks don't) this has
>   been split from LOOKUP_BENEATH. The naming is based on "find -xdev"
>   (though find(1) doesn't walk upwards, the semantics seem obvious).
>
> * AT_NO_PROCLINK: Disallows ->get_link "symlink" jumping. This is a very
>   specific restriction, and it exists because /proc/$pid/fd/...
>   "symlinks" allow for access outside nd->root and pose risk to
>   container runtimes that don't want to be tricked into accessing a host
>   path (but do want to allow no-funny-business symlink resolution).

AT_BENEATH has to imply AT_NO_PROCLINK, right? Especially with the
semantics you picked for AT_BENEATH. With the original O_BENEATH_ONLY
semantics, it might be okay to not imply AT_NO_PROCLINK...

> * AT_NO_SYMLINK: Disallows symlink jumping *of any kind*. Implies
>   AT_NO_PROCLINK (obviously).
>
> The AT_NO_*LINK flags return -ELOOP if path resolution would violates
> their requirement, while the others all return -EXDEV. Currently these
> are only enabled for the stat(2) family and the openat(2) family (the
> latter has its own brand of O_* flags with the same semantics). Ideally
> these flags would be supported by all *at(2) syscalls, but this will
> require adding flags arguments to many of them (and will be done in a
> separate patchset).
