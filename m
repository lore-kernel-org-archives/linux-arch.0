From: Mark Rutland <mark.rutland@arm.com>
Subject: [RFC PATCH 0/4] API for inhibiting speculative arbitrary read primitives
Date: Wed,  3 Jan 2018 22:38:23 +0000
Message-ID: <20180103223827.39601-1-mark.rutland@arm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55496 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751078AbeACWid (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Jan 2018 17:38:33 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>

Recently, Google Project Zero discovered several classes of attack
against speculative execution. One of these, known as variant-1, allows
explicit bounds checks to be bypassed under speculation, providing an
arbitrary read gadget. Further details can be found on the GPZ blog [1]
and the Documentation patch in this series.

There are a number of potential gadgets in the Linux codebase, and
mitigations for these are architecture-specific.

This RFC attempts to provide a cross-architecture API for inhibiting
these primitives. Hopefully, architecture-specific mitigations can be
unified behind this. An arm64 implementation is provided following the
architecturally recommended sequence laid out in the Arm whitepaper [2].
The API is based on a proposed compiler intrinsic [3].

I've provided a patch to BPF as an example use of the API. I know that
this is incomplete and less than optimal. I'd appreciate feedback from
other affected architectures as to whether this API is suitable for
their required mitigation.

I've pushed the series to my kernel.org repo [4].

[1] https://googleprojectzero.blogspot.co.uk/2018/01/reading-privileged-memory-with-side.html
[2] https://developer.arm.com/support/security-update
[3] https://developer.arm.com/support/security-update/compiler-support-for-mitigations
[4] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git core/nospec

Thanks,
Mark.

Mark Rutland (4):
  asm-generic/barrier: add generic nospec helpers
  Documentation: document nospec helpers
  arm64: implement nospec_{load,ptr}()
  bpf: inhibit speculated out-of-bounds pointers

 Documentation/speculation.txt    | 99 ++++++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/barrier.h | 61 +++++++++++++++++++++++++
 include/asm-generic/barrier.h    | 76 ++++++++++++++++++++++++++++++
 kernel/bpf/arraymap.c            | 21 ++++++---
 kernel/bpf/cpumap.c              |  8 ++--
 kernel/bpf/devmap.c              |  6 ++-
 kernel/bpf/sockmap.c             |  6 ++-
 7 files changed, 265 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/speculation.txt

-- 
2.11.0
