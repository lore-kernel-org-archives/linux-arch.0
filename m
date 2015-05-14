From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH 3/4] ARC: [axs101] Tweak DDR port aperture mappings for performance
Date: Thu, 14 May 2015 15:48:43 +0300
Message-ID: <1431607724-9142-4-git-send-email-abrodkin@synopsys.com>
References: <1431607724-9142-1-git-send-email-abrodkin@synopsys.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1431607724-9142-1-git-send-email-abrodkin@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, arc-linux-dev@synopsys.com, devicetree@vger.kernel.org, Vineet.Gupta1@synopsys.com
List-Id: linux-arch.vger.kernel.org

From: Vineet Gupta <vgupta@synopsys.com>

Route all MB originated traffic to DDR Port 1 and keep Port 0 for CPU
traffic only

Basic system parameters
--------------------------------------------------------------------------------------
        Host                 OS Description 				Mhz  tlb   cache  mem   scal
                                                			    pages  line   par   load
                                                      				   bytes
----------------- ------------- --------------------------------------- ---- ----- ----- ------ ----
axs101-sd-2-new-f Linux 3.13.0+ axs101-sd-2-new-fw-old-img-rerun    	739  	8    32 1.1100    1
axs101-sd-3-arc-3 Linux 3.13.9+ axs101-sd-3-arc-3.13-tip-regression 	735  	8    32 1.1000    1
axs101-sd-9-diffe Linux 3.13.11 axs101-sd-9-different-tweak         	740  	8    32 1.0000    1

Processor, Processes - times in microseconds - smaller is better
------------------------------------------------------------------------------
Host                 OS  Mhz null null      open slct sig  sig  fork exec sh
                             call  I/O stat clos TCP  inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ---- ---- ---- ---- ---- ----
axs101-sd Linux 3.13.0+  739 0.50 0.88 5.38 14.6 34.1 0.92 5.18 2135 6555 12.K
axs101-sd Linux 3.13.9+  735 0.50 0.90 5.89 19.2 81.4 0.94 4.08 2560 8559 15.K
axs101-sd Linux 3.13.11  740 0.50 0.88 4.45 17.8 34.4 0.94 3.25 2052 6493 12.K
                                                 ^^^^                     ^^^^

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/plat-axs10x/axs10x.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arc/plat-axs10x/axs10x.c b/arch/arc/plat-axs10x/axs10x.c
index 2e7686d..759a7a1 100644
--- a/arch/arc/plat-axs10x/axs10x.c
+++ b/arch/arc/plat-axs10x/axs10x.c
@@ -173,8 +173,8 @@ static const struct aperture axc001_memmap[16] = {
 	{AXC001_SLV_NONE,		0x0},
 	{AXC001_SLV_DDR_PORT0,		0x0}, /* 0x8000_0000: DDR   0..256M */
 	{AXC001_SLV_DDR_PORT0,		0x1}, /* 0x9000_0000: DDR 256..512M */
-	{AXC001_SLV_DDR_PORT1,		0x0},
-	{AXC001_SLV_DDR_PORT1,		0x1},
+	{AXC001_SLV_DDR_PORT0,		0x2},
+	{AXC001_SLV_DDR_PORT0,		0x3},
 	{AXC001_SLV_NONE,		0x0},
 	{AXC001_SLV_AXI_TUNNEL,		0xD},
 	{AXC001_SLV_AXI_TUNNEL,		0xE}, /* MB: CREG, CGU... */
@@ -194,10 +194,10 @@ static const struct aperture axc001_axi_tunnel_memmap[16] = {
 	{AXC001_SLV_NONE,		0x0},
 	{AXC001_SLV_NONE,		0x0},
 	{AXC001_SLV_NONE,		0x0},
-	{AXC001_SLV_DDR_PORT0,		0x0},
-	{AXC001_SLV_DDR_PORT0,		0x1},
 	{AXC001_SLV_DDR_PORT1,		0x0},
 	{AXC001_SLV_DDR_PORT1,		0x1},
+	{AXC001_SLV_DDR_PORT1,		0x2},
+	{AXC001_SLV_DDR_PORT1,		0x3},
 	{AXC001_SLV_NONE,		0x0},
 	{AXC001_SLV_AXI_TUNNEL,		0xD},
 	{AXC001_SLV_AXI_TUNNEL,		0xE},
-- 
2.1.0
