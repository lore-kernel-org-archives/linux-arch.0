Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792576600;
	b=0OuBZjq9z4VxQ2LE3Zo20+Vodoux6qiDgGgfiQWC4lfc/Zz13CogHYqXC/kJPd/Pkj2f
	 WkwaFUYsijE3+hz37eyoDPH/YmKuzNna64l+obVo5Cg1eUjV2JsPaGIrrX0dTPXL9bKnO
	 83J1TivZx4fPKNnuJ6lcLAWYZcDPCak0T8EAEIHZWCNtKz4clIrXZty64QvR1hT2X24/z
	 rLNnlmoC6VI6K75rvIG5trUcMH0a9Q8YfR+Hd1yNadPe1aOFTgAYnE9CgnWJDW/iq/TTJ
	 akmCMq8eu2ZquNciyz/YK1pkXhRHvyl5rf02SRbzwHtaezWIJDpCdV0+Ss42ImFTYOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792576600;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hU7HzZLc83zMlss5+YNu7AzVpfMiuG6aVIeozN0rE1Y=;
	b=OHWo4FpWjv7YOyTSnXUtF9rE3lEaBImBWyX8KVG2JabPFXg3xQ6+b5nKygCrCCnCKxms
	 nyhhCXyFlkwC7fB6Opju+J7OQk1VfJqQlYDUxIS7+QLNEzoYjlPZ17cbMu6sRiHgMluy7
	 qrURgr8dZPYheDt+Vks84H/OkBpi2Zt7ohtfJgCEpTP4YrCw+CSU8Kizk3Zk2dm9ftICP
	 0CA/PTa/4juQ/eIXi4YsUFzYoBP8Njj2nNYpS5Imv3DYMNK+t9RuarqSXKtnDAhqTi/rK
	 7G9P1CTjNJ5Livq060Fe3aqK97yWQAtk8SxhFlJ3ExSejJjt7W0EacysIzOI07gqyMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RhJ+4UPG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BC3606A319;
	Wed, 21 Oct 2026 09:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RhJ+4UPG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51DE11F000C9;
	Wed, 21 Oct 2026 09:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792576599;
	bh=hU7HzZLc83zMlss5+YNu7AzVpfMiuG6aVIeozN0rE1Y=;
	h=From:To:Cc:Subject:Date;
	b=RhJ+4UPGwpJ38DZCMD/M/c23iamaCl6vhuqwHYSVC34qAUTTU554hnLqgRkuBMsS8
	 yAOzALhvRZhRyZx030tv7Fzzz5cdJhgT13m67qW4lWcExWH1GrdXUES1luuTqtmVDx
	 cxgbhjKut0zlnwMCVYUTqYFwlEXFhKtCGTfF25Ocy0idyzdmelDI4D0q4h+tBSEEAe
	 YBGZN5ra5yzvn7A2EULSRbBdd+vbA+eJjd3D4s+RM7PcI09giLrXcSVP3PbcnqOlQc
	 nCERN0fhUIYSlJIMf6q033bQwIJAuVp0+R0FZVCOBLyj+0ONaitQ9bxtbXFaovVugk
	 TpotKukLzsl7g==
From: Philipp Stanner <phasta@kernel.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	"Paul E . McKenney" <paulmck@kernel.org>
Cc: linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>
Subject: [PATCH 0/2] dma-fence: Order is-signaled-bit
Date: Wed, 21 Oct 2026 11:55:11 +0200
Message-ID: <20261021095512.1345191-2-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v2:
  - Add a set_bit_release() function for proper ordering and use it.

Based on the DRM branch drm-misc-next

Philipp Stanner (2):
  asm-generic/bitops: Add set_bit_release()
  dma-buf/dma-fence: Order setting of the signaled-bit properly

 drivers/dma-buf/dma-fence.c                      | 11 +++++++++--
 include/asm-generic/bitops/instrumented-atomic.h | 14 ++++++++++++++
 include/linux/dma-fence.h                        |  6 +++++-
 3 files changed, 28 insertions(+), 3 deletions(-)


base-commit: 1ecab8b0bad393750c60cc3819ce9c256595463c
-- 
2.56.0

