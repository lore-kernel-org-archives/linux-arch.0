Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55582 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbfDLUjr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 12 Apr 2019 16:39:47 -0400
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v2 0/5] cpu/speculation: Add 'mitigations=' cmdline option
Date: Fri, 12 Apr 2019 15:39:27 -0500
Message-ID: <cover.1555085500.git.jpoimboe@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Kosina <jikos@kernel.org>, Waiman Long <longman@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Jon Masters <jcm@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tyler Hicks <tyhicks@canonical.com>, Linus Torvalds <torvalds@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Steven Price <steven.price@arm.com>, Phil Auld <pauld@redhat.com>
Message-ID: <20190412203927.GqjOnEw9WLkRpmak28qB9aG5qvxuwKWKeEwe3zPA6K0@z>

v2:
- docs improvements: [Randy, Michael]
- Rename to "mitigations=" [Michael]
- Add cpu_mitigations_off() function wrapper [Michael]
- x86: Simplify logic [Boris]
- powerpc: Fix no_rfi_flush checking bug (use '&&' instead of '||')
- arm64: Rebase onto Jeremy Linton's v7 patches [Will]
- arm64: "kpti command line option" [Steve P]
- arm64: Add nospectre_v2 support

-----------

Keeping track of the number of mitigations for all the CPU speculation
bugs has become overwhelming for many users.  It's getting more and more
complicated to decide which mitigations are needed for a given
architecture.  Complicating matters is the fact that each arch tends to
have its own custom way to mitigate the same vulnerability.

Most users fall into a few basic categories:

a) they want all mitigations off;

b) they want all reasonable mitigations on, with SMT enabled even if
   it's vulnerable; or

c) they want all reasonable mitigations on, with SMT disabled if
   vulnerable.

Define a set of curated, arch-independent options, each of which is an
aggregation of existing options:

- mitigations=off: Disable all mitigations.

- mitigations=auto: [default] Enable all the default mitigations, but
  leave SMT enabled, even if it's vulnerable.

- mitigations=auto,nosmt: Enable all the default mitigations, disabling
  SMT if needed by a mitigation.

Josh Poimboeuf (5):
  cpu/speculation: Add 'mitigations=' cmdline option
  x86/speculation: Support 'mitigations=' cmdline option
  powerpc/speculation: Support 'mitigations=' cmdline option
  s390/speculation: Support 'mitigations=' cmdline option
  arm64/speculation: Support 'mitigations=' cmdline option

 .../admin-guide/kernel-parameters.txt         | 34 +++++++++++++++++++
 arch/arm64/kernel/cpu_errata.c                |  6 +++-
 arch/arm64/kernel/cpufeature.c                |  8 ++++-
 arch/powerpc/kernel/security.c                |  6 ++--
 arch/powerpc/kernel/setup_64.c                |  2 +-
 arch/s390/kernel/nospec-branch.c              |  3 +-
 arch/x86/kernel/cpu/bugs.c                    | 11 ++++--
 arch/x86/mm/pti.c                             |  4 ++-
 include/linux/cpu.h                           | 24 +++++++++++++
 kernel/cpu.c                                  | 15 ++++++++
 10 files changed, 103 insertions(+), 10 deletions(-)

-- 
2.17.2
