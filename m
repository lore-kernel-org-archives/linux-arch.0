From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
Date: Tue, 28 Jul 2020 07:23:03 -0700
Message-ID: <1764B08C-CC1E-4636-944A-DB95B81C7A8E@amacapital.net>
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-Reply-To: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org, gerg@linux-m68k.org, ktkhai@virtuozzo.com, christian.brauner@ubuntu.com, peterz@infradead.org, esyr@redhat.com, jgg@ziepe.ca, christian@kellner.me, areber@redhat.com, cyphar@cyphar.com, steven.sistare@oracle.com
List-Id: linux-arch.vger.kernel.org



> On Jul 27, 2020, at 10:02 AM, Anthony Yznaga <anthony.yznaga@oracle.com> w=
rote:
>=20
> =EF=BB=BFThis patchset adds support for preserving an anonymous memory ran=
ge across
> exec(3) using a new madvise MADV_DOEXEC argument.  The primary benefit for=

> sharing memory in this manner, as opposed to re-attaching to a named share=
d
> memory segment, is to ensure it is mapped at the same virtual address in
> the new process as it was in the old one.  An intended use for this is to
> preserve guest memory for guests using vfio while qemu exec's an updated
> version of itself.  By ensuring the memory is preserved at a fixed address=
,
> vfio mappings and their associated kernel data structures can remain valid=
.
> In addition, for the qemu use case, qemu instances that back guest RAM wit=
h
> anonymous memory can be updated.

This will be an amazing attack surface. Perhaps use of this flag should requ=
ire no_new_privs?  Arguably it should also require a special flag to execve(=
) to honor it.  Otherwise library helpers that do vfork()+exec() or posix_sp=
awn() could be quite surprised.
