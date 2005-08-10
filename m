Return-Path: <linux-arch-owner@vger.kernel.org>
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] consolidate sys_ptrace
Date: Wed, 10 Aug 2005 09:59:01 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F041A27D7@scsmsx401.amr.corp.intel.com>
From: "Luck, Tony" <tony.luck@intel.com>
To: Christoph Hellwig <hch@lst.de>, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

>Some architectures have a too different ptrace so we have to exclude
>them: alpha, ia64, m32r, parisc, sparc, sparc64.  They continue to
>keep their implementations.

So it should be no surprise that this patch works ok for ia64, but here
is the ACK anyway.

>+#ifndef __ARCH_SYS_PTRACE

Most of the existing "#define ARCH_foo" uses don't have a prepended
"__" (current score is 20 to 3).  So there is a small question of
going with the prevailing style, or doing the right thing.  Just in
case anyone else raises this, my vote is with "__".

-Tony
