Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792576607;
	b=v1Byu0rZhLTR/u1IEvLokSBgeNgiYl8GBdbgTYJFA/+KjPSeDBR7EpAmp5/I1chwsuiJ
	 VxZ1gNCWG/axNM1s2rh/mWt9l0i+7gzas6YpshqdeJKfIUyB0jAWHmVlMx6YOnV8gU1jX
	 czE9uM9qAf7G54TdUD2NvnpvoESmQF1nQh+qGg/21IiCCQW1g4SlPimM2WuayWTPf1qIh
	 xEV8hNZ5iC9vl7yunr1SSp4A95k1lg7HUmB0txdNaGLUuluJugXpbuYV2Y5g9gbm06tgJ
	 M6ZYl7Fpcktc/F0GAYDKBnaVSWw6rtwhn8CqvekwnwTVivJZW2qa7KlNQ2jdPuXJ95g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792576607;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OBRANLxJ945k7D1G3lIFWXCIRvOVfhFWCqR5YEXkSkI=;
	b=qhRBnIcYtQjjKW+Lfb9eSoAmRym9URRZU209InngOTAyI9KmZK3NMo50eCYNnw5QBbo9
	 2sH++AHeG7wn1Oss111Qr9vaiSTl0wxf76jXanK5l0rK5iBwkC6wh4LqN6BJon8MKO5hQ
	 MhGrS73MnRLTbkQWHfPyWHMe7f1W2C9lfurKor+Ofo0KjRzqTKIoiJWdTMcDPFqq88bmi
	 uRb4OgL+fyLp0rJZ6k6cpStewH34017gTxu5JKoO7SHlO/OJxWFVNUaxk5u0EeNK6cQSk
	 IrMmI2Ze50zLYwOuOj7xQM8soSj4X80ALwfcIGaqF4xfy+cyUfYFyGaGy/DVNv/dAHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cm6uDSBn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE220606A31F;
	Wed, 21 Oct 2026 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cm6uDSBn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC531F000C9;
	Wed, 21 Oct 2026 09:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792576606;
	bh=OBRANLxJ945k7D1G3lIFWXCIRvOVfhFWCqR5YEXkSkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cm6uDSBn8rUl0CV7nI5Aa3oolTOxPGbITFM/bWZPytq04QyetEjSd16NBzFq/3t5i
	 BekTV8Djg2tYKAHk1xMr5vreTI6LimHfWkujWEMtXIof4E2UniWUFeO66WiLGux/yH
	 mGHYQgLe2F6oKl7OuqGmbItsHPOB0hxHt+hd403oWeUDZE313RV8SrNAZ7wnCbHP45
	 6Z31kGtXu7A/DrpdBjD/dXCtIO8Yl2SllSWOB0P567NVSJnw7CHoZFTzhN8jN3QR4C
	 sbzCGXUQHsL7+JFQ1WULE5S4IB9Q/UOsknWA9/4m40MyAw1Eyk1X7Xpf8kRUGOVIWq
	 O5n/5DNPt75ww==
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
Subject: [PATCH 2/2] dma-buf/dma-fence: Order setting of the signaled-bit properly
Date: Wed, 21 Oct 2026 11:55:13 +0200
Message-ID: <20261021095512.1345191-4-phasta@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021095512.1345191-2-phasta@kernel.org>
References: <20261021095512.1345191-2-phasta@kernel.org>
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

dma_fence_is_signaled() can return true *while* the fence is still
signaling. This is fragile and has been involved in at least two bugs:

	commit c8a5d5ea3ba6 ("nouveau: fix client work fence deletion race")
	commit 7c703a7d3f2b ("drm/amdgpu: Fix one use-after-free of VM")

The signaled-bit is set under lock-protection but read without it.
Adding the lock has been rejected on the grounds of the lock-acquisition
shooting down cache lines of parties that merely want to check whether
the fence is already signaled.

Make sure the bit can only become visible as 1 once the callbacks have
ran. To achieve this, read the bit with test_bit_acquire() and set it
with set_bit_release().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/dma-buf/dma-fence.c | 11 +++++++++--
 include/linux/dma-fence.h   |  6 +++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index bd58688b81a7..07d499fa35ac 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -359,8 +359,7 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
 
 	dma_fence_assert_held(fence);
 
-	if (unlikely(test_and_set_bit(DMA_FENCE_FLAG_SIGNALED_BIT,
-				      &fence->flags)))
+	if (unlikely(dma_fence_test_signaled_flag(fence)))
 		return;
 
 	trace_dma_fence_signaled(fence);
@@ -384,6 +383,14 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
 		INIT_LIST_HEAD(&cur->node);
 		cur->func(fence, cur);
 	}
+
+	/*
+	 * This orders the signaled-state with the test_bit_acquire() in
+	 * dma_fence_test_signaled_flag(). This ensures that functions like
+	 * dma_fence_is_signaled() can only ever return true once signaling is
+	 * completed (i.e., after the callbacks above ran).
+	 */
+	set_bit_release(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
 }
 EXPORT_SYMBOL(dma_fence_signal_timestamp_locked);
 
diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
index dd07d128adc3..61522027af41 100644
--- a/include/linux/dma-fence.h
+++ b/include/linux/dma-fence.h
@@ -496,7 +496,11 @@ const char __rcu *dma_fence_timeline_name(struct dma_fence *fence);
 static inline bool
 dma_fence_test_signaled_flag(struct dma_fence *fence)
 {
-	return test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
+	/*
+	 * The counterpart of this ordered operation can be found in
+	 * dma_fence_signal_timestamp_locked().
+	 */
+	return test_bit_acquire(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
 }
 
 /**
-- 
2.56.0

