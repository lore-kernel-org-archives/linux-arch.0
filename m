Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Relay1.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 51F45EF02
	for <linux-arch@vger.kernel.org>; Wed,  7 Sep 2005 16:31:15 +0200 (CEST)
From: Andi Kleen <ak@suse.de>
Subject: memory clobbers for _syscall macros needed
Date: Wed, 7 Sep 2005 16:31:04 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509071631.05128.ak@suse.de>
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>


FYI. Michael Matz pointed out an i386 bug in that the _syscall* macros
are missing memory clobbers (see appended description)
x86-64 luckily already had a memory clobber, but from a quick grep 
a lot of other architectures are missing it. I would suggest you
fix your architecture by adding memory clobbers there.

>>>>
The problem is, that on i386 the syscallN
macro is defined like so:
  long __res; \
  __asm__ volatile ("int $0x80" \
        : "=a" (__res) \
        : "0" (__NR_##name),"b" ((long)(arg1)),"c" ((long)(arg2)), \
          "d" ((long)(arg3)),"S" ((long)(arg4)),"D" ((long)(arg5))); \

If one of the arguments (in the _llseek syscall it's the arg4) is a pointer
which the syscall is expected to write to (to the memory pointed to by this
ptr), then this side-effect is not captured in the asm.

If anyone uses this macro to define it's own version of the syscall
(sometimes necessary when not using glibc) and it's inlined, then GCC
doesn't know that this asm write to "*dest", when called like so for instance:
  out = 1;
  llseek (fd, bla, blubb, &out, trara)
  use (out);
Here nobody tells GCC that "out" actually is written to (just a pointer to it
is passed to the asm).  Hence GCC might (and in the above bug did)
copy-propagate "1" into the second use of "out".

The easiest solution would be to add a "memory" clobber to the definition
of this syscall macro.  As this is a syscall, it shouldn't inhibit too many
optimizations.
<<<

-Andi
