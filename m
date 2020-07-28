Return-Path: <SRS0=h896=BH=kvack.org=owner-linux-mm@kernel.org>
Subject: Re: [RFC PATCH 0/5] madvise MADV_DOEXEC
References: <1595869887-23307-1-git-send-email-anthony.yznaga@oracle.com>
 <1764B08C-CC1E-4636-944A-DB95B81C7A8E@amacapital.net>
From: Steven Sistare <steven.sistare@oracle.com>
Message-ID: <54599ed9-99f1-378e-bccf-ba41ef1f8217@oracle.com>
Date: Tue, 28 Jul 2020 10:30:41 -0400
MIME-Version: 1.0
In-Reply-To: <1764B08C-CC1E-4636-944A-DB95B81C7A8E@amacapital.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: owner-linux-mm@kvack.org
To: Andy Lutomirski <luto@amacapital.net>, Anthony Yznaga <anthony.yznaga@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, mhocko@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org, arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org, gerg@linux-m68k.org, ktkhai@virtuozzo.com, christian.brauner@ubuntu.com, peterz@infradead.org, esyr@redhat.com, jgg@ziepe.ca, christian@kellner.me, areber@redhat.com, cyphar@cyphar.com
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200728143041.yio2HtJ2X0ot46R1Nm-Zm_aHSBS4WVcG20goV_Dv528@z>

On 7/28/2020 10:23 AM, Andy Lutomirski wrote:
>> On Jul 27, 2020, at 10:02 AM, Anthony Yznaga <anthony.yznaga@oracle.co=
m> wrote:
>>
>> =EF=BB=BFThis patchset adds support for preserving an anonymous memory=
 range across
>> exec(3) using a new madvise MADV_DOEXEC argument.  The primary benefit=
 for
>> sharing memory in this manner, as opposed to re-attaching to a named s=
hared
>> memory segment, is to ensure it is mapped at the same virtual address =
in
>> the new process as it was in the old one.  An intended use for this is=
 to
>> preserve guest memory for guests using vfio while qemu exec's an updat=
ed
>> version of itself.  By ensuring the memory is preserved at a fixed add=
ress,
>> vfio mappings and their associated kernel data structures can remain v=
alid.
>> In addition, for the qemu use case, qemu instances that back guest RAM=
 with
>> anonymous memory can be updated.
>=20
> This will be an amazing attack surface. Perhaps use of this flag should=
 require no_new_privs?  Arguably it should also require a special flag to=
 execve() to honor it.  Otherwise library helpers that do vfork()+exec() =
or posix_spawn() could be quite surprised.

Preservation is disabled across fork, so fork/exec combo's are not affect=
ed.  We forgot to document that.

- Steve
