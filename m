Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A7633ADA8;
	Thu,  2 Apr 2026 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775143524; cv=none; b=ShJ+wDN3hdjShWGhNR0WB4IwcuNq9pJdEhjzc5PLLkoi5H6Y8SEZpTpxh4XnStKrwWzX2NkA0Ab0v3Z0FY9y1mZCfQLITY3/gAa6AGQrGZmI5enrENUaxEIpWGbuzXUtgBjBMX8obsEV/vbzAOTTmYBKpP+ZC0X2W9nrq4E+G24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775143524; c=relaxed/simple;
	bh=Ey4nyNf6TNVqze53+yKNKJ2dlvv9GCYYcOpq0LmDn30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NnMihqjLlmqX6V29oWAMfttSPYip5wVUUKJVpZ4AHlgwjAlWvyX/jyCS6UiMM9H4EW8kSwCRcoYedC9cUqoiRKMmMX5aHg+jHfEV+8F/vHOnDmNbPmRWzoPNR73OlMEFAZgiXcv25nblE2Q0dijrg25FutUM+XMIj8f7hTMUHO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pMxM4Osg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pMxM4Osg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865D8C116C6;
	Thu,  2 Apr 2026 15:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775143524;
	bh=Ey4nyNf6TNVqze53+yKNKJ2dlvv9GCYYcOpq0LmDn30=;
	h=From:To:Cc:Subject:Date:Reply-To:From;
	b=pMxM4Osg9urNErpp6dnRx16CgD3UstWyzGLAxr6OjOZn/n1TBKieLAetm4T2l4F61
	 n+5FSZ5ds0bpNvuI+UjQMKZ/sM9PwSa2JgwctbLl/QB2BKEe8wksXFwT/OC+ED4ezU
	 ZG33dkTOuHNAEHxtZNo7mYil7fiXcQIOEo8unTzEITBZI7orftPJDX1j9QSFq4BaBK
	 gzI+cQph9fXQ/QmeAHWw5hiVDoQktmZti4IzN9Y9Ghf2DrQdOmgTHFCTi3s1t/um5j
	 v1nV78hTW3OpumeEWJXwfm1BD453yVank+Lr+9/ucPV4Vf/U5MAdA9RQnSjq77vDpr
	 wq8MrGpf6K8Ww==
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
Subject: [PATCH 0/3] rust: more memory barriers bindings
Date: Thu,  2 Apr 2026 16:24:33 +0100
Message-ID: <20260402152443.1059634-2-gary@kernel.org>
X-Mailer: git-send-email 2.51.2
Reply-To: Gary Guo <gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Gary Guo <gary@garyguo.net>

This expands the existing smp barriers to also mandatory barriers and
DMA barriers.

The API looks like:
`mb(Ordering)`/`smp_mb(Ordering)`/`dma_mb(Ordering)`, where `Ordering`
is one of `Full`, `Read`, `Write` and also `Acquire`, `Release`.

The `Acquire` and `Release` barriers are mapped to `Full` barriers for
now and they only serve the purpose of documenting what ordering is
needed without codegen optimizations, but they could be improved
later to produce better codegen compared to full barriers. More on them
in the commit message of patch 2.

A user of these introduced API is included in patch 3, which is a
concurrency bug that exists in Nova code today due to missing barriers.

To: Miguel Ojeda <ojeda@kernel.org>
To: Boqun Feng <boqun@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Björn Roy Baron <bjorn3_gh@protonmail.com>
Cc: Benno Lossin <lossin@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>
Cc: Trevor Gross <tmgross@umich.edu>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Andrea Parri <parri.andrea@gmail.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jade Alglave <j.alglave@ucl.ac.uk>
Cc: Luc Maranget <luc.maranget@inria.fr>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Akira Yokosawa <akiyks@gmail.com>
Cc: Daniel Lustig <dlustig@nvidia.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>
Cc: rust-for-linux@vger.kernel.org
Cc: nouveau@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: lkmm@lists.linux.dev

Gary Guo (3):
  rust: sync: add helpers for mb, dma_mb and friends
  rust: sync: generic memory barriers
  gpu: nova-core: fix wrong use of barriers in GSP code

 drivers/gpu/nova-core/gsp/cmdq.rs   |  19 +++
 drivers/gpu/nova-core/gsp/fw.rs     |  12 --
 rust/helpers/barrier.c              |  30 +++++
 rust/kernel/sync/atomic/ordering.rs |   2 +-
 rust/kernel/sync/barrier.rs         | 194 ++++++++++++++++++++++++----
 5 files changed, 217 insertions(+), 40 deletions(-)


base-commit: 36ece9697e89016181e5ae87510e40fb31d86f2b
-- 
2.51.2

