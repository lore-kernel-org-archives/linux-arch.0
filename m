From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: Generic section maintainers
Date: Wed, 3 Aug 2016 12:56:22 -0700
Message-ID: <CAB=NE6VpHJLicvrKhPhQD4p+hNRCpvPJU7AXFAQdxXeDWfPLJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Josh Poimboeuf <jpoimboe@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joe Perches <joe@perches.com>
List-Id: linux-arch.vger.kernel.org

Arnd, Josh,

In my linker table work [0], other than the linker table work and
section ranges stuff, I'm adding:

o include/linux/sections.h
o include/asm-generic/section-core.h (not in RFC v3 but it is in my
RFC v4 series not yet posted, splitting this up fixes compilation on
powerpc which otherwise creates a header issue nightmare to resolve)

I extend include/asm-generic/sections.h to then include
<asm-generic/section-core.h>, and furthermore provide the beginning of
a central place to document in a central place all common sections.

As per checkpatch complaints I'll be adding myself to MAINTAINERS for
the linker table headers, section ranges, but noticed then we don't
have anyone in particularly looking carefully after
include/asm-generic/sections.h other than the default which is Arnd.
Given this work on streamlining the section stuff, I'd like to help so
am considering adding a specific entry on MAINTAINRERS for generic
sections and adding myself to it along with Arnd. Wanted to check if
this is OK. While at it, it occurred to me that you might be
interested in this a swell Josh, given your work with objtool. Would
anyone else like to help with active maintenance / review of these ?

So is this OK to merge into my series into the patch "sections.h: add
sections header to collect all section info".

diff --git a/MAINTAINERS b/MAINTAINERS
index 49b354cb455a..9919277c66ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5190,6 +5190,18 @@ S: Supported
 F: drivers/base/power/domain*.c
 F: include/linux/pm_domain.h

+GENERIC SECTIONS
+M: "Luis R. Rodriguez" <mcgrof@kernel.org>
+M: Josh Poimboeuf <jpoimboe@redhat.com>
+M: Arnd Bergmann <arnd@arndb.de>
+L: linux-arch@vger.kernel.org
+L: linux-kernel@vger.kernel.org
+S: Supported
+F: include/asm-generic/section-core.h
+F: include/asm-generic/sections.h
+F: include/asm-generic/vmlinux.lds.h
+F: Documentation/DocBook/sections.tmpl
+
 GENERIC UIO DRIVER FOR PCI DEVICES
 M: "Michael S. Tsirkin" <mst@redhat.com>
 L: kvm@vger.kernel.org


[0] https://lkml.kernel.org/r/1469222687-1600-1-git-send-email-mcgrof@kernel.org

  Luis
