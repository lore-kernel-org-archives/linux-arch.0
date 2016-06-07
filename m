From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH] bitmap_equal memcmp optimization for s390
Date: Tue,  7 Jun 2016 10:37:40 +0200
Message-ID: <201606070837.u578YGqF033970@mx0a-001b2d01.pphosted.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "David S. Miller" <davem@davemloft.net>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: linux-arch.vger.kernel.org

Servus,

while working on an improved TLB flush logic for s390 I noticed that
for s390 cpumask_equal() alias bitmap_equal() can be improved for the
special case "(nbits % BITS_PER_LONG) == 0". The memcmp function can
be used in this case and we have an instruction for that ..

Trouble is that the default memcmp implementation uses a byte loop
while the __bitmap_equal function uses a loop over unsigned long.
For x86 the __bitmap_equal function is faster than memcmp, using
memcmp for the special case for all architectures is not correct.
Right now the patches uses a '#ifdef CONFIG_S390' to guard the
memcmp special case.

I hesitate to put another CONFIG_S390 into common code, alternatively
__HAVE_ARCH_MEMCMP could be used. There are 7 architectures with the
define: arc, arm64, blackfin, frv, powerpc, s390 and sparc.
Of those I guess only powerpc, s390 and sparc will have configs with
(NR_CPUS > BITS_PER_LONG). For (NR_CPUS <= BITS_PER_LONG) the xor
optimization is used.

powerpc, s390 and sparc do have optimized memcmp code, the question
is if it is faster then __bitmap_equal.

Now, CONFIG_S390 or __HAVE_ARCH_MEMCMP ?

blue skies,
  Martin
