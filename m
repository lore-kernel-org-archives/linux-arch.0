Return-Path: <SRS0=9CnN=7J=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgE0DHm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 May 2020 23:07:42 -0400
MIME-Version: 1.0
References: <20200526205322.23465-1-mic@digikod.net> <20200526205322.23465-8-mic@digikod.net>
In-Reply-To: <20200526205322.23465-8-mic@digikod.net>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 27 May 2020 06:07:29 +0300
Message-ID: <CAOQ4uxibpDTyjCJWLGG9jr-Gv9PwO==o50b9O8HGQeUfVMDFag@mail.gmail.com>
Subject: Re: [PATCH v18 07/12] landlock: Support filesystem access-control
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@amacapital.net>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Arnd Bergmann <arnd@arndb.de>, Casey Schaufler <casey@schaufler-ca.com>, James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>, Jeff Dike <jdike@addtoit.com>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Michael Kerrisk <mtk.manpages@gmail.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mickael.salaun@ssi.gouv.fr>, Richard Weinberger <richard@nod.at>, "Serge E . Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>, kernel-hardening@lists.openwall.com, Linux API <linux-api@vger.kernel.org>, linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-kselftest@vger.kernel.org, LSM List <linux-security-module@vger.kernel.org>, x86@kernel.org
Message-ID: <20200527030729.mdjvW9tZTY869qJQnJH6sWR0IKQICgqz1xcje73NRo8@z>

On Wed, May 27, 2020 at 3:36 AM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
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
ADfKK40uAiC4GF2p9Q@mail.gmail.com/
[2] https://lore.kernel.org/linux-fsdevel/CAOQ4uxgn=3DYNj8cJuccx2KqxEVGZy1z=
3DBVYXrD=3DMc7Dc=3DJe+-w@mail.gmail.com/
[3] https://github.com/amir73il/linux/commits/rename_xmnt
