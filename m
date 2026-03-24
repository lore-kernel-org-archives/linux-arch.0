Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6383F20F5;
	Tue, 24 Mar 2026 17:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774372614; cv=none; b=ib67ZwCO41xLd4Au575jXSGZHONN9ZJrs2sGCaw/iLsxpuS4ftfG+rL8TLEFIUdnUhytqa5/kZaSk5l+TrTo39Hs6f6nJF1EmcuXLZwA28gO7mH2S5lwNVP8lPvQ0Q3u0JPudbGSdT9ZJDdUtEDHVu84s6k62Bw8fZ8FrAvPHyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774372614; c=relaxed/simple;
	bh=Aq9UnkgRNsW2rt0ZQw598mGXDJfQHqGHprMzz3wL4sc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CxC/xlwFZYjn5MSd7um8ilgDaAUA+so/xm0H5Pa3eZZeam/jwQPGuuL3dhVxPtxHuYuhdEIM3GW9K3aLUfFcC9lJVmW70AWQh95vJwubhZPzj9V1EskookJNvqxmFpJYZyoiTVGuT6mOQBG5iP8logxgraiGxs87F3kTLl8FpgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=aFpYz0gq; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="aFpYz0gq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1774372611;
	bh=Aq9UnkgRNsW2rt0ZQw598mGXDJfQHqGHprMzz3wL4sc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aFpYz0gqC5drXtur6Tr4Vj0N2v9XqzZ6X9lBzjhI3MUOrzd29U0yNiDFqm+bHuK36
	 dDIMX7eorsQHu+tebUDVwon2P6bGxJaJoJK7Dp0o/x0zq47GH+7JjVADJbSlopSmK2
	 0loQhqvt1K6elZnJ2c7mMKdt+kQ28N6jMYD01jow=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 24 Mar 2026 18:16:45 +0100
Subject: [PATCH v2 1/3] checksyscalls: move path to reference table to a
 variable
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260324-kbuild-missing-syscalls-v2-1-651b8beb0bfd@weissschuh.net>
References: <20260324-kbuild-missing-syscalls-v2-0-651b8beb0bfd@weissschuh.net>
In-Reply-To: <20260324-kbuild-missing-syscalls-v2-0-651b8beb0bfd@weissschuh.net>
To: Arnd Bergmann <arnd@arndb.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mips@vger.kernel.org, linux-kbuild@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774372608; l=878;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Aq9UnkgRNsW2rt0ZQw598mGXDJfQHqGHprMzz3wL4sc=;
 b=yRfsjU1B4IjJm+8YLDYD7rYLGbu+C89qQzw6XQpz9cytMWu9oaBfK+wWWEZW04Kg9JygESc/X
 lL0qQjgVGsMAnNxGpfVSngMQEcCRge0tod3NUVYMSYrf5OzoAToSbCL
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

