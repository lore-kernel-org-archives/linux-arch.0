Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010062.outbound.protection.outlook.com [52.101.46.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B5E3D411B;
	Thu,  9 Jul 2026 06:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579429; cv=fail; b=Qe3tLgIM5zviErNEP7fJEmoHqq6MkooC2ScVRxm+ELpCfYOU08x0X74P+aTAFW1dic7GlsO/mXlDSgUQgXv+L3/q8yymy4wwdCPfNL33ENSU7t3/okiOeuTXwC5yF+AaVKc0/r9pBfKdkG8w3jYZL9L5k8+yYUVpZOfM3tw/Ick=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579429; c=relaxed/simple;
	bh=EFY92RctPSn4rt12XblU7t9y26bM0Qdd1IjMCXEN8r8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tYvWv1VFWSDzYT/22767zpn/seG1iLRScX3Y805tdFtsT070ple7X2BVGPAvyH06d+1Wo7+c8WpWiuOfWxXeol7zZnc2C7v/EnwZg+fRGGSs5LJDfB4HH1cER3Qc2GCdixHj61YxphVuVpM+O1NxrTzcQxOSvVyR6pr+mGhayns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B3nbalfO; arc=fail smtp.client-ip=52.101.46.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B3nbalfO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UEYmMaxucnsGzc5zSA3yUniVZeCrVsDn4D318h/U0E8oqTQzzBT6WYh8vdgNSVXR5S1cpT4QxIDuUdJNxPHT+FZ02wvCG1gjbCZCW0MPa/FWpoObxJXHVHYpMG2ruq49PZiSxl8u5NmJTMslxixc0ZHG5d5z1Blae5o7jiIA2nAFE0IAdqmUWDWBcEeQNqzi3FBLJXWC7XGkg8nrD8DZQ62+KZFHF7W1ZaogTqmyuBgjQZ2mFQafOq/uWj0n04ySNkFruyoz8SODoPuH3F6T3RCbKm7FwV0vPABf1S5soEtvPo9Kg6ydAgGZU3ybEiRwvXwDrBCKrdZJ0SG2+X/UMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fb08XlILcgnPPS+HtD1MxpT+THx4tV+CmgFFLflX2lQ=;
 b=sYPNl8fokYFHO3YKvGev+fJ2CkxQTCXnsbqcoNn4nQQmdLhkaXNQlXxtSPXsSkT1NBzVFccHNh3wtrxiXRDwPCV9RokOr6En+DqK1sCm4nbWQDxbGyL7TWSb6aAddxWUzdxBjlQLDxblcxgebwT44CaBI2CIJuB17To/HKF7LuMGEgb8ojwy7IWaDjJIbw00Yll9VulElU0rz7tIMgCiwZCJZ/0W1PUwMfJ6748O3GYSRs+IiLT/BDaGcxiM7Wz53vL3k57dxU9XDM013Ul1O59A8esiZExWEOzlPz81tGtZxsF55R0Fv4KgT8aKIxCAPzy1zQzaPEUKnl8P7ZmbVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fb08XlILcgnPPS+HtD1MxpT+THx4tV+CmgFFLflX2lQ=;
 b=B3nbalfO2M/H1TlTqWSPFQNYKIo4vhnRDBV1q89WxWf6cvSfzXo7iJqSG5GjUirmGxijCIpDz2+K7sMg0pPAFaf7AUzxJ4fezYmM2XvUlqVqg9oMtpvkhAu2qvIKEVpS8tsw/wV/B9KuPQ+evWrihmQ94lGT5xsvXx0kebPz2B4=
Received: from BL1PR13CA0438.namprd13.prod.outlook.com (2603:10b6:208:2c3::23)
 by IA0PR12MB7506.namprd12.prod.outlook.com (2603:10b6:208:442::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 06:43:33 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::41) by BL1PR13CA0438.outlook.office365.com
 (2603:10b6:208:2c3::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.3 via Frontend Transport; Thu, 9
 Jul 2026 06:43:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 06:43:33 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 01:43:33 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 23:43:32 -0700
Received: from xhdshubpati40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Thu, 9 Jul 2026 01:43:25 -0500
From: Shubham Patil <shubhamsanjay.patil@amd.com>
To: <git@amd.com>, <michal.simek@amd.com>, <alexandre.belloni@bootlin.com>,
	<Frank.Li@nxp.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <pgaj@cadence.com>,
	<wsa+renesas@sang-engineering.com>, <tommaso.merciai.xr@bp.renesas.com>,
	<arnd@arndb.de>, <quic_msavaliy@quicinc.com>, <Shyam-sundar.S-k@amd.com>,
	<sakari.ailus@linux.intel.com>, <billy_tsai@aspeedtech.com>,
	<kees@kernel.org>, <gustavoars@kernel.org>, <jarkko.nikula@linux.intel.com>,
	<jorge.marques@analog.com>, <linux-i3c@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-hardening@vger.kernel.org>
CC: <radhey.shyam.pandey@amd.com>, <srinivas.goud@amd.com>,
	<shubhrajyoti.datta@amd.com>, <shubhamsanjay.patil@amd.com>, "Manikanta
 Guntupalli" <manikanta.guntupalli@amd.com>
Subject: [PATCH v10 2/2] i3c: master: Add driver for AMD AXI I3C master controller
Date: Thu, 9 Jul 2026 12:12:33 +0530
Message-ID: <20260709064233.1451482-3-shubhamsanjay.patil@amd.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20260709064233.1451482-1-shubhamsanjay.patil@amd.com>
References: <20260709064233.1451482-1-shubhamsanjay.patil@amd.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|IA0PR12MB7506:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d9ceed8-9364-4359-4667-08dedd8565a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|82310400026|36860700016|1800799024|921020|18002099003|22082099003|3023799007|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	iNW0h8vgSaFVLLW2rf4z4zMvnSDujg4XYP6eY0Fv5G9ym3FY/edaQdWC+7UElzz2gg39jrVBN8oXprM5CSAooHTC1SP+CdCrtkm1dktZWBnCKYVo9SLpjh1vCPWg8hSPthgDTaDFtmKqk78UTnt6nr7e+mI+ujVEZDoUrE//2LpULVxMHU7hQ18R6Yt0k/n2wNsDpTt1nhg8ZrxCp9raA0uaiyX7BkcXVe6TJ3YVTimjP6IaT22eaFY03kL9rDTISEbjxav5c7sQLH9AQAdeDyRP+ev1ZmlPT5pJXhaSQJbzEyf0g7+jRSxEC6R6utQvdZcGgq1s2kVPOlGOF/zWuK6SkSNPBwehYq/gHWDZ+wlvFSPMHk5LsQLE/8HVoBPy4kthJo9hGyNnYteBcGI0GuCAKhrkMSccx+jqcEcMySMQcDaS3Twz+bVTDuvVeJC8tikPWeATE0LXZK8Cd6V3Sqi0lNBsxSvr+lT6KHG46BOEgr/lJ6GKjlpQz2jIavXhOOjH6g00Qy6YeOqRyY+d+Aewt9por4hxfhkfSWTn+x/NAn0ARiatzIFZmbWpHztfn+nnFRTfZDmUbST3IWSDnfQ06zNFDQMDaOobblzAu/tJ9+TgYf0VhSEnCskWa5ITGV7qQlx42PSTlIEzZpPZhfvsoHclE3AC649csT/4pzXvxFLd8chRmuDwgrawUL98xYy9i0ut9Yidbr8m4QbRkaUSDqDBOL+pb02LCN5/B7HFA7/3/UHeT/kKQQaiE+dt
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(921020)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jigqvxlL/Xg/oTBincAjmrmnbjPXRX+lWILP9Gd0OkKqeufT02kvueSnNpE137lHrowY1ANsNPPbuHdHhACyb6enCoCbnzMeSnbRLTI+z3zxaTZwb3zLr8xfm3caHCyiszAhtVoaVcqvQB0tKdZcihkYZd5VYW0CcPuLHdftrBqnkWSPNrrxj40MTP7lOT+3On26PHVu7eebeebb0v+cYxdipy3rAHhvzaeBBh7jUE95RcHY15//BztijEDYoTNNqnvySMXyKBrr7YMRXNQdJp+QnakvqNZXFU9pzd+LKvWkEKwpz7TN0qHDj5loB0Hsh4MAi33W0TOZ3JB+FT3zWO0hLy+qVctW8tkF5YxAhOyCQl8YwS4MrHjV+Irpk+L7P2Briyu1O196ZQYglfngGW+2tXtZ8KWBOCpQUBO5QUj/Tmp22JUZoUFAo3o6ovSB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 06:43:33.8338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d9ceed8-9364-4359-4667-08dedd8565a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7506

From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>

Add an I3C master driver and maintainers fragment for the AMD I3C bus
controller.

The driver currently supports the I3C bus operating in SDR mode,
with features including Dynamic Address Assignment, private data
transfers, and CCC transfers in both broadcast and direct modes. It
also supports operation in I2C mode.

The controller's data FIFOs are accessed big-endian; the driver performs
this conversion locally using ioread32be()/iowrite32be() with the
helpers, so it does not depend on any core FIFO-endianness helpers.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Co-developed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
Co-developed-by: Shubham Patil <shubhamsanjay.patil@amd.com>
Signed-off-by: Shubham Patil <shubhamsanjay.patil@amd.com>
---
Changes for V10:
clk config: reject timing values exceeding the 18-bit registers (-EINVAL)
instead of silently masking.
Direct CCC read: clamp length to min(rx_actual, payload.len).
Private transfers: report err/actual_len only for issued commands.
Handle response code 5 (early T-bit read termination) as a short read;
added xi3c_cmd.rx_actual and XI3C_RESP_BYTES_MASK.
Report actual_len as min(rx_actual, len) for private reads.
Allow zero-length transfers with a NULL buffer.
DAA: move PID scratch buffer off-stack to kcalloc().
DAA: drop i3c_master_add_i3c_dev_locked() return check.
DAA: replace __free(kfree) with explicit kfree() at a single out: label.
DAA: on max devices / no free address, warn and break so already
enumerated devices are kept.
Document timing constants (MIPI I3C v1.1.1, AMD PG439); fix OD/tCAS
constants to ns and XI3C_MAX_DEVS to 128.
Replace udelay() with fsleep() in FIFO reset.
Use kzalloc_flex() and kmalloc_objs().
Replace min_t() with min() in RX-FIFO drain.
Trim verbose comments and drop two MODULE_AUTHOR lines.

Changes for V9:
Drop big-endian MMIO infra patches; do BE FIFO access locally with
ioread32be()/iowrite32be() (self-contained, no internals.h).
Replace async completion/queue with a synchronous path under the mutex.
Rework response handling: add enum i3c_error_code, return -ENODEV/-EIO,
set err M2/M0, and propagate err to CCC and private transfers.
Switch .priv_xfers to .i3c_xfers; reject non-SDR modes (-EOPNOTSUPP).
Rework DAA: incremental addressing, bounded count (-ENOSPC),
end-of-enumeration via -ENODEV, zeroed PID buffers.
Sleep with usleep_range() in FIFO loops instead of busy-spinning.
Use FIELD_PREP() with named masks; convert accessor macros to inlines.
Split the timeout macro into XI3C_RESP_TIMEOUT_US and XI3C_XFER_TIMEOUT_MS;
add XI3C_POLL_INTERVAL_US.
xi3c_clk_cfg(): use NSEC_PER_SEC and named constants, guard underflow,
handle I3C_BUS_MODE_MIXED_SLOW.
Drop ENTHDR (SDR-only); dispatch CCCs via the I3C_CCC_DIRECT bit.
Use const TX buffers and parity8() for the DAA parity bit.
Update MODULE_DESCRIPTION, copyright, and Kconfig to AMD_AXI_I3C_MASTER;
fix the MAINTAINERS entry.

Changes for V8:
Used time_left instead of timeout.
Used __free(kfree) for xfer to simplify err path in multiple places.

Changes for V7:
Updated timeout macro name.
Updated xi3c_master_wr_to_tx_fifo() and xi3c_master_rd_from_rx_fifo()
to use i3c_writel_fifo() and i3c_readl_fifo().

Changes for V6:
Removed typecast for xi3c_getrevisionnumber(), xi3c_wrfifolevel(),
and xi3c_rdfifolevel().
Replaced dynamic allocation with a static variable for pid_bcr_dcr.
Fixed sparse warning in do_daa by typecasting the address parity value
to u8.
Fixed sparse warning in xi3c_master_bus_init by typecasting the pid value
to u64 in info.pid calculation.

Changes for V5:
Used GENMASK_ULL for PID mask as it's 64bit mask.

Changes for V4:
Updated timeout macros.
Removed type casting for xi3c_is_resp_available() macro.
Used ioread32() and iowrite32() instead of readl() and writel()
to keep consistency.
Read XI3C_RESET_OFFSET reg before udelay().
Removed xi3c_master_free_xfer() and directly used kfree().
Skipped checking return value of i3c_master_add_i3c_dev_locked().
Used devm_mutex_init() instead of mutex_init().

Changes for V3:
Resolved merge conflicts.

Changes for V2:
Updated commit description.
Added mixed mode support with clock configuration.
Converted smaller functions into inline functions.
Used FIELD_GET() in xi3c_get_response().
Updated xi3c_master_rd_from_rx_fifo() to use cmd->rx_buf.
Used parity8() for address parity calculation.
Added guards for locks.
Dropped num_targets and updated xi3c_master_do_daa().
Used __free(kfree) in xi3c_master_send_bdcast_ccc_cmd().
Dropped PM runtime support.
Updated xi3c_master_read() and xi3c_master_write() with
xi3c_is_resp_available() check.
Created separate functions: xi3c_master_init() and xi3c_master_reinit().
Used xi3c_master_init() in bus initialization and xi3c_master_reinit()
in error paths.
Added DAA structure to xi3c_master structure.
---
 MAINTAINERS                         |    8 +
 drivers/i3c/master/Kconfig          |   15 +
 drivers/i3c/master/Makefile         |    1 +
 drivers/i3c/master/amd-i3c-master.c | 1124 +++++++++++++++++++++++++++
 4 files changed, 1148 insertions(+)
 create mode 100644 drivers/i3c/master/amd-i3c-master.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 461a3eed6129..bfaa6999913c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1035,6 +1035,14 @@ L:	linux-sound@vger.kernel.org
 S:	Supported
 F:	sound/soc/amd/
 
+AMD AXI I3C MASTER DRIVER
+M:	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
+M:	Shubham Patil <shubhamsanjay.patil@amd.com>
+L:	linux-i3c@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/i3c/xlnx,axi-i3c-1.0.yaml
+F:	drivers/i3c/master/amd-i3c-master.c
+
 AMD AXI W1 DRIVER
 M:	Kris Chaplin <kris.chaplin@amd.com>
 R:	Thomas Delev <thomas.delev@amd.com>
diff --git a/drivers/i3c/master/Kconfig b/drivers/i3c/master/Kconfig
index 2609f2b18e0a..da96d2aaa399 100644
--- a/drivers/i3c/master/Kconfig
+++ b/drivers/i3c/master/Kconfig
@@ -86,3 +86,18 @@ config RENESAS_I3C
 
 	  This driver can also be built as a module. If so, the module will be
 	  called renesas-i3c.
+
+config AMD_AXI_I3C_MASTER
+	tristate "AMD AXI I3C Master driver"
+	depends on HAS_IOMEM
+	help
+	  Support for the AMD AXI I3C master controller, a soft IP used on
+	  AMD (Xilinx) FPGAs and adaptive SoCs with ARM or MicroBlaze
+	  processors.
+
+	  The controller currently supports Standard Data Rate (SDR) mode.
+	  Features include Dynamic Address Assignment, private transfers,
+	  and CCC transfers in both broadcast and direct modes.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called amd-i3c-master.
diff --git a/drivers/i3c/master/Makefile b/drivers/i3c/master/Makefile
index 816a227b6f7a..8d82196dcf83 100644
--- a/drivers/i3c/master/Makefile
+++ b/drivers/i3c/master/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_AST2600_I3C_MASTER)	+= ast2600-i3c-master.o
 obj-$(CONFIG_SVC_I3C_MASTER)		+= svc-i3c-master.o
 obj-$(CONFIG_MIPI_I3C_HCI)		+= mipi-i3c-hci/
 obj-$(CONFIG_RENESAS_I3C)		+= renesas-i3c.o
+obj-$(CONFIG_AMD_AXI_I3C_MASTER)	+= amd-i3c-master.o
diff --git a/drivers/i3c/master/amd-i3c-master.c b/drivers/i3c/master/amd-i3c-master.c
new file mode 100644
index 000000000000..ef5ad5abb788
--- /dev/null
+++ b/drivers/i3c/master/amd-i3c-master.c
@@ -0,0 +1,1124 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * I3C master driver for the AMD I3C controller.
+ *
+ * Copyright (C) 2026, Advanced Micro Devices, Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/cleanup.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/i3c/master.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/time.h>
+#include <linux/unaligned.h>
+
+#define XI3C_VERSION_OFFSET			0x00	/* Version Register */
+#define XI3C_RESET_OFFSET			0x04	/* Soft Reset Register */
+#define XI3C_CR_OFFSET				0x08	/* Control Register */
+#define XI3C_ADDRESS_OFFSET			0x0C	/* Target Address Register */
+#define XI3C_SR_OFFSET				0x10	/* Status Register */
+#define XI3C_CMD_FIFO_OFFSET			0x20	/* I3C Command FIFO Register */
+#define XI3C_WR_FIFO_OFFSET			0x24	/* I3C Write Data FIFO Register */
+#define XI3C_RD_FIFO_OFFSET			0x28	/* I3C Read Data FIFO Register */
+#define XI3C_RESP_STATUS_FIFO_OFFSET		0x2C	/* I3C Response status FIFO Register */
+#define XI3C_FIFO_LVL_STATUS_OFFSET		0x30	/* CMD slots free | WR-FIFO free (words) */
+#define XI3C_FIFO_LVL_STATUS_1_OFFSET		0x34	/* RESP fill | RD-FIFO fill level (words) */
+#define XI3C_SCL_HIGH_TIME_OFFSET		0x38	/* I3C SCL HIGH Register */
+#define XI3C_SCL_LOW_TIME_OFFSET		0x3C	/* I3C SCL LOW Register */
+#define XI3C_SDA_HOLD_TIME_OFFSET		0x40	/* I3C SDA HOLD Register */
+#define XI3C_TSU_START_OFFSET			0x48	/* I3C START SETUP Register */
+#define XI3C_THD_START_OFFSET			0x4C	/* I3C START HOLD Register */
+#define XI3C_TSU_STOP_OFFSET			0x50	/* I3C STOP Setup Register */
+#define XI3C_OD_SCL_HIGH_TIME_OFFSET		0x54	/* I3C OD SCL HIGH Register */
+#define XI3C_OD_SCL_LOW_TIME_OFFSET		0x58	/* I3C OD SCL LOW Register */
+#define XI3C_PID0_OFFSET			0x6C	/* LSB 4 bytes of the PID */
+#define XI3C_PID1_BCR_DCR			0x70	/* MSB 2 bytes of the PID, BCR and DCR */
+
+#define XI3C_CR_EN_MASK				BIT(0)	/* Core Enable */
+#define XI3C_CR_RESUME_MASK			BIT(2)	/* Core Resume */
+#define XI3C_SR_RESP_NOT_EMPTY_MASK		BIT(4)	/* Resp Fifo not empty status mask */
+#define XI3C_RD_FIFO_NOT_EMPTY_MASK		BIT(15)	/* Read Fifo not empty status mask */
+
+#define XI3C_BCR_MASK				GENMASK(23, 16)
+#define XI3C_DCR_MASK				GENMASK(31, 24)
+#define XI3C_PID_MASK				GENMASK_ULL(63, 16)
+#define XI3C_TIMING_MASK			GENMASK(17, 0)
+#define XI3C_REV_NUM_MASK			GENMASK(15, 8)
+#define XI3C_PID1_MASK				GENMASK(15, 0)
+#define XI3C_FIFO_LEVEL_MASK			GENMASK(15, 0)
+#define XI3C_RESP_CODE_MASK			GENMASK(8, 5)
+
+/* Controller response codes; PG439 page 34, Table 46 */
+#define XI3C_RESP_CODE_SUCCESS			0	/* Transfer completed OK */
+#define XI3C_RESP_CODE_NO_TARGET		2	/* 7E NACK: no target on bus */
+#define XI3C_RESP_CODE_NACK			3	/* Target NACK / DAA end */
+#define XI3C_RESP_CODE_READ_EARLY_TERM	5	/* Target ended read early (T-bit), short read */
+
+/* xi3c_get_response() private return: read ended early with valid data; resume needed */
+#define XI3C_XFER_SHORT_READ			1
+
+#define XI3C_RESP_BYTES_MASK			GENMASK(20, 9)	/* NUM_BYTES processed */
+#define XI3C_ADDR_MASK				GENMASK(6, 0)
+#define XI3C_FIFOS_RST_MASK			GENMASK(4, 1)
+
+/* Command FIFO word layout (bit ranges encoded in the GENMASK/BIT args) */
+#define XI3C_CMD_TYPE				GENMASK(3, 0)	/* command type */
+#define XI3C_CMD_TERMINATE			BIT(4)		/* terminate (last cmd of xfer) */
+#define XI3C_CMD_ADDR				GENMASK(15, 8)	/* target address << 1 | RnW */
+#define XI3C_CMD_LEN				GENMASK(27, 16)	/* payload length in bytes */
+#define XI3C_CMD_TID				GENMASK(31, 28)	/* transfer ID */
+
+/* tLOW_OD open-drain SCL low; MIPI I3C v1.1.1 Table 74 min 200 ns, 500 ns chosen conservatively */
+#define XI3C_OD_TLOW_NS				500
+/* Open-drain SCL high (tHIGH) max; MIPI I3C v1.1.1 Table 74 (41 ns) */
+#define XI3C_OD_THIGH_NS			41
+/*
+ * tSU_STA/tHD_STA/tSU_STO min, 400 kHz/Fm; MIPI I3C v1.1.1 Table 73
+ * (mixed bus with legacy I2C device)
+ */
+#define XI3C_I2C_TCASMIN_NS			600
+/* tSU_STA/tHD_STA/tSU_STO min, 1 MHz/Fm+; MIPI I3C v1.1.1 Table 73 (pure I3C bus) */
+#define XI3C_TCASMIN_NS				260
+/* Max payload per transfer: 12-bit CMD length field (XI3C_CMD_LEN); PG439 page 32, Table 42 */
+#define XI3C_MAXDATA_LENGTH			4095
+/* Max enumerated devices; PG439 page 27, AXI_I3C_IBI_TARGET_ADDR register detail */
+#define XI3C_MAX_DEVS				128
+/* DAA target response = 48-bit PID + BCR + DCR = 8 bytes; PG439 page 28 */
+#define XI3C_DAA_SLAVEINFO_READ_BYTECOUNT	8
+
+/*
+ * Min SDA hold cycles, rev 0 IP. Revision-specific value, PG439 page 24,
+ * AXI_I3C_SDA_HOLD_TIME register detail
+ */
+#define XI3C_THOLD_MIN_REV0			5
+/*
+ * Min SDA hold cycles, rev >= 1 IP. Revision-specific value, PG439 page 24,
+ * AXI_I3C_SDA_HOLD_TIME register detail
+ */
+#define XI3C_THOLD_MIN_REV1			6
+/*
+ * SCL/SDA pre-bias to account for the HW pipeline. PG439 page 24,
+ * AXI_I3C_SDA_HOLD_TIME register detail
+ */
+#define XI3C_CYCLE_ADJUST			2
+/* Short settling delay so the FIFO reset assert/de-assert takes effect before the FIFOs are used */
+#define XI3C_FIFO_RESET_DELAY_US		10
+/*
+ * Poll/sleep slice for FIFO and response waits: small enough to stay
+ * responsive, avoids busy-waiting
+ */
+#define XI3C_POLL_INTERVAL_US			10
+
+#define XI3C_I2C_MODE				0
+#define XI3C_I2C_TID				0
+#define XI3C_SDR_MODE				1
+#define XI3C_SDR_TID				1
+
+#define XI3C_WORD_LEN				4
+
+/* Software guard: 500 ms (us, for readl_poll_timeout) to bail out if no response word arrives */
+#define XI3C_RESP_TIMEOUT_US			500000
+/* Software guard: 1 s (ms, for msecs_to_jiffies) to bail out if a transfer never completes */
+#define XI3C_XFER_TIMEOUT_MS			1000
+
+struct xi3c_cmd {
+	const void *tx_buf;
+	void *rx_buf;
+	u16 tx_len;
+	u16 rx_len;
+	u16 rx_actual;
+	u8 addr;
+	u8 type;
+	u8 tid;
+	bool rnw;
+	bool is_daa;
+	bool continued;
+	enum i3c_error_code err;
+};
+
+struct xi3c_xfer {
+	unsigned int ncmds;
+	unsigned int nissued;
+	struct xi3c_cmd cmds[] __counted_by(ncmds);
+};
+
+/**
+ * struct xi3c_master - I3C master controller state.
+ * @base: I3C master controller embedded by the framework.
+ * @dev: Pointer to the backing device structure.
+ * @membase: Memory base of the HW registers.
+ * @pclk: Input clock driving the controller.
+ * @lock: Serializes transfers and CCC submission.
+ * @daa: ENTDAA enumeration state.
+ * @daa.addrs: Dynamic addresses assigned in enumeration order.
+ * @daa.index: Number of responders enumerated so far.
+ */
+struct xi3c_master {
+	struct i3c_master_controller base;
+	struct device *dev;
+	void __iomem *membase;
+	struct clk *pclk;
+	struct mutex lock; /* serializes transfers and CCC submission */
+	struct {
+		u8 addrs[XI3C_MAX_DEVS];
+		u8 index;
+	} daa;
+};
+
+static inline struct xi3c_master *
+to_xi3c_master(struct i3c_master_controller *master)
+{
+	return container_of(master, struct xi3c_master, base);
+}
+
+static inline u8 xi3c_get_revision_number(struct xi3c_master *master)
+{
+	return FIELD_GET(XI3C_REV_NUM_MASK,
+			 ioread32(master->membase + XI3C_VERSION_OFFSET));
+}
+
+static inline u16 xi3c_wr_fifo_level(struct xi3c_master *master)
+{
+	return ioread32(master->membase + XI3C_FIFO_LVL_STATUS_OFFSET) &
+	       XI3C_FIFO_LEVEL_MASK;
+}
+
+static inline u16 xi3c_rd_fifo_level(struct xi3c_master *master)
+{
+	return ioread32(master->membase + XI3C_FIFO_LVL_STATUS_1_OFFSET) &
+	       XI3C_FIFO_LEVEL_MASK;
+}
+
+static inline bool xi3c_is_resp_available(struct xi3c_master *master)
+{
+	return FIELD_GET(XI3C_SR_RESP_NOT_EMPTY_MASK,
+			 ioread32(master->membase + XI3C_SR_OFFSET));
+}
+
+static int xi3c_get_response(struct xi3c_master *master, struct xi3c_cmd *cmd)
+{
+	u32 response_data;
+	u32 resp_reg;
+	u8 code;
+	int ret;
+
+	ret = readl_poll_timeout(master->membase + XI3C_SR_OFFSET,
+				 resp_reg,
+				 resp_reg & XI3C_SR_RESP_NOT_EMPTY_MASK,
+				 XI3C_POLL_INTERVAL_US, XI3C_RESP_TIMEOUT_US);
+	if (ret) {
+		dev_err(master->dev, "XI3C response timeout\n");
+		return ret;
+	}
+
+	response_data = ioread32(master->membase + XI3C_RESP_STATUS_FIFO_OFFSET);
+	code = FIELD_GET(XI3C_RESP_CODE_MASK, response_data);
+
+	switch (code) {
+	case XI3C_RESP_CODE_SUCCESS:
+		cmd->err = I3C_ERROR_UNKNOWN;
+		cmd->rx_actual = FIELD_GET(XI3C_RESP_BYTES_MASK, response_data);
+		return 0;
+	case XI3C_RESP_CODE_READ_EARLY_TERM:
+		/* Short read: valid data, but controller parked in STOP and must be resumed */
+		cmd->err = I3C_ERROR_UNKNOWN;
+		cmd->rx_actual = FIELD_GET(XI3C_RESP_BYTES_MASK, response_data);
+		return XI3C_XFER_SHORT_READ;
+	case XI3C_RESP_CODE_NO_TARGET:
+	case XI3C_RESP_CODE_NACK:
+		cmd->err = I3C_ERROR_M2;
+		return cmd->is_daa ? -ENODEV : -EIO;
+	default:
+		cmd->err = I3C_ERROR_M0;
+		dev_err(master->dev, "XI3C transfer error, response code %u\n",
+			code);
+		return -EIO;
+	}
+}
+
+static inline void xi3c_writesl_be(void __iomem *addr, const void *buffer,
+				   unsigned int count)
+{
+	const u32 *buf = buffer;
+
+	while (count--)
+		iowrite32be(get_unaligned(buf++), addr);
+}
+
+static inline void xi3c_readsl_be(const void __iomem *addr, void *buffer,
+				  unsigned int count)
+{
+	u32 *buf = buffer;
+
+	while (count--)
+		put_unaligned(ioread32be(addr), buf++);
+}
+
+static inline void xi3c_writel_fifo(void __iomem *addr, const void *buf,
+				    int nbytes)
+{
+	xi3c_writesl_be(addr, buf, nbytes / 4);
+	if (nbytes & 3) {
+		u32 tmp = 0;
+
+		memcpy(&tmp, (const u8 *)buf + (nbytes & ~3), nbytes & 3);
+		xi3c_writesl_be(addr, &tmp, 1);
+	}
+}
+
+static inline void xi3c_readl_fifo(const void __iomem *addr, void *buf,
+				   int nbytes)
+{
+	xi3c_readsl_be(addr, buf, nbytes / 4);
+	if (nbytes & 3) {
+		u32 tmp;
+
+		xi3c_readsl_be(addr, &tmp, 1);
+		memcpy((u8 *)buf + (nbytes & ~3), &tmp, nbytes & 3);
+	}
+}
+
+static void xi3c_master_write_to_cmdfifo(struct xi3c_master *master,
+					 struct xi3c_cmd *cmd, u16 len)
+{
+	u32 transfer_cmd;
+	u8 addr;
+
+	addr = ((cmd->addr & XI3C_ADDR_MASK) << 1) | (u8)cmd->rnw;
+
+	transfer_cmd  = FIELD_PREP(XI3C_CMD_TYPE, cmd->type);
+	transfer_cmd |= FIELD_PREP(XI3C_CMD_TERMINATE, !cmd->continued);
+	transfer_cmd |= FIELD_PREP(XI3C_CMD_ADDR, addr);
+	transfer_cmd |= FIELD_PREP(XI3C_CMD_TID, cmd->tid);
+
+	/*
+	 * For dynamic addressing, an additional 1-byte length must be added
+	 * to the command FIFO to account for the address present in the TX FIFO
+	 */
+	if (cmd->is_daa) {
+		xi3c_writel_fifo(master->membase + XI3C_WR_FIFO_OFFSET,
+				 cmd->tx_buf, cmd->tx_len);
+
+		len++;
+	}
+
+	transfer_cmd |= FIELD_PREP(XI3C_CMD_LEN, len);
+	iowrite32(transfer_cmd, master->membase + XI3C_CMD_FIFO_OFFSET);
+}
+
+static inline void xi3c_master_enable(struct xi3c_master *master)
+{
+	iowrite32(ioread32(master->membase + XI3C_CR_OFFSET) | XI3C_CR_EN_MASK,
+		  master->membase + XI3C_CR_OFFSET);
+}
+
+static inline void xi3c_master_disable(struct xi3c_master *master)
+{
+	iowrite32(ioread32(master->membase + XI3C_CR_OFFSET) & ~XI3C_CR_EN_MASK,
+		  master->membase + XI3C_CR_OFFSET);
+}
+
+static inline void xi3c_master_resume(struct xi3c_master *master)
+{
+	iowrite32(ioread32(master->membase + XI3C_CR_OFFSET) |
+		  XI3C_CR_RESUME_MASK, master->membase + XI3C_CR_OFFSET);
+}
+
+static void xi3c_master_reset_fifos(struct xi3c_master *master)
+{
+	u32 data;
+
+	/* Assert FIFO reset. */
+	data = ioread32(master->membase + XI3C_RESET_OFFSET);
+	data |= XI3C_FIFOS_RST_MASK;
+	iowrite32(data, master->membase + XI3C_RESET_OFFSET);
+	/* Read-back flushes the posted write before the settling delay below. */
+	ioread32(master->membase + XI3C_RESET_OFFSET);
+	fsleep(XI3C_FIFO_RESET_DELAY_US);
+
+	/* De-assert FIFO reset, then wait for the FIFOs to come back up. */
+	data &= ~XI3C_FIFOS_RST_MASK;
+	iowrite32(data, master->membase + XI3C_RESET_OFFSET);
+	ioread32(master->membase + XI3C_RESET_OFFSET);
+	fsleep(XI3C_FIFO_RESET_DELAY_US);
+}
+
+static inline void xi3c_master_init(struct xi3c_master *master)
+{
+	/* Reset fifos */
+	xi3c_master_reset_fifos(master);
+
+	/* Enable controller */
+	xi3c_master_enable(master);
+}
+
+static inline void xi3c_master_reinit(struct xi3c_master *master)
+{
+	/* Reset fifos */
+	xi3c_master_reset_fifos(master);
+
+	/* Resume controller */
+	xi3c_master_resume(master);
+}
+
+static struct xi3c_xfer *xi3c_master_alloc_xfer(unsigned int ncmds)
+{
+	struct xi3c_xfer *xfer;
+
+	xfer = kzalloc_flex(*xfer, cmds, ncmds, GFP_KERNEL);
+	if (!xfer)
+		return NULL;
+
+	xfer->ncmds = ncmds;
+
+	return xfer;
+}
+
+static void xi3c_master_rd_from_rx_fifo(struct xi3c_master *master,
+					struct xi3c_cmd *cmd)
+{
+	u16 rx_data_available;
+	u16 copy_len;
+	u16 len;
+
+	rx_data_available = xi3c_rd_fifo_level(master);
+	len = rx_data_available * XI3C_WORD_LEN;
+
+	if (!len)
+		return;
+
+	copy_len = min(len, cmd->rx_len);
+	xi3c_readl_fifo(master->membase + XI3C_RD_FIFO_OFFSET,
+			(u8 *)cmd->rx_buf, copy_len);
+
+	cmd->rx_buf = (u8 *)cmd->rx_buf + copy_len;
+	cmd->rx_len -= copy_len;
+}
+
+static int xi3c_master_read(struct xi3c_master *master, struct xi3c_cmd *cmd)
+{
+	unsigned long timeout;
+	u32 status_reg;
+	int ret;
+
+	if (cmd->rx_len > XI3C_MAXDATA_LENGTH)
+		return -EINVAL;
+	/*
+	 * Zero-length probes (e.g. i2cdetect) legitimately pass a NULL
+	 * buffer; only a non-zero length requires one.
+	 */
+	if (cmd->rx_len && !cmd->rx_buf)
+		return -EINVAL;
+
+	/* Fill command fifo */
+	xi3c_master_write_to_cmdfifo(master, cmd, cmd->rx_len);
+
+	if (!cmd->rx_len)
+		return 0;
+
+	ret = readl_poll_timeout(master->membase + XI3C_SR_OFFSET,
+				 status_reg,
+				 status_reg & (XI3C_RD_FIFO_NOT_EMPTY_MASK |
+					       XI3C_SR_RESP_NOT_EMPTY_MASK),
+				 XI3C_POLL_INTERVAL_US, XI3C_RESP_TIMEOUT_US);
+	if (ret) {
+		dev_err(master->dev, "XI3C read timeout\n");
+		return ret;
+	}
+
+	if (!(status_reg & XI3C_RD_FIFO_NOT_EMPTY_MASK))
+		return 0;
+
+	timeout = jiffies + msecs_to_jiffies(XI3C_XFER_TIMEOUT_MS);
+
+	/* Read data from rx fifo */
+	while (cmd->rx_len > 0 && !xi3c_is_resp_available(master)) {
+		if (time_after(jiffies, timeout)) {
+			dev_err(master->dev, "XI3C read timeout\n");
+			return -EIO;
+		}
+		xi3c_master_rd_from_rx_fifo(master, cmd);
+		usleep_range(XI3C_POLL_INTERVAL_US, 2 * XI3C_POLL_INTERVAL_US);
+	}
+
+	/* Read remaining data */
+	xi3c_master_rd_from_rx_fifo(master, cmd);
+
+	return 0;
+}
+
+static void xi3c_master_wr_to_tx_fifo(struct xi3c_master *master,
+				      struct xi3c_cmd *cmd)
+{
+	u16 wrfifo_space;
+	u16 len;
+
+	wrfifo_space = xi3c_wr_fifo_level(master);
+	if (cmd->tx_len > wrfifo_space * XI3C_WORD_LEN)
+		len = wrfifo_space * XI3C_WORD_LEN;
+	else
+		len = cmd->tx_len;
+
+	if (len) {
+		xi3c_writel_fifo(master->membase + XI3C_WR_FIFO_OFFSET, cmd->tx_buf,
+				 len);
+
+		cmd->tx_buf = (const u8 *)cmd->tx_buf + len;
+		cmd->tx_len -= len;
+	}
+}
+
+static int xi3c_master_write(struct xi3c_master *master, struct xi3c_cmd *cmd)
+{
+	unsigned long timeout;
+	u16 cmd_len;
+
+	if (cmd->tx_len > XI3C_MAXDATA_LENGTH)
+		return -EINVAL;
+	/*
+	 * Zero-length probes (e.g. i2cdetect) legitimately pass a NULL
+	 * buffer; only a non-zero length requires one.
+	 */
+	if (cmd->tx_len && !cmd->tx_buf)
+		return -EINVAL;
+
+	cmd_len = cmd->tx_len;
+
+	/* Fill Tx fifo */
+	xi3c_master_wr_to_tx_fifo(master, cmd);
+
+	/* Write to command fifo */
+	xi3c_master_write_to_cmdfifo(master, cmd, cmd_len);
+
+	timeout = jiffies + msecs_to_jiffies(XI3C_XFER_TIMEOUT_MS);
+	/* Fill if any remaining data to tx fifo */
+	while (cmd->tx_len > 0 && !xi3c_is_resp_available(master)) {
+		if (time_after(jiffies, timeout)) {
+			dev_err(master->dev, "XI3C write timeout\n");
+			return -EIO;
+		}
+
+		xi3c_master_wr_to_tx_fifo(master, cmd);
+		usleep_range(XI3C_POLL_INTERVAL_US, 2 * XI3C_POLL_INTERVAL_US);
+	}
+
+	return 0;
+}
+
+static int xi3c_master_xfer(struct xi3c_master *master, struct xi3c_cmd *cmd)
+{
+	int ret;
+
+	if (cmd->rnw)
+		ret = xi3c_master_read(master, cmd);
+	else
+		ret = xi3c_master_write(master, cmd);
+
+	if (ret)
+		goto err_xfer_out;
+
+	ret = xi3c_get_response(master, cmd);
+	if (ret < 0)
+		goto err_xfer_out;
+
+	/* Short read leaves the controller parked in STOP; resume it for the next command */
+	if (ret == XI3C_XFER_SHORT_READ)
+		xi3c_master_resume(master);
+
+	return 0;
+
+err_xfer_out:
+	xi3c_master_reinit(master);
+	return ret;
+}
+
+static int xi3c_master_common_xfer(struct xi3c_master *master,
+				   struct xi3c_xfer *xfer)
+{
+	unsigned int i;
+	int ret;
+
+	guard(mutex)(&master->lock);
+
+	for (i = 0; i < xfer->ncmds; i++) {
+		ret = xi3c_master_xfer(master, &xfer->cmds[i]);
+		if (ret) {
+			/* Count commands sent on the bus; the rest never ran */
+			xfer->nissued = i + 1;
+			return ret;
+		}
+	}
+
+	xfer->nissued = xfer->ncmds;
+
+	return 0;
+}
+
+static int xi3c_master_do_daa(struct i3c_master_controller *m)
+{
+	u8 (*pid_bufs)[XI3C_DAA_SLAVEINFO_READ_BYTECOUNT];
+	struct xi3c_master *master = to_xi3c_master(m);
+	struct xi3c_cmd *daa_cmd;
+	struct xi3c_xfer *xfer;
+	int addr, ret, i;
+	u8 last_addr = 0;
+	u8 *pid_buf;
+	u8 ccc_id;
+
+	xfer = xi3c_master_alloc_xfer(1);
+	if (!xfer)
+		return -ENOMEM;
+
+	pid_bufs = kcalloc(XI3C_MAX_DEVS, XI3C_DAA_SLAVEINFO_READ_BYTECOUNT,
+			   GFP_KERNEL);
+	if (!pid_bufs) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/* Fill ENTDAA CCC */
+	ccc_id = I3C_CCC_ENTDAA;
+	daa_cmd = &xfer->cmds[0];
+	daa_cmd->addr = I3C_BROADCAST_ADDR;
+	daa_cmd->rnw = false;
+	daa_cmd->tx_buf = &ccc_id;
+	daa_cmd->tx_len = 1;
+	daa_cmd->type = XI3C_SDR_MODE;
+	daa_cmd->tid = XI3C_SDR_TID;
+	daa_cmd->continued = true;
+
+	ret = xi3c_master_common_xfer(master, xfer);
+	if (ret) {
+		/* NACK on ENTDAA broadcast means no devices to enumerate */
+		if (daa_cmd->err == I3C_ERROR_M2)
+			ret = 0;
+		goto err_daa;
+	}
+
+	master->daa.index = 0;
+
+	while (true) {
+		struct xi3c_cmd *cmd = &xfer->cmds[0];
+		u8 daa_byte;
+
+		/* Out of device slots; stop and keep what was enumerated */
+		if (master->daa.index >= XI3C_MAX_DEVS) {
+			dev_warn(master->dev,
+				 "DAA: reached %d devices, stopping enumeration\n",
+				 XI3C_MAX_DEVS);
+			xi3c_master_reinit(master);
+			break;
+		}
+
+		addr = i3c_master_get_free_addr(m, last_addr + 1);
+		if (addr < 0) {
+			dev_warn(master->dev,
+				 "DAA: no free dynamic address, stopping enumeration\n");
+			xi3c_master_reinit(master);
+			break;
+		}
+
+		pid_buf = pid_bufs[master->daa.index];
+
+		daa_byte = (addr << 1) | (parity8(addr) ^ 1);
+
+		cmd->tx_buf = &daa_byte;
+		cmd->tx_len = 1;
+		cmd->addr = I3C_BROADCAST_ADDR;
+		cmd->rnw = true;
+		cmd->rx_buf = pid_buf;
+		cmd->rx_len = XI3C_DAA_SLAVEINFO_READ_BYTECOUNT;
+		cmd->is_daa = true;
+		cmd->type = XI3C_SDR_MODE;
+		cmd->tid = XI3C_SDR_TID;
+		cmd->continued = true;
+
+		ret = xi3c_master_common_xfer(master, xfer);
+
+		/* -ENODEV: no more responders, enumeration complete */
+		if (ret == -ENODEV) {
+			ret = 0;
+			break;
+		}
+		if (ret)
+			goto err_daa;
+
+		master->daa.addrs[master->daa.index] = addr;
+		last_addr = addr;
+		master->daa.index++;
+	}
+
+	for (i = 0; i < master->daa.index; i++) {
+		u64 pid;
+
+		/* Ignore per-device add errors so one failure doesn't abort the rest */
+		i3c_master_add_i3c_dev_locked(m, master->daa.addrs[i]);
+
+		pid = FIELD_GET(XI3C_PID_MASK,
+				get_unaligned_be64(pid_bufs[i]));
+		dev_dbg(master->dev, "Client %d: PID: 0x%llx\n", i, pid);
+	}
+
+	ret = 0;
+	goto out;
+
+err_daa:
+	xi3c_master_reinit(master);
+out:
+	kfree(pid_bufs);
+	kfree(xfer);
+	return ret;
+}
+
+static bool
+xi3c_master_supports_ccc_cmd(struct i3c_master_controller *master,
+			     const struct i3c_ccc_cmd *cmd)
+{
+	if (cmd->ndests > 1)
+		return false;
+
+	switch (cmd->id) {
+	case I3C_CCC_ENEC(true):
+	case I3C_CCC_ENEC(false):
+	case I3C_CCC_DISEC(true):
+	case I3C_CCC_DISEC(false):
+	case I3C_CCC_ENTAS(0, true):
+	case I3C_CCC_ENTAS(0, false):
+	case I3C_CCC_RSTDAA(true):
+	case I3C_CCC_RSTDAA(false):
+	case I3C_CCC_ENTDAA:
+	case I3C_CCC_SETMWL(true):
+	case I3C_CCC_SETMWL(false):
+	case I3C_CCC_SETMRL(true):
+	case I3C_CCC_SETMRL(false):
+	case I3C_CCC_SETDASA:
+	case I3C_CCC_SETNEWDA:
+	case I3C_CCC_GETMWL:
+	case I3C_CCC_GETMRL:
+	case I3C_CCC_GETPID:
+	case I3C_CCC_GETBCR:
+	case I3C_CCC_GETDCR:
+	case I3C_CCC_GETSTATUS:
+	case I3C_CCC_GETMXDS:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static int xi3c_master_send_bdcast_ccc_cmd(struct xi3c_master *master,
+					   struct i3c_ccc_cmd *ccc)
+{
+	struct xi3c_xfer *xfer __free(kfree) = NULL;
+	u8 *buf __free(kfree) = NULL;
+	struct xi3c_cmd *cmd;
+	u16 xfer_len;
+	int ret;
+
+	if (ccc->dests[0].payload.len >= XI3C_MAXDATA_LENGTH)
+		return -EINVAL;
+
+	xfer_len = ccc->dests[0].payload.len + 1;
+
+	xfer = xi3c_master_alloc_xfer(1);
+	if (!xfer)
+		return -ENOMEM;
+
+	buf = kmalloc_objs(*buf, xfer_len, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	buf[0] = ccc->id;
+	memcpy(&buf[1], ccc->dests[0].payload.data, ccc->dests[0].payload.len);
+
+	cmd = &xfer->cmds[0];
+	cmd->addr = ccc->dests[0].addr;
+	cmd->rnw = ccc->rnw;
+	cmd->tx_buf = buf;
+	cmd->tx_len = xfer_len;
+	cmd->type = XI3C_SDR_MODE;
+	cmd->tid = XI3C_SDR_TID;
+	cmd->continued = false;
+
+	ret = xi3c_master_common_xfer(master, xfer);
+	ccc->err = cmd->err;
+
+	return ret;
+}
+
+static int xi3c_master_send_direct_ccc_cmd(struct xi3c_master *master,
+					   struct i3c_ccc_cmd *ccc)
+{
+	struct xi3c_xfer *xfer __free(kfree) = NULL;
+	struct xi3c_cmd *cmd;
+	int ret;
+
+	if (ccc->dests[0].payload.len > XI3C_MAXDATA_LENGTH)
+		return -EINVAL;
+
+	xfer = xi3c_master_alloc_xfer(2);
+	if (!xfer)
+		return -ENOMEM;
+
+	/* Broadcasted message */
+	cmd = &xfer->cmds[0];
+	cmd->addr = I3C_BROADCAST_ADDR;
+	cmd->rnw = false;
+	cmd->tx_buf = &ccc->id;
+	cmd->tx_len = 1;
+	cmd->type = XI3C_SDR_MODE;
+	cmd->tid = XI3C_SDR_TID;
+	cmd->continued = true;
+
+	/* Directed message */
+	cmd = &xfer->cmds[1];
+	cmd->addr = ccc->dests[0].addr;
+	cmd->rnw = ccc->rnw;
+	if (cmd->rnw) {
+		cmd->rx_buf = ccc->dests[0].payload.data;
+		cmd->rx_len = ccc->dests[0].payload.len;
+	} else {
+		cmd->tx_buf = ccc->dests[0].payload.data;
+		cmd->tx_len = ccc->dests[0].payload.len;
+	}
+	cmd->type = XI3C_SDR_MODE;
+	cmd->tid = XI3C_SDR_TID;
+	cmd->continued = false;
+
+	ret = xi3c_master_common_xfer(master, xfer);
+
+	/*
+	 * Report broadcast error if any, else the directed one, so either
+	 * NACK reaches the caller
+	 */
+	ccc->err = xfer->cmds[0].err ? xfer->cmds[0].err : xfer->cmds[1].err;
+
+	/* Report actual byte count so the core sees the right length on short reads */
+	if (!ret && ccc->rnw)
+		ccc->dests[0].payload.len = min(xfer->cmds[1].rx_actual,
+						ccc->dests[0].payload.len);
+
+	return ret;
+}
+
+static int xi3c_master_send_ccc_cmd(struct i3c_master_controller *m,
+				    struct i3c_ccc_cmd *cmd)
+{
+	struct xi3c_master *master = to_xi3c_master(m);
+
+	if (cmd->id & I3C_CCC_DIRECT)
+		return xi3c_master_send_direct_ccc_cmd(master, cmd);
+
+	return xi3c_master_send_bdcast_ccc_cmd(master, cmd);
+}
+
+static int xi3c_master_i3c_xfers(struct i3c_dev_desc *dev,
+				 struct i3c_xfer *xfers,
+				 int nxfers, enum i3c_xfer_mode mode)
+{
+	struct i3c_master_controller *m = i3c_dev_get_master(dev);
+	struct xi3c_master *master = to_xi3c_master(m);
+	struct xi3c_xfer *xfer __free(kfree) = NULL;
+	int i, ret;
+
+	if (!nxfers)
+		return 0;
+
+	if (mode != I3C_SDR)
+		return -EOPNOTSUPP;
+
+	for (i = 0; i < nxfers; i++)
+		if (xfers[i].len > XI3C_MAXDATA_LENGTH)
+			return -EINVAL;
+
+	xfer = xi3c_master_alloc_xfer(nxfers);
+	if (!xfer)
+		return -ENOMEM;
+
+	for (i = 0; i < nxfers; i++) {
+		struct xi3c_cmd *cmd = &xfer->cmds[i];
+
+		cmd->addr = dev->info.dyn_addr;
+		cmd->rnw = xfers[i].rnw;
+
+		if (cmd->rnw) {
+			cmd->rx_buf = xfers[i].data.in;
+			cmd->rx_len = xfers[i].len;
+		} else {
+			cmd->tx_buf = xfers[i].data.out;
+			cmd->tx_len = xfers[i].len;
+		}
+
+		cmd->type = XI3C_SDR_MODE;
+		cmd->tid = XI3C_SDR_TID;
+		cmd->continued = (i + 1) < nxfers;
+	}
+
+	ret = xi3c_master_common_xfer(master, xfer);
+
+	for (i = 0; i < xfer->nissued; i++) {
+		xfers[i].err = xfer->cmds[i].err;
+		if (xfers[i].rnw)
+			xfers[i].actual_len = min(xfer->cmds[i].rx_actual,
+						  xfers[i].len);
+	}
+
+	return ret;
+}
+
+static int xi3c_master_i2c_xfers(struct i2c_dev_desc *dev,
+				 struct i2c_msg *xfers,
+				 int nxfers)
+{
+	struct i3c_master_controller *m = i2c_dev_get_master(dev);
+	struct xi3c_master *master = to_xi3c_master(m);
+	struct xi3c_xfer *xfer __free(kfree) = NULL;
+	int i;
+
+	if (!nxfers)
+		return 0;
+
+	for (i = 0; i < nxfers; i++)
+		if (xfers[i].len > XI3C_MAXDATA_LENGTH)
+			return -EINVAL;
+
+	xfer = xi3c_master_alloc_xfer(nxfers);
+	if (!xfer)
+		return -ENOMEM;
+
+	for (i = 0; i < nxfers; i++) {
+		struct xi3c_cmd *cmd = &xfer->cmds[i];
+
+		cmd->addr = xfers[i].addr & XI3C_ADDR_MASK;
+		cmd->rnw = !!(xfers[i].flags & I2C_M_RD);
+
+		if (cmd->rnw) {
+			cmd->rx_buf = xfers[i].buf;
+			cmd->rx_len = xfers[i].len;
+		} else {
+			cmd->tx_buf = xfers[i].buf;
+			cmd->tx_len = xfers[i].len;
+		}
+
+		cmd->type = XI3C_I2C_MODE;
+		cmd->tid = XI3C_I2C_TID;
+		cmd->continued = (i + 1) < nxfers;
+	}
+
+	return xi3c_master_common_xfer(master, xfer);
+}
+
+static int xi3c_clk_cfg(struct xi3c_master *master, unsigned long sclhz, u8 mode)
+{
+	unsigned long core_rate, core_periodns;
+	u32 tcasmin, tsustart, tsustop, thdstart;
+	u32 thigh, tlow, thold;
+	u32 odthigh, odtlow;
+
+	core_rate = clk_get_rate(master->pclk);
+	if (!core_rate)
+		return -EINVAL;
+
+	if (!sclhz)
+		return -EINVAL;
+
+	core_periodns = DIV_ROUND_UP(NSEC_PER_SEC, core_rate);
+
+	thigh = DIV_ROUND_UP(core_rate, sclhz) >> 1;
+	tlow = thigh;
+
+	/* Reject rates whose timing exceeds the 18-bit registers (would wrap) */
+	if (thigh <= XI3C_CYCLE_ADJUST ||
+	    (thigh - XI3C_CYCLE_ADJUST) > XI3C_TIMING_MASK)
+		return -EINVAL;
+
+	/* Hold time : 40% of tlow time */
+	thold = (tlow * 4) / 10;
+
+	if (xi3c_get_revision_number(master) == 0)
+		thold = max_t(u32, thold, XI3C_THOLD_MIN_REV0);
+	else
+		thold = max_t(u32, thold, XI3C_THOLD_MIN_REV1);
+
+	iowrite32((thigh - XI3C_CYCLE_ADJUST) & XI3C_TIMING_MASK,
+		  master->membase + XI3C_SCL_HIGH_TIME_OFFSET);
+	iowrite32((tlow - XI3C_CYCLE_ADJUST) & XI3C_TIMING_MASK,
+		  master->membase + XI3C_SCL_LOW_TIME_OFFSET);
+	iowrite32((thold - XI3C_CYCLE_ADJUST) & XI3C_TIMING_MASK,
+		  master->membase + XI3C_SDA_HOLD_TIME_OFFSET);
+
+	if (mode == XI3C_I2C_MODE) {
+		iowrite32((thigh - XI3C_CYCLE_ADJUST) & XI3C_TIMING_MASK,
+			  master->membase + XI3C_OD_SCL_HIGH_TIME_OFFSET);
+		iowrite32((tlow - XI3C_CYCLE_ADJUST) & XI3C_TIMING_MASK,
+			  master->membase + XI3C_OD_SCL_LOW_TIME_OFFSET);
+
+		tcasmin = DIV_ROUND_UP(XI3C_I2C_TCASMIN_NS, core_periodns);
+	} else {
+		odtlow = DIV_ROUND_UP(XI3C_OD_TLOW_NS, core_periodns);
+		odthigh = DIV_ROUND_UP(XI3C_OD_THIGH_NS, core_periodns);
+
+		odtlow = max(tlow, odtlow);
+		odthigh = min(thigh, odthigh);
+
+		if (odthigh <= XI3C_CYCLE_ADJUST)
+			return -EINVAL;
+
+		iowrite32((odthigh - XI3C_CYCLE_ADJUST) & XI3C_TIMING_MASK,
+			  master->membase + XI3C_OD_SCL_HIGH_TIME_OFFSET);
+		iowrite32((odtlow - XI3C_CYCLE_ADJUST) & XI3C_TIMING_MASK,
+			  master->membase + XI3C_OD_SCL_LOW_TIME_OFFSET);
+
+		tcasmin = DIV_ROUND_UP(XI3C_TCASMIN_NS, core_periodns);
+	}
+
+	thdstart = max(thigh, tcasmin);
+	tsustart = max(tlow, tcasmin);
+	tsustop = max(tlow, tcasmin);
+
+	iowrite32((tsustart - XI3C_CYCLE_ADJUST) & XI3C_TIMING_MASK,
+		  master->membase + XI3C_TSU_START_OFFSET);
+	iowrite32((thdstart - XI3C_CYCLE_ADJUST) & XI3C_TIMING_MASK,
+		  master->membase + XI3C_THD_START_OFFSET);
+	iowrite32((tsustop - XI3C_CYCLE_ADJUST) & XI3C_TIMING_MASK,
+		  master->membase + XI3C_TSU_STOP_OFFSET);
+
+	return 0;
+}
+
+static int xi3c_master_bus_init(struct i3c_master_controller *m)
+{
+	struct xi3c_master *master = to_xi3c_master(m);
+	struct i3c_bus *bus = i3c_master_get_bus(m);
+	struct i3c_device_info info = {};
+	unsigned long sclhz;
+	u32 pid1_bcr_dcr;
+	u8 mode;
+	int ret;
+
+	switch (bus->mode) {
+	case I3C_BUS_MODE_MIXED_FAST:
+	case I3C_BUS_MODE_MIXED_LIMITED:
+	case I3C_BUS_MODE_MIXED_SLOW:
+		mode = XI3C_I2C_MODE;
+		sclhz = bus->scl_rate.i2c;
+		break;
+	case I3C_BUS_MODE_PURE:
+		mode = XI3C_SDR_MODE;
+		sclhz = bus->scl_rate.i3c;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	ret = xi3c_clk_cfg(master, sclhz, mode);
+	if (ret)
+		return ret;
+
+	xi3c_master_init(master);
+
+	/* Get an address for the master. */
+	ret = i3c_master_get_free_addr(m, 0);
+	if (ret < 0)
+		return ret;
+
+	info.dyn_addr = ret;
+
+	/* Write the dynamic address value to the address register. */
+	iowrite32(info.dyn_addr, master->membase + XI3C_ADDRESS_OFFSET);
+
+	/* Read PID, BCR and DCR values, and assign to i3c device info. */
+	pid1_bcr_dcr = ioread32(master->membase + XI3C_PID1_BCR_DCR);
+	info.pid = ((u64)FIELD_GET(XI3C_PID1_MASK, pid1_bcr_dcr) << 32) |
+		   ioread32(master->membase + XI3C_PID0_OFFSET);
+	info.bcr = FIELD_GET(XI3C_BCR_MASK, pid1_bcr_dcr);
+	info.dcr = FIELD_GET(XI3C_DCR_MASK, pid1_bcr_dcr);
+
+	return i3c_master_set_info(&master->base, &info);
+}
+
+static void xi3c_master_bus_cleanup(struct i3c_master_controller *m)
+{
+	struct xi3c_master *master = to_xi3c_master(m);
+
+	xi3c_master_disable(master);
+}
+
+static const struct i3c_master_controller_ops xi3c_master_ops = {
+	.bus_init = xi3c_master_bus_init,
+	.bus_cleanup = xi3c_master_bus_cleanup,
+	.do_daa = xi3c_master_do_daa,
+	.supports_ccc_cmd = xi3c_master_supports_ccc_cmd,
+	.send_ccc_cmd = xi3c_master_send_ccc_cmd,
+	.i3c_xfers = xi3c_master_i3c_xfers,
+	.i2c_xfers = xi3c_master_i2c_xfers,
+};
+
+static int xi3c_master_probe(struct platform_device *pdev)
+{
+	struct xi3c_master *master;
+	int ret;
+
+	master = devm_kzalloc(&pdev->dev, sizeof(*master), GFP_KERNEL);
+	if (!master)
+		return -ENOMEM;
+
+	master->dev = &pdev->dev;
+
+	master->membase = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(master->membase))
+		return dev_err_probe(master->dev, PTR_ERR(master->membase),
+				     "Failed to map registers\n");
+
+	master->pclk = devm_clk_get_enabled(master->dev, NULL);
+	if (IS_ERR(master->pclk))
+		return dev_err_probe(master->dev, PTR_ERR(master->pclk),
+				     "Failed to get and enable clock\n");
+
+	ret = devm_mutex_init(master->dev, &master->lock);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, master);
+
+	return i3c_master_register(&master->base, master->dev,
+				   &xi3c_master_ops, false);
+}
+
+static void xi3c_master_remove(struct platform_device *pdev)
+{
+	struct xi3c_master *master = platform_get_drvdata(pdev);
+
+	i3c_master_unregister(&master->base);
+}
+
+static const struct of_device_id xi3c_master_of_ids[] = {
+	{ .compatible = "xlnx,axi-i3c-1.0" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, xi3c_master_of_ids);
+
+static struct platform_driver xi3c_master_driver = {
+	.probe = xi3c_master_probe,
+	.remove = xi3c_master_remove,
+	.driver = {
+		.name = "axi-i3c-master",
+		.of_match_table = xi3c_master_of_ids,
+	},
+};
+module_platform_driver(xi3c_master_driver);
+
+MODULE_AUTHOR("Manikanta Guntupalli <manikanta.guntupalli@amd.com>");
+MODULE_DESCRIPTION("AMD AXI I3C master driver");
+MODULE_LICENSE("GPL");
-- 
2.49.1

