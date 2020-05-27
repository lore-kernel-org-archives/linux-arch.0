From: Amir Goldstein <amir73il-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v18 07/12] landlock: Support filesystem access-control
Date: Wed, 27 May 2020 06:07:29 +0300
Message-ID: <CAOQ4uxibpDTyjCJWLGG9jr-Gv9PwO==o50b9O8HGQeUfVMDFag@mail.gmail.com>
References: <20200526205322.23465-1-mic@digikod.net> <20200526205322.23465-8-mic@digikod.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200526205322.23465-8-mic-WFhQfpSGs3bR7s880joybQ@public.gmane.org>
Sender: linux-api-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic-WFhQfpSGs3bR7s880joybQ@public.gmane.org>
Cc: linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Al Viro <viro-RmSDqhL/yNMiFSDQTTA3OLVCufUGDwFn@public.gmane.org>, Andy Lutomirski <luto-kltTT9wpgjJwATOyAt5JVQ@public.gmane.org>, Anton Ivanov <anton.ivanov-eaSgp5hN2EAtwqFdIEgyzdBPR1lH4CV8@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Casey Schaufler <casey-iSGtlc1asvQWG2LlvL+J4A@public.gmane.org>, James Morris <jmorris-gx6/JNMH7DfYtjvyW6yDsg@public.gmane.org>, Jann Horn <jannh-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Jeff Dike <jdike-OPE4K8JWMJJBDgjK7y7TUQ@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Michael Kerrisk <mtk.manpages-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mickael.salaun-D9rjmswh09VWj0EZb7rXcA@public.gmane.org>, Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>, "Serge E . Hallyn" <serge-A9i7LUbDfNHQT0dZR+AlfA@public.gmane.org>, Shuah Khan <shuah-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Vincent Dagonneau <vincent.dagonneau-D9rjmswh09VWj0EZb7rXcA@public.gmane.org>, kernel-hardening-ZwoEplunGu1jrUoiu81ncdBPR1lH4CV8@public.gmane.org, Linux API <linux-api-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>linux
List-Id: linux-arch.vger.kernel.org

On Wed, May 27, 2020 at 3:36 AM Micka=C3=ABl Sala=C3=BCn <mic-WFhQfpSGs3bR7s880joybQ@public.gmane.org> =
wrote:
>
> Thanks to the Landlock objects and ruleset, it is possible to identify
> inodes according to a process's domain.  To enable an unprivileged
> process to express a file hierarchy, it first needs to open a directory
> (or a file) and pass this file descriptor to the kernel through
> landlock(2).  When checking if a file access request is allowed, we walk
> from the requested dentry to the real root, following the different
> mount layers.  The access to each "tagged" inodes are collected
> according to their rule layer level, and ANDed to create access to the
> requested file hierarchy.  This makes possible to identify a lot of
> files without tagging every inodes nor modifying the filesystem, while
> still following the view and understanding the user has from the
> filesystem.
>

Hi Mickael,

Nice work! I am interested in the problem of system wide file access
rules based on directory hierarchy [1][2]. Not the same problem, but
with obvious overlaps.

I sketched this untested POC [2] a while ago -
It introduces the concept of "border control" LSM hooks to avoid the
need to check which sections in the hierarchy an inode belongs to
on every syscall.

With this, you could cache a topology with id's per section and
cache the section id + topology generation in the inode's security state.
When inode crosses border control hooks, it's section id is updated.
When directory hierarchy topology changes, some or all of the cached
section id's are invalidated and rules <-> sections relations may need
to be changed.

Do you think something like that could be useful for landlock?

Note that the POC is using d_mountpoint() as the only type of "fence"
mark. It is sufficient for controlling rename in and out of containers, so
I just used an already available dentry flag for "fence".
If the border control hook concept is useful, this could be extended to
a more generic d_border_passing(), with some internal kernel API
to manage it and with all the bike shedding that comes with it...

Thanks,
Amir.

[1] https://lore.kernel.org/linux-fsdevel/CAOQ4uxhBVhyyJv0+xSFQiGQEj60AbD3S=
ADfKK40uAiC4GF2p9Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org/
[2] https://lore.kernel.org/linux-fsdevel/CAOQ4uxgn=3DYNj8cJuccx2KqxEVGZy1z=
3DBVYXrD=3DMc7Dc=3DJe+-w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org/
[3] https://github.com/amir73il/linux/commits/rename_xmnt
