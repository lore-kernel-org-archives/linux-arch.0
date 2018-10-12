From: Jordan Glover <Golden_Miller83@protonmail.ch>
Subject: Re: [PATCH security-next v5 00/30] LSM: Explict ordering
Date: Fri, 12 Oct 2018 00:11:35 +0000
Message-ID: <32stV62RmME8Dj5jKB8Z03zPe_Et72kMo71D8SpgSOHUo6SaROc8DomMWdk5jDGpyqVd8T63NIIK2NdDw95clpF8Uj47Wca2FBFItXDRh7E=@protonmail.ch>
References: <20181011001846.30964-1-keescook@chromium.org>
 <CAGXu5jLBaHj5MhXaK-8zdu6Rgo2B6rEq+at17xZ1Puct+YUajQ@mail.gmail.com>
 <ZhaXhoElmWQlsxHmgFHpB2xSWzJYFZWBasrSKQNjGj4_T2A4AY2F9v1rP9LkUfilUbZ0ExWXX9koLNjUM8S6baX6xfSSMPXY_CpihbCetVc=@protonmail.ch>
 <CAGXu5j+kekUdcE2EhUu__8MXJ1O+D=-zTXLGNCRVa_VyDxePpw@mail.gmail.com>
 <f68e5f4b-6360-a9e7-597f-89d1d3ca73c1@canonical.com>
Reply-To: Jordan Glover <Golden_Miller83@protonmail.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f68e5f4b-6360-a9e7-597f-89d1d3ca73c1@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Johansen <john.johansen@canonical.com>
Cc: Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>, Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Randy Dunlap <rdunlap@infradead.org>, LSM <linux-security-module@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Friday, October 12, 2018 1:48 AM, John Johansen <john.johansen@canonical=
.com> wrote:

> On 10/11/2018 04:09 PM, Kees Cook wrote:
>
> > On Thu, Oct 11, 2018 at 3:58 PM, Jordan Glover
> > Golden_Miller83@protonmail.ch wrote:
> >
> > > On Thursday, October 11, 2018 7:57 PM, Kees Cook keescook@chromium.or=
g wrote:
> > >
> > > >     To switch to SELinux at boot time with
> > > >     "CONFIG_LSM=3Dyama,loadpin,integrity,apparmor", the old way con=
tinues to
> > > >     work:
> > > >
> > > >     selinux=3D1 security=3Dselinux
> > > >
> > > >     This will work still, since it will enable selinux (selinux=3D1=
) and
> > > >     disable all other major LSMs (security=3Dselinux).
> > > >
> > > >     The new way to enable selinux would be using
> > > >     "lsm=3Dyama,loadpin,integrity,selinux".
> > > >
> > >
> > > It seems to me that legacy way is more user friendly than the new one=
.
> > > AppArmor and SElinux are households names but the rest may be enigmat=
ic
> > > for most users and the need for explicit passing them all may be
> > > troublesome. Especially when the new ones like sara,landlock or cows =
:)
> > > will be incoming. Moreover to knew what you have to pass there, you n=
eed
> > > to look at CONFIG_LSM in kernel config (which will vary across distro=
s
> > > and also mean copy-paste from the web source may won't work as expect=
ed)
> > > which again most users don't do.
> > > I think there is risk that users will end up with "lsm=3Dselinux" wit=
hout
> > > realizing that they may disable something along the way.
> > > I would prefer for "lsm=3D" to work as override to "CONFIG_LSM=3D" wi=
th
> > > below assumptions:
> > > I. lsm=3D"$lsm" will append "$lsm" at the end of string. Before extre=
me
> > > stacking it will also remove the other major (explicit) lsm from it.
> > > II. lsm=3D"!$lsm" will remove "$lsm" from the string.
> > > III. If "$lsm" already exist in the string, it's moved at the end of =
it
> > > (this will cover ordering).
> >
> > We've had things sort of like this proposed, but if you can convince
> > James and others, I'm all for it. I think the standing objection from
> > James and John about this is that the results of booting with
> > "lsm=3Dsomething" ends up depending on CONFIG_LSM=3D for that distro. S=
o
> > you end up with different behaviors instead of a consistent behavior
> > across all distros.
>
> Its certainly a point that could confuse the user. I do have concerns
> about it, but not something that is on a must haves list
>
> > Now, in the future blob and extreme stacking world, having the
> > explicit lsm=3D list shouldn't be too bad since LSMs will effectively
> > ALL be initialized -- but they'll be inactive since they have no
> > policy loaded.
>
> you are more optimistic about this than I am, but there will be at
> least some movement towards this.
>
> > But I still agree with you: I'd like a friendlier way to
> > disable/enable specific LSMs, but an explicit lsm=3D seems to be the
> > only way.
>
> Hrmmm, I don't know about the only way, but a way to provide the
> explicit list, and also set a specific set as the default in the
> Kconfig is a hard requirement.
>

My proposition allows for explicit "lsm=3D" list but also accepts non
explicit list. This is it's advantage above current approach.

The current approach works but it seems to target the very same people
who designed it :)

> The initial lsm.ebable, lsm.disable had too many issues, and for
> various reasons I never managed to get back to kees' proposal
> for using +.
>
> That said, I do think the right approach for the initial pass is
> the explicit list. It moves the arguments to the side and allows
> this work to move forward.
>

I'm afraid when it hits stable kernel and people will rely on it,
then it will be too late. Things will be even more hard to change
than now when we have to keep legacy syntax of security=3Dxxx.

I added explanation why explicit list doesn't solve consistency
across distros in the other reply

> > > It's possible that something lime this was discussed already
> > > but without full examples it was hard to me for tracking things.
> >
> > It's been a painful thread. ;)
>
> Indeed

Jordan
