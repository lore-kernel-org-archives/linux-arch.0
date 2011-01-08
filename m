From: Sam Ravnborg <sam@ravnborg.org>
Subject: [RFC] kbuild: generic support for asm-generic
Date: Sat, 8 Jan 2011 14:03:02 +0100
Message-ID: <20110108130302.GA21698@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kbuild-owner@vger.kernel.org
To: lkml <linux-kernel@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, linux arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Guan Xuetao <guanxuetao@mprc>
List-Id: linux-arch.vger.kernel.org

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
