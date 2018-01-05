From: Mark Rutland <mark.rutland@arm.com>
Subject: [RFCv2 0/4] API for inhibiting speculative arbitrary read primitives
Date: Fri,  5 Jan 2018 14:57:46 +0000
Message-ID: <20180105145750.53294-1-mark.rutland@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: dan.j.williams@intel.com, elena.reshetova@intel.com, corbet@lwn.net, alan@linux.intel.com, peterz@infradead.org, will.deacon@arm.com, gregkh@linuxfoundation.org, tglx@linutronix.de, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-arch.vger.kernel.org

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

Since v1 [5]:
* Remove the nospec_*load helpers
* Added nospec_array_ptr()
* Rework asm-generic implementation to fit other architectures
* Improve documentation

[1] https://googleprojectzero.blogspot.co.uk/2018/01/reading-privileged-memory-with-side.html
[2] https://developer.arm.com/support/security-update
[3] https://developer.arm.com/support/security-update/compiler-support-for-mitigations
[4] git://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git core/nospec
[5] https://lkml.kernel.org/r/20180103223827.39601-1-mark.rutland@arm.com

Thanks,
Mark.

Mark Rutland (4):
  asm-generic/barrier: add generic nospec helpers
  Documentation: document nospec helpers
  arm64: implement nospec_{load,ptr}()
  bpf: inhibit speculated out-of-bounds pointers

 Documentation/speculation.txt    | 166 +++++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/barrier.h |  55 +++++++++++++
 include/asm-generic/barrier.h    |  68 ++++++++++++++++
 kernel/bpf/arraymap.c            |  20 +++--
 kernel/bpf/cpumap.c              |   5 +-
 kernel/bpf/devmap.c              |   3 +-
 kernel/bpf/sockmap.c             |   3 +-
 7 files changed, 308 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/speculation.txt

-- 
2.11.0
