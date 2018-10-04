From: John Johansen <john.johansen@canonical.com>
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
Date: Wed, 3 Oct 2018 23:22:16 -0700
Message-ID: <9473fc3d-2737-aec3-d91a-fdd936872b7d@canonical.com>
References: <20181002005505.6112-1-keescook@chromium.org>
 <QpdcE4QSCQKJqDmB2QBEGBlnlioHuRHlM0g5HF8KbHjU1zIUAOjnQ2r9EIMu3m0S2OWNR3_M_TSp_M6CVDqkp6kKuFPUvegsyDPNw1AGju4=@protonmail.ch>
 <CAGXu5jKqXNbEvPr1axQtGCCnWsGhDgjynW5u326mcx4vZ1oH8g@mail.gmail.com>
 <abe03d09-4dcb-2b02-4102-5e108d617a42@canonical.com>
 <CAGXu5jJtC1gkJ0ZKDFroL8UzvjiPfmC+6EsrzyB0j0oETdSQQg@mail.gmail.com>
 <alpine.LRH.2.21.1810030758460.23596@namei.org>
 <CAGXu5jLKgrdhah-5TtAXDL-odbLGeyAUH2=PkAU769AkEnZFfQ@mail.gmail.com>
 <5955f5ce-b803-4f58-8b07-54c291e33da5@canonical.com>
 <alpine.LRH.2.21.1810040416500.13517@namei.org>
 <CAGXu5j+oPR58oJ06-n7e96-Rmu+ywTW0hud5LhOZ_3UXG5s12w@mail.gmail.com>
 <alpine.LRH.2.21.1810040427550.13517@namei.org>
 <CAGXu5jJmVR4Wsdti=aFaDhCBaxsVu1KTJOdsJOtFvZOV1ZhdvQ@mail.gmail.com>
 <alpine.LRH.2.21.1810040723320.16168@namei.org>
 <CAGXu5jJDBhFrdCBHH4MZVDmG88mMxSaSx0w9anCcyx24YHLO5w@mail.gmail.com>
 <6037a1f0-7af1-9847-91f6-6444f04f5b21@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6037a1f0-7af1-9847-91f6-6444f04f5b21@infradead.org>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, Kees Cook <keescook@chromium.org>, James Morris <jmorris@namei.org>
