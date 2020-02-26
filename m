Return-Path: <SRS0=oITL=4O=vger.kernel.org=linux-doc-owner@kernel.org>
MIME-Version: 1.0
References: <20200224160215.4136-1-mic@digikod.net> <20200224160215.4136-6-mic@digikod.net>
In-Reply-To: <20200224160215.4136-6-mic@digikod.net>
From: Jann Horn <jannh@google.com>
Date: Wed, 26 Feb 2020 21:29:18 +0100
Message-ID: <CAG48ez36SMrPPgsj0omcVukRLwOzBzqWOQjuGCmmmrmsGiNukw@mail.gmail.com>
Subject: Re: [RFC PATCH v14 05/10] fs,landlock: Support filesystem access-control
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-doc-owner@vger.kernel.org
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: kernel list <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Andy Lutomirski <luto@amacapital.net>, Arnd Bergmann <arnd@arndb.de>, Casey Schaufler <casey@schaufler-ca.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, James Morris <jmorris@namei.org>, Jann Horn <jann@thejh.net>, Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>, Michael Kerrisk <mtk.manpages@gmail.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mickael.salaun@ssi.gouv.fr>, "Serge E . Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, Vincent Dagonneau <vincent.dagonneau@ssi.gouv.fr>, Kernel Hardening <kernel-hardening@lists.openwall.com>, Linux API <linux-api@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-doc@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, linux-security-module <linux-security-module@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200226202918.z9XW7ovmRlgFUA0YsXqdac1F3N2Is2Q3Zof4NOclS5k@z>

On Mon, Feb 24, 2020 at 5:03 PM Micka=C3=ABl Sala=C3=BCn <mic@digikod.net> =
wrote:
> +static inline u32 get_mem_access(unsigned long prot, bool private)
> +{
> +       u32 access =3D LANDLOCK_ACCESS_FS_MAP;
> +
> +       /* Private mapping do not write to files. */
> +       if (!private && (prot & PROT_WRITE))
> +               access |=3D LANDLOCK_ACCESS_FS_WRITE;
> +       if (prot & PROT_READ)
> +               access |=3D LANDLOCK_ACCESS_FS_READ;
> +       if (prot & PROT_EXEC)
> +               access |=3D LANDLOCK_ACCESS_FS_EXECUTE;
> +       return access;
> +}

When I do the following, is landlock going to detect that the mmap()
is a read access, or is it incorrectly going to think that it's
neither read nor write?

$ cat write-only.c
#include <fcntl.h>
#include <sys/mman.h>
#include <stdio.h>
int main(void) {
  int fd =3D open("/etc/passwd", O_RDONLY);
  char *ptr =3D mmap(NULL, 0x1000, PROT_WRITE, MAP_PRIVATE, fd, 0);
  printf("'%.*s'\n", 4, ptr);
}
$ gcc -o write-only write-only.c -Wall
$ ./write-only
'root'
$
