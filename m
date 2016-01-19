From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 2/2] kbuild: Remove stale asm-generic wrappers
Date: Tue, 19 Jan 2016 15:09:14 +0100
Message-ID: <1667268.iM977TQnEK@wuerfel>
References: <1453210670-12596-1-git-send-email-james.hogan@imgtec.com> <1453210670-12596-3-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1453210670-12596-3-git-send-email-james.hogan@imgtec.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: James Hogan <james.hogan@imgtec.com>
Cc: Michal Marek <mmarek@suse.com>, linux-kernel@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>, Florian Fainelli <f.fainelli@gmail.com>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, linux-mips@linux-mips.org
List-Id: linux-arch.vger.kernel.org

On Tuesday 19 January 2016 13:37:50 James Hogan wrote:
> When a header file is removed from generic-y (often accompanied by th=
e
> addition of an arch specific header), the generated wrapper file will
> persist, and in some cases may still take precedence over the new arc=
h
> header.
>=20
> For example commit f1fe2d21f4e1 ("MIPS: Add definitions for extended
> context") removed ucontext.h from generic-y in arch/mips/include/asm/=
,
> and added an arch/mips/include/uapi/asm/ucontext.h. The continued use=
 of
> the wrapper when reusing a dirty build tree resulted in build failure=
s
> in arch/mips/kernel/signal.c:
>=20
> arch/mips/kernel/signal.c: In function =E2=80=98sc_to_extcontext=E2=80=
=99:
> arch/mips/kernel/signal.c:142:12: error: =E2=80=98struct ucontext=E2=80=
=99 has no member named =E2=80=98uc_extcontext=E2=80=99
>   return &uc->uc_extcontext;
>             ^
>=20
> Fix by detecting and removing wrapper headers in generated header
> directories that do not correspond to a filename in generic-y, genhdr=
-y,
> or the newly introduced generated-y.

Good idea.

Acked-by: Arnd Bergmann <arnd@arndb.de>

Can you merge this through the mips tree, or do you need me to pick it
up through asm-generic?
--
To unsubscribe from this list: send the line "unsubscribe linux-kbuild"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
