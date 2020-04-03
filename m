From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 1/4] powerpc/64s: implement probe_kernel_read/write
 without touching AMR
Date: Fri, 03 Apr 2020 21:05:26 +1000
Message-ID: <1585911072.njtr9qmios.astroid@bobo.none>
References: <20200403093529.43587-1-npiggin@gmail.com>
        <558b6131-60b4-98b7-dc40-25d8dacea05a@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40727 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgDCLFk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Apr 2020 07:05:40 -0400
In-Reply-To: <558b6131-60b4-98b7-dc40-25d8dacea05a@c-s.fr>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>, linuxppc-dev@lists.ozlabs.org
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

Christophe Leroy's on April 3, 2020 8:31 pm:
>=20
>=20
> Le 03/04/2020 =C3=A0 11:35, Nicholas Piggin a =C3=A9crit=C2=A0:
>> There is no need to allow user accesses when probing kernel addresses.
>=20
> I just discovered the following commit=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D75a1a607bb7e6d918be3aca11ec2214a275392f4
>=20
> This commit adds probe_kernel_read_strict() and probe_kernel_write_strict=
().
>=20
> When reading the commit log, I understand that probe_kernel_read() may=20
> be used to access some user memory. Which will not work anymore with=20
> your patch.

Hmm, I looked at _strict but obviously not hard enough. Good catch.

I don't think probe_kernel_read() should ever access user memory,
the comment certainly says it doesn't, but that patch sort of implies
that they do.

I think it's wrong. The non-_strict maybe could return userspace data to=20
you if you did pass a user address? I don't see why that shouldn't just=20
be disallowed always though.

And if the _strict version is required to be safe, then it seems like a
bug or security issue to just allow everyone that doesn't explicitly
override it to use the default implementation.

Also, the way the weak linkage is done in that patch, means parisc and
um archs that were previously overriding probe_kernel_read() now get
the default probe_kernel_read_strict(), which would be wrong for them.

>=20
> Isn't it probe_kernel_read_strict() and probe_kernel_write_strict() that=20
> you want to add ?
>=20
>>=20
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>> v2:
>> - Enable for all powerpc (suggested by Christophe)
>> - Fold helper function together (Christophe)
>> - Rename uaccess.c to maccess.c to match kernel/maccess.c.
>>=20
>>   arch/powerpc/include/asm/uaccess.h | 25 +++++++++++++++-------
>>   arch/powerpc/lib/Makefile          |  2 +-
>>   arch/powerpc/lib/maccess.c         | 34 ++++++++++++++++++++++++++++++
>=20
> x86 does it in mm/maccess.c

Yeah I'll fix that up, thanks.

Thanks,
Nick
=
