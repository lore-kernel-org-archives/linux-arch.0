From: Will Deacon <will.deacon@arm.com>
Subject: Re: [gcv v3 27/35] arm: Replace __get_cpu_var uses
Date: Wed, 4 Sep 2013 10:33:35 +0100
Message-ID: <20130904093335.GA8007@mudshark.cambridge.arm.com>
References: <20130828193457.140443630@linux.com>
 <00000140c67834c9-cc2bec76-2d70-48d1-a35b-6e2d5dedf22b-000000@email.amazonses.com>
 <20130830100105.GF25628@mudshark.cambridge.arm.com>
 <00000140e4440576-ae4236ee-3073-4f94-b569-d17396e57513-000000@email.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <00000140e4440576-ae4236ee-3073-4f94-b569-d17396e57513-000000@email.amazonses.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Lameter <cl@linux.com>
Cc: Tejun Heo <tj@kernel.org>, "akpm@linuxfoundation.org" <akpm@linuxfoundation.org>, Russell King <linux@arm.linux.org.uk>, Catalin Marinas <Catalin.Marinas@arm.com>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, Steven Rostedt <srostedt@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Hi Christoph,

On Tue, Sep 03, 2013 at 03:39:57PM +0100, Christoph Lameter wrote:
> On Fri, 30 Aug 2013, Will Deacon wrote:
> > ...so I don't think this is quite right, and indeed, we get a bunch=
 of errors
> > from GCC:
> >
> > arch/arm/kernel/hw_breakpoint.c: In function =E2=80=98arch_install_=
hw_breakpoint=E2=80=99:
> > arch/arm/kernel/hw_breakpoint.c:347:33: error: incompatible types w=
hen assigning to type =E2=80=98struct perf_event *[16]=E2=80=99 from ty=
pe =E2=80=98struct perf_event **=E2=80=99
> > arch/arm/kernel/hw_breakpoint.c:347:1: error: incompatible types wh=
en assigning to type =E2=80=98struct perf_event *[16]=E2=80=99 from typ=
e =E2=80=98struct perf_event **=E2=80=99
> > arch/arm/kernel/hw_breakpoint.c:347:1: error: incompatible types wh=
en assigning to type =E2=80=98struct perf_event *[16]=E2=80=99 from typ=
e =E2=80=98struct perf_event **=E2=80=99
> > arch/arm/kernel/hw_breakpoint.c:347:1: error: incompatible types wh=
en assigning to type =E2=80=98struct perf_event *[16]=E2=80=99 from typ=
e =E2=80=98struct perf_event **=E2=80=99
>=20
> Did you apply the first patch of this series which is a bug fix?

No, sorry, I didn't see that. Do you have a branch anywhere that I can =
play
with?

> > changing to match your recipe still doesn't work, however:
> >
> > arch/arm/kernel/hw_breakpoint.c: In function =E2=80=98arch_install_=
hw_breakpoint=E2=80=99:
> > arch/arm/kernel/hw_breakpoint.c:347:33: error: cast specifies array=
 type
>=20
> Yep that is the macro bug that was fixed in the first patch.

Ok. Sorry for the noise.

> > >
> > >         WARN_ON(preemptible());
> > >
> > > -       if (local_inc_return(&__get_cpu_var(mde_ref_count)) =3D=3D=
 1)
> > > +       if (this_cpu_inc_return(mde_ref_count) =3D=3D 1)
> > >                 enable =3D DBG_MDSCR_MDE;
> >
> > I'm not sure that this is safe. We rely on local_inc_return to be a=
tomic
> > with respect to the current CPU, which will end up being a wrapper =
around
> > atomic64_inc_return. However, this_cpu_inc_return simply uses a loc=
k, so
> > other people accessing the count in a different manner (local_dec_a=
nd_test
> > below) may break local atomicity unless we start disabling interrup=
ts or
> > something horrible like that.
>=20
> I do not see any special code for ARM for this_cpu_inc_return. The
> fallback solution in the core code is to disable interrupts for the
> inc_return and arch/arm/include/asm/percpu.h includes
> asm-generic/percpu.h.
>=20
> Where did you see it using a lock?

God knows! You're completely right, and we simply disable interrupts wh=
ich I
somehow misread as taking a lock. However, is it guaranteed that mixing
an atomic64_* access with a this_cpu_inc_return will retain atomicity
between the two? E.g. if you get interrupted during an atomic64_xchg
operation, the interrupt handler issues this_cpu_inc_return, then on re=
turn
to the xchg operation it must reissue any reads that had been executed
prior to the interrupt. This should work on ARM/ARM64 (returning from t=
he
interrupt will clear the exclusive monitor) but I don't know about othe=
r
architectures.

Will
