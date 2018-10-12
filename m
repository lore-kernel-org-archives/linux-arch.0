From: John Johansen <john.johansen@canonical.com>
Subject: Re: [PATCH security-next v5 00/30] LSM: Explict ordering
Date: Thu, 11 Oct 2018 18:19:48 -0700
Message-ID: <38dde301-d77e-35fd-88d4-5cdc5b570ee8@canonical.com>
References: <20181011001846.30964-1-keescook@chromium.org>
 <CAGXu5jLBaHj5MhXaK-8zdu6Rgo2B6rEq+at17xZ1Puct+YUajQ@mail.gmail.com>
 <ZhaXhoElmWQlsxHmgFHpB2xSWzJYFZWBasrSKQNjGj4_T2A4AY2F9v1rP9LkUfilUbZ0ExWXX9koLNjUM8S6baX6xfSSMPXY_CpihbCetVc=@protonmail.ch>
 <CAGXu5j+kekUdcE2EhUu__8MXJ1O+D=-zTXLGNCRVa_VyDxePpw@mail.gmail.com>
 <f68e5f4b-6360-a9e7-597f-89d1d3ca73c1@canonical.com>
 <32stV62RmME8Dj5jKB8Z03zPe_Et72kMo71D8SpgSOHUo6SaROc8DomMWdk5jDGpyqVd8T63NIIK2NdDw95clpF8Uj47Wca2FBFItXDRh7E=@protonmail.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <32stV62RmME8Dj5jKB8Z03zPe_Et72kMo71D8SpgSOHUo6SaROc8DomMWdk5jDGpyqVd8T63NIIK2NdDw95clpF8Uj47Wca2FBFItXDRh7E=@protonmail.ch>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Jordan Glover <Golden_Miller83@protonmail.ch>
Cc: Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>, Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Randy Dunlap <rdunlap@infradead.org>, LSM <linux-security-module@vger.kernel.org>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 10/11/2018 05:11 PM, Jordan Glover wrote:
> ‐‐‐‐‐‐‐ Original Message ‐‐‐‐‐‐‐
> On Friday, October 12, 2018 1:48 AM, John Johansen <john.johansen@canonical.com> wrote:
> 
>> On 10/11/2018 04:09 PM, Kees Cook wrote:
>>
>>> On Thu, Oct 11, 2018 at 3:58 PM, Jordan Glover
>>> Golden_Miller83@protonmail.ch wrote:
>>>
>>>> On Thursday, October 11, 2018 7:57 PM, Kees Cook keescook@chromium.org wrote:
>>>>
>>>>>     To switch to SELinux at boot time with
>>>>>     "CONFIG_LSM=yama,loadpin,integrity,apparmor", the old way continues to
>>>>>     work:
>>>>>
>>>>>     selinux=1 security=selinux
>>>>>
>>>>>     This will work still, since it will enable selinux (selinux=1) and
>>>>>     disable all other major LSMs (security=selinux).
>>>>>
>>>>>     The new way to enable selinux would be using
>>>>>     "lsm=yama,loadpin,integrity,selinux".
>>>>>
>>>>
>>>> It seems to me that legacy way is more user friendly than the new one.
>>>> AppArmor and SElinux are households names but the rest may be enigmatic
>>>> for most users and the need for explicit passing them all may be
>>>> troublesome. Especially when the new ones like sara,landlock or cows :)
>>>> will be incoming. Moreover to knew what you have to pass there, you need
>>>> to look at CONFIG_LSM in kernel config (which will vary across distros
>>>> and also mean copy-paste from the web source may won't work as expected)
>>>> which again most users don't do.
>>>> I think there is risk that users will end up with "lsm=selinux" without
>>>> realizing that they may disable something along the way.
>>>> I would prefer for "lsm=" to work as override to "CONFIG_LSM=" with
>>>> below assumptions:
>>>> I. lsm="$lsm" will append "$lsm" at the end of string. Before extreme
>>>> stacking it will also remove the other major (explicit) lsm from it.
>>>> II. lsm="!$lsm" will remove "$lsm" from the string.
>>>> III. If "$lsm" already exist in the string, it's moved at the end of it
>>>> (this will cover ordering).
>>>
>>> We've had things sort of like this proposed, but if you can convince
>>> James and others, I'm all for it. I think the standing objection from
>>> James and John about this is that the results of booting with
>>> "lsm=something" ends up depending on CONFIG_LSM= for that distro. So
>>> you end up with different behaviors instead of a consistent behavior
>>> across all distros.
>>
>> Its certainly a point that could confuse the user. I do have concerns
>> about it, but not something that is on a must haves list
>>
>>> Now, in the future blob and extreme stacking world, having the
>>> explicit lsm= list shouldn't be too bad since LSMs will effectively
>>> ALL be initialized -- but they'll be inactive since they have no
>>> policy loaded.
>>
>> you are more optimistic about this than I am, but there will be at
>> least some movement towards this.
>>
>>> But I still agree with you: I'd like a friendlier way to
>>> disable/enable specific LSMs, but an explicit lsm= seems to be the
>>> only way.
>>
>> Hrmmm, I don't know about the only way, but a way to provide the
>> explicit list, and also set a specific set as the default in the
>> Kconfig is a hard requirement.
>>
> 
> My proposition allows for explicit "lsm=" list but also accepts non
> explicit list. This is it's advantage above current approach.
> 
> The current approach works but it seems to target the very same people
> who designed it :)
> 
>> The initial lsm.ebable, lsm.disable had too many issues, and for
>> various reasons I never managed to get back to kees' proposal
>> for using +.
>>
>> That said, I do think the right approach for the initial pass is
>> the explicit list. It moves the arguments to the side and allows
>> this work to move forward.
>>
> 
> I'm afraid when it hits stable kernel and people will rely on it,
> then it will be too late. Things will be even more hard to change
> than now when we have to keep legacy syntax of security=xxx.
> 
> I added explanation why explicit list doesn't solve consistency
> across distros in the other reply
> 

It isn't perfect but it manages consistency across distros as best as
can be achieved atm.

Its just a fact that some LSMs are not going to be built into some
kernels. The only way to deal with that is direct people to build
their own kernels.

The other major problem is that the current LSM stacking patches do
not deal with "extreme" stacking. So doing

lsm=+apparmor

(I am going to stick with the + syntax atm to avoid confusion between
adding and setting)

assuming apparmor is builtin will not necessarily get you apparmor if
another major lsm is enabled.  Yes your specific proposal would as it
specifies it overrides the current major, except that ordering
important so if say landlock registers before apparmor, you may still
not get apparmor.

You proposal does not provide a means to ensure you have only a
specific set of LSMs enabled. As an LSM not explicitly listed in lsm=
lsm=! may still be enabled. So the user is going to have to be aware
of the initial LSMs list if they are trying to guarentee a specific
security arrangement.

This violates one of the hard asks, and I will tell you that this will
just mean there is going to be some distro patching to make sure it
exists.

The current explicit list is more consistent, and it is amenable to
being extended with + or ! as selective add/remove so we are not
locked into only supporting an explicit list.


>>>> It's possible that something lime this was discussed already
>>>> but without full examples it was hard to me for tracking things.
>>>
>>> It's been a painful thread. ;)
>>
>> Indeed
> 
> Jordan
> 
