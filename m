From: David Howells <dhowells@redhat.com>
Subject: Has anyone got gcc-4.7.0 to build an SH64 kernel without dying?
Date: Tue, 29 May 2012 18:23:04 +0100
Message-ID: <10426.1338312184@redhat.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:27712 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752712Ab2E2RXQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 29 May 2012 13:23:16 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: lethal@linux-sh.org
Cc: dhowells@redhat.com, dhorak@redhat.com, linux-sh@vger.kernel.org, linux-arch@vger.kernel.org


Has anyone had any success building a gcc-4.7.0 that can build SH64 binaries
without dying?  I am seeing ICEs and SEGVs:

include/linux/genhd.h:214:3: internal compiler error: Segmentation fault
mm/madvise.c:285:2: internal compiler error: Segmentation fault
mm/percpu.c: In function 'pcpu_free_area':
mm/percpu.c:602:1: error: unrecognizable insn:
(insn 74 73 75 8 (set (reg:SI 279)
        (abs:SI (reg:SI 280))) mm/percpu.c:575 -1
     (nil))
mm/percpu.c:602:1: internal compiler error: in extract_insn, at recog.c:2123

I'm not entirely certain what target triplet I should be using.  I'm currently
using sh64-linux-gnu.  It does build a compiler (and it can find its
binutils).  I've also tried sh64-elf, but that doesn't work either.

David
