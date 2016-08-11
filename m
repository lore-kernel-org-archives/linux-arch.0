From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] Xen: remove -fshort-wchar gcc flag
Date: Thu, 11 Aug 2016 14:39:50 +0200
Message-ID: <16541778.WMH6K24aDt@wuerfel>
References: <1470910580-18458-1-git-send-email-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kbuild-owner@vger.kernel.org>
In-Reply-To: <1470910580-18458-1-git-send-email-npiggin@gmail.com>
Sender: linux-kbuild-owner@vger.kernel.org
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, Michal Marek <mmarek@suse.com>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, David Vrabel <david.vrabel@citrix.com>, Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org
List-Id: linux-arch.vger.kernel.org

A previous patch added the --no-wchar-size-warning to the Makefile to
avoid this harmless warning:

arm-linux-gnueabi-ld: warning: drivers/xen/efi.o uses 2-byte wchar_t yet the output is to use 4-byte wchar_t; use of wchar_t values across objects may fail

Changing kbuild to use thin archives instead of recursive linking
unfortunately brings the same warning back during the final link.

This time, we remove the -fshort-wchar flag that originally caused
the warning, hopefully fixing the problem for good. I don't see
any reason for having the flag in the first place, as the Xen code
does not use wchar_t at all.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 971a69db7dc0 ("Xen: don't warn about 2-byte wchar_t in efi")
---
On Thursday, August 11, 2016 8:16:14 PM CEST Nicholas Piggin wrote:
> Hi,
> 
> I would like to submit the kbuild changes in patches 1-3 for
> consideration.
> 
> I've taken on the feedback, so thanks everybody for that. The
> biggest change since last time is a more general way for
> architectures to do a post-link pass in patch 3.
> 
> On the question of whether to enable thin archives unconditionally,
> I prefer to have architectures enable them as they are tested. But
> I would like to see everybody moved as soon as possible and the
> incremental linking removed.

It would be nice to get this patch merged along with the thin
archive conversion, either by merging it through the xen
Tree, or by making it part of Nick's series with an Ack
from the xen maintainers.

diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
index 8feab810aed9..7f188b8d0c67 100644
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -7,9 +7,6 @@ obj-y	+= xenbus/
 nostackp := $(call cc-option, -fno-stack-protector)
 CFLAGS_features.o			:= $(nostackp)
 
-CFLAGS_efi.o				+= -fshort-wchar
-LDFLAGS					+= $(call ld-option, --no-wchar-size-warning)
-
 dom0-$(CONFIG_ARM64) += arm-device.o
 dom0-$(CONFIG_PCI) += pci.o
 dom0-$(CONFIG_USB_SUPPORT) += dbgp.o

