Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:50084 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726079AbfE3SWz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Thu, 30 May 2019 14:22:55 -0400
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: single copy atomicity for double load/stores on 32-bit systems
Message-ID: <2fd3a455-6267-5d21-c530-41964a4f6ce9@synopsys.com>
Date: Thu, 30 May 2019 11:22:42 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Will Deacon <Will.Deacon@arm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: arcml <linux-snps-arc@lists.infradead.org>, lkml <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Message-ID: <20190530182242.bdB0jVpWalPYcAci66rlCQEobAyMwkW4umP3dq_8e_s@z>

Hi Peter,

Had an interesting lunch time discussion with our hardware architects pertinent to
"minimal guarantees expected of a CPU" section of memory-barriers.txt


|  (*) These guarantees apply only to properly aligned and sized scalar
|     variables.  "Properly sized" currently means variables that are
|     the same size as "char", "short", "int" and "long".  "Properly
|     aligned" means the natural alignment, thus no constraints for
|     "char", two-byte alignment for "short", four-byte alignment for
|     "int", and either four-byte or eight-byte alignment for "long",
|     on 32-bit and 64-bit systems, respectively.


I'm not sure how to interpret "natural alignment" for the case of double
load/stores on 32-bit systems where the hardware and ABI allow for 4 byte
alignment (ARCv2 LDD/STD, ARM LDRD/STRD ....)

I presume (and the question) that lkmm doesn't expect such 8 byte load/stores to
be atomic unless 8-byte aligned

ARMv7 arch ref manual seems to confirm this. Quoting

| LDM, LDC, LDC2, LDRD, STM, STC, STC2, STRD, PUSH, POP, RFE, SRS, VLDM, VLDR,
| VSTM, and VSTR instructions are executed as a sequence of word-aligned word
| accesses. Each 32-bit word access is guaranteed to be single-copy atomic. A
| subsequence of two or more word accesses from the sequence might not exhibit
| single-copy atomicity

While it seems reasonable form hardware pov to not implement such atomicity by
default it seems there's an additional burden on application writers. They could
be happily using a lockless algorithm with just a shared flag between 2 threads
w/o need for any explicit synchronization. But upgrade to a new compiler which
aggressively "packs" struct rendering long long 32-bit aligned (vs. 64-bit before)
causing the code to suddenly stop working. Is the onus on them to declare such
memory as c11 atomic or some such.

Thx,
-Vineet
