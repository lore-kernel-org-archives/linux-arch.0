From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH v2 01/17] asm: simd context helper API
Date: Sun, 26 Aug 2018 07:18:52 -0700
Message-ID: <2532E417-DDD2-4E2C-9F21-3B8D9B96370D@amacapital.net>
References: <20180824213849.23647-1-Jason@zx2c4.com> <20180824213849.23647-2-Jason@zx2c4.com> <alpine.DEB.2.21.1808261234240.1195@nanos.tec.linutronix.de> <CAHmME9qrc_f6uqGOrRVpnO_sTXHg2cg-WwWg4ik3yqu=HCOZSg@mail.gmail.com> <alpine.DEB.2.21.1808261602250.1195@nanos.tec.linutronix.de>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.21.1808261602250.1195@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, LKML <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, Andrew Lutomirski <luto@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Samuel Neves <sneves@dei.uc.pt>, linux-arch@vger.kernel.org, Rik van Riel <riel@surriel.com>
List-Id: linux-arch.vger.kernel.org



> On Aug 26, 2018, at 7:06 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> Jason,
>=20
>> On Sun, 26 Aug 2018, Jason A. Donenfeld wrote:
>>> On Sun, Aug 26, 2018 at 6:10 AM Thomas Gleixner <tglx@linutronix.de> wro=
te:
>>> I'm not too fond of this simply because it requires that relax() step in=

>>> all code pathes. I'd rather make that completely transparent by just
>>> marking the task as FPU using and let the context switch code deal with i=
t
>>> in case that it gets preempted. I'll let one of my engineers look into
>>> that next week.
>>=20
>> Do you mean to say you intend to make kernel_fpu_end() and
>> kernel_neon_end() only actually do something upon context switch, but
>> not when it's actually called? So that multiple calls to
>> kernel_fpu_begin() and kernel_neon_begin() can be made without
>> penalty?
>=20
> On context switch and exit to user. That allows to keep those code pathes
> fully preemptible. Still twisting my brain around the details.

I think you=E2=80=99ll have to treat exit to user and context switch as diff=
erent things. For exit to user, we want to restore the *user* state, but, fo=
r context switch, we=E2=80=99ll need to restore *kernel* state.

Do user first as its own patch set. It=E2=80=99ll be less painful that way.

And someone needs to rework PKRU for this to make sense. See previous thread=
s.
