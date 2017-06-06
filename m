From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 05/17] MAINTAINERS: Add RISC-V
Date: Tue,  6 Jun 2017 15:59:55 -0700
Message-ID: <20170606230007.19101-6-palmer@dabbelt.com>
References: <20170523004107.536-1-palmer@dabbelt.com>
 <20170606230007.19101-1-palmer@dabbelt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35730 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbdFFXBi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Jun 2017 19:01:38 -0400
Received: by mail-pf0-f196.google.com with SMTP id u26so25592262pfd.2
        for <linux-arch@vger.kernel.org>; Tue, 06 Jun 2017 16:01:33 -0700 (PDT)
In-Reply-To: <20170606230007.19101-1-palmer@dabbelt.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, olof@lixom.net
Cc: albert@sifive.com, patches@groups.riscv.org, nathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, Palmer Dabbelt <palmer@dabbelt.com>

From: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

RISC-V needs a MAINTAINERS entry. Let's add one.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a28acd7f525..50b18dad8c22 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10877,6 +10877,14 @@ M:	Maxim Levitsky <maximlevitsky@gmail.com>
 S:	Maintained
 F:	drivers/memstick/host/r592.*
 
+RISC-V ARCHITECTURE
+M:	Palmer Dabbelt <palmer@sifive.com>
+M:	Albert Ou <albert@sifive.com>
+L:	patches@groups.riscv.org
+T:	git https://github.com/riscv/riscv-linux
+S:	Supported
+F:	arch/riscv/
+
 ROCCAT DRIVERS
 M:	Stefan Achatz <erazor_de@users.sourceforge.net>
 W:	http://sourceforge.net/projects/roccat/
-- 
2.13.0
