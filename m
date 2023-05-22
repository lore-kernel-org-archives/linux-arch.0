Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4489C77B73
	for <linux-arch@archiver.kernel.org>; Mon, 22 May 2023 12:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234130AbjEVM3B (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Mon, 22 May 2023 08:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjEVM1e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 22 May 2023 08:27:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B2BB18C;
        Mon, 22 May 2023 05:25:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29A4D11FB;
        Mon, 22 May 2023 05:26:25 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 762E43F59C;
        Mon, 22 May 2023 05:25:38 -0700 (PDT)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     akiyks@gmail.com, boqun.feng@gmail.com, corbet@lwn.net,
        keescook@chromium.org, linux-arch@vger.kernel.org,
        linux@armlinux.org.uk, linux-doc@vger.kernel.org,
        mark.rutland@arm.com, paulmck@kernel.org, peterz@infradead.org,
        sstabellini@kernel.org, will@kernel.org
Subject: [PATCH 25/26] locking/atomic: docs: Add atomic operations to the driver basic API documentation
Date:   Mon, 22 May 2023 13:24:28 +0100
Message-Id: <20230522122429.1915021-26-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230522122429.1915021-1-mark.rutland@arm.com>
References: <20230522122429.1915021-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Add the generated atomic headers to driver-api/basics.rst in order to
provide documentation for the Linux kernel's atomic operations.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Kees Cook <keescook@chromium.org>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: <linux-doc@vger.kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
[Mark: add atomic-long.h]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 Documentation/driver-api/basics.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/driver-api/basics.rst b/Documentation/driver-api/basics.rst
index 4b4d8e28d3be4..a1fbd97fb79fb 100644
--- a/Documentation/driver-api/basics.rst
+++ b/Documentation/driver-api/basics.rst
@@ -87,6 +87,12 @@ Atomics
 .. kernel-doc:: arch/x86/include/asm/atomic.h
    :internal:
 
+.. kernel-doc:: include/linux/atomic/atomic-arch-fallback.h
+   :internal:
+
+.. kernel-doc:: include/linux/atomic/atomic-long.h
+   :internal:
+
 Kernel objects manipulation
 ---------------------------
 
-- 
2.30.2

