From: Sam Ravnborg <sam@ravnborg.org>
Subject: [RFC v2] kbuild: generic support for asm-generic
Date: Sun, 9 Jan 2011 09:28:51 +0100
Message-ID: <20110109082851.GA10463@merkur.ravnborg.org>
References: <20110108130302.GA21698@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110108130302.GA21698@merkur.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lkml <linux-kernel@vger.kernel.org>, linux-kbuild <linux-kbuild@vger.kernel.org>, linux arch <linux-arch@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Guan Xuetao <guanxuetao@mprc>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-arch.vger.kernel.org

On Sat, Jan 08, 2011 at 02:03:02PM +0100, Sam Ravnborg wrote:
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

Based on feedback from Stephen, Guang and Arnd here
is a new patchset supporting generic headers.

Changes since v2:
- Fix spelling miss in LINUXINCLUDE (Stephen)
- Properly delete file with mrproper (Guang)
- Fixed support for headers that are not exported (Guang)
- New way to list files used from the generic set (Arnd)

We now list which files are sued from the generic set in:
arch/$(ARCH)/include/asm/Kbuild like this:

    generic-y += termios.h

	Sam
