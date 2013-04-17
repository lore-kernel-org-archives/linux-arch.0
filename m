From: James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 1/1] metag: avoid unnecessary builtin dtb rebuilds
Date: Wed, 17 Apr 2013 11:02:55 +0100
Message-ID: <1366192975-14953-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:46380 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965955Ab3DQKDc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 17 Apr 2013 06:03:32 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org
Cc: James Hogan <james.hogan@imgtec.com>, Stephen Warren <swarren@nvidia.com>, Vineet Gupta <Vineet.Gupta1@synopsys.com>, Grant Likely <grant.likely@secretlab.ca>, Michal Marek <mmarek@suse.cz>, Sam Ravnborg <sam@ravnborg.org>

The builtin .dtb.S intermediate file needs to be marked with .SECONDARY
so that it isn't automatically deleted (which causes it to be
regenerated on every build). Also add *.dtb.S to clean-files so it gets
cleaned up by make clean.

Similarly, if the specified builtin dtb isn't already in dtb-y (e.g.
imported into the tree and specified in CONFIG_METAG_BUILTIN_DTB_NAME)
it too will be treated as an intermediate and deleted automatically
(again causing it to be regenerated on every build), so add it to dtb-y
so it gets added to targets and the dtbs target.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Stephen Warren <swarren@nvidia.com>
Cc: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Michal Marek <mmarek@suse.cz>
Cc: Sam Ravnborg <sam@ravnborg.org>
---
 arch/metag/boot/dts/Makefile | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/metag/boot/dts/Makefile b/arch/metag/boot/dts/Makefile
index e0b5afd..dbd9521 100644
--- a/arch/metag/boot/dts/Makefile
+++ b/arch/metag/boot/dts/Makefile
@@ -4,13 +4,17 @@ dtb-y	+= skeleton.dtb
 builtindtb-y				:= skeleton
 
 ifneq ($(CONFIG_METAG_BUILTIN_DTB_NAME),"")
-	builtindtb-y			:= $(CONFIG_METAG_BUILTIN_DTB_NAME)
+	builtindtb-y			:= $(patsubst "%",%,$(CONFIG_METAG_BUILTIN_DTB_NAME))
 endif
-obj-$(CONFIG_METAG_BUILTIN_DTB)	+= $(patsubst "%",%,$(builtindtb-y)).dtb.o
+
+dtb-$(CONFIG_METAG_BUILTIN_DTB)	+= $(builtindtb-y).dtb
+obj-$(CONFIG_METAG_BUILTIN_DTB)	+= $(builtindtb-y).dtb.o
 
 targets	+= dtbs
 targets	+= $(dtb-y)
 
+.SECONDARY: $(obj)/$(builtindtb-y).dtb.S
+
 dtbs: $(addprefix $(obj)/, $(dtb-y))
 
-clean-files += *.dtb
+clean-files += *.dtb *.dtb.S
-- 
1.8.1.2
