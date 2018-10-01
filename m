From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH 0/3] namei: implement various scoping AT_* flags
Date: Mon, 1 Oct 2018 13:28:28 +0000
Message-ID: <1f1d699b1c8d472495a5b07199c31a6e@AcuMS.aculab.com>
References: <20180929103453.12025-1-cyphar@cyphar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180929103453.12025-1-cyphar@cyphar.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: 'Aleksa Sarai' <cyphar@cyphar.com>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Andy Lutomirski <luto@kernel.org>, Christian Brauner <christian@brauner.io>, Eric Biederman <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.ws>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "dev@opencontainers.org" <dev@opencontainers.org>, "containers@lists.linux-foundation.org" <containers@lists.linux-foundation.org>
List-Id: linux-arch.vger.kernel.org

From: Aleksa Sarai
> Sent: 29 September 2018 11:35
> 
> The need for some sort of control over VFS's path resolution (to avoid
> malicious paths resulting in inadvertent breakouts) has been a very
> long-standing desire of many userspace applications. This patchset is a
> revival of Al Viro's old AT_NO_JUMPS[1] patchset with a few additions.
> 
> The most obvious change is that AT_NO_JUMPS has been split as dicussed
> in the original thread, along with a further split of AT_NO_PROCLINKS
> which means that each individual property of AT_NO_JUMPS is now a
> separate flag:
> 
>   * Path-based escapes from the starting-point using "/" or ".." are
>     blocked by AT_BENEATH.

You may need to allow absolute paths that refer to items inside
the controlled area.
(Even if done by a textual replacement based on the expected name
of the base directory.)

>   * Mountpoint crossings are blocked by AT_XDEV.

You might want a mountpoint flag that allows crossing into the mounted
filesystem (you may need to get out in order to do pwd()).

>   * /proc/$pid/fd/$fd resolution is blocked by AT_NO_PROCLINKS (more
> 	correctly it actually blocks any user of nd_jump_link() because it
> 	allows out-of-VFS path resolution manipulation).

Or 'fix' the /proc/$pid/fd/$fd code to open the actual vnode rather than
being a symlink (although this might still let you get a directory vnode).
FWIW this is what NetBSD does - you can link the open file back into
the filesystem!

> 
> AT_NO_JUMPS is now effectively (AT_BENEATH|AT_XDEV|AT_NO_PROCLINKS). At
> Linus' suggestion in the original thread, I've also implemented
> AT_NO_SYMLINKS which just denies _all_ symlink resolution (including
> "proclink" resolution).

What about allowing 'trivial' symlinks?

...
> Currently I've only enabled these for openat(2) and the stat(2) family.
> I would hope we could enable it for basically every *at(2) syscall --
> but many of them appear to not have a @flags argument and thus we'll
> need to add several new syscalls to do this. I'm more than happy to send
> those patches, but I'd prefer to know that this preliminary work is
> acceptable before doing a bunch of copy-paste to add new sets of *at(2)
> syscalls.

If you make the flags a property of the directory vnode (perhaps as
well as any syscall flags), and make it inherited by vnode lookup then
it can be used to stop library functions (or entire binaries) using
blocked paths.
You'd then only need to add an fcntl() call to set the flags (but never
clear them) to get the restriction applied to every lookup.
...

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
