From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH security-next v2 26/26] LSM: Add all exclusive LSMs to
 ordered initialization
Date: Thu, 20 Sep 2018 17:45:47 -0700
Message-ID: <CAGXu5j++wXMUXuqT7m5MZdeXqO=i7RgyKZoLwELfSTx6UPOVSA@mail.gmail.com>
References: <20180920162338.21060-1-keescook@chromium.org> <20180920162338.21060-27-keescook@chromium.org>
 <a0165ce9-d15b-eaef-a5e8-2aeb6bdc69f6@schaufler-ca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a0165ce9-d15b-eaef-a5e8-2aeb6bdc69f6@schaufler-ca.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: James Morris <jmorris@namei.org>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Thu, Sep 20, 2018 at 5:25 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 9/20/2018 9:23 AM, Kees Cook wrote:
>>  config LSM_ORDER
>>       string "Default initialization order of builtin LSMs"
>> -     default "yama,loadpin,integrity"
>> +     default "yama,loadpin,integrity,selinux,smack,tomoyo,apparmor"
>
> If I want to compile all the major modules into my kernel and use
> AppArmor by default would I use
>
>         default "yama,loadpin,integrity,apparmor,selinux,smack,tomoyo"
>
> or
>
>         default "yama,loadpin,integrity,apparmor"

I was expecting the former, but the latter will have the same result.

> When we have "blob-sharing" how could I compile in tomoyo,
> but exclude it without a boot line option?

Ooh, yes, this series has no way to do that. Perhaps
CONFIG_LSM_DISABLE in the same form as CONFIG_LSM_ORDER? I would
totally remove LoadPin's CONFIG for this in favor it.

> When we have full stacking, how could I compile in selinux
> but exclude it?

Yup, same problem. Same suggested solution?

Should lsm.enable/disable= also become a comma-separated list, or
should I leave it as a multi-instance thing like I have it?

-Kees

-- 
Kees Cook
Pixel Security
