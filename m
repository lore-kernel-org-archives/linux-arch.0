Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yb1-f195.google.com ([209.85.219.195]:41480 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbeI2C0x (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 28 Sep 2018 22:26:53 -0400
Received: by mail-yb1-f195.google.com with SMTP id d14-v6so3169049ybs.8
        for <linux-arch@vger.kernel.org>; Fri, 28 Sep 2018 13:01:34 -0700 (PDT)
Received: from mail-yw1-f53.google.com (mail-yw1-f53.google.com. [209.85.161.53])
        by smtp.gmail.com with ESMTPSA id r5-v6sm1889887ywr.80.2018.09.28.13.01.31
        for <linux-arch@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 13:01:31 -0700 (PDT)
Received: by mail-yw1-f53.google.com with SMTP id z143-v6so3143289ywa.7
        for <linux-arch@vger.kernel.org>; Fri, 28 Sep 2018 13:01:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e6122c7d-bd29-d081-3c1e-96b7c369d4fe@schaufler-ca.com>
References: <20180925001832.18322-1-keescook@chromium.org> <e6122c7d-bd29-d081-3c1e-96b7c369d4fe@schaufler-ca.com>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 28 Sep 2018 13:01:30 -0700
Message-ID: <CAGXu5jKQVDW8Wp0ESv2raa0xJnHCCMNqFCzZ5jSVXQ=Dp7FF8A@mail.gmail.com>
Subject: Re: [PATCH security-next v3 00/29] LSM: Explict LSM ordering
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: James Morris <jmorris@namei.org>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20180928200130.ZCyftTvfiU3KpZ2GTOlBQBFhi7vrMi-eivEnDN6kC4Y@z>

On Fri, Sep 28, 2018 at 8:55 AM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 9/24/2018 5:18 PM, Kees Cook wrote:
>> v3:
>> - add CONFIG_LSM_ENABLE and refactor resulting logic
>
> Kees, you can add my
>
>         Reviewed-by:Casey Schaufler <casey@schaufler-ca.com>
>
> for this entire patch set. Thank you for taking this on, it's
> a significant and important chunk of the LSM infrastructure
> update.

Thanks!

John, you'd looked at this a bit too -- do the results line up with
your expectations?

Any thoughts from SELinux, TOMOYO, or IMA folks?

-Kees

>
>
>> ...
>> Breakdown of patches:
>>
>> Infrastructure improvements (no logical changes):
>>   LSM: Correctly announce start of LSM initialization
>>   vmlinux.lds.h: Avoid copy/paste of security_init section
>>   LSM: Rename .security_initcall section to .lsm_info
>>   LSM: Remove initcall tracing
>>   LSM: Convert from initcall to struct lsm_info
>>   vmlinux.lds.h: Move LSM_TABLE into INIT_DATA
>>   LSM: Convert security_initcall() into DEFINE_LSM()
>>   LSM: Record LSM name in struct lsm_info
>>   LSM: Provide init debugging infrastructure
>>   LSM: Don't ignore initialization failures
>>
>> Split "integrity" out into "ordered initialization" (no logical changes):
>>   LSM: Introduce LSM_FLAG_LEGACY_MAJOR
>>   LSM: Provide separate ordered initialization
>>
>> Provide centralized LSM enable/disable infrastructure:
>>   LoadPin: Rename "enable" to "enforce"
>>   LSM: Plumb visibility into optional "enabled" state
>>   LSM: Lift LSM selection out of individual LSMs
>>   LSM: Prepare for arbitrary LSM enabling
>>   LSM: Introduce CONFIG_LSM_ENABLE
>>   LSM: Introduce lsm.enable= and lsm.disable=
>>   LSM: Prepare for reorganizing "security=" logic
>>   LSM: Refactor "security=" in terms of enable/disable
>>
>> Provide centralized LSM ordering infrastructure:
>>   LSM: Build ordered list of ordered LSMs for init
>>   LSM: Introduce CONFIG_LSM_ORDER
>>   LSM: Introduce "lsm.order=" for boottime ordering
>>
>> Move minor LSMs into ordered LSM initialization:
>>   LoadPin: Initialize as ordered LSM
>>   Yama: Initialize as ordered LSM
>>   LSM: Introduce enum lsm_order
>>   capability: Initialize as LSM_ORDER_FIRST
>>
>> Move major LSMs into ordered LSM initialization:
>>   LSM: Separate idea of "major" LSM from "exclusive" LSM
>>   LSM: Add all exclusive LSMs to ordered initialization
>>
>> -Kees
>>
>>  .../admin-guide/kernel-parameters.txt         |  20 +
>>  arch/arc/kernel/vmlinux.lds.S                 |   1 -
>>  arch/arm/kernel/vmlinux-xip.lds.S             |   1 -
>>  arch/arm64/kernel/vmlinux.lds.S               |   1 -
>>  arch/h8300/kernel/vmlinux.lds.S               |   1 -
>>  arch/microblaze/kernel/vmlinux.lds.S          |   2 -
>>  arch/powerpc/kernel/vmlinux.lds.S             |   2 -
>>  arch/um/include/asm/common.lds.S              |   2 -
>>  arch/xtensa/kernel/vmlinux.lds.S              |   1 -
>>  include/asm-generic/vmlinux.lds.h             |  25 +-
>>  include/linux/init.h                          |   2 -
>>  include/linux/lsm_hooks.h                     |  43 ++-
>>  include/linux/module.h                        |   1 -
>>  security/Kconfig                              |  61 ++-
>>  security/apparmor/lsm.c                       |  16 +-
>>  security/commoncap.c                          |   8 +-
>>  security/integrity/iint.c                     |   5 +-
>>  security/loadpin/Kconfig                      |   4 +-
>>  security/loadpin/loadpin.c                    |  28 +-
>>  security/security.c                           | 351 +++++++++++++++---
>>  security/selinux/hooks.c                      |  16 +-
>>  security/smack/smack_lsm.c                    |   8 +-
>>  security/tomoyo/tomoyo.c                      |   7 +-
>>  security/yama/yama_lsm.c                      |   7 +-
>>  24 files changed, 438 insertions(+), 175 deletions(-)
>>
>



-- 
Kees Cook
Pixel Security
