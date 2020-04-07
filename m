From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 1/4] powerpc/64s: implement probe_kernel_read/write
 without touching AMR
Date: Tue, 07 Apr 2020 14:01:18 +1000
Message-ID: <1586230235.0xvc3pjkcj.astroid@bobo.none>
References: <20200403093529.43587-1-npiggin@gmail.com>
        <558b6131-60b4-98b7-dc40-25d8dacea05a@c-s.fr>
        <1585911072.njtr9qmios.astroid@bobo.none>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40909 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgDGECs (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Apr 2020 00:02:48 -0400
In-Reply-To: <1585911072.njtr9qmios.astroid@bobo.none>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>, linuxppc-dev@lists.ozlabs.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org

Nicholas Piggin's on April 3, 2020 9:05 pm:
> Christophe Leroy's on April 3, 2020 8:31 pm:
>>=20
>>=20
>> Le 03/04/2020 =C3=A0 11:35, Nicholas Piggin a =C3=A9crit=C2=A0:
>>> There is no need to allow user accesses when probing kernel addresses.
>>=20
>> I just discovered the following commit=20
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commi=
t/?id=3D75a1a607bb7e6d918be3aca11ec2214a275392f4
>>=20
>> This commit adds probe_kernel_read_strict() and probe_kernel_write_stric=
t().
>>=20
>> When reading the commit log, I understand that probe_kernel_read() may=20
>> be used to access some user memory. Which will not work anymore with=20
>> your patch.
>=20
> Hmm, I looked at _strict but obviously not hard enough. Good catch.
>=20
> I don't think probe_kernel_read() should ever access user memory,
> the comment certainly says it doesn't, but that patch sort of implies
> that they do.
>=20
> I think it's wrong. The non-_strict maybe could return userspace data to=20
> you if you did pass a user address? I don't see why that shouldn't just=20
> be disallowed always though.
>=20
> And if the _strict version is required to be safe, then it seems like a
> bug or security issue to just allow everyone that doesn't explicitly
> override it to use the default implementation.
>=20
> Also, the way the weak linkage is done in that patch, means parisc and
> um archs that were previously overriding probe_kernel_read() now get
> the default probe_kernel_read_strict(), which would be wrong for them.

The changelog in commit 75a1a607bb7 makes it a bit clearer. If the
non-_strict variant is used on non-kernel addresses, then it might not=20
return -EFAULT or it might cause a kernel warning. The _strict variant=20
is supposed to be usable with any address and it will return -EFAULT if=20
it was not a valid and mapped kernel address.

The non-_strict variant can not portably access user memory because it
uses KERNEL_DS, and its documentation says its only for kernel pointers.
So powerpc should be fine to run that under KUAP AFAIKS.

I don't know why the _strict behaviour is not just made default, but
the implementation of it does seem to be broken on the archs that
override the non-_strict variant.

Thanks,
Nick
=
