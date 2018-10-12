From: Jordan Glover <Golden_Miller83@protonmail.ch>
Subject: Re: [PATCH security-next v5 00/30] LSM: Explict ordering
Date: Fri, 12 Oct 2018 11:31:13 +0000
Message-ID: <_CkJnKYmEZ4ZF0JtsSYuahAd9sgnX9OtcstjXaeqb8wn5uxfimc6S4jomly7If9VqnOXqXwaiCbJ9ttS6NiqE7n6cQUlwLvfO53paLmacvU=@protonmail.ch>
References: <20181011001846.30964-1-keescook@chromium.org>
 <CAGXu5jLBaHj5MhXaK-8zdu6Rgo2B6rEq+at17xZ1Puct+YUajQ@mail.gmail.com>
 <ZhaXhoElmWQlsxHmgFHpB2xSWzJYFZWBasrSKQNjGj4_T2A4AY2F9v1rP9LkUfilUbZ0ExWXX9koLNjUM8S6baX6xfSSMPXY_CpihbCetVc=@protonmail.ch>
 <CAGXu5j+kekUdcE2EhUu__8MXJ1O+D=-zTXLGNCRVa_VyDxePpw@mail.gmail.com>
 <f68e5f4b-6360-a9e7-597f-89d1d3ca73c1@canonical.com>
 <32stV62RmME8Dj5jKB8Z03zPe_Et72kMo71D8SpgSOHUo6SaROc8DomMWdk5jDGpyqVd8T63NIIK2NdDw95clpF8Uj47Wca2FBFItXDRh7E=@protonmail.ch>
 <38dde301-d77e-35fd-88d4-5cdc5b570ee8@canonical.com>
Reply-To: Jordan Glover <Golden_Miller83@protonmail.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <38dde301-d77e-35fd-88d4-5cdc5b570ee8@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Johansen <john.johansen@canonical.com>
Cc: Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>, Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Randy Dunlap <rdunlap@infradead.org>, LSM <linux-security-module@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

Sent with ProtonMail Secure Email.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Friday, October 12, 2018 3:19 AM, John Johansen <john.johansen@canonical=
.com> wrote:
>
> It isn't perfect but it manages consistency across distros as best as
> can be achieved atm.
>
> Its just a fact that some LSMs are not going to be built into some
> kernels. The only way to deal with that is direct people to build
> their own kernels.
>
> The other major problem is that the current LSM stacking patches do
> not deal with "extreme" stacking. So doing
>
> lsm=3D+apparmor
>
> (I am going to stick with the + syntax atm to avoid confusion between
> adding and setting)
>
> assuming apparmor is builtin will not necessarily get you apparmor if
> another major lsm is enabled. Yes your specific proposal would as it
> specifies it overrides the current major, except that ordering
> important so if say landlock registers before apparmor, you may still
> not get apparmor.
>

I think this will be solved with LSM_ORDER_LAST or something like that
Kees proposed.

> You proposal does not provide a means to ensure you have only a
> specific set of LSMs enabled. As an LSM not explicitly listed in lsm=3D
> lsm=3D! may still be enabled. So the user is going to have to be aware
> of the initial LSMs list if they are trying to guarentee a specific
> security arrangement.
>

What about special marker like "!!" which will mean "this string is
explicit?

lsm=3D!!,apparmor

will enable apparmor and disable everything else.

lsm=3D!!,!apparmor or lsm=3D!!

will set the string empty and disable everything.

"!!" in "CONFIG_LSM" will take precedence over "!!" in "lsm=3D" which
will make "lsm=3D" totally ignored. This way distro could lock specific
lsm set which isn't possible with current approach.

CONFIG_LSM=3D!!,yama,loadpin,integrity,apparmor

> This violates one of the hard asks, and I will tell you that this will
> just mean there is going to be some distro patching to make sure it
> exists.
>

I think I can quess who will make those patches :)

> The current explicit list is more consistent, and it is amenable to
> being extended with + or ! as selective add/remove so we are not
> locked into only supporting an explicit list.
>

Jordan
