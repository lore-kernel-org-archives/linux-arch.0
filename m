From: Jordan Glover <Golden_Miller83@protonmail.ch>
Subject: Re: [PATCH security-next v5 00/30] LSM: Explict ordering
Date: Thu, 11 Oct 2018 22:58:21 +0000
Message-ID: <ZhaXhoElmWQlsxHmgFHpB2xSWzJYFZWBasrSKQNjGj4_T2A4AY2F9v1rP9LkUfilUbZ0ExWXX9koLNjUM8S6baX6xfSSMPXY_CpihbCetVc=@protonmail.ch>
References: <20181011001846.30964-1-keescook@chromium.org>
 <CAGXu5jLBaHj5MhXaK-8zdu6Rgo2B6rEq+at17xZ1Puct+YUajQ@mail.gmail.com>
Reply-To: Jordan Glover <Golden_Miller83@protonmail.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGXu5jLBaHj5MhXaK-8zdu6Rgo2B6rEq+at17xZ1Puct+YUajQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: James Morris <jmorris@namei.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Randy Dunlap <rdunlap@infradead.org>, LSM <linux-security-module@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Thursday, October 11, 2018 7:57 PM, Kees Cook <keescook@chromium.org> wr=
ote:

> On Wed, Oct 10, 2018 at 5:18 PM, Kees Cook keescook@chromium.org wrote:
>
> > v5:
> >
> > -   redesigned to use CONFIG_LSM=3D and lsm=3D for both ordering and en=
abling
> > -   dropped various Reviewed-bys due to rather large refactoring
>
> Here's a tl;dr of the behavioral changes...
>
> Right now, we have:
>
> -   hard-coded special LSM: capability which cannot be disabled.
> -   hard-coded "minor" LSMs: they are enabled in a static order based on
>     whether they are built into the kernel or not: yama, loadpin.
>
> -   a single LSM without a specified order because it only uses the
>     early-init position: integrity.
>
> -   "major" LSMs that are selected via CONFIG_DEFAULT_SECURITY=3D or
>     "security=3D" boot param.
>
> -   SELinux and AppArmor each can enable/disable themselves via
>     CONFIG_..._BOOTPARAM_VALUE=3D and selinux=3D/apparmor=3D.
>
>     So, right now, systems will have all the minor LSMs and integrity
>     initialized if they are built into the kernel without any way to
>     control their order or disable them at boot time. To select a major
>     LSM, the pattern is:
>
>     selinux=3D1 security=3Dselinux
>
>     Note that both are used here because if you built with
>     CONFIG_SELINUX_BOOTPARAM_VALUE=3D0 and CONFIG_DEFAULT_SECURITY=3Dappa=
rmor,
>     just booting with "security=3Dselinux" just disables AppArmor but
>     SELinux stays disabled. So the documented way to switch majors is wit=
h
>     "selinux=3D1 security=3Dselinux". However Tomoyo and Smack do not hav=
e
>     separate enable/disable logic. They will work fine with just
>     "security=3Dsmack".
>
>     Now, in order to gain arbitrary LSM ordering, this series introduces
>     CONFIG_LSM=3D (to replace CONFIG_DEFAULT_SECURITY=3D) and "lsm=3D" (t=
o
>     replace "security=3D"). Note that "security=3D" has not been removed =
-- it
>     will still work. Mixing it with "lsm=3D" can lead to situations where
>     "security=3D" becomes effectively ignored, though.
>
>     In the rest of this I'm going to ignore capability: it will always be
>     first and it will always be enabled.
>
>     Assuming that all LSMs are built in (e.g. yama, loadpin, selinux,
>     smack, tomoyo, apparmor, integrity), here are the changes:
>
>     To choose the "default major LSM" of AppArmor before:
>     CONFIG_DEFAULT_SECURITY=3Dapparmor
>
>     To choose the "default major LSM" of AppArmor without extreme stackin=
g now:
>     CONFIG_LSM=3Dyama,loadpin,integrity,apparmor
>
>     To choose the "default major LSM" of AppArmor with future extreme sta=
cking now:
>     CONFIG_LSM=3Dyama,loadpin,integrity,apparmor,tomoyo,selinux,smack
>
>     Whichever exclusive LSM is listed first will be the first to attempt
>     initialization. Any non-conflicting LSMs following it will initialize
>     too.
>
>     This means a distro can disable the "blob-sharing" behavior by just
>     providing a CONFIG_LSM=3D that includes a single major LSM.
>
>     To switch to SELinux at boot time with
>     "CONFIG_LSM=3Dyama,loadpin,integrity,apparmor", the old way continues=
 to
>     work:
>
>     selinux=3D1 security=3Dselinux
>
>     This will work still, since it will enable selinux (selinux=3D1) and
>     disable all other major LSMs (security=3Dselinux).
>
>     The new way to enable selinux would be using
>     "lsm=3Dyama,loadpin,integrity,selinux".
>

It seems to me that legacy way is more user friendly than the new one.
AppArmor and SElinux are households names but the rest may be enigmatic
for most users and the need for explicit passing them all may be
troublesome. Especially when the new ones like sara,landlock or cows :)
will be incoming. Moreover to knew what you have to pass there, you need
to look at CONFIG_LSM in kernel config (which will vary across distros
and also mean copy-paste from the web source may won't work as expected)
which again most users don't do.

I think there is risk that users will end up with "lsm=3Dselinux" without
realizing that they may disable something along the way.

I would prefer for "lsm=3D" to work as override to "CONFIG_LSM=3D" with
below assumptions:

I. lsm=3D"$lsm" will append "$lsm" at the end of string. Before extreme
stacking it will also remove the other major (explicit) lsm from it.

II. lsm=3D"!$lsm" will remove "$lsm" from the string.

III. If "$lsm" already exist in the string, it's moved at the end of it
(this will cover ordering).

Examples:

1. Without extreme stacking.

a) Enable selinux, disable apparmor and leave the rest untouched.

CONFIG_LSM=3Dyama,loadpin,integrity,apparmor && lsm=3Dselinux =3D yama,load=
pin,integrity,selinux

b) Enable selinux, disable apparmor and disable loadpin.

CONFIG_LSM=3Dyama,loadpin,integrity,apparmor && lsm=3Dselinux,!loadpin =3D =
yama,integrity,selinux


2. With extreme stacking.

a) Enable selinux, disable apparmor and leave the rest untouched.

CONFIG_LSM=3Dyama,loadpin,integrity,apparmor && lsm=3Dselinux,!apparmor =3D=
 yama,loadpin,integrity,selinux

b) Enable selinux, disable apparmor and disable loadpin.

CONFIG_LSM=3Dyama,loadpin,integrity,apparmor && lsm=3Dselinux,!apparmor,!lo=
adpin =3D yama,integrity,selinux

c) Enable selinux and order it after apparmor.

CONFIG_LSM=3Dyama,loadpin,integrity,apparmor && lsm=3Dselinux =3D yama,load=
pin,integrity,apparmor,selinux

d) Enable selinux and order it before apparmor.

CONFIG_LSM=3Dyama,loadpin,integrity,apparmor && lsm=3Dselinux,apparmor =3D =
yama,loadpin,integrity,selinux,apparmor


IMO above will be easier to handle for users. At worst case with
full ordering all existing lsm's it will look the same as what
Kees proposes but I assume that ordering is rather for more
advanced people.

It's possible that something lime this was discussed already
but without full examples it was hard to me for tracking things.

Jordan
