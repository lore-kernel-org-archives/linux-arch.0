From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH security-next v5 00/30] LSM: Explict ordering
Date: Thu, 11 Oct 2018 16:09:18 -0700
Message-ID: <CAGXu5j+kekUdcE2EhUu__8MXJ1O+D=-zTXLGNCRVa_VyDxePpw@mail.gmail.com>
References: <20181011001846.30964-1-keescook@chromium.org> <CAGXu5jLBaHj5MhXaK-8zdu6Rgo2B6rEq+at17xZ1Puct+YUajQ@mail.gmail.com>
 <ZhaXhoElmWQlsxHmgFHpB2xSWzJYFZWBasrSKQNjGj4_T2A4AY2F9v1rP9LkUfilUbZ0ExWXX9koLNjUM8S6baX6xfSSMPXY_CpihbCetVc=@protonmail.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ZhaXhoElmWQlsxHmgFHpB2xSWzJYFZWBasrSKQNjGj4_T2A4AY2F9v1rP9LkUfilUbZ0ExWXX9koLNjUM8S6baX6xfSSMPXY_CpihbCetVc=@protonmail.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: Jordan Glover <Golden_Miller83@protonmail.ch>
Cc: James Morris <jmorris@namei.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Randy Dunlap <rdunlap@infradead.org>, LSM <linux-security-module@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Oct 11, 2018 at 3:58 PM, Jordan Glover
<Golden_Miller83@protonmail.ch> wrote:
> On Thursday, October 11, 2018 7:57 PM, Kees Cook <keescook@chromium.org> wrote:
>>     To switch to SELinux at boot time with
>>     "CONFIG_LSM=yama,loadpin,integrity,apparmor", the old way continues to
>>     work:
>>
>>     selinux=1 security=selinux
>>
>>     This will work still, since it will enable selinux (selinux=1) and
>>     disable all other major LSMs (security=selinux).
>>
>>     The new way to enable selinux would be using
>>     "lsm=yama,loadpin,integrity,selinux".
>>
>
> It seems to me that legacy way is more user friendly than the new one.
> AppArmor and SElinux are households names but the rest may be enigmatic
> for most users and the need for explicit passing them all may be
> troublesome. Especially when the new ones like sara,landlock or cows :)
> will be incoming. Moreover to knew what you have to pass there, you need
> to look at CONFIG_LSM in kernel config (which will vary across distros
> and also mean copy-paste from the web source may won't work as expected)
> which again most users don't do.
>
> I think there is risk that users will end up with "lsm=selinux" without
> realizing that they may disable something along the way.
>
> I would prefer for "lsm=" to work as override to "CONFIG_LSM=" with
> below assumptions:
>
> I. lsm="$lsm" will append "$lsm" at the end of string. Before extreme
> stacking it will also remove the other major (explicit) lsm from it.
>
> II. lsm="!$lsm" will remove "$lsm" from the string.
>
> III. If "$lsm" already exist in the string, it's moved at the end of it
> (this will cover ordering).

We've had things sort of like this proposed, but if you can convince
James and others, I'm all for it. I think the standing objection from
James and John about this is that the results of booting with
"lsm=something" ends up depending on CONFIG_LSM= for that distro. So
you end up with different behaviors instead of a consistent behavior
across all distros.

Now, in the future blob and extreme stacking world, having the
explicit lsm= list shouldn't be too bad since LSMs will effectively
ALL be initialized -- but they'll be inactive since they have no
policy loaded.

But I still agree with you: I'd like a friendlier way to
disable/enable specific LSMs, but an explicit lsm= seems to be the
only way.

> It's possible that something lime this was discussed already
> but without full examples it was hard to me for tracking things.

It's been a painful thread. ;)

-Kees

-- 
Kees Cook
Pixel Security
