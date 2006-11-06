Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:30646 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1752820AbWKFMXk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 6 Nov 2006 07:23:40 -0500
Date: Mon, 6 Nov 2006 05:23:37 -0700
From: Matthew Wilcox <matthew@wil.cx>
Subject: Which architectures need 64-bit resources?
Message-ID: <20061106122337.GK27140@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

I have a patch sitting in the parisc tree which does:

 config RESOURCES_64BIT
-       bool "64 bit Memory and IO resources (EXPERIMENTAL)" if (!64BIT && EXPER
IMENTAL)
+       bool "64 bit Memory and IO resources (EXPERIMENTAL)" if (!64BIT && !PARI
SC && EXPERIMENTAL)
        default 64BIT

This is a bit selfish really, and it'll lead to something pretty ugly and
unmaintainable ...

+       bool "64 bit Memory and IO resources (EXPERIMENTAL)" if (!64BIT && !PARISC && !M68K && !AVR && !CRIS && !FRV && !H8300 && !M32R && !S390 && !SUPERH && !SPARC && !V850 && !XTENSA && EXPERIMENTAL)

at least if my understanding of those arches needs is correct.  Much better
to have the dependencies be positive:

+       bool "64 bit Memory and IO resources (EXPERIMENTAL)" if (!64BIT && (ARM || X86 || MIPS || PPC) && EXPERIMENTAL)

Do I have that set of architectures right?  Any others that need 64 bit
resource types?  Any there that shouldn't be there?  Should we ditch
the EXPERIMENTAL tag at the same time?
