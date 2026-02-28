Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD08364EBF;
	Sat, 28 Feb 2026 07:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772263083; cv=none; b=RX/JSNSF0ELVPi2qrFBaE5QlNn1Jr+tmcgFVX98wqRK7bn3bjysg+orFwAllHViqpm0UTXmVG2pCtnw6/GJgyScm4BGCOBmp1xbPNwoPOsw7ilYkIqxr2QDXQADm2RVnYzs8i6k3w4Gs355GBwM+7sHJnB/eQseiSD0AyIZU3ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772263083; c=relaxed/simple;
	bh=dHOCb3Js1rgL4IVQgbPeUdmevxaHC20kSgYfIAE0oU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B7oLmpn/6Ymhxbd2ZefF5O/eeKQktT2Fyt7cTXQDrwzbV2AH6r+M9W/vcxgKDu9YxP5KNTYTiK4hr/mFM9LQX0g+8dPtsHJyGRh0qE4d6MsCFKYtifj+Pd9Q5jo/EGONK51br9q0FnekycCJU7RlmzUM4G2bbedocjEFFWwIEPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4ovOqBPa; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4ovOqBPa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=/SZTD+qG9CUIEkJhXvsCUWhPAzSTot04mTe/XU4+qls=; b=4ovOqBPaXmx60NrgHfWnsZoD/k
	XqTQ8oLuVthTvU5M547nFZiG5CdEszzCTBu3U0GSxMPWNTmLpXJ4SUebALR6ir72DOTTj0DJBmtX5
	8OChdq6rk0DOSnSrxEaQiU3k1aYfQS4vgvhZkq90KWp1HNsFcrnrphWK/V6xc6+D6iWk469gEM9kN
	DHuQcBnaIKXAz0GUbCjfKV3USshIic3HlJtNavQYCrclrRVZCfMELBFWV5Kk22GoVrKALAvnvY420
	+zGCdEqL8TAXqdtaXAhwpy+cYEFy0VbqOTnNa3ASbKVEWB623QlVrZ6Mn1aEdW3CKlcvBorzuKjXo
	qahZev+g==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwEaP-00000009biB-0UkW;
	Sat, 28 Feb 2026 07:18:01 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org
Subject: [PATCH] futex: add missing function parameter comments
Date: Fri, 27 Feb 2026 23:17:58 -0800
Message-ID: <20260228071759.2663907-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Correct or add the missing function parameter kernel-doc comments
to avoid warnings:

Warning: include/asm-generic/futex.h:38 function parameter 'op' not
 described in 'futex_atomic_op_inuser_local'
Warning: include/asm-generic/futex.h:38 function parameter 'oparg' not
 described in 'futex_atomic_op_inuser_local'
Warning: include/asm-generic/futex.h:38 function parameter 'oval' not
 described in 'futex_atomic_op_inuser_local'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Thomas Gleixner <tglx@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: André Almeida <andrealmeid@igalia.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org

 include/asm-generic/futex.h |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-next-20260211.orig/include/asm-generic/futex.h
+++ linux-next-20260211/include/asm-generic/futex.h
@@ -25,7 +25,9 @@
  *			  argument and comparison of the previous
  *			  futex value with another constant.
  *
- * @encoded_op:	encoded operation to execute
+ * @op:		encoded operation to execute
+ * @oparg:	operation code (one of FUTEX_OP_...)
+ * @oval:	previous value at @uaddr on successful return
  * @uaddr:	pointer to user space address
  *
  * Return:
