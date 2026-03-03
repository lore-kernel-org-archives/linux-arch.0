Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26483BED38;
	Tue,  3 Mar 2026 17:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772560402; cv=none; b=nzfkURENu8VrHGTXUszHdxUlITef9e7WIauR3O4PeIdF6mCx8BkrMyEwlX4bf9OgmQy6z6g9Ba//Tuj8pZXH08KosNt2Se/4SmOPvft9xNIUUwmX3FCrcN/TuEcqUHI/6nXTGoAyiIg+xHq4iggnZOaQH4fkuHLApwZdL0dAwRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772560402; c=relaxed/simple;
	bh=Aq9UnkgRNsW2rt0ZQw598mGXDJfQHqGHprMzz3wL4sc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XGV0gX1rZT61AsyX0tMbMLI0FIkIz4KrFMC3MDlzMEPFe588u34zxvCKQaqxKkw/XcvQ8ffTlmOcrhIQ9BgY12DQqWEIxXgvChWj1bgp9SXV8b+3P3h8lAxqWl9KrBMm1Sq2drJ3hw8ZpmfPoRCveyq5+ZOXP34MEmPdqlQL+CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=MraP35Bc; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="MraP35Bc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1772560398;
	bh=Aq9UnkgRNsW2rt0ZQw598mGXDJfQHqGHprMzz3wL4sc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MraP35BcBluwe6lKLj+b/nCwJM3n6PuN+n0QR9iBknTmXSbrCqebu+uVlnkUu9zkA
	 CxKp4uHfJZ3WCWWxw+AYzmydqRYLMqcRHY0a75aQfx0fQOhd5eO9/5iu0qocPtv2n0
	 fqxVBNog5E54H3lG4i5VjdgYT8AdOm2mQk8J9alU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 03 Mar 2026 18:53:12 +0100
Subject: [PATCH 1/3] checksyscalls: move path to reference table to a
 variable
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260303-kbuild-missing-syscalls-v1-1-3b4d69b68c75@weissschuh.net>
References: <20260303-kbuild-missing-syscalls-v1-0-3b4d69b68c75@weissschuh.net>
In-Reply-To: <20260303-kbuild-missing-syscalls-v1-0-3b4d69b68c75@weissschuh.net>
To: Arnd Bergmann <arnd@arndb.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mips@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772560397; l=878;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Aq9UnkgRNsW2rt0ZQw598mGXDJfQHqGHprMzz3wL4sc=;
 b=Tw91EzsW5z0YzT4oFK04KaHpcYOo/IBci5OEz0BY/nDgtEyHYBzcKwUed2t0z1tRAd/bu++gh
 mR7C1o4swv8BLDGzZfpWdeXr060Vum3S4+zXOV6x5KGBTRH4jCJtbWO
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

An upcoming patch will need to reuse this path.

Move it into a reusable variable.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 scripts/checksyscalls.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
index 1e5d2eeb726d..9becaf8d7b78 100755
--- a/scripts/checksyscalls.sh
+++ b/scripts/checksyscalls.sh
@@ -10,6 +10,8 @@
 # checksyscalls.sh gcc gcc-options
 #
 
+reference_table="$(dirname $0)/../arch/x86/entry/syscalls/syscall_32.tbl"
+
 ignore_list() {
 cat << EOF
 #include <asm/types.h>
@@ -269,5 +271,5 @@ syscall_list() {
 	done
 }
 
-(ignore_list && syscall_list $(dirname $0)/../arch/x86/entry/syscalls/syscall_32.tbl) | \
+(ignore_list && syscall_list ${reference_table}) | \
 $* -Wno-error -Wno-unused-macros -E -x c - > /dev/null

-- 
2.53.0

