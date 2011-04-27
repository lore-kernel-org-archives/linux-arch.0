From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4] kbuild: asm-generic support
Date: Wed, 27 Apr 2011 21:52:37 +0200
Message-ID: <201104272152.37889.arnd@arndb.de>
References: <20110108130302.GA21698@merkur.ravnborg.org> <20110427194225.GA6551@merkur.ravnborg.org> <20110427194647.GA6621@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <20110427194647.GA6621@merkur.ravnborg.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>, Michal Marek <mmarek@suse.cz>, 'lkml' <linux-kernel@vger.kernel.org>, 'linux-kbuild' <linux-kbuild@vger.kernel.org>, 'linux arch' <linux-arch@vger.kernel.org>, 'Guan Xuetao' <guanxuetao@mprc.pku.edu.cn>, Remis Lima Baima <remis.developer@googlemail.com>
List-Id: linux-arch.vger.kernel.org

On Wednesday 27 April 2011 21:46:47 Sam Ravnborg wrote:
> From 8546953f0c87d6b1c37c25df73511780c86ad89d Mon Sep 17 00:00:00 2001
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Fri, 22 Apr 2011 14:45:13 +0200
> Subject: [PATCH] kbuild: asm-generic support
> 
> There is an increasing amount of header files
> shared between individual architectures in asm-generic.
> To avoid a lot of dummy wrapper files that just
> include the corresponding file in asm-generic provide
> some basic support in kbuild for this.
> 
> With the following patch an architecture can maintain
> a list of files in the file arch/$(ARCH)/include/asm/Kbuild
> 
> To use a generic file just add:
> 
>         generic-y += <name-of-header-file.h>
> 
> For each file listed kbuild will generate the necessary
> wrapper in arch/$(ARCH)/include/generated/asm.
> 
> When installing userspace headers a wrapper is likewise created.
> 
> The original inspiration for this came from the unicore32
> patchset - although a different method is used.
> 
> The patch includes several improvements from Arnd Bergmann.
> Michael Marek contributed Makefile.asm-generic.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Acked-by: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>
> Tested-by: Guan Xuetao <guanxuetao@mprc.pku.edu.cn>
> Cc: Arnd Bergmann <arnd@arndb.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

I'm glad to see this finally happen.

Maybe you can mention Remis Baima in the changelog as well,
he did an earlier implementation back in the days when some
architectures were still using include/asm-${ARCH}, which IIRC
did not get merged because of the complexity associated with
that.

	Arnd
