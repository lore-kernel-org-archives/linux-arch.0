Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193A9C43461
	for <linux-arch@archiver.kernel.org>; Wed,  7 Apr 2021 05:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E91C3613D0
	for <linux-arch@archiver.kernel.org>; Wed,  7 Apr 2021 05:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238828AbhDGFgD (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 7 Apr 2021 01:36:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348808AbhDGFfm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 7 Apr 2021 01:35:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9ADAC613AF;
        Wed,  7 Apr 2021 05:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617773733;
        bh=gLoJ516uqKiucx6WRY0TlVov1Wwhx5YWTL7Jb2S9rMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DSc+53E7iJBo9rRyDlEgQM3yAP3O80Tk4OWDSXGQhLyjnioXJA7+cKZNbaBDvdtRt
         U8F3ywI3N9PlJiAJvANFVNQkEo33HExlJvQQQcEtZsz2DPc5JQZ5EtzP0brNA6IcUx
         /kJLcf6M47uvVpWJDIlihbVjO6pxB27rk4bE/Eh0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 05/20] kbuild: scripts/install.sh: prepare for arch-specific bootloaders
Date:   Wed,  7 Apr 2021 07:34:04 +0200
Message-Id: <20210407053419.449796-6-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210407053419.449796-1-gregkh@linuxfoundation.org>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Despite the last release of LILO being in 2015, it seems that it is
still the default x86 bootloader and wants to be called to "install" the
new kernel image when it has been replaced on the disk.  To allow
arch-specific programs like this to be called in future changes, move
the logic to an arch-specific test now.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/install.sh | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/scripts/install.sh b/scripts/install.sh
index 92d0d2ade414..2adcb993efa2 100644
--- a/scripts/install.sh
+++ b/scripts/install.sh
@@ -54,10 +54,15 @@ install "$2" "$4"/vmlinuz
 install "$3" "$4"/System.map
 sync
 
-if [ -x /sbin/lilo ]; then
-       /sbin/lilo
-elif [ -x /etc/lilo/install ]; then
-       /etc/lilo/install
-else
-       echo "Cannot find LILO."
-fi
+# Some architectures like to call specific bootloader "helper" programs:
+case "${ARCH}" in
+	x86)
+		if [ -x /sbin/lilo ]; then
+			/sbin/lilo
+		elif [ -x /etc/lilo/install ]; then
+			/etc/lilo/install
+		else
+			echo "Cannot find LILO."
+		fi
+		;;
+esac
-- 
2.31.1

