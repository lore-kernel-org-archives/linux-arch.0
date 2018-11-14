From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 02/34] powerpc: allow NOT_COHERENT_CACHE for amigaone
Date: Wed, 14 Nov 2018 09:22:42 +0100
Message-ID: <20181114082314.8965-3-hch@lst.de>
References: <20181114082314.8965-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181114082314.8965-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, iommu@lists.linux-foundation.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

AMIGAONE select NOT_COHERENT_CACHE, so we better allow it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/platforms/Kconfig.cputype | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index f4e2c5729374..6fedbf349fce 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -412,7 +412,8 @@ config NR_CPUS
 
 config NOT_COHERENT_CACHE
 	bool
-	depends on 4xx || PPC_8xx || E200 || PPC_MPC512x || GAMECUBE_COMMON
+	depends on 4xx || PPC_8xx || E200 || PPC_MPC512x || \
+		GAMECUBE_COMMON || AMIGAONE
 	default n if PPC_47x
 	default y
 
-- 
2.19.1
