Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from condef-07.nifty.com ([202.248.20.72]:35505 "EHLO
        condef-07.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932309AbdEOL1d (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 May 2017 07:27:33 -0400
Received: from conuserg-08.nifty.com ([10.126.8.71])by condef-07.nifty.com with ESMTP id v4FBGeWc010177
        for <linux-arch@vger.kernel.org>; Mon, 15 May 2017 20:16:40 +0900
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 1/5] of: remove drivers/of/testcase-data from include search path for CPP
Date: Mon, 15 May 2017 20:14:44 +0900
Message-ID: <1494846888-18966-2-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1494846888-18966-1-git-send-email-yamada.masahiro@socionext.com>
References: <1494846888-18966-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: devicetree@vger.kernel.org
Cc: linux-arch <linux-arch@vger.kernel.org>, Omar Sandoval <osandov@osandov.com>, Gaurav Minocha <gaurav.minocha.os@gmail.com>, Grant Likely <grant.likely@linaro.org>, Frank Rowand <frowand.list@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Olof Johansson <olof@lixom.net>, Russell King <linux@armlinux.org.uk>, Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <mmarek@suse.com>, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Message-ID: <20170515111444.I4jW0uLNZ9crA7s-7yc14i5_YAuiCTsFJEsuZW7PlqA@z>

This search path was added by commit b5190516b282 ("of: Move testcase
FDT data into drivers/of").  At that time, it was needed for platform
DT files to include testcase data.

It became unnecessary when commit ae9304c9d311 ("Adding selftest
testdata dynamically into live tree") introduced dynamic addition of
testcase data, but it missed to delete this search path.

Moreover, the directory drivers/of/testcase-data does not exist since
commit 19fd74879a32 ("of/unittest: Rename selftest.c to unittest.c").

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 scripts/Makefile.lib | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 58c05e5..011d464 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -176,7 +176,6 @@ ld_flags       = $(LDFLAGS) $(ldflags-y)
 dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
 		 -I$(srctree)/arch/$(SRCARCH)/boot/dts                   \
 		 -I$(srctree)/scripts/dtc/include-prefixes               \
-		 -I$(srctree)/drivers/of/testcase-data                   \
 		 -undef -D__DTS__
 
 # Finds the multi-part object the current object will be linked into
-- 
2.7.4