Cc: Jordan Glover <Golden_Miller83@protonmail.ch>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, "Schaufler, Casey" <casey.schaufler@intel.com>, linux-security-module <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 10/03/2018 04:59 PM, Randy Dunlap wrote:
> On 10/3/18 4:55 PM, Kees Cook wrote:
>> On Wed, Oct 3, 2018 at 2:34 PM, James Morris <jmorris@namei.org> wrote:
>>> On Wed, 3 Oct 2018, Kees Cook wrote:
>>>
>>>> On Wed, Oct 3, 2018 at 11:28 AM, James Morris <jmorris@namei.org> wrote:
>>>>> On Wed, 3 Oct 2018, Kees Cook wrote:
>>>>>
>>>>>> On Wed, Oct 3, 2018 at 11:17 AM, James Morris <jmorris@namei.org> wrote:
>>>>>>> On Tue, 2 Oct 2018, John Johansen wrote:
>>>>>>>> To me a list like
>>>>>>>>   lsm.enable=X,Y,Z
>>>>>>>
>>>>>>> What about even simpler:
>>>>>>>
>>>>>>> lsm=selinux,!apparmor,yama
>>>>>>
>>>>>> We're going to have lsm.order=, so I'd like to keep it with a dot
>>>>>> separator (this makes it more like module parameters, too). You want
>>>>>> to mix enable/disable in the same string? That implies you'd want
>>>>>> implicit enabling (i.e. it complements the builtin enabling), which is
>>>>>> opposite from what John wanted.
>>>>>>
>>>>>
>>>>> Why can't this be the order as well?
>>>>
>>>> That was covered extensively in the earlier threads. It boils down to
>>>> making sure we do not create a pattern of leaving LSMs disabled by
>>>> default when they are added to the kernel. The v1 series used
>>>> security= like this:
>>>>
>>>> +       security=       [SECURITY] An ordered comma-separated list of
>>>> +                       security modules to attempt to enable at boot. If
>>>> +                       this boot parameter is not specified, only the
>>>> +                       security modules asking for initialization will be
>>>> +                       enabled (see CONFIG_DEFAULT_SECURITY). Duplicate
>>>> +                       or invalid security modules will be ignored. The
>>>> +                       capability module is always loaded first, without
>>>> +                       regard to this parameter.
>>>>
>>>> This meant booting "security=apparmor" would disable all the other
>>>> LSMs, which wasn't friendly at all. So "security=" was left alone (to
>>>> leave it to only select the "major" LSM: all major LSMs not matching
>>>> "security=" would be disabled). So I proposed "lsm.order=" to specify
>>>> the order things were going to be initialized in, but to avoid kernels
>>>> booting with newly added LSMs forced-off due to not being listed in
>>>> "lsm.order=", it had to have implicit fall-back for unlisted LSMs.
>>>> (i.e. anything missing from lsm.order would then follow their order in
>>>> CONFIG_LSM_ORDER, and anything missing there would fall back to
>>>> link-time ordering.) However, then the objection was raised that this
>>>> didn't provide a way to explicitly disable an LSM. So I proposed
>>>> lsm.enable/disable, and John argued for CONFIG_LSM_ENABLE over
>>>> CONFIG_LSM_DISABLE.
>>>
>>> Ok, but it may end up being clearer, simpler, and thus more secure to just
>>> have a single way to configure LSM.
>>>
>>> For example:
>>>
>>>   - All LSMs which are built are NOT enabled by default
>>>
>>>   - You specify enablement and order via a Kconfig:
>>>
>>>         CONFIG_LSM="selinux,yama"
>>>
>>>   - This can be entirely overridden by a boot param:
>>>
>>>         lsm="apparmor,landlock"
>>
>> This doesn't work with how SELinux and AppArmor do their bootparams,
>> unfortunately. (And Paul and Stephen have expressed that the
>> documented selinux on/off must continue to work.) For example, let's
>> say you've built an Ubuntu kernel with:
>>
>> CONFIG_SELINUX=y
>> ...
>> CONFIG_LSM="yama,apparmor"
>>
>> (i.e. you want SELinux available, but not enabled, so it's left out of
>> CONFIG_LSM)
>>
>> Then someone boots the system with:
>>
>> selinux=1 security=selinux
>>
>> In what order does selinux get initialized relative to yama?
>> (apparmor, flagged as a "legacy major", would have been disabled by
>> the "security=" not matching it.)
>>
> 
> To me, "security=selinux" means SELinux and nothing else, so I think that
> all of these params are inviting a lot of confusion.
> 
> Sorry, I don't have a good answer for this.
> 

Your not the only one. I have had users ask about why they are getting
other security messures (yama in particular) when they specified a
specific security=



>>
>> The LSM order needs to be defined externally to enablement because
>> something may become enabled when not listed in the order.
>>
>> Now, maybe I misunderstood your earlier suggestion, and what you meant
>> was to do something like:
>>
>> CONFIG_LSM="yama,apparmor,!selinux"
>>
>> to mean "put selinux here in the order, but don't enable it". Then the
>> problem becomes what happens to an LSM that has been built in but not
>> listed in CONFIG_LSM?
>>
>> Related to that, this means that when new LSMs are added, they will
>> need to be added to any custom CONFIG_LSM= or lsm= parameters. If
>> that's really how we have to go, I'll accept it, but I think it's a
>> bit unfriendly. :P
>>
>> Another reason I don't like it is because it requires users to know
>> about all the LSMs to make changes. One LSM can't be added/removed
>> without specifying ALL of the LSMs. (i.e. there is no trivial way to
>> enable/disable a single LSM without it growing its own enable/disable
>> code as in SELinux/AppArmor. I'd hoped to make that easier for both
>> users and developers.) Again, I can live with it, but I think it's
>> unfriendly.
>>
>> I just want to have a direct I can go that meets all the requirements.
>> :) I'm fine to ignore my sense of aesthetics if everyone can agree on
>> the code.
> 
> 
