Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from pfepb.post.tele.dk ([195.41.46.236]:37744 "EHLO
	pfepb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852Ab1AHNDF (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2011 08:03:05 -0500
Date: Sat, 8 Jan 2011 14:03:02 +0100
From: Sam Ravnborg <sam@ravnborg.org>
Subject: [RFC] kbuild: generic support for asm-generic
Message-ID: <20110108130302.GA21698@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: lkml <linux-kernel@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, linux arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Guan Xuetao <guanxuetao@mprc.pku.edu.cn>, Michal Marek <mmarek@suse.cz>
Message-ID: <20110108130302.f1a8lzYGCtX2pmDwk6gb8kh0jBUgwmgqKyWq22lVgh0@z>

Hi Arnd et all.

This is my second attempt to provide generic support for
architectures that use existing headers from asm-generic.

With this kbuild will read the file: arch/$ARCH/include/asm-generic

For each file listed in this file a wrapper is generated in
arch/$ARCH/inclue/generated/asm/

The patch include support so headers_install works.

The inspiration came from the unicore32 patchset,
but I redid this to make it more general.

I will follow-up with two patches.
One that implment the functionality.
A second that convert two headers in x86 to use the
new asm-generic stuff (only as an example).

	Sam
