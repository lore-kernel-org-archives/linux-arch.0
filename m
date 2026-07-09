Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011049.outbound.protection.outlook.com [52.101.52.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190573DB652;
	Thu,  9 Jul 2026 06:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579405; cv=fail; b=TNekbO1Tc18MsMjva+RHsvUL+2Eo76S2MIqBnZDCWEB2EAYegQUTNEIC8LhgvwUWl1MmauJgfq5FIc+ckWqMmY5x2xaGIvdL6LRXnJRS0Quiy1N/EdFatfOZtOMnzNvLjXtbht0YyVMhPnsQ6O78q03G+BHNEF6cFPHf/XFq/88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579405; c=relaxed/simple;
	bh=KTrJXnyZzmck6ARj2yYWjcf9T/uQMjqAOqQhU8o04hU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h12Z3kgx0pmo1dgCnkKMzrKUFjYfX1qd5FLSrUzIv5V6RpB3vDwPwRIo0fR+kSzoCLnNz/tthtVImSZFf9DvMpexmIm6s6w0XvLOviRhER3Tg8Vdtvd65o7fUrv1pGFFJoJtfh4imUfdrJSJEP/M4N33yJAhj4i96/SGUb+i+xg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zt21dIaE; arc=fail smtp.client-ip=52.101.52.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zt21dIaE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OYVkWBDYF8sPhhvQXmcSre7prcBESHUCfNRxlsbaYqD9USXstfGniKHHnnLo+CUsOV/3coLIwS2bbgu8z7CzGXWOW/p4MfWlHjI+9N4CCVvLp3rnQ7IDDeMDdxQ20u39AZwLNQKnGxbL8r2h8Nre+l96d2TZ2HoszKq3raWxgKZlo8ep+KE1NAeVdnvZDNcspGIDGxXdZO6iOtvRWe0W5XRCobmVZKKv7/Zf53oy6Lr9d4UVTkb9mzu+SX59IZlS3tEzlcGwy+3l4qWvoOvMI2Ejegbr7YzltemGlZn4WThDpQ2yZs6z3k7ADMgCfGdCOz4RMz7mnAkGdHs/FxfUxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPlleH54N+IDGEQZumGZpdTWNI3mINEqyIodk8Qvr3s=;
 b=MGnRDg1Hb5b9tPIOg2iNAed3HJm1BArRJ09x0J4xvOBWO/hxLNd+uDyJfdcrG3jntfRglXPq4FN2ksGQx44MBr3VTSEnM5QKpbV5oNYiOdAovSs9noLOP00hNCY2NwQbHlMaLZwg1wKBv57ZDA97nL0QdwaKOBVSCkqc6uzJVZqTxAjqrhIvztGQgg1GaBXoEXJEx8e14rEuKu2QVOJO1ltCsH+8WkQgI6IHIFLPtWrGoZ/h+M9Hj94aP9tZhCpbprJE1IRSJ0OkuAFCZJl3+vvjLaSuwA75DTGz14HG7fe+YntgiOjGlz7CAbh+lNZ9HMMkC0zXN6ymI//yEZqtDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPlleH54N+IDGEQZumGZpdTWNI3mINEqyIodk8Qvr3s=;
 b=Zt21dIaEvFZwmDTHU0X3J5bbDXIkkdmhgeOkstTFNFEzAqmPrW/eI8VCcd0tYGBTNoreczBgofvuZwoE7D7AUQAKzhB+p+QaGt/2EaVdwR16C3ifsLRwh7nzxMrELgAzGmDAIHVPjY1/OuySe+kSh1zLRO3oyI9BEs96wsyoB/A=
Received: from MN2PR16CA0038.namprd16.prod.outlook.com (2603:10b6:208:234::7)
 by CYXPR12MB9443.namprd12.prod.outlook.com (2603:10b6:930:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 06:43:14 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:208:234:cafe::5e) by MN2PR16CA0038.outlook.office365.com
 (2603:10b6:208:234::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 06:43:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 06:43:13 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 01:43:12 -0500
Received: from xhdshubpati40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Thu, 9 Jul 2026 01:43:06 -0500
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
	<shubhrajyoti.datta@amd.com>, <shubhamsanjay.patil@amd.com>
Subject: [PATCH v10 0/2] Add AMD I3C master controller driver and bindings
Date: Thu, 9 Jul 2026 12:12:31 +0530
Message-ID: <20260709064233.1451482-1-shubhamsanjay.patil@amd.com>
X-Mailer: git-send-email 2.49.1
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|CYXPR12MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: 198f682f-7581-4378-506d-08dedd8559ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|82310400026|36860700016|1800799024|921020|18002099003|3023799007|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	5xC5cKqPuqaQWJpoYK/3rvaEts0VWni7ZTTbQvl+HxMDmkxlZdF9IjgcoXKYUsTIlworSqfVSA/gQ4W93sCK097Py1ZvGofKCBAY2ASQDqp7w3NqIaK08vd/+JrlQSxX+QmN+inWqgzRL6uKG7UX3EBhmoauGe+ilD4usKMR9q85ev68McR/y/K9JzHKBGaBkxN90vB7R2eXRe7o8VFcpW02YH5zR++teaDtlO8M0IDP7DTKby1KbBtzGA5zXdUZRmmkE2emfWgVZrtWHiqKscxjTY048Nki1EBO8jvf/UHIbzqwrsq2AnBB6+wAGtWyupvO/MQR/EcCD9JdMN1K74pMihhpt4h/HEtyrkGRYvYYkXjG5FINwabZdzZGPLSywlyBgQhwvVpEVUo4Khfk55zbhz0dCikL95BP4W1fhfUAALDcIJUdsHzuvmmvySn9rV5AKhKqf0XQqKXw/PPIvklSaRlqZgVVuq0wqdaSX/7NaPShDz29nfycmeoe6vGPWTca/U2IWgGmFQMOdY6wlUcJRT0qxRg+s3J3pbja16QQFpnwBCVy22PtpASlqZUjzJTwIwSYa2GhaKoRyqggZWR0egrK9lAS5jegcbHpgSxWYfuJqC7pdpVDFsuQNWk/Wlmx4tOvlrt2ftvuagUKt5oAVPpznXnWy9YX/5VBp3bcyPDVQp81P+liw5u1EYMY/7nq3Ov9z8EJbESAg2GH7ufxYsfvfuDKxj4XmuScy/z7NFSY7M3QtYvAnTRLYO6g
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(921020)(18002099003)(3023799007)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hRVhYJHT/oja90ipzB8zvOuNv/AS3GdVvI6F9dynMk3018e+guFROZbyyl5DYVAk0C59FMMRlv52tzYErhmpf6+McLiljGBNMIDqyNsWgh7ln0Wr/e4Eu2uV9sjHF13gc476OcgUqElwKZu4BCTr7SHJ27P24S1NG0W3yxKT7REjGANFgXMVkBBcAUQNMawBTjDMGvhImvVLZNgvRn7rNnUHL5EsLdH4xQ7+fB509DfigS4PIrxd9YN/1ej1ZXdNUP01PJK5L+aFGXmRuPQo7q09Ld9XqDschjBy9Yre6jkL7iYEKFzIH4a5qwHbUhIhlcwLfmxcKYG4hqGEXuCyS4r2UUIzJ/DWhoAO5qbi7q5pDKw2XB9FLEQAEFESmroCcmea7h4FMnmvHEI6Wu+2dpzFb1dqpqKONe/9O2zuq+4VKLEaHsil78/lNnnCTyjv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 06:43:13.7597
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 198f682f-7581-4378-506d-08dedd8559ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9443

This patch series introduces support for the AMD I3C master controller,
including the device tree binding and driver implementation.
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
Use symbolic interrupt macros (GIC_SPI / IRQ_TYPE_LEVEL_HIGH) in the
binding example and include arm-gic.h.
Added Shubham Patil as Co-developed-by / Signed-off-by on the binding.
Trimmed verbose comments and dropped redundant MODULE_AUTHOR lines.

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
Included dependent patch "i3c: fix big-endian FIFO transfers"
to this series as [3/5].
Resolved conflicts with "i3c: fix big-endian FIFO transfers".
Updated description.
Used time_left instead of timeout.
Used __free(kfree) for xfer to simplify err path in multiple places.

Changes for V7:
Added i3c controller version details to commit description.
Added Reviewed-by tag to binding patch [1/4].
Added big-endian MMIO accessors [2/4].
Added endianness support for i3c_readl_fifo() and i3c_writel_fifo() [3/4].
Updated timeout macro name.
Updated xi3c_master_wr_to_tx_fifo() and xi3c_master_rd_from_rx_fifo()
to use i3c_writel_fifo() and i3c_readl_fifo().

Changes for V6:
Corrected the $id in the YAML file to match the filename and fix
the dtschema warning.
Removed typecast for xi3c_getrevisionnumber(), xi3c_wrfifolevel(),
and xi3c_rdfifolevel().
Replaced dynamic allocation with a static variable for pid_bcr_dcr.
Fixed sparse warning in do_daa by typecasting the address parity value
to u8.
Fixed sparse warning in xi3c_master_bus_init by typecasting the pid value
to u64 in info.pid calculation.

Changes for V5:
Renamed the xlnx,axi-i3c.yaml file into xlnx,axi-i3c-1.0.yaml.
Used GENMASK_ULL for PID mask as it's 64bit mask.

Changes for V4:
Added h/w documentation details.
Updated timeout macros.
Removed type casting for xi3c_is_resp_available() macro.
Used ioread32() and iowrite32() instead of readl() and writel()
to keep consistency.
Read XI3C_RESET_OFFSET reg before udelay().
Removed xi3c_master_free_xfer() and directly used kfree().
Skipped checking return value of i3c_master_add_i3c_dev_locked().
Used devm_mutex_init() instead of mutex_init().

Changes for V3:
Updated commit description.
Corrected the order of properties and removed resets property.
Added compatible to required list.
Added interrupts to example.
Resolved merge conflicts.

Changes for V2:
Updated commit subject and description.
Moved allOf to after required.
Removed xlnx,num-targets property.
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
Manikanta Guntupalli (2):
  dt-bindings: i3c: Add AMD I3C master controller support
  i3c: master: Add driver for AMD AXI I3C master controller

 .../bindings/i3c/xlnx,axi-i3c-1.0.yaml        |   58 +
 MAINTAINERS                                   |    8 +
 drivers/i3c/master/Kconfig                    |   15 +
 drivers/i3c/master/Makefile                   |    1 +
 drivers/i3c/master/amd-i3c-master.c           | 1124 +++++++++++++++++
 5 files changed, 1206 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/xlnx,axi-i3c-1.0.yaml
 create mode 100644 drivers/i3c/master/amd-i3c-master.c

-- 
2.49.1

