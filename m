From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH security-next v4 23/32] selinux: Remove boot parameter
Date: Tue, 2 Oct 2018 09:34:22 -0700
Message-ID: <CAGXu5jLLg-anBAPmfDzeQA--HYzYAGaRamUiJS8HTt+wMFp_qA@mail.gmail.com>
References: <20181002005505.6112-1-keescook@chromium.org> <20181002005505.6112-24-keescook@chromium.org>
 <CAHC9VhQjMfH6Q+Tif8nBknZojgxrb6x+oDz4vHRiZN8rb8MZ5Q@mail.gmail.com>
 <785ef6a9-ae46-3533-0348-74bcf6f10928@tycho.nsa.gov> <CAGXu5jKNzG3rGUAV39D0w4txHRG3H2qU1Z1e_b+03OgycTaWqA@mail.gmail.com>
 <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <809f1cfd-077b-ee58-51ba-b22daf46d12b@tycho.nsa.gov>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, "Schaufler, Casey" <casey.schaufler@intel.com>, linux-security-module <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Tue, Oct 2, 2018 at 7:58 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 10/02/2018 10:44 AM, Kees Cook wrote:
>>
>> On Tue, Oct 2, 2018 at 6:42 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>
>>> On 10/02/2018 08:12 AM, Paul Moore wrote:
>>>>
>>>>
>>>> On Mon, Oct 1, 2018 at 9:04 PM Kees Cook <keescook@chromium.org> wrote:
>>>>>
>>>>>
>>>>> Since LSM enabling is now centralized with CONFIG_LSM_ENABLE and
>>>>> "lsm.enable=...", this removes the LSM-specific enabling logic from
>>>>> SELinux.
>>>>>
>>>>> Signed-off-by: Kees Cook <keescook@chromium.org>
>>>>> ---
>>>>>    .../admin-guide/kernel-parameters.txt         |  9 ------
>>>>>    security/selinux/Kconfig                      | 29
>>>>> -------------------
>>>>>    security/selinux/hooks.c                      | 15 +---------
>>>>>    3 files changed, 1 insertion(+), 52 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt
>>>>> b/Documentation/admin-guide/kernel-parameters.txt
>>>>> index cf963febebb0..0d10ab3d020e 100644
>>>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>>>> @@ -4045,15 +4045,6 @@
>>>>>                           loaded. An invalid security module name will
>>>>> be
>>>>> treated
>>>>>                           as if no module has been chosen.
>>>>>
>>>>> -       selinux=        [SELINUX] Disable or enable SELinux at boot
>>>>> time.
>>>>> -                       Format: { "0" | "1" }
>>>>> -                       See security/selinux/Kconfig help text.
>>>>> -                       0 -- disable.
>>>>> -                       1 -- enable.
>>>>> -                       Default value is set via kernel config option.
>>>>> -                       If enabled at boot time, /selinux/disable can
>>>>> be
>>>>> used
>>>>> -                       later to disable prior to initial policy load.
>>>>
>>>>
>>>>
>>>> No comments yet on the rest of the patchset, but the subject line of
>>>> this patch caught my eye and I wanted to comment quickly on this one
>>>> ...
>>>>
>>>> Not a fan unfortunately.
>>>>
>>>> Much like the SELinux bits under /proc/self/attr, this is a user
>>>> visible thing which has made its way into a lot of docs, scripts, and
>>>> minds; I believe removing it would be a big mistake.
>>>
>>>
>>>
>>> Yes, we can't suddenly break existing systems that had selinux=0 in their
>>> grub config.  We have to retain the support.
>>
>>
>> Is it okay to only support selinux=0 (instead of also selinux=1)?
>
>
> For Fedora/RHEL kernels, selinux=1 would be redundant since it is the
> default.  However, in other distros where SELinux is not the default, I
> think they have documented selinux=1 as the way to enable SELinux.  So users
> may be relying on that as well. I don't think we can safely drop support for
> either one.  Sorry.

Okay. How would you like to resolve this? Should SELinux remain
"enable special", and AppArmor is okay to remove the LSM-specific
enabling?

The trouble is with handling CONFIG_LSM_ENABLE vs lsm.enable=... boot
param vs the SELinux bootparam. I.e. CONFIG_LSM_ENABLE is redundant to
SECURITY_SELINUX_BOOTPARAM_VALUE, and selinux= is redundant to
lsm.enable=. Specifically, how should the kernel distinguish between
the four settings?

-Kees

-- 
Kees Cook
Pixel Security
