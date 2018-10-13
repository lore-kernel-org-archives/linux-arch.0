Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-by2nam01on0087.outbound.protection.outlook.com ([104.47.34.87]:28574
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726163AbeJMVUa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 13 Oct 2018 17:20:30 -0400
From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH v9 00/24] ILP32 for ARM64
Date: Sat, 13 Oct 2018 13:43:12 +0000
Message-ID: <20181013134303.GA12721@yury-thinkpad>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
 <20180724173957.GA22106@yury-thinkpad>
 <20181010141017.GA2881@asgard.redhat.com>
 <20181010153655.GA212880@arrakis.emea.arm.com>
 <20181013021416.GE21972@asgard.redhat.com>
 <20181013093411.o3id6yzkspsxr5jt@mbp>
In-Reply-To: <20181013093411.o3id6yzkspsxr5jt@mbp>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <93FE0310E155A04AA98A37E4988E636C@namprd07.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Eugene Syromiatnikov <esyr@redhat.com>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Palmer Dabbelt <palmer@sifive.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Pavel Machek <pavel@ucw.cz>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Joseph Myers <joseph@codesourcery.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "Ellcey, Steve" <Steve.Ellcey@cavium.com>, "Kapoor, Prasun" <Prasun.Kapoor@cavium.com>, Andreas Schwab <schwab@suse.de>, Alexander Graf <agraf@suse.de>, Bamvor Zhangjian <bamv2005@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Dave Martin <Dave.Martin@arm.com>, Adam Borowski <kilobyte@angband.pl>, Manuel Montezelo <manuel.montezelo@gmail.com>, James Hogan <james.hogan@imgtec.com>, Chris Metcalf <cmetcalf@mellanox.com>, Arnd Bergmann <arnd@arndb.de>, Andrew Pinski <pinskia@gmail.com>, Lin Yongting <linyongting@huawei.com>, Alexey Klimov <klimov.linux@gmail.com>, Wookey <wookey@wookware.org>, Mark Brown <broonie@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>, Florian Weimer <fweimer@redhat.com>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, Nathan_Lynch <Nathan_Lynch@mentor.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, James Morse <james.morse@arm.com>, Ramana Radhakrishnan <ramana.gcc@googlemail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, "David S . Miller" <davem@davemloft.net>, Christoph Muellner <christoph.muellner@theobroma-systems.com>
Message-ID: <20181013134312.reGgp9e0vhKu6N0BsihFBtfMN30E--8qXra1zfsneGg@z>

On Sat, Oct 13, 2018 at 10:34:11AM +0100, Catalin Marinas wrote:
>=20
> Lines: 73
>=20
> External Email
>=20
> On Sat, Oct 13, 2018 at 04:14:16AM +0200, Eugene Syromiatnikov wrote:
> > On Wed, Oct 10, 2018 at 04:36:56PM +0100, Catalin Marinas wrote:
> > > On Wed, Oct 10, 2018 at 04:10:21PM +0200, Eugene Syromiatnikov wrote:
> > > > I have some questions regarding AArch64 ILP32 implementation for wh=
ich I
> > > > failed to find an answer myself:
> > > >  * How ptrace() tracer is supposed to distinguish between ILP32 and=
 LP64
> > > >    tracees? For MIPS N32 and x32 this is possible based on syscall
> > > >    number, but for AArch64 ILP32 I do not see such a sign. There's =
also
> > > >    ARM_ip is employed for signalling entering/exiting, I wonder whe=
ther
> > > >    it's possible to employ it also for signalling tracee's personal=
ity.
> > >
> > > With the current implementation, I don't think you can distinguish. F=
rom
> > > the kernel perspective, the register set is the same. What is the
> > > use-case for this?
> >
> > Err, a ptrace()-based tracer trying to trace a process, for example?
>=20
> I first thought it wouldn't matter for ptrace-based tracers since the
> syscall numbers are (mostly) the same. But the arguments layout in
> register is indeed different, so I see your point now about having to
> distinguish.
>=20
> > > We could add a new regset to expose the ILP32 state (NT_ARM_..., I ca=
n't
> > > think of a name now but probably not PER* as this implies PER_LINUX_.=
..
> > > which is independent from TIF_32BIT_*).
> >
> > So that would require an additional ptrace() call on each syscall stop,
> > is that correct?
>=20
> The ILP32 state does not change at run-time, so it could only do a
> ptrace() call once and save the information. No need to re-read it on
> each syscall stop.
>=20
> We could set a high bit in the syscall number reported to the ptrace
> caller (though not changing the syscall ABI) but I haven't thought of
> other consequences. For example, can the ptrace caller change the
> syscall number?

I believe, /proc/PID/auxv is enough to distinguish between arm64, ilp32
and aarch32 ABis. If no, I think it's better to do it there.

I don't have ILP32 machine available at the moment, but I'll check it soon.=
=20

> > > >  * What's the reasoning behind capping syscall arguments to 32 bit?=
 x32
> > > >    and MIPS N32 do not have such a restriction (and do not need spe=
cial
> > > >    wrappers for syscalls that pass 64-bit values as a result, excep=
t
> > > >    when they do,  as it is the case for preadv2 on x32); moreover, =
that
> > > >    would lead to insurmountable difficulties for AArch64 ILP32 trac=
ers
> > > >    that try to trace LP64 tracees, as it would be impossible to pas=
s
> > > >    64-bit addresses to process_vm_{read,write} or ptrace PEEK/POKE.
> > >
> > > We've attempted in earlier versions to allow a mix of 32 and 64-bit
> > > register values from ILP32 but it got pretty complicated. The entry c=
ode
> > > would need to know which registers need zeroing of the top 32-bit
> >
> > If kernel specifies 64-bit wide registers for syscalls, then it's the
> > caller's (libc's) responsibility to properly sign-extend arguments when
> > needed, and glibc, for example, already has proper type definitions tha=
t
> > aimed to handle this.
>=20
> We tried, see my other reply.

A couple of links to recall the story:
https://www.spinics.net/lists/linux-s390/msg11593.html
http://linux-kernel.2935.n7.nabble.com/RFC6-PATCH-v6-00-21-ILP32-for-ARM64-=
td1345105.html

Cover-letter of the series has links to previous discussions.

I would also notice that even if we pass 64-bit parameters in a single
register, we cannot avoid using the compat layer. It looks more natural
not to split the 64-bit register, but from performance point of view
there is almost no difference, either we split registers or not (2.6%
for empty syscall, as I measured). And the cost of overcomplication was
considered too much. So we chose to stick to more standard compat layer
and gain in maintainability.=20

Yury
