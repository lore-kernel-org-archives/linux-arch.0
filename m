Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D99351C03;
	Tue,  3 Mar 2026 17:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772560401; cv=none; b=MjgnKC4uP6MfXfsgdFAMJdryL+r3+1I6OOM7UuVKcuIPqT6zL1jrcnokDZy2ip+z+cU5K02fxIEo8A9DaEZksDChBLEUR4fiUPeMpvCHMVvVZp6hZ7FG2RmflMR7JdmXsmKp2aQ7/Hi19EHq7+47eZQTf9YA+kUlQSpflmt5KQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772560401; c=relaxed/simple;
	bh=ZgFCBLsj4RSblbaDtp65NBCrt+sAiTJ7SQZyzV+FO84=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=h0QyYFnct5DloLFoWHrr7MzuIdhH2iSoVdqB8jN3rGVdS+vhjSK0F1Dk1fIdl5goc+z/kuURTaiVCdVjsucIqDlofsJ3DEL/5sAO+/wFxGccPT50icifG+ANNpW/NbDgHRjz7FkJ5UtfDO5xbcqref2GkojKGfXUPRkSdFAURMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=n3iEbrXq; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="n3iEbrXq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1772560398;
	bh=ZgFCBLsj4RSblbaDtp65NBCrt+sAiTJ7SQZyzV+FO84=;
	h=From:Subject:Date:To:Cc:From;
	b=n3iEbrXq+resgnAsB7AIctVikDzPw093lH5nWiiKtO5sjgSCOCA/KepRmA6dVGpaR
	 GMOZFuecHZtfL2GG32x/06CiLjxZhBVZuZkxYZdRWl7BQJLYGKQPmjk/XEyx2ZTsLV
	 3h/I4Oa4nbpe+wg1zN4v/nIFdmA5Y8zKX0IWwHJM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 0/3] checksyscalls: only run when necessary
Date: Tue, 03 Mar 2026 18:53:11 +0100
Message-Id: <20260303-kbuild-missing-syscalls-v1-0-3b4d69b68c75@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQqDMBBA4avIrDuQjD8Ur1K60GQaB9NYMigWy
 d0buvwW712gnIUVxuaCzIeobKnC3hpwy5QCo/hqIEODIUu4zrtEj29RlRRQv+qmGBW5pbvn1nV
 z30GtP5lfcv7Pj2cpP/G+cEZpAAAA
X-Change-ID: 20260212-kbuild-missing-syscalls-e328de3c4b54
To: Arnd Bergmann <arnd@arndb.de>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mips@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772560397; l=869;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=ZgFCBLsj4RSblbaDtp65NBCrt+sAiTJ7SQZyzV+FO84=;
 b=NAKr6FEUl3lsfD/l0FxSr47M3NTIZrwvOY/wqe9ahoUStKFt0uQOiEE7nv/mkUt4nH5HPBOOC
 K3XYwOJvg3zDI9KuCZ+Xw1WegJxdJkdK0RQpM6cYRJpbo/ThGytKKLc
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Currently checksyscalls.sh is unconditionally executed during each build.
Most of these executions are unnecessary.

Only run checksyscalls.sh if one of its inputs have changed.

Intended to be applied through the asm-generic tree.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Thomas Weißschuh (3):
      checksyscalls: move path to reference table to a variable
      checksyscalls: only run when necessary
      checksyscalls: move instance functionality into generic code

 Kbuild                   | 14 ++++++++++----
 arch/mips/Makefile       |  6 ++----
 scripts/checksyscalls.sh |  9 ++++++++-
 3 files changed, 20 insertions(+), 9 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260212-kbuild-missing-syscalls-e328de3c4b54

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

