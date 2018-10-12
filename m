From: Jordan Glover <Golden_Miller83@protonmail.ch>
Subject: Re: [PATCH security-next v5 00/30] LSM: Explict ordering
Date: Fri, 12 Oct 2018 11:31:01 +0000
Message-ID: <oANoEf39nJu-HzALTRaisEW9Um9AoAH5KyO5lM7tpmml58QTZLk7U9aHpTmcg8W_684zTws70sLPZXlK5Z91zLluFesVPYXiEUbIZr98Ljs=@protonmail.ch>
References: <20181011001846.30964-1-keescook@chromium.org>
 <CAGXu5jLBaHj5MhXaK-8zdu6Rgo2B6rEq+at17xZ1Puct+YUajQ@mail.gmail.com>
 <ZhaXhoElmWQlsxHmgFHpB2xSWzJYFZWBasrSKQNjGj4_T2A4AY2F9v1rP9LkUfilUbZ0ExWXX9koLNjUM8S6baX6xfSSMPXY_CpihbCetVc=@protonmail.ch>
 <CAGXu5j+kekUdcE2EhUu__8MXJ1O+D=-zTXLGNCRVa_VyDxePpw@mail.gmail.com>
 <37rRa7F7i2XcwVPiT6gLC8cX8p0732iDiT6mGjstlbBi3mcJsQCLA6A8HcDMNjR0SGheErloJl8z-Z5c57XxtJRBF9-LO_fUTUf41EcAGC4=@protonmail.ch>
 <1a8ac9f4-8f82-5d3b-46ef-08801793443e@canonical.com>
Reply-To: Jordan Glover <Golden_Miller83@protonmail.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1a8ac9f4-8f82-5d3b-46ef-08801793443e@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Johansen <john.johansen@canonical.com>
Cc: Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>, Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Randy Dunlap <rdunlap@infradead.org>, LSM <linux-security-module@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Friday, October 12, 2018 2:26 AM, John Johansen <john.johansen@canonical=
.com> wrote:

> On 10/11/2018 04:53 PM, Jordan Glover wrote:
>
> > =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Origina=
l Message =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=
=90
> > On Friday, October 12, 2018 1:09 AM, Kees Cook keescook@chromium.org wr=
ote:
> >
> > > We've had things sort of like this proposed, but if you can convince
> > > James and others, I'm all for it. I think the standing objection from
> > > James and John about this is that the results of booting with
> > > "lsm=3Dsomething" ends up depending on CONFIG_LSM=3D for that distro.=
 So
> > > you end up with different behaviors instead of a consistent behavior
> > > across all distros.
> >
> > Ok, I'll try :)
> > The final lsm string contains two parts: Kconfig "CONFIG_LSM=3D" and bo=
ot
> > param "lsm=3D". Changing even only one of those parts also changes the
> > final string.
> > In case of distros, it's the "CONFIG_LSM=3D" which changes. Even when "=
lsm=3D"
> > stays constant, the behavior will be different, example:
> > Distro A has: CONFIG_LSM=3Dloadpin,integrity,selinux
> > Distro B has CONFIG_LSM=3Dyama,loadpin,integrity,selinux
> > User on distro A wants to enable apparmor with:
> > lsm=3Dloadpin,integrity,apparmor
> > which they do and add it to howto on wiki.
> > User on distro B want to enable apparmor, they found info on some wiki =
and do:
> > lsm=3Dloadpin,integrity,apparmor
> > Puff, yama got disabled!
> > Above example shows why I think "consistent behavior across all distros=
"
> > argument for current approach is flawed - because distros aren't
> > consistent. In my proposition the user will just use "lsm=3Dapparmor" a=
nd
> > it will consistently enable apparmor on all distros which is what they
> > really wanted, but all pre-existing differences across distros will
> > remain unchanged.
>
> Are you sure about that? I have had more than one question about
> security=3DX resulting in a system with more than just X enabled. Ie why
> is yama enabled when I specifically set security to X.
>

So, non-explicit list will match current "security=3D" behavior which users
are more familiar with. The current answer for this question is "because
your distro enabled it and you didn't disabled it. With non-explcit list
that answer will stay the same.

With explicit list, the question will be "why is yama disabled when I
enabled AppArmor with lsm=3Dapparmor".

To ask both questions user have to know that something like "yama" exist
in first place.

As for question what users typically want you may look at search results
for "disable/enable yama" and "disable/enable apparmor/selinux". The
difference is several orders of magnitude. That's why I think typical user
just want to switch on/off one major lsm. I don't think anecdotal evidence
is representative here.

> There will certainly be cases where what you describe is exactly what
> the user wants. The problem is an explosion of options isn't good
> for the user either.
>
> What I want at the moment is the discussion about different ways to
> enable LSMs to be split off so this work can move forward.
>
> > The current approach requires that everyone who dares to touch "lsm=3D"
> > knows about existence of all lsm, their enabled/disabled status on
> > target distro and their order. I doubt there are many people other
> > than recipients of this mail who fit for the above.
>
> Without having gotten a chance to review the current set of patches
> that was not what was discussed, it should only requires they know the
> set that they want.
>

"it should only requires they know the set that they want" is very
hard requirement and I don't think most users will pass this.
Especially when sets like:

lsm=3Dyama,loadpin,integrity,apparmor
lsm=3Dloadpin,integrity,yama,apparmor

will behave differently.

Jordan
