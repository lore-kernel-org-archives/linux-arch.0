From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v3 24/31] arm64: Add support for /proc/sys/debug/exception-trace
Date: Fri,  7 Sep 2012 17:26:59 +0100
Message-ID: <1347035226-18649-25-git-send-email-catalin.marinas@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:34632 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752871Ab2IGQ16 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 7 Sep 2012 12:27:58 -0400
In-Reply-To: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

This patch allows setting of the show_unhandled_signals variable via
/proc/sys/debug/exception-trace. The default value is currently 1
showing unhandled user faults (undefined instructions, data aborts) and
invalid signal stack frames.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/sysctl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 87174ef..79dcb00 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1544,7 +1544,7 @@ static struct ctl_table fs_table[] =3D {
=20
 static struct ctl_table debug_table[] =3D {
 #if defined(CONFIG_X86) || defined(CONFIG_PPC) || defined(CONFIG_SPARC) ||=
 \
-    defined(CONFIG_S390) || defined(CONFIG_TILE)
+    defined(CONFIG_S390) || defined(CONFIG_TILE) || defined(CONFIG_ARM64)
 =09{
 =09=09.procname=09=3D "exception-trace",
 =09=09.data=09=09=3D &show_unhandled_signals,
