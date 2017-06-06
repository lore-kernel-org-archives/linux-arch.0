Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33516 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751532AbdFFXB0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jun 2017 19:01:26 -0400
Received: by mail-pf0-f195.google.com with SMTP id f27so25611423pfe.0
        for <linux-arch@vger.kernel.org>; Tue, 06 Jun 2017 16:01:26 -0700 (PDT)
From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 04/17] Documentation: atomic_ops.txt is core-api/atomic_ops.rst
Date: Tue,  6 Jun 2017 15:59:54 -0700
Message-ID: <20170606230007.19101-5-palmer@dabbelt.com>
In-Reply-To: <20170606230007.19101-1-palmer@dabbelt.com>
References: <20170523004107.536-1-palmer@dabbelt.com>
 <20170606230007.19101-1-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, olof@lixom.net
Cc: albert@sifive.com, patches@groups.riscv.org, Palmer Dabbelt <palmer@dabbelt.com>
Message-ID: <20170606225954._g7ZsncbfOiVuMEPG5B_RwsikXfOtSGRnUbHGQZt2s4@z>

I was reading the memory barries documentation in order to make sure the
RISC-V barries were correct, and I found a broken link to the atomic
operations documentation.

Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 Documentation/memory-barriers.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
index 732f10ea382e..f1c9eaa45a57 100644
--- a/Documentation/memory-barriers.txt
+++ b/Documentation/memory-barriers.txt
@@ -498,11 +498,11 @@ And a couple of implicit varieties:
      This means that ACQUIRE acts as a minimal "acquire" operation and
      RELEASE acts as a minimal "release" operation.
 
-A subset of the atomic operations described in atomic_ops.txt have ACQUIRE
-and RELEASE variants in addition to fully-ordered and relaxed (no barrier
-semantics) definitions.  For compound atomics performing both a load and a
-store, ACQUIRE semantics apply only to the load and RELEASE semantics apply
-only to the store portion of the operation.
+A subset of the atomic operations described in core-api/atomic_ops.rst have
+ACQUIRE and RELEASE variants in addition to fully-ordered and relaxed (no
+barrier semantics) definitions.  For compound atomics performing both a load
+and a store, ACQUIRE semantics apply only to the load and RELEASE semantics
+apply only to the store portion of the operation.
 
 Memory barriers are only required where there's a possibility of interaction
 between two CPUs or between a CPU and a device.  If it can be guaranteed that
-- 
2.13.0
