Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yb1-f196.google.com ([209.85.219.196]:41446 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728457AbeI3AsJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 29 Sep 2018 20:48:09 -0400
Received: by mail-yb1-f196.google.com with SMTP id d14-v6so4027326ybs.8
        for <linux-arch@vger.kernel.org>; Sat, 29 Sep 2018 11:18:44 -0700 (PDT)
Received: from mail-yw1-f44.google.com (mail-yw1-f44.google.com. [209.85.161.44])
        by smtp.gmail.com with ESMTPSA id r69-v6sm3926195ywh.44.2018.09.29.11.18.41
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 11:18:41 -0700 (PDT)
Received: by mail-yw1-f44.google.com with SMTP id h134-v6so3956303ywc.9
        for <linux-arch@vger.kernel.org>; Sat, 29 Sep 2018 11:18:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <eda428eb-f6e1-f048-a394-251953c388b6@i-love.sakura.ne.jp>
References: <20180925001832.18322-1-keescook@chromium.org> <e6122c7d-bd29-d081-3c1e-96b7c369d4fe@schaufler-ca.com>
 <CAGXu5jKQVDW8Wp0ESv2raa0xJnHCCMNqFCzZ5jSVXQ=Dp7FF8A@mail.gmail.com> <eda428eb-f6e1-f048-a394-251953c388b6@i-love.sakura.ne.jp>
From: Kees Cook <keescook@chromium.org>
Date: Sat, 29 Sep 2018 11:18:40 -0700
Message-ID: <CAGXu5jLUaFX_jPHoOq1abEAjJdLo29Hr2q=sk07yj4KytW6psQ@mail.gmail.com>
Subject: Re: [PATCH security-next v3 00/29] LSM: Explict LSM ordering
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Casey Schaufler <casey@schaufler-ca.com>, James Morris <jmorris@namei.org>, John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20180929181840.JVfSDjH2YH27EIODfE9GZCS7eFGgCMkmqHCiOZHcpvg@z>

On Sat, Sep 29, 2018 at 3:48 AM, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2018/09/29 5:01, Kees Cook wrote:
>> On Fri, Sep 28, 2018 at 8:55 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> On 9/24/2018 5:18 PM, Kees Cook wrote:
>>>> v3:
>>>> - add CONFIG_LSM_ENABLE and refactor resulting logic
>>>
>>> Kees, you can add my
>>>
>>>         Reviewed-by:Casey Schaufler <casey@schaufler-ca.com>
>>>
>>> for this entire patch set. Thank you for taking this on, it's
>>> a significant and important chunk of the LSM infrastructure
>>> update.
>>
>> Thanks!
>>
>> John, you'd looked at this a bit too -- do the results line up with
>> your expectations?
>>
>> Any thoughts from SELinux, TOMOYO, or IMA folks?
>
> I'm OK with this approach. Thank you.

Thanks for looking it over!

> Just wondering what is "__lsm_name_##lsm" for...
>
> +#define DEFINE_LSM(lsm)                                                        \
> +       static const char __lsm_name_##lsm[] __initconst                \
> +               __aligned(1) = #lsm;                                    \
> +       static struct lsm_info __lsm_##lsm                              \
> +               __used __section(.lsm_info.init)                        \
> +               __aligned(sizeof(unsigned long))                        \
> +               = {                                                     \
> +                       .name = __lsm_name_##lsm,                       \
> +
> +#define END_LSM          }

I wasn't super happy with the END_LSM thing, but I wanted to be able
to declare the name as __initconst, otherwise it needlessly stays in
memory after init. That said, it's not a huge deal, and maybe
readability trumps a tiny meory savings?

> We could do something like below so that funny END_LSM is not required?
> I felt } like a typo error at the first glance. What we need is to
> gather into one section with appropriate alignment, isn't it?
>
> #define LSM_INFO                                                        \
>         static struct lsm_info __lsm_                                   \
>                 __used __section(.lsm_info.init)                        \
>                 __aligned(sizeof(unsigned long))                        \
>
> LSM_INFO = {
>         .name = "tomoyo",
>         .flags = LSM_FLAG_LEGACY_MAJOR | LSM_FLAG_EXCLUSIVE,
>         .init = tomoyo_init,
> };

I thought the structure instances would need a unique name, but it
seems the section naming removes that requirement. This seems only to
be needed if we had multiple LSMs defined in the same source file.
Though I wonder if this would be a problem for LTO in the future?

I'm happy to do whatever.

-Kees

-- 
Kees Cook
Pixel Security
