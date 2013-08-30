From: Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 09/11] xtensa: don't use echo -e needlessly
Date: Fri, 30 Aug 2013 19:35:01 +0400
Message-ID: <1377876903-27860-10-git-send-email-jcmvbkbc@gmail.com>
References: <1377876903-27860-1-git-send-email-jcmvbkbc@gmail.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:59925 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756599Ab3H3Pf0 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 30 Aug 2013 11:35:26 -0400
Received: by mail-lb0-f173.google.com with SMTP id o14so1842065lbi.4
        for <linux-arch@vger.kernel.org>; Fri, 30 Aug 2013 08:35:25 -0700 (PDT)
In-Reply-To: <1377876903-27860-1-git-send-email-jcmvbkbc@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Chris Zankel <chris@zankel.net>
Cc: Marc Gauthier <marc@tensilica.com>, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, Max Filippov <jcmvbkbc@gmail.com>

-e is not needed to output strings without escape sequences. This breaks
big endian FSF build when the shell is dash, because its builtin echo
doesn't understand '-e' switch and outputs it in the echoed string.

Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/Makefile      |    4 ++--
 arch/xtensa/boot/Makefile |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/xtensa/Makefile b/arch/xtensa/Makefile
index 136224b..81250ec 100644
--- a/arch/xtensa/Makefile
+++ b/arch/xtensa/Makefile
@@ -55,10 +55,10 @@ ifneq ($(CONFIG_LD_NO_RELAX),)
 LDFLAGS := --no-relax
 endif
 
-ifeq ($(shell echo -e __XTENSA_EB__ | $(CC) -E - | grep -v "\#"),1)
+ifeq ($(shell echo __XTENSA_EB__ | $(CC) -E - | grep -v "\#"),1)
 CHECKFLAGS += -D__XTENSA_EB__
 endif
-ifeq ($(shell echo -e __XTENSA_EL__ | $(CC) -E - | grep -v "\#"),1)
+ifeq ($(shell echo __XTENSA_EL__ | $(CC) -E - | grep -v "\#"),1)
 CHECKFLAGS += -D__XTENSA_EL__
 endif
 
diff --git a/arch/xtensa/boot/Makefile b/arch/xtensa/boot/Makefile
index 64ffc4b..ca20a89 100644
--- a/arch/xtensa/boot/Makefile
+++ b/arch/xtensa/boot/Makefile
@@ -12,7 +12,7 @@
 KBUILD_CFLAGS	+= -fno-builtin -Iarch/$(ARCH)/boot/include
 HOSTFLAGS	+= -Iarch/$(ARCH)/boot/include
 
-BIG_ENDIAN	:= $(shell echo -e __XTENSA_EB__ | $(CC) -E - | grep -v "\#")
+BIG_ENDIAN	:= $(shell echo __XTENSA_EB__ | $(CC) -E - | grep -v "\#")
 
 export ccflags-y
 export BIG_ENDIAN
-- 
1.7.7.6
