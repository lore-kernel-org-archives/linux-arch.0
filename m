From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC v5 06/21] scritps: um: suppress warnings if SRCARCH=um
Date: Thu,  2 Jul 2020 23:07:00 +0900
Message-ID: <103c87a24c9966f465cdc3c4e4d6519c81cf33d2.1593697069.git.thehajime@gmail.com>
References: <cover.1593697069.git.thehajime@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729514AbgGBOIh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Jul 2020 10:08:37 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F739C08C5C1
        for <linux-arch@vger.kernel.org>; Thu,  2 Jul 2020 07:08:37 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id q17so12588704pfu.8
        for <linux-arch@vger.kernel.org>; Thu, 02 Jul 2020 07:08:37 -0700 (PDT)
In-Reply-To: <cover.1593697069.git.thehajime@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-um@lists.infradead.org
Cc: Octavian Purdila <tavi.purdila@gmail.com>, Akira Moroo <retrage01@gmail.com>, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org, Hajime Tazaki <thehajime@gmail.com>

This commit fixes numbers of warning messages about leaked CONFIG
options.  nommu mode of UML requires copies of kernel headers to offer
syscall-like API for the library users.  Thus, the warnings are to be
avoided to function this exposure of API.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 scripts/headers_install.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
index a07668a5c36b..59966f3b4ebe 100755
--- a/scripts/headers_install.sh
+++ b/scripts/headers_install.sh
@@ -99,6 +99,9 @@ include/uapi/linux/raw.h:CONFIG_MAX_RAW_DEVS
 for c in $configs
 do
 	warn=1
+	if [ "$SRCARCH" = "um" ] ; then
+		break
+	fi
 
 	for ignore in $config_leak_ignores
 	do
-- 
2.21.0 (Apple Git-122.2)
