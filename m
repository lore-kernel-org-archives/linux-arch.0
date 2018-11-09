From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/2] csky, h8300, riscv: remove <asm/scatterlist.h> leftovers
Date: Fri,  9 Nov 2018 10:00:07 +0100
Message-ID: <20181109090008.24150-2-hch@lst.de>
References: <20181109090008.24150-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181109090008.24150-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: iommu@lists.linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

There has been no <asm/scatterlist.h> for a long time, which also means
there is no point in using it from asm-generic.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/csky/include/asm/Kbuild  | 1 -
 arch/h8300/include/asm/Kbuild | 1 -
 arch/riscv/include/asm/Kbuild | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
index 2a0abe8f2a35..7c48a123300d 100644
--- a/arch/csky/include/asm/Kbuild
+++ b/arch/csky/include/asm/Kbuild
@@ -34,7 +34,6 @@ generic-y += pci.h
 generic-y += percpu.h
 generic-y += preempt.h
 generic-y += qrwlock.h
-generic-y += scatterlist.h
 generic-y += sections.h
 generic-y += serial.h
 generic-y += shm.h
diff --git a/arch/h8300/include/asm/Kbuild b/arch/h8300/include/asm/Kbuild
index a5d0b2991f47..32f0c8952147 100644
--- a/arch/h8300/include/asm/Kbuild
+++ b/arch/h8300/include/asm/Kbuild
@@ -36,7 +36,6 @@ generic-y += parport.h
 generic-y += percpu.h
 generic-y += pgalloc.h
 generic-y += preempt.h
-generic-y += scatterlist.h
 generic-y += sections.h
 generic-y += serial.h
 generic-y += sizes.h
diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
index 6a646d9ea780..011cc7c7b3ad 100644
--- a/arch/riscv/include/asm/Kbuild
+++ b/arch/riscv/include/asm/Kbuild
@@ -37,7 +37,6 @@ generic-y += poll.h
 generic-y += posix_types.h
 generic-y += preempt.h
 generic-y += resource.h
-generic-y += scatterlist.h
 generic-y += sections.h
 generic-y += sembuf.h
 generic-y += serial.h
-- 
2.19.1
