From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH security-next v3 00/29] LSM: Explict LSM ordering
Date: Sun, 30 Sep 2018 09:57:05 -0700
Message-ID: <CAGXu5jLRPMjWDnvh+wKfqQHZ+nrSH5rHz1Hat2owEu2mTXnjRw@mail.gmail.com>
References: <20180925001832.18322-1-keescook@chromium.org> <e6122c7d-bd29-d081-3c1e-96b7c369d4fe@schaufler-ca.com>
 <CAGXu5jKQVDW8Wp0ESv2raa0xJnHCCMNqFCzZ5jSVXQ=Dp7FF8A@mail.gmail.com>
 <eda428eb-f6e1-f048-a394-251953c388b6@i-love.sakura.ne.jp>
 <CAGXu5jLUaFX_jPHoOq1abEAjJdLo29Hr2q=sk07yj4KytW6psQ@mail.gmail.com> <67c14d95-10f6-37d5-ee8a-c1fb6a6d460a@i-love.sakura.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <67c14d95-10f6-37d5-ee8a-c1fb6a6d460a@i-love.sakura.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Casey Schaufler <casey@schaufler-ca.com>, James Morris <jmorris@namei.org>, John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On Sat, Sep 29, 2018 at 7:36 PM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2018/09/30 3:18, Kees Cook wrote:
>>> Just wondering what is "__lsm_name_##lsm" for...
>>>
>>> +#define DEFINE_LSM(lsm)                                                        \
>>> +       static const char __lsm_name_##lsm[] __initconst                \
>>> +               __aligned(1) = #lsm;                                    \
>>> +       static struct lsm_info __lsm_##lsm                              \
>>> +               __used __section(.lsm_info.init)                        \
>>> +               __aligned(sizeof(unsigned long))                        \
>>> +               = {                                                     \
>>> +                       .name = __lsm_name_##lsm,                       \
>>> +
>>> +#define END_LSM          }
>>
>> I wasn't super happy with the END_LSM thing, but I wanted to be able
>> to declare the name as __initconst, otherwise it needlessly stays in
>> memory after init. That said, it's not a huge deal, and maybe
>> readability trumps a tiny meory savings?
>
> The value of .name field is a few bytes string, and is not sensitive
> information. Keeping such string in non-__initdata section unlikely
> increases total memory pages required for that module.
>
> Unless we need to generate unique address of such string for some reason,
> I think that this saving is pointless.

Okay, sounds good. I will adjust the macro and respin with a v4.

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
