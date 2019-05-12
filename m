Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41098 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbfELOe2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 12 May 2019 10:34:28 -0400
Received: by mail-pg1-f193.google.com with SMTP id z3so5389344pgp.8
        for <linux-arch@vger.kernel.org>; Sun, 12 May 2019 07:34:28 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6 5/6] binfmt_*: scope path resolution of interpreters
From: Andy Lutomirski <luto@amacapital.net>
In-Reply-To: <20190512133549.ymx5yg5rdqvavzyq@yavin>
Date: Sun, 12 May 2019 07:34:26 -0700
Content-Transfer-Encoding: quoted-printable
Message-ID: <0ED963D0-4C31-45B1-B361-E4A75DFBF7C1@amacapital.net>
References: <20190506191735.nmzf7kwfh7b6e2tf@yavin> <20190510204141.GB253532@google.com> <CALCETrW2nn=omqJb4p+m-BDsCOhg+YZQ3ELd4BdhODV3G44gfA@mail.gmail.com> <20190510225527.GA59914@google.com> <C60DC580-854D-478D-AF23-5F29FB7C3E50@amacapital.net> <CAHk-=wh1JJD_RabMaFfinsAQp1vHGJOQ1rKqihafY=r7yHc8sQ@mail.gmail.com> <CALCETrUOj=4VWp=B=QT0BQ8X_Ds_b+pt68oDwfjGb+K0StXmWA@mail.gmail.com> <CAHk-=wg3+3GfHsHdB4o78jNiPh_5ShrzxBuTN-Y8EZfiFMhCvw@mail.gmail.com> <9CD2B97D-A6BD-43BE-9040-B410D996A195@amacapital.net> <CAHk-=wh3dT7=SMjvSZreXSu36Cg7gsfSipLhfTz5ioDKXV5uHg@mail.gmail.com> <20190512133549.ymx5yg5rdqvavzyq@yavin>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>, Al Viro <viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, Kees Cook <keescook@chromium.org>, Christian Brauner <christian@brauner.io>, Tycho Andersen <tycho@tycho.ws>, David Drysdale <drysdale@google.com>, Chanho Min <chanho.min@lge.com>, Oleg Nesterov <oleg@redhat.com>, Aleksa Sarai <asarai@suse.de>, Linux Containers <containers@lists.linux-foundation.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, kernel list <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Message-ID: <20190512143426.lKR6IWN1aSU5yRRh4xcyuN8dkj_-DEMT8anmDkaiJCw@z>


> On May 12, 2019, at 6:35 AM, Aleksa Sarai <cyphar@cyphar.com> wrote:
>=20
>> On 2019-05-12, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>> On Sat, May 11, 2019 at 7:37 PM Andy Lutomirski <luto@amacapital.net> wr=
ote:
>>> I bet this will break something that already exists. An execveat()
>>> flag to turn off /proc/self/exe would do the trick, though.
>>=20
>> Thinking more about it, I suspect it is (once again) wrong to let the
>> thing that does the execve() control that bit.
>>=20
>> Generally, the less we allow people to affect the lifetime and
>> environment of a suid executable, the better off we are.
>>=20
>> But maybe we could limit /proc/*/exe to at least not honor suid'ness
>> of the target? Or does chrome/runc depend on that too?
>=20
> Speaking on the runc side, we don't depend on this. It's possible
> someone depends on this for fexecve(3) -- but as mentioned before in
> newer kernels glibc uses execve(AT_EMPTY_PATH).

Why are we concerned about suid?  Don=E2=80=99t we already block suid if the=
 path being execed doesn=E2=80=99t come from the current mountns?  That shou=
ld mostly cover the things we care about, no?

I suppose we could also block suid for deleted files, so that deleting a kno=
wn-buggy suid binary becomes more reliable. But every sensible package tool s=
hould already be chmoding the suid away before unlinking.=
