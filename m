Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:55646 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756927Ab2HNRxR (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 14 Aug 2012 13:53:17 -0400
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v2 31/31] arm64: MAINTAINERS update
Date: Tue, 14 Aug 2012 18:52:32 +0100
Message-ID: <1344966752-16102-32-git-send-email-catalin.marinas@arm.com>
In-Reply-To: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Message-ID: <20120814175232.h796N_q9zJodMbMpKpDkVVXxtassYNf_E9ho7Bqh1yw@z>

This patch updates the MAINTAINERS file for the AArch64 Linux kernel
port.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 MAINTAINERS |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 94b823f..6d7c5f4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1204,6 +1204,12 @@ S:=09Maintained
 F:=09arch/arm/mach-pxa/z2.c
 F:=09arch/arm/mach-pxa/include/mach/z2.h
=20
+ARM64 PORT (AARCH64 ARCHITECTURE)
+M:=09Catalin Marinas <catalin.marinas@arm.com>
+L:=09linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:=09Maintained
+F:=09arch/arm64/
+
 ASC7621 HARDWARE MONITOR DRIVER
 M:=09George Joseph <george.joseph@fairview5.com>
 L:=09lm-sensors@lm-sensors.org

