From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH 0/3] namei: implement various scoping AT_* flags
Date: Sat, 29 Sep 2018 07:25:57 -0700
Message-ID: <1EE20CA2-4C8B-4A80-B613-0277D92B376D@amacapital.net>
References: <20180929103453.12025-1-cyphar@cyphar.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180929103453.12025-1-cyphar@cyphar.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>, David Howells <dhowells@redhat.com>, Andy Lutomirski <luto@kernel.org>, Christian Brauner <christian@brauner.io>, Eric Biederman <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.ws>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, dev@opencontainers.org, containers@lists.linux-foundation.org
List-Id: linux-arch.vger.kernel.org



> On Sep 29, 2018, at 3:34 AM, Aleksa Sarai <cyphar@cyphar.com> wrote:
>=20
> The need for some sort of control over VFS's path resolution (to avoid
> malicious paths resulting in inadvertent breakouts) has been a very
> long-standing desire of many userspace applications. This patchset is a
> revival of Al Viro's old AT_NO_JUMPS[1] patchset with a few additions.
>=20
> The most obvious change is that AT_NO_JUMPS has been split as dicussed
> in the original thread, along with a further split of AT_NO_PROCLINKS
> which means that each individual property of AT_NO_JUMPS is now a
> separate flag:
>=20
>  * Path-based escapes from the starting-point using "/" or ".." are
>    blocked by AT_BENEATH.

Seems useful.

>  * Mountpoint crossings are blocked by AT_XDEV.

Seems useful.

>  * /proc/$pid/fd/$fd resolution is blocked by AT_NO_PROCLINKS (more
>    correctly it actually blocks any user of nd_jump_link() because it
>    allows out-of-VFS path resolution manipulation).
>=20

So how do I disable following symlinks? ISTM the most natural way would be t=
o have AT_NO_SYMLINKS, and to have that flag disable proc links.=
