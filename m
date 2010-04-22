From: npiggin@suse.de
Subject: [patch 00/14] convert remaining architectures to pagefault_out_of_memory()
Date: Fri, 23 Apr 2010 02:06:13 +1000
Message-ID: <20100422160613.723698029@suse.de>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:36301 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753662Ab0DVQRa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 22 Apr 2010 12:17:30 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>

Hi,

The following patches convert the rest of the architectures to use
pagefault_on_out_of_memory. The reason is to provide a consistent
architecture independent page fault hook that the kernel can use.
Also see commit 1c0fe6e3bd

x86, arm, mips, sparc, s390, uml are already using this.

Subsequent patches will be sent to arch maintainers and cc'ed to
linux-arch.

Thanks,
Nick
