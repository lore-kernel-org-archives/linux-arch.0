From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 0/3] nospec: Various fix-ups for include/linux/nospec.h
Date: Fri, 16 Feb 2018 13:20:37 -0800
Message-ID: <151881603700.17395.6474595347527003884.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:40080 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750727AbeBPV3n (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 16 Feb 2018 16:29:43 -0500
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mingo@kernel.org
Cc: linux-arch@vger.kernel.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>

Hi Ingo,

Here is a small pile of cleanups and fixes for nospec.h after inspection
from Linus, Rasmus, and Christian. Full changelogs below:

These have received a build success notification from 0day across 126
configs.

---

Dan Williams (2):
      nospec: Kill array_index_nospec_mask_check()
      nospec: Include asm/barrier.h dependency

Rasmus Villemoes (1):
      nospec: Allow index argument to have const-qualified type


 include/linux/nospec.h |   26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

--
    nospec: Kill array_index_nospec_mask_check()
    
    There are multiple problems with the dynamic sanity checking in
    array_index_nospec_mask_check():
    
    * It causes unnecessary overhead in the 32-bit case since integer sized
      @index values will no longer cause the check to be compiled away like
      in the 64-bit case.
    
    * In the 32-bit case it may trigger with user controllable input when
      the expectation is that should only trigger during development of new
      kernel enabling.
    
    * The macro reuses the input parameter in multiple locations which is
      broken if someone passes an expression like 'index++' to
      array_index_nospec().


    
    nospec: Allow index argument to have const-qualified type
    
    The last expression in a statement expression need not be a bare
    variable, quoting gcc docs
    
      The last thing in the compound statement should be an expression
      followed by a semicolon; the value of this subexpression serves as the
      value of the entire construct.
    
    and we already use that in e.g. the min/max macros which end with a
    ternary expression.
    
    This way, we can allow index to have const-qualified type, which will in
    some cases avoid the need for introducing a local copy of index of
    non-const qualified type. That, in turn, can prevent readers not
    familiar with the internals of array_index_nospec from wondering about
    the seemingly redundant extra variable, and I think that's worthwhile
    considering how confusing the whole _nospec business is.
    
    The expression _i&_mask has type unsigned long (since that is the type
    of _mask, and the BUILD_BUG_ONs guarantee that _i will get promoted to
    that), so in order not to change the type of the whole expression, add
    a cast back to typeof(_i).

    
    nospec: Include asm/barrier.h dependency
    
    The nospec.h header expects the per-architecture header file
    asm/barrier.h to optionally define array_index_mask_nospec(). Include
    that dependency to prevent inadvertent fallback to the default
    array_index_mask_nospec() implementation. The default implementation may
    not provide a full mitigation on architectures that perform data value
    speculation.
