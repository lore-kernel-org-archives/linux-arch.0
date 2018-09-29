Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34402 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728382AbeI2XDb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Sep 2018 19:03:31 -0400
Received: by mail-pf1-f194.google.com with SMTP id k19-v6so6348417pfi.1
        for <linux-arch@vger.kernel.org>; Sat, 29 Sep 2018 09:34:28 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/3] namei: implement various scoping AT_* flags
From: Andy Lutomirski <luto@amacapital.net>
In-Reply-To: <20180929154551.jsi6dt3xjxdxoqeh@ryuk>
Date: Sat, 29 Sep 2018 09:34:24 -0700
Content-Transfer-Encoding: quoted-printable
Message-ID: <9D01A225-05BE-4B4A-873A-94168D17F687@amacapital.net>
References: <20180929103453.12025-1-cyphar@cyphar.com> <1EE20CA2-4C8B-4A80-B613-0277D92B376D@amacapital.net> <20180929154551.jsi6dt3xjxdxoqeh@ryuk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>, David Howells <dhowells@redhat.com>, Andy Lutomirski <luto@kernel.org>, Christian Brauner <christian@brauner.io>, Eric Biederman <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.ws>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, dev@opencontainers.org, containers@lists.linux-foundation.org
Message-ID: <20180929163424.fkom9ywU4WqN2KkcnQHQXtNiU4DH_kScRpXg4p39KCY@z>



> On Sep 29, 2018, at 8:45 AM, Aleksa Sarai <cyphar@cyphar.com> wrote:
>=20
> On 2018-09-29, Andy Lutomirski <luto@amacapital.net> wrote:
>>> The most obvious change is that AT_NO_JUMPS has been split as dicussed
>>> in the original thread, along with a further split of AT_NO_PROCLINKS
>>> which means that each individual property of AT_NO_JUMPS is now a
>>> separate flag:
>>>=20
>>> * Path-based escapes from the starting-point using "/" or ".." are
>>>   blocked by AT_BENEATH.
>>=20
>> Seems useful.
>>=20
>>> * Mountpoint crossings are blocked by AT_XDEV.
>>=20
>> Seems useful.
>>=20
>>> * /proc/$pid/fd/$fd resolution is blocked by AT_NO_PROCLINKS (more
>>>   correctly it actually blocks any user of nd_jump_link() because it
>>>   allows out-of-VFS path resolution manipulation).
>>>=20
>>=20
>> So how do I disable following symlinks? ISTM the most natural way
>> would be to have AT_NO_SYMLINKS, and to have that flag disable proc
>> links.
>=20
> So, this patchset has both AT_NO_SYMLINKS and AT_NO_PROCLINKS.

And AT_THIS_ROOT, which is neat. Want to update your cover letter to include=
 all of this?  Or at I just reading the wrong thing?

>=20
> * AT_NO_SYMLINKS blocks *all* symlinks (which is something Linus requested=

>  in the original thread[2] -- apparently this is something that would
>  be useful to git even if wouldn't violate AT_BENEATH). This implies
>  AT_NO_PROCLINKS.
>=20
> * AT_NO_PROCLINKS only blocks procfs-style "symlinks" (filesystem
>  "symlinks" that call nd_jump_link() themselves -- currently only
>  procfs and nsfs).
>=20

Hmm. I=E2=80=99m not sure that blocking nsfs links is always what the contai=
ner runtime wants, but the overall concept sounds quite useful.  Maybe call i=
t AT_NO_TELEPORT?  Or AT_NO_MAGIC_LINKS?

Also, as a perhaps-silly suggestion: if you end up adding a new syscall, I c=
an see a use for a mode that does the path walk but, rather than failing on a=
 disallowed link, stops early and indicates where it stopped. Then web serve=
rs, samba, etc can more efficiently implement custom behavior when links are=
 encountered.  And it may also be useful to have a variant of AT_THIS_ROOT w=
here trying to escape is an error instead of having it just get stuck at the=
 root.=
