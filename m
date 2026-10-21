Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792576603;
	b=eUhXuIcbiEyBsvB7ZLvL73PPZntZsU1GUqujDHcv+y+0088I8h2ZMeyW0PWdQrBVJVi6
	 OWbz9wAzTy78SiFm2Jfi4SyRyfCp5eIYh3hexaL4lcK1XmTnSFHZtPs/xD+gexUiDCDjN
	 0WOa/3ikdslY+QIcWIYNANYgH68v5TNRYN8FDIpCutHLS7VayL5p9WdHK0d8DENC6qI0l
	 oFwemMaaQSvCosSrD+X9qASLQMJxYxaZzTswtmXGfDyin6BbyL2m4WWefCLEAaGHXHUvZ
	 kqWIWAIFQ7Xz6SB9cXL5gL3ZxZ1Xv4Ryp8FEzr8BYdpVSDNjW8sT2goCm4sQxR1TT9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792576603;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EZCm0kE3titGYhKqRVn8yaTjCW0wvCcWPMDKwf1pgeE=;
	b=xFowvCqzTPF1f4RDNUkEf4ihriO/Huj3+uIB1flBWIvjmu7pGnLdwd/ILyWh1JBkBDQt
	 1LnqiZlv1xiEsac+zb5xpKn3J//4VvCdEcqQO2UOn5lepO5unewq0RNjhllqHm7GEyoEV
	 b2raK/6yBrEfpHFcNx1DZbwkR7/e6KM5C4+gRfH9qDMg2FNgfbwyItkPUFYfUGNUrCzzS
	 K0liMxTcelFz0JYNEFKFJ5DhzHSRAPkK41lUldyXXBhBiUZBmD2iHsx17MC0o+Rd0F3/w
	 O+Attzs+eRTvAfszSa6TdVhy1Rdp15SG3mcK2SWunl87B6ONEgr5aYiZr1IG1eDm+2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lS0Rf170;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B4B606A31E;
	Wed, 21 Oct 2026 09:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lS0Rf170
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032901F000CA;
	Wed, 21 Oct 2026 09:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792576603;
	bh=EZCm0kE3titGYhKqRVn8yaTjCW0wvCcWPMDKwf1pgeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lS0Rf170RqojOFfZUl03pobZ9QngXd5aL0EYku/6zFqBesXGJtuEKiEsgInSY4bKG
	 T5rT6AIzTmZgbE9ZQaEx7VvWeIYCriUTbQV8tcGRWo0Pyv6DFlg4TsryjvrnrWgm+l
	 aqq1uKQ5mB1BZ3tcjbnA2comYA57x+nkVzNSv+YmgXUW1NE9zLHS6dVW7t08ka6JNJ
	 v65iQSUM49jDJYZvRApKFyxoUiU6CNZyRF10KhhGUQ8TvOzv0rUmG0dyGninbvpXAC
	 rI/h0+wbwfTQEItJoM1QVG303LDx0htcwxYqogWH2p2GQo99yrK1whxwE0HvtFhvSD
	 q7K3OnG9pI8Zg==
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
Subject: [PATCH 1/2] asm-generic/bitops: Add set_bit_release()
Date: Wed, 21 Oct 2026 11:55:12 +0200
Message-ID: <20261021095512.1345191-3-phasta@kernel.org>
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

The kernel already has test_bit_acquire(). A set_bit_release(), however,
was missing so far. It can be expected to be useful for parties that
need release ordering, but not the stricter full ordering of the other
bit-setting functions.

Add set_bit_release().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 include/asm-generic/bitops/instrumented-atomic.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/asm-generic/bitops/instrumented-atomic.h b/include/asm-generic/bitops/instrumented-atomic.h
index c010d54275e4..fb2d1472fd4d 100644
--- a/include/asm-generic/bitops/instrumented-atomic.h
+++ b/include/asm-generic/bitops/instrumented-atomic.h
@@ -72,6 +72,20 @@ static __always_inline bool test_and_set_bit(long nr, volatile unsigned long *ad
 	return arch_test_and_set_bit(nr, addr);
 }
 
+/**
+ * set_bit_release - Set a bit with release ordering
+ * @nr: Bit to set
+ * @addr: Address to start counting from
+ *
+ * This is an atomic ordered operation (implied write memory barrier).
+ */
+static __always_inline void set_bit_release(long nr, volatile unsigned long *addr)
+{
+	kcsan_wmb();
+	instrument_atomic_write(addr + BIT_WORD(nr), sizeof(long));
+	arch_set_bit(nr, addr);
+}
+
 /**
  * test_and_clear_bit - Clear a bit and return its old value
  * @nr: Bit to clear
-- 
2.56.0

