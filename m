From: John Johansen <john.johansen@canonical.com>
Subject: Re: [PATCH security-next v3 14/29] LSM: Plumb visibility into
 optional "enabled" state
Date: Mon, 1 Oct 2018 15:53:33 -0700
Message-ID: <c4270e42-388a-c1c8-add9-66116b7f5fb3@canonical.com>
References: <20180925001832.18322-1-keescook@chromium.org>
 <20180925001832.18322-15-keescook@chromium.org>
 <alpine.LRH.2.21.1810020747380.20364@namei.org>
 <CAGXu5jJKvb=3vu3_b-NNdr_=KwvgO9qa96Qo5qzSZuiy2=+Oig@mail.gmail.com>
 <822e8ef3-5035-736e-1bea-dcb4af5c36ac@canonical.com>
 <CAGXu5jKm3yp8VFjTrRd1dibMVQeCmsHawNMyvtiCcEjxT7S57Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGXu5jKm3yp8VFjTrRd1dibMVQeCmsHawNMyvtiCcEjxT7S57Q@mail.gmail.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: James Morris <jmorris@namei.org>, Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 10/01/2018 03:29 PM, Kees Cook wrote:
> On Mon, Oct 1, 2018 at 3:20 PM, John Johansen
> <john.johansen@canonical.com> wrote:
>> On 10/01/2018 02:56 PM, Kees Cook wrote:
>>> On Mon, Oct 1, 2018 at 2:47 PM, James Morris <jmorris@namei.org> wrote:
>>>> On Mon, 24 Sep 2018, Kees Cook wrote:
>>>>
>>>>> In preparation for lifting the "is this LSM enabled?" logic out of the
>>>>> individual LSMs, pass in any special enabled state tracking (as needed
>>>>> for SELinux, AppArmor, and LoadPin). This should be an "int" to include
>>>>> handling any future cases where "enabled" is exposed via sysctl which
>>>>> has no "bool" type.
>>>>>
>>>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>>>> ---
>>>>>  include/linux/lsm_hooks.h | 1 +
>>>>>  security/apparmor/lsm.c   | 5 +++--
>>>>>  security/selinux/hooks.c  | 1 +
>>>>>  3 files changed, 5 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>>>>> index 5056f7374b3d..2a41e8e6f6e5 100644
>>>>> --- a/include/linux/lsm_hooks.h
>>>>> +++ b/include/linux/lsm_hooks.h
>>>>> @@ -2044,6 +2044,7 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
>>>>>  struct lsm_info {
>>>>>       const char *name;       /* Populated automatically. */
>>>>>       unsigned long flags;    /* Optional: flags describing LSM */
>>>>> +     int *enabled;           /* Optional: NULL means enabled. */
>>>>
>>>> This seems potentially confusing.
>>>>
>>>> Perhaps initialize 'enabled' to a default int pointer, like:
>>>>
>>>>         static int lsm_default_enabled = 1;
>>>>
>>>> Then,
>>>>
>>>>         DEFINE_LSM(foobar)
>>>>         flags = LSM_FLAG_LEGACY_MAJOR,
>>>>         .enabled = &lsm_default_enabled,
>>>>         .init = foobar_init,
>>>>         END_LSM;
>>>
>>> The reason I didn't do this is because there are only two LSMs that
>>> expose this "enabled" variable, so I didn't like making the other LSMs
>>> have to declare this. Internally, though, this is exactly what the
>>> infrastructure does: if it finds a NULL, it aims it at
>>> &lsm_default_enabled (in a later patch).
>>>
>>> However, it seems more discussion is needed on the "enable" bit of
>>> this, so I'll reply to John in a moment...
>>>
>> fwiw the apparmor.enabled config is really only a meant to be used to
>> disable apparmor. I'd drop it entirely except its part of the userspace
>> api now and needs to show up in
>>
>>   /sys/module/apparmor/parameters/enabled
> 
> Showing the enabled-ness there can be wired up. What should happen if
> someone sets apparmor.enabled=0/1 in new-series-world? (See other
> thread...)
> 
I am open to either just making apparmor=0/apparmor.enabled=0 a means
of only disabling apparmor, thats how it is currently used. Or even
potentially getting rid of it as an available kernel boot config
parameter and running with just lsm.enabled/disabled.

The important bit that applications are relying on is having
  /sys/module/apparmor/parameters/enabled

set to the the correct value.
