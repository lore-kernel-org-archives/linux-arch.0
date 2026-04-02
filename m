Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A98C3C7DF9;
	Thu,  2 Apr 2026 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775143541; cv=none; b=WPBAKooBdvCP7bEu2D9PCM68/+QRGQkFT0Sf/6qRr6ol8tO0Y398uTJiUUubMJVH4X59j5RM78+BTCzQLUjj/8RUHe1Yeaj1U5aleD+JdgeXA/wSG8gJCdu/PZdxmNMQVhLgMUh4enW4CFwGKtORWPqM8gRH7U6p7GqBANIT8+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775143541; c=relaxed/simple;
	bh=H/ah7c8QblLITP8uZx6rQ0un/4q3xoSn//XPdWvMKg4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RAmmAZJi2DiAOUqq4yxqgpG7+BBYfavsyh/8L/2Rm0OwTqU9yj9fk5wfAkkTH1/H+GgsM5W5VdxnteiYdb6cgmhVqgCaBwPXfUCE2dx2mlFYm5MJwQi/xiUwZ5+7X+TAJ84N1vnDs0FsYdxkx0xte+u/1cb1+GSfyGer3DH0gQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWFy+j0h; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWFy+j0h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3369C116C6;
	Thu,  2 Apr 2026 15:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775143541;
	bh=H/ah7c8QblLITP8uZx6rQ0un/4q3xoSn//XPdWvMKg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=WWFy+j0hRa4F4bO2EyJSlQJHcjpjpFFyjoTGDTtQjbjJzxTkfZTuhsSiTyyWfX0O6
	 g8vteUT5Rt/P+nSlO8IOZsb+5RgeXoASrPj02F/QUpNaVWyonQeoCTK9x4dhl1XXbs
	 jfZ5iC7mVVQxOEJ7Oxyyam5pxByJzK8iKhMs07MX/0bItN4OcZZPImdZqt6HGC7kk6
	 k1DslyAQTlkKWRLMW/s0H9WLkaxQtKFuZ2+GXcIanu5Y7IzXiD3HdRl/3lW8+iDFO8
	 eYEYAdmUgrqDX7WspZto8eIeJbVIsour5bzkBTq/QAEZZOebr9ozUc6D3ldNaWNAzo
	 GYbFhHKTSAcFw==
From: Gary Guo <gary@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
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
	lkmm@lists.linux.dev,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 3/3] gpu: nova-core: fix wrong use of barriers in GSP code
Date: Thu,  2 Apr 2026 16:24:36 +0100
Message-ID: <20260402152443.1059634-5-gary@kernel.org>
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

Currently, in the GSP->CPU messaging path, the current code misses a read
barrier before data read. The barrier after read is updated to a DMA
barrier (with release ordering desired), instead of the existing (Rust)
SeqCst SMP barrier; the location of barrier is also moved to the beginning
of function, because the barrier is needed to synchronizing between data
and ring-buffer pointer, the RMW operation does not internally need a
barrier (nor it has to be atomic, as CPU pointers are updated by CPU only).

In the CPU->GSP messaging path, the current code misses a write barrier
after data write and before updating the CPU write pointer. Barrier is not
needed before data write due to control dependency, this fact is documented
explicitly. This could be replaced with an acquire barrier if needed.

Signed-off-by: Gary Guo <gary@garyguo.net>
---
 drivers/gpu/nova-core/gsp/cmdq.rs | 19 +++++++++++++++++++
 drivers/gpu/nova-core/gsp/fw.rs   | 12 ------------
 2 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gsp/cmdq.rs
index 2224896ccc89..7e4315b13984 100644
--- a/drivers/gpu/nova-core/gsp/cmdq.rs
+++ b/drivers/gpu/nova-core/gsp/cmdq.rs
@@ -19,6 +19,12 @@
     prelude::*,
     sync::{
         aref::ARef,
+        barrier::{
+            dma_mb,
+            Read,
+            Release,
+            Write, //
+        },
         Mutex, //
     },
     time::Delta,
@@ -258,6 +264,9 @@ fn new(dev: &device::Device<device::Bound>) -> Result<Self> {
         let tx = self.cpu_write_ptr() as usize;
         let rx = self.gsp_read_ptr() as usize;
 
+        // ORDERING: control dependency provides necessary LOAD->STORE ordering.
+        // `dma_mb(Acquire)` may be used here if we don't want to rely on control dependency.
+
         // SAFETY:
         // - We will only access the driver-owned part of the shared memory.
         // - Per the safety statement of the function, no concurrent access will be performed.
@@ -311,6 +320,9 @@ fn driver_write_area_size(&self) -> usize {
         let tx = self.gsp_write_ptr() as usize;
         let rx = self.cpu_read_ptr() as usize;
 
+        // ORDERING: Ensure data load is ordered after load of GSP write pointer.
+        dma_mb(Read);
+
         // SAFETY:
         // - We will only access the driver-owned part of the shared memory.
         // - Per the safety statement of the function, no concurrent access will be performed.
@@ -408,6 +420,10 @@ fn cpu_read_ptr(&self) -> u32 {
 
     // Informs the GSP that it can send `elem_count` new pages into the message queue.
     fn advance_cpu_read_ptr(&mut self, elem_count: u32) {
+        // ORDERING: Ensure read pointer is properly ordered.
+        //
+        dma_mb(Release);
+
         super::fw::gsp_mem::advance_cpu_read_ptr(&self.0, elem_count)
     }
 
@@ -422,6 +438,9 @@ fn cpu_write_ptr(&self) -> u32 {
 
     // Informs the GSP that it can process `elem_count` new pages from the command queue.
     fn advance_cpu_write_ptr(&mut self, elem_count: u32) {
+        // ORDERING: Ensure all command data is visible before updateing ring buffer pointer.
+        dma_mb(Write);
+
         super::fw::gsp_mem::advance_cpu_write_ptr(&self.0, elem_count)
     }
 }
diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/fw.rs
index 0c8a74f0e8ac..62c2cf1b030c 100644
--- a/drivers/gpu/nova-core/gsp/fw.rs
+++ b/drivers/gpu/nova-core/gsp/fw.rs
@@ -42,11 +42,6 @@
 
 // TODO: Replace with `IoView` projections once available.
 pub(super) mod gsp_mem {
-    use core::sync::atomic::{
-        fence,
-        Ordering, //
-    };
-
     use kernel::{
         dma::Coherent,
         dma_read,
@@ -72,10 +67,6 @@ pub(in crate::gsp) fn cpu_read_ptr(qs: &Coherent<GspMem>) -> u32 {
 
     pub(in crate::gsp) fn advance_cpu_read_ptr(qs: &Coherent<GspMem>, count: u32) {
         let rptr = cpu_read_ptr(qs).wrapping_add(count) % MSGQ_NUM_PAGES;
-
-        // Ensure read pointer is properly ordered.
-        fence(Ordering::SeqCst);
-
         dma_write!(qs, .cpuq.rx.0.readPtr, rptr);
     }
 
@@ -87,9 +78,6 @@ pub(in crate::gsp) fn advance_cpu_write_ptr(qs: &Coherent<GspMem>, count: u32) {
         let wptr = cpu_write_ptr(qs).wrapping_add(count) % MSGQ_NUM_PAGES;
 
         dma_write!(qs, .cpuq.tx.0.writePtr, wptr);
-
-        // Ensure all command data is visible before triggering the GSP read.
-        fence(Ordering::SeqCst);
     }
 }
 
-- 
2.51.2

