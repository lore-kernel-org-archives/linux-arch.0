Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40301 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731091AbeITWID (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Sep 2018 18:08:03 -0400
Received: by mail-pg1-f195.google.com with SMTP id l63-v6so4667737pga.7
        for <linux-arch@vger.kernel.org>; Thu, 20 Sep 2018 09:23:48 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH security-next v2 00/26] LSM: Explict LSM ordering
Date: Thu, 20 Sep 2018 09:23:12 -0700
Message-ID: <20180920162338.21060-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20180920162312.RMxIebFB2Q3BxBCtC0jZjgzW8sYtrHgC7fHhZT1MVQI@z>

v2:
- add "lsm.order=" and CONFIG_LSM_ORDER instead of overloading "security="
- reorganize introduction of ordering logic code

Updated cover letter:

This refactors the LSM registration and initialization infrastructure
to more centrally support different LSM types. What was considered a
"major" LSM is kept for legacy use of the "security=" boot parameter,
and now overlaps with the new class of "exclusive" LSMs for the future
blob sharing (to be added later). The "minor" LSMs become more well
defined as a result of the refactoring.

Instead of continuing to (somewhat improperly) overload the kernel's
initcall system, this changes the LSM infrastructure to store a
registration structure (struct lsm_info) table instead, where metadata
about each LSM can be recorded (name, flags, order, enable flag, init
function). This can be extended in the future to include things like
required blob size for the coming "blob sharing" LSMs.

The "major" LSMs had to individually negotiate which of them should be
enabled. This didn't provide a way to negotiate combinations of other
LSMs (as will be needed for "blob sharing" LSMs). This is solved by
providing the LSM infrastructure with all the details needed to make
the choice (exposing the per-LSM "enabled" flag, if used, the LSM
characteristics, and ordering expectations).

As a result of the refactoring, the "minor" LSMs are able to remove
the open-coded security_add_hooks() calls for "capability", "yama",
and "loadpin", and to redefine "integrity" properly as a general LSM.
(Note that "integrity" actually defined _no_ hooks, but needs the early
initialization).

With all LSMs being proessed centrally, it was possible to implement
a new boot parameter "lsm.order=" to provide explicit ordering, which
is helpful for the future "blob sharing" LSMs. Matching this is the
new CONFIG_LSM_ORDER, which replaces CONFIG_DEFAULT_SECURITY, as it
provides a higher granularity of control.

To better show LSMs activation some debug reporting was added (enabled
with the "lsm.debug" boot commandline option).

Finally, I added a WARN() around LSM initialization failures, which
appear to have always been silently ignored. (Realistically any LSM init
failures would have only been due to catastrophic kernel issues that
would render a system unworkable anyway, but it'd be better to expose
the problem as early as possible.)

-Kees

Kees Cook (26):
  LSM: Correctly announce start of LSM initialization
  vmlinux.lds.h: Avoid copy/paste of security_init section
  LSM: Rename .security_initcall section to .lsm_info
  LSM: Remove initcall tracing
  LSM: Convert from initcall to struct lsm_info
  vmlinux.lds.h: Move LSM_TABLE into INIT_DATA
  LSM: Convert security_initcall() into DEFINE_LSM()
  LSM: Record LSM name in struct lsm_info
  LSM: Provide init debugging infrastructure
  LSM: Don't ignore initialization failures
  LSM: Introduce LSM_FLAG_LEGACY_MAJOR
  LSM: Provide separate ordered initialization
  LSM: Plumb visibility into optional "enabled" state
  LSM: Lift LSM selection out of individual LSMs
  LSM: Introduce lsm.enable= and lsm.disable=
  LSM: Prepare for reorganizing "security=" logic
  LSM: Refactor "security=" in terms of enable/disable
  LSM: Build ordered list of ordered LSMs for init
  LSM: Introduce CONFIG_LSM_ORDER
  LSM: Introduce "lsm.order=" for boottime ordering
  LoadPin: Initialize as ordered LSM
  Yama: Initialize as ordered LSM
  LSM: Introduce enum lsm_order
  capability: Mark as LSM_ORDER_FIRST
  LSM: Separate idea of "major" LSM from "exclusive" LSM
  LSM: Add all exclusive LSMs to ordered initialization

 .../admin-guide/kernel-parameters.txt         |   7 +
 arch/arc/kernel/vmlinux.lds.S                 |   1 -
 arch/arm/kernel/vmlinux-xip.lds.S             |   1 -
 arch/arm64/kernel/vmlinux.lds.S               |   1 -
 arch/h8300/kernel/vmlinux.lds.S               |   1 -
 arch/microblaze/kernel/vmlinux.lds.S          |   2 -
 arch/powerpc/kernel/vmlinux.lds.S             |   2 -
 arch/um/include/asm/common.lds.S              |   2 -
 arch/xtensa/kernel/vmlinux.lds.S              |   1 -
 include/asm-generic/vmlinux.lds.h             |  25 +-
 include/linux/init.h                          |   2 -
 include/linux/lsm_hooks.h                     |  43 ++-
 include/linux/module.h                        |   1 -
 security/Kconfig                              |  42 +--
 security/apparmor/lsm.c                       |  16 +-
 security/commoncap.c                          |   8 +-
 security/integrity/iint.c                     |   5 +-
 security/loadpin/loadpin.c                    |  10 +-
 security/security.c                           | 304 ++++++++++++++----
 security/selinux/hooks.c                      |  16 +-
 security/smack/smack_lsm.c                    |   8 +-
 security/tomoyo/tomoyo.c                      |   7 +-
 security/yama/yama_lsm.c                      |   7 +-
 23 files changed, 348 insertions(+), 164 deletions(-)

-- 
2.17.1
