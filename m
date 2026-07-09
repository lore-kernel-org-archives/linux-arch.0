Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011009.outbound.protection.outlook.com [40.107.208.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55E83DC4DA;
	Thu,  9 Jul 2026 06:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579415; cv=fail; b=fGwInrWqaQOkRISJmPhdC3PAmDpNKwB8x9e+xsI0s47u1FKA8AbwONY4TH3BUj28ztAvl431Twye5suKnWvrz9UlwNTFHbjbKPPUGe04OYz6ZKGRQIZBt3xD8oZmC/HVaxteh+m8F925Pfu44P8j5VKRAv1ut1smL0qdzbT5pws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579415; c=relaxed/simple;
	bh=/H65NTVDoN/WCfSkAv6ir+FnhWckwzsNkdMlouCtxVo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jwH+n/pySdyqouulNb8EWlo79pC9oLHAPlNTvtfzU5dejRo+ehZPkLNwPLnXGGsMpf6pQUihgLRTiUodFpNzm93/3VlpfT20WJRqRCS6fxymAaNxnylR7PMRITlPhkYZG76xxcYUs+uN9BW7ps3AWXQ2ZxvJLXy0N5nzFrVdmnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5AP76uH4; arc=fail smtp.client-ip=40.107.208.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5AP76uH4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJqx8nbK+/YDJbT7HhTbYP8GSbTQr3w63x5oK6aWcssZoeDy5Gb9+87pZiKYZC4paFY+z18ot+tpY38it1soJb6cCLeSOKFZYiqFyD6Oi8aqPOvRCd7ya54YKIynOAQaIhneeeWSJTEJD5aJRszuUnrJ4dvUHCIVCQvwTkGwadrLdXuhU41FzdZWy3YuyLwV+5f7TyzZXQsL1BIavNFPnO8rLakXOVri6uthdKxLyufYxmhwJAqU2hhIxrw3veQhyPBQPVraw22cKC07XChyu9cTuaaUb7tlozyHPbqp62RNEblLOJXocP3fGixbTZKEo108V8KruoaCGfJFJqgLvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7FkyAzuBHYFVMTOg8bmv21jBsyt1fRFzI/Rms9EFCg=;
 b=A1WayRLQOCvWvSvlvhMEzFnI+spFgBtVcCSc9L+oq8ikVPKKJz5UI/6fIOZPKe5ZrkE0AZ07gW1T8Wv0I4X65dokYoPOwPQQItde7J7AH0Qds1TRB9jeBh3DjAkZrWxMYE7smi5F4SniCJ2CbQvN4cFjFV6ad/pnWfC2gH80JyXbfVYbykzNf75sC7SgsH4iMz2apmfDkODRim4+i/j+Vi1PNkTu/+jl2vjrx85vMFCcVmryYoC9R3cL3SD8zEuo1cjDafY8VFsRlA+LQXpHfsODOwNg+2kAZDHW6owrSjRevEM2JoJ9czg93xNvYoZQYy+VEVieAaiMXoktnHm6vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7FkyAzuBHYFVMTOg8bmv21jBsyt1fRFzI/Rms9EFCg=;
 b=5AP76uH4KmTFgPDIpCEdeGyv0tTDxDCq5RSpwoRUXWwxhv5/Nj90irOQJHNGiGrgEPeaRYwTxurcf4nlTYqIVCU3mwVPk7wRqfuY1m6MzjMGj7ULpdTvXTrKiQtUUU75oENx7z41nqb3LGouNtVCHkajkOQEPobAnZGrSU9z0Kc=
Received: from BL1PR13CA0448.namprd13.prod.outlook.com (2603:10b6:208:2c3::33)
 by LV9PR12MB9829.namprd12.prod.outlook.com (2603:10b6:408:2eb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Thu, 9 Jul
 2026 06:43:24 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:2c3:cafe::89) by BL1PR13CA0448.outlook.office365.com
 (2603:10b6:208:2c3::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.3 via Frontend Transport; Thu, 9
 Jul 2026 06:43:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 06:43:24 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 01:43:22 -0500
Received: from xhdshubpati40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Thu, 9 Jul 2026 01:43:16 -0500
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
Subject: [PATCH v10 1/2] dt-bindings: i3c: Add AMD I3C master controller support
Date: Thu, 9 Jul 2026 12:12:32 +0530
Message-ID: <20260709064233.1451482-2-shubhamsanjay.patil@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|LV9PR12MB9829:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c1fb64d-fa72-4f62-6ffc-08dedd855fd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|82310400026|1800799024|376014|23010399003|9063799003|11063799006|3023799007|18002099003|22082099003|56012099006|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	OGf1VFe7MW7ti0cnpMpO89BLV/upwv/qx/znbcdeZvnhRacY6q3TRbURLSDIwnkjz8w9W7KibPZ0+omWOPLvFra6xIiuY9HU9d2B+tqZoKmniF6pXQprN4RryorN9B079ZD5kWUY+JCcjteCVSf5rM+GH/tgGUjj3RXM9easHVpBVZrS88DMBWFM4y06XZ8BO92yXYmi27MB3n6UAxyY24/kPhCD1nwft6nV8Zz5Mld0AWEjcfChe1lB9TMwgHvmZglmDdmuHA1ZpSxggzLdoJtYc21GGEOMU15mL9Eyuseao4E2W0IMgU5x1zmdc55vmoqGk7AsWAb6qsDljQoCERkNlVWTEoXNXpm4dMT7lLToGlkaDiXx2mWKZmVRVv04M79bB/0cIInwdlbFK2pgUAkOpdV71cyH2CGb+VVW6pO0We/tR8vX5/GDyoBtlbdYpStoyoDJZ+x7ZZ+18l8BqPWHlgZ8PcJepmNrWBCHmUmICr6AMKSNPGPg1r3rxrf3SR0zzrE7AqEObAO30nJdGfjr3bTP/WPn1Wc8utUQkJnJ/w5K+clBvdHPyarO3C/4a+xDsGmJrExz0KFFBPmxYumga3l16KWwzUMsUOR2WtG/iB4BWj77aTZDxbKev4S14y9o4WXy9iGBGApFSoZDpptLVsKVcFcAqgCBcoMyp+j0x798Va6Q0nGSWzTBrut1
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(82310400026)(1800799024)(376014)(23010399003)(9063799003)(11063799006)(3023799007)(18002099003)(22082099003)(56012099006)(13003099007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aUT+cLB10bdrbO0zRr9xbdueFW6pf1bx/+PW2m2yzsx2kDShfJqr/OQXMLlkO9DpdkjolapSUb3Omh5RN0lkO3zktolWnM/eplxcmXejx09qYs8iRi+vBm+jMdFkY3yEeBK4KQc6VKdXz0e8vDxfkqDLSyo+hhGa82JBiasNWFxObtjIGbHB8uoLhRGA7BrYLQK5u/kaUWZgcAs9dzfhjHFjzzE+105jyY/8nCdg0Q7weZZcbSGg8MSiVi7Eu9BFllFIFhGusJ3BqxGMbuHLcQWfcdF44/6FfgKeKuxore091NYqQUq9dGIN2/3cqjeD4LPa9qjW4ThGqM2Y3bmqICLO4jCccEexH3Di2iR/cXl1vw9PAf123WGyQN6weivO2sP9ukzipsbaQVlqUqGaviqfmO76rs0PvSLvKt+HU4rSatsPh28hbCIdDSk5rAB1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 06:43:24.0906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1fb64d-fa72-4f62-6ffc-08dedd855fd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9829

From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>

Add device tree binding documentation for the AMD I3C master controller
version 1.0.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Co-developed-by: Shubham Patil <shubhamsanjay.patil@amd.com>
Signed-off-by: Shubham Patil <shubhamsanjay.patil@amd.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes for V10:
Use symbolic interrupt macros and include arm-gic.h.
Added Shubham Patil as Co-developed-by / Signed-off-by on the binding.

Changes for V9:
Updated the MAINTAINER section.

Changes for V8:
None.

Changes for V7:
Added i3c controller version details to commit description.

Changes for V6:
Corrected the file name for $id in yaml to fix the dtschema warning.

Changes for V5:
Renamed the xlnx,axi-i3c.yaml file into xlnx,axi-i3c-1.0.yaml.

Changes for V4:
Added h/w documentation details.

Changes for V3:
Updated commit description.
Corrected the order of properties and removed resets property.
Added compatible to required list.
Added interrupts to example.

Changes for V2:
Updated commit subject and description.
Moved allOf to after required.
Removed xlnx,num-targets property.
---
 .../bindings/i3c/xlnx,axi-i3c-1.0.yaml        | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/xlnx,axi-i3c-1.0.yaml

diff --git a/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c-1.0.yaml b/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c-1.0.yaml
new file mode 100644
index 000000000000..2caa245a8656
--- /dev/null
+++ b/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c-1.0.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/i3c/xlnx,axi-i3c-1.0.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AMD I3C master
+
+maintainers:
+  - Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
+  - Shubham Patil <shubhamsanjay.patil@amd.com>
+
+description:
+  The AXI-I3C IP is an I3C Controller with an AXI4-Lite interface, compatible
+  with the MIPI I3C Specification v1.1.1. The design includes bidirectional I/O
+  buffers that implement open collector drivers for the SDA and SCL signals.
+  External pull-up resistors are required to properly hold the bus at a Logic-1
+  level when the drivers are released.
+
+  For more details, please see https://docs.amd.com/r/en-US/pg439-axi-i3c
+
+properties:
+  compatible:
+    const: xlnx,axi-i3c-1.0
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+allOf:
+  - $ref: i3c.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    i3c@80000000 {
+        compatible = "xlnx,axi-i3c-1.0";
+        reg = <0x80000000 0x10000>;
+        clocks = <&zynqmp_clk 71>;
+        interrupt-parent = <&imux>;
+        interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+        #address-cells = <3>;
+        #size-cells = <0>;
+    };
+...
-- 
2.49.1

