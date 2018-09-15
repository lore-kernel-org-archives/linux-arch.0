From: Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH net-next v3 01/17] asm: simd context helper API
Date: Sat, 15 Sep 2018 12:58:21 -0700
Message-ID: <61B4DFD6-9BB5-4B81-BD0E-ACF112EA8AF7@amacapital.net>
References: <20180911010838.8818-1-Jason@zx2c4.com> <20180911010838.8818-2-Jason@zx2c4.com> <20180912061433.GA8484@ip-172-31-15-78> <CAHmME9pmgu_xWJ0rvdS4RhzwjKPiNdkQ9nc6mqTNeb6A8xT8Eg@mail.gmail.com> <20180913050301.GA26367@ip-172-31-15-78> <CAHmME9rMg_2eHBnfP6j9Y3O7-At90HF=ToTWeFL_Qc4nGURORg@mail.gmail.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHmME9rMg_2eHBnfP6j9Y3O7-At90HF=ToTWeFL_Qc4nGURORg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: kevin@guarana.org, Andrew Lutomirski <luto@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, Samuel Neves <sneves@dei.uc.pt>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


> On Sep 13, 2018, at 6:52 AM, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>=20
>> On Thu, Sep 13, 2018 at 7:03 AM Kevin Easton <kevin@guarana.org> wrote:
>> Yes.  It's also how most get/put APIs already work in the kernel, eg
>> kref_get/put (mostly because they tend to be 'getting/putting' an
>> already-initialized object, though).
>=20
> Right; in this case the object wouldn't be initialized yet, which
> might defeat the purpose, since one advantage of the & way you
> mentioned is _put modifies the context.
>=20
> Andy - any opinions on this? The tl;dr is:
>=20
> 1) what we have now:
>=20
> simd_context_t simd_context =3D simd_get();
> for (item in items) {
>    do_something(item);
>    simd_context =3D simd_relax(simd_context);
> }
> simd_put();
>=20
> 2) what kevin is proposing:
>=20
> simd_context_t simd_context;
>=20
> simd_get(&simd_context);
> for (item in items) {
>    do_something(item);
>    simd_relax(&simd_context);
> }
> simd_put(&simd_context);
>=20
> I can see pros and cons of each approach.

I have no strong opinion, except that, if you paint the bikeshed =E2=80=9Cpa=
ss by value=E2=80=9D, then simd_get and simd_relax should probably have warn=
_unused_result set.=
