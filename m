From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH security-next v3 00/29] LSM: Explict LSM ordering
Date: Fri, 28 Sep 2018 13:01:30 -0700
Message-ID: <CAGXu5jKQVDW8Wp0ESv2raa0xJnHCCMNqFCzZ5jSVXQ=Dp7FF8A@mail.gmail.com>
References: <20180925001832.18322-1-keescook@chromium.org> <e6122c7d-bd29-d081-3c1e-96b7c369d4fe@schaufler-ca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e6122c7d-bd29-d081-3c1e-96b7c369d4fe@schaufler-ca.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: James Morris <jmorris@namei.org>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

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
