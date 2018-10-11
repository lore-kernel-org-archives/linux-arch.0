From: Jordan Glover <Golden_Miller83@protonmail.ch>
Subject: Re: [PATCH security-next v5 00/30] LSM: Explict ordering
Date: Thu, 11 Oct 2018 23:53:50 +0000
Message-ID: <37rRa7F7i2XcwVPiT6gLC8cX8p0732iDiT6mGjstlbBi3mcJsQCLA6A8HcDMNjR0SGheErloJl8z-Z5c57XxtJRBF9-LO_fUTUf41EcAGC4=@protonmail.ch>
References: <20181011001846.30964-1-keescook@chromium.org>
 <CAGXu5jLBaHj5MhXaK-8zdu6Rgo2B6rEq+at17xZ1Puct+YUajQ@mail.gmail.com>
 <ZhaXhoElmWQlsxHmgFHpB2xSWzJYFZWBasrSKQNjGj4_T2A4AY2F9v1rP9LkUfilUbZ0ExWXX9koLNjUM8S6baX6xfSSMPXY_CpihbCetVc=@protonmail.ch>
 <CAGXu5j+kekUdcE2EhUu__8MXJ1O+D=-zTXLGNCRVa_VyDxePpw@mail.gmail.com>
Reply-To: Jordan Glover <Golden_Miller83@protonmail.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGXu5j+kekUdcE2EhUu__8MXJ1O+D=-zTXLGNCRVa_VyDxePpw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: James Morris <jmorris@namei.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Randy Dunlap <rdunlap@infradead.org>, LSM <linux-security-module@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Friday, October 12, 2018 1:09 AM, Kees Cook <keescook@chromium.org> wrot=
e:

> We've had things sort of like this proposed, but if you can convince
> James and others, I'm all for it. I think the standing objection from
> James and John about this is that the results of booting with
> "lsm=3Dsomething" ends up depending on CONFIG_LSM=3D for that distro. So
> you end up with different behaviors instead of a consistent behavior
> across all distros.
>

Ok, I'll try :)

The final lsm string contains two parts: Kconfig "CONFIG_LSM=3D" and boot
param "lsm=3D". Changing even only one of those parts also changes the
final string.

In case of distros, it's the "CONFIG_LSM=3D" which changes. Even when "lsm=
=3D"
stays constant, the behavior will be different, example:

Distro A has: CONFIG_LSM=3Dloadpin,integrity,selinux
Distro B has CONFIG_LSM=3Dyama,loadpin,integrity,selinux

User on distro A wants to enable apparmor with:

lsm=3Dloadpin,integrity,apparmor

which they do and add it to howto on wiki.

User on distro B want to enable apparmor, they found info on some wiki and =
do:

lsm=3Dloadpin,integrity,apparmor


Puff, yama got disabled!

Above example shows why I think "consistent behavior across all distros"
argument for current approach is flawed -  because distros aren't
consistent. In my proposition the user will just use "lsm=3Dapparmor" and
it will consistently enable apparmor on all distros which is what they
really wanted, but all pre-existing differences across distros will
remain unchanged.

The current approach requires that everyone who dares to touch "lsm=3D"
knows about existence of all lsm, their enabled/disabled status on
target distro and their order. I doubt there are many people other
than recipients of this mail who fit for the above.

I it's better to assume that average user has rather vague knowledge
about lsm and don't delve deep into Kconfig's of their chosen distro.
If they want to use "lsm=3D" their goal is to disable/enable on or more
things. My proposition will work better for those. More advanced users
still will may pass any "lsm=3D" string as they like, this having full
control.

Jordan
