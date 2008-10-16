From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Subject: [RFC patch 00/15] Tracer Timestamping
Date: Thu, 16 Oct 2008 19:27:29 -0400
Message-ID: <20081016232729.699004293@polymtl.ca>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757610AbYJPX4I@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Steve
Cc: David Miller <davem@davemloft.net>
List-Id: linux-arch.vger.kernel.org

Hi,

Starting with the bottom of my LTTng patchset
(git://git.kernel.org/pub/scm/linux/kernel/git/compudj/linux-2.6-lttng.git)
I post as RFC the timestamping infrastructure I have been using for a while in
the tracer. It integrates get_cycles() standardization following David Miller's
comments I did more recently.

It also deals with 32 -> 64 bits timestamp counter extension with a RCU-style
algorithm, which is especially useful on MIPS and SuperH architectures.

There is also a TSC synchronization test within this patchset to detect
unsynchronized TSCs. See comments in this specific patch to figure out the
difference between the current x86 tsc_sync.c and the one I propose in this
patch.

It also provides an architecture-agnostic fallback in case there is no
timestamp counter available : basically, it's
(jiffies << 13) | atomically_incremented_counter (if there are more than 8192
events per jiffy, time will still be monotonic, but will increment faster than
the actual system frequency).

Comments are welcome. Note that this is only the beginning of the patchset. I
plan to submit the event ID allocation/portable event typing aimed at exporting
the data to userspace and buffering mechanism as soon as I integrate a core
version of the LTTV userspace tools to the kernel build tree. Other than that, I
currently have a tracer which fulfills most of the requirements expressed
earlier. I just fear that if I release only the kernel part without foolproof
binary-to-ascii trace decoder within the kernel, people might be a bit reluctant
to fetch a separate userspace package.

Mathieu

-- 
Mathieu Desnoyers
Computer Engineering Ph.D. Student, Ecole Polytechnique de Montreal
OpenPGP key fingerprint: 8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68
