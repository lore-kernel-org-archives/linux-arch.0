Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FB034403F;
	Thu,  2 Apr 2026 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775143529; cv=none; b=HEaGvNI8AYHWcxsoThjGESj56EqRATQkfWJdLxUC8gdOCL8i3aRru72CbFs7e6YH73xcAIWyZpZgKHPz9S8BqXIfFTm2Q88H/32N8Q7CSvGn2bYN4l+GWwKNuW4c1eEa9CjsYLB/mjo7XtZZoppfKmCjfrokx4ZH+LJbEVxY/MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775143529; c=relaxed/simple;
	bh=xhCfedEVrgNyKr1DnCyfjrBfs37cxy3biI06+Ypg+4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZiSgnc6liY5cVbwaghi2rH2rt1x1o8lOvnkCKqohJRlSSyfN7afcbwXXBOQbbl0p8UpiXU/INbRHfpKs4kar+AJ5+9LgOPGl2m52Kf+1zDxy57b5pwkUzcTFeKFEQYVZF74X6Clp4qkr3xiNvEqhrhCFjIfbDXIpg/FFO4f6qzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2szK5EQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2szK5EQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79FAC2BCB2;
	Thu,  2 Apr 2026 15:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775143529;
	bh=xhCfedEVrgNyKr1DnCyfjrBfs37cxy3biI06+Ypg+4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=u2szK5EQABMsAPFYy8mBZDK+tw5TJ9Jb97ejNonPomb60WjK7cm9YdgvJ08GHfFx0
	 WJNFVYVgQzVyu6qQWWw7oquCAMk+uyI9XJxzf9UyKcljCufusNJ2D6Ysv52Gnlbdcg
	 pybdeQgMmvUF9v0hrJxuZmJ4my/jxRk0pjTdSAznVXqpIECdS+2xQZpouklOsMRJHd
	 ZPPhDZAXwJuguR47XdvG6SIs/xpCiuAAfnqoo9hD6Lyl/UuEfI+qJGtvUsBm0y2ucL
	 J9QjNwk97R3rhjDx9wzdDKlxuPXCeAaBoTEiwnQ1fSxGYt2t/Ya2GOeleX5e4Q6qP4
	 Q/lXl/z2d9YFQ==
From: Gary Guo <gary@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev
Subject: [PATCH 1/3] rust: sync: add helpers for mb, dma_mb and friends
Date: Thu,  2 Apr 2026 16:24:34 +0100
Message-ID: <20260402152443.1059634-3-gary@kernel.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260402152443.1059634-2-gary@kernel.org>
References: <20260402152443.1059634-2-gary@kernel.org>
Reply-To: Gary Guo <gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gary Guo <gary@garyguo.net>

They supplement the existing smp_mb, smp_rmb and smp_wmb.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/helpers/barrier.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/rust/helpers/barrier.c b/rust/helpers/barrier.c
index fed8853745c8..dbc7a3017c78 100644
--- a/rust/helpers/barrier.c
+++ b/rust/helpers/barrier.c
@@ -2,6 +2,36 @@
 
 #include <asm/barrier.h>
 
+__rust_helper void rust_helper_mb(void)
+{
+	mb();
+}
+
+__rust_helper void rust_helper_rmb(void)
+{
+	rmb();
+}
+
+__rust_helper void rust_helper_wmb(void)
+{
+	wmb();
+}
+
+__rust_helper void rust_helper_dma_mb(void)
+{
+	dma_mb();
+}
+
+__rust_helper void rust_helper_dma_rmb(void)
+{
+	dma_rmb();
+}
+
+__rust_helper void rust_helper_dma_wmb(void)
+{
+	dma_wmb();
+}
+
 __rust_helper void rust_helper_smp_mb(void)
 {
 	smp_mb();
-- 
2.51.2

