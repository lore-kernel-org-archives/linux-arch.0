From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] kbuild: generic support for asm-generic
Date: Sat, 8 Jan 2011 21:53:31 +0100
Message-ID: <201101082153.31837.arnd@arndb.de>
References: <20110108130302.GA21698@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:49152 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685Ab1AHUxq (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 8 Jan 2011 15:53:46 -0500
In-Reply-To: <20110108130302.GA21698@merkur.ravnborg.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, linux arch <linux-arch@vger.kernel.org>, Guan Xuetao <guanxuetao@mprc.pku.edu.cn>, Michal Marek <mmarek@suse.cz>

On Saturday 08 January 2011, Sam Ravnborg wrote:
> Hi Arnd et all.
> 
> This is my second attempt to provide generic support for
> architectures that use existing headers from asm-generic.
> 
> With this kbuild will read the file: arch/$ARCH/include/asm-generic
> 
> For each file listed in this file a wrapper is generated in
> arch/$ARCH/inclue/generated/asm/
> 
> The patch include support so headers_install works.
> 
> The inspiration came from the unicore32 patchset,
> but I redid this to make it more general.
> 
> I will follow-up with two patches.
> One that implment the functionality.
> A second that convert two headers in x86 to use the
> new asm-generic stuff (only as an example).

Very nice patch!

This is something I'd certainly like to see upstream, and you made
a good point about keeping it seperate from the unicore32 submission.

One detail I don't like too much is that you now have two different
formats for specifying lists of headers to do something with.

Instead of the new arch/*/include/asm-generic file, how about listing
all files that are actually provided by the architecture as "header-y"
in arch/*/include/asm/Kbuild, and listing all files as something
else in include/asm-generic/Kbuild and include/asm-generic/Kbuild.asm?

	Arnd
