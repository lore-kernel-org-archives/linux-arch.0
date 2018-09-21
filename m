From: John Johansen <john.johansen@canonical.com>
Subject: Re: [PATCH security-next v2 26/26] LSM: Add all exclusive LSMs to
 ordered initialization
Date: Fri, 21 Sep 2018 06:19:56 -0700
Message-ID: <915ba7e5-0e10-87ef-f0a9-1d8db2e6de90@canonical.com>
References: <20180920162338.21060-1-keescook@chromium.org>
 <20180920162338.21060-27-keescook@chromium.org>
 <a0165ce9-d15b-eaef-a5e8-2aeb6bdc69f6@schaufler-ca.com>
 <CAGXu5j++wXMUXuqT7m5MZdeXqO=i7RgyKZoLwELfSTx6UPOVSA@mail.gmail.com>
 <7d2cc28b-aee5-ee91-9362-f92f8ca30adc@schaufler-ca.com>
 <6c899d9e-45aa-8159-c402-b3c4d1936112@canonical.com>
 <CAGXu5jKzqij5dY2FYm5rafPNPpF1Tx9BPmK+=FvG+=tpFxpscw@mail.gmail.com>
 <74ecd4ec-491b-93d7-4e3f-46f92121130b@canonical.com>
 <CAGXu5j+QhU2HOicYKqfNo17n9k6DKgt1upa3O2p1b5Gvn6icbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAGXu5j+QhU2HOicYKqfNo17n9k6DKgt1upa3O2p1b5Gvn6icbQ@mail.gmail.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>, James Morris <jmorris@namei.org>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 09/20/2018 08:02 PM, Kees Cook wrote:
> On Thu, Sep 20, 2018 at 7:14 PM, John Johansen
> <john.johansen@canonical.com> wrote:
>> On 09/20/2018 07:05 PM, Kees Cook wrote:
>>> On Thu, Sep 20, 2018 at 6:39 PM, John Johansen
>>> <john.johansen@canonical.com> wrote:
>>>> On 09/20/2018 06:10 PM, Casey Schaufler wrote:
>>>>> On 9/20/2018 5:45 PM, Kees Cook wrote:
>>>>>> On Thu, Sep 20, 2018 at 5:25 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>>>>>> On 9/20/2018 9:23 AM, Kees Cook wrote:
>>>>>>>>  config LSM_ORDER
>>>>>>>>       string "Default initialization order of builtin LSMs"
>>>>>>>> -     default "yama,loadpin,integrity"
>>>>>>>> +     default "yama,loadpin,integrity,selinux,smack,tomoyo,apparmor"
>>>>>>> If I want to compile all the major modules into my kernel and use
>>>>>>> AppArmor by default would I use
>>>>>>>
>>>>>>>         default "yama,loadpin,integrity,apparmor,selinux,smack,tomoyo"
>>>>>>>
>>>>>>> or
>>>>>>>
>>>>>>>         default "yama,loadpin,integrity,apparmor"
>>>>>> I was expecting the former, but the latter will have the same result.
>>>>
>>>> t find having the two be equivalent violates expectations. At least
>>>> when considering the end goal of full/extreme stacking, its trivially
>>>> the same with current major lsms being exclusive
>>>
>>> This mixes "enablement" with "ordering", though, and I think the past
>>> threads have shown this to be largely problematic.
>>>
>>> However, with CONFIG_LSM_ENABLED, we get the effect you're looking for, IIUC.
>>
>> no, I was just stating in a world where we have full stacking those two
>> are not equivalent, as I would assume the order of any lsm not listed
>> may end up being different.
> 
> Right, the ordering would be defined first by runtime (lsm.order=)
> followed any missing LSMs then ordered by their order in
> CONFIG_LSM_ORDER=, followed by any still missing LSMs then ordered by
> their order at link-time (which *may* be Makefile order, but could
> change with LTO, etc).
> 
>>>>>>> When we have "blob-sharing" how could I compile in tomoyo,
>>>>>>> but exclude it without a boot line option?
>>>>>> Ooh, yes, this series has no way to do that. Perhaps
>>>>>> CONFIG_LSM_DISABLE in the same form as CONFIG_LSM_ORDER? I would
>>>>>> totally remove LoadPin's CONFIG for this in favor it.
>>>>>
>>>>> I would generally prefer an optional CONFIG_LSM_ENABLE to
>>>>> CONFIG_LSM_DISABLE, but I understand the logic behind your
>>>>> approach. I would be looking for something like
>>>>>
>>>> +1 on the CONFIG_LSM_ENABLE ove DISABLE
>>>>
>>>>> CONFIG LSM_ENABLE
>>>>>       string "Default set of enabled LSMs"
>>>>>       default ""
>>>>>
>>>>> as opposed to
>>>>>
>>>>> CONFIG LSM_DISABLE
>>>>>       string "Default set of disabled LSMs"
>>>>>       default ""
>>>>>
>>>>> where an empty string is interpreted as "use 'em all"
>>>>> in either case.
>>>
>>> Yes, I like CONFIG_LSM_ENABLE if "empty" means "enable all". Should
>>> CONFIG_LSM_ENABLE replace all the other CONFIG-based LSM
>>> enabling/disabling?
>>
>> I don't particularly like "empty" being "enable all". With that
>> how would I disable all builtin lsms so that I just boot with
>> capability.
>>
>> An option of all or even * is more explicit and leaves the empty
>> set to mean disable everything
> 
> Okay, that works. I prefer "all" FWIW.
> 
me too, I was just trying to throw out options.
