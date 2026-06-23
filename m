Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010067.outbound.protection.outlook.com [52.101.61.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBE835E1D5;
	Tue, 23 Jun 2026 11:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782215111; cv=fail; b=Nn2aDNww0CPk4fKaZcaJj1K0XHEnlUvNBy/N2nTn0K9/3caqvoLV+D9AcSZQFwoVslQJdfHTSOJ/Yg47OdNUKkvbWbyZ+Ziquj/27m8dh4CloDPEsfSoyPYPS2E6DmX82BFAAkgjn4+yJN5yodJQuPyEqGBjgyrq/4LO8vQ7g3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782215111; c=relaxed/simple;
	bh=g5l5nnCV+So06M1OqPvdqgNl6FtEekTdCqyv+Hlj5f4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UA3nANgsVUPZITyMtGSqs0/Wz7Qzkbed/hO5diESr44WUHLXfEbvh0QA4rVbGuCZH9kJ2tu0T9Eb8G1OQ/P1KE0T0PxmKNGNSF8nQq0UsAbIbt3v/JArV92w6BTyiPJFR7cI9uBhKWauMP8bAdjtZ9JW99e4u5UpJpdUHYa16z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b+W3DZrJ; arc=fail smtp.client-ip=52.101.61.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b+W3DZrJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OSKnCc8wqwNWADPpB66/DFlCPoNUblz8Xpa79fFfg+dyHO+n8Vh37Ozns+xgsDXDPXasuonehWkeFDCVH/IjTvEkNVErM4M2oW1nVwWOiVV9AK7lfnfy2nfZPf21wRo6kiDlNp3SYiZtC6AQNkIbJ1Jm9bPWOCzDZXN2p9RcEpSYVa992uN1jb1u/i2BHoRfT3UFx9XV9qp0IFPgxb9FZbmUps9E3VATwDf5f7ZHCG6rh+iapwzEuo7GJWCUlQHSiOEWWgSYxQRhhsrRMn0/4sd6dFNJKfhJbpN6TFytVjW3KWhEE0SFYeNq+mfGC9RIaMP/a8/c4ymkQgEPte2MCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J373wcV/c2Rz7d6BaTvL+l9hX3HK0VK4aisrrnwK9sw=;
 b=eW8WBdWj46EgiIQbr3/kXlPZj1o9CvqYZi1D9hNXZRupzQQ8L9Ugtc+bk0GsKoxJRU6tTNYkmTdpgfGlWqhV76sK/D38+xMqB6ajtUH8AGFZj6MIAm4ljWE2bx6Bnf1E8wuWjRO2o8iI7aKugjbXvy2Bn0wMaSEs78cJUalwzvtH0P4O5fQKmEiMM+qyBD0Dp07pnnR2GTLfSYIPaoOjuyTGw2yx+fzwGT43a6W0yqsaEEtFDlJmSHhAiyZoyEiPNiqZcYwd+o2DcD6dlNEPwbFPn3QXyRrK8sbWic8faCKUbs9BswPp9HXow62PNNNgILqVMM1ioLpjHCXvNOYCYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J373wcV/c2Rz7d6BaTvL+l9hX3HK0VK4aisrrnwK9sw=;
 b=b+W3DZrJM1feQAehs+WSLE46j3oB4LISx/WdVLoaiKs2y+Z1pJIkNmIspVdTlxPqyLA25kv5wZiv1lT14cefb04P5UlX32JZo1w1WBH83Sg6MBUGdcuqs1553k+ABWdVKUOu1YnR8VrZ7eFHFRO9EJHlyxnLOCk3NLm9zO39wCg=
Received: from SJ0PR05CA0205.namprd05.prod.outlook.com (2603:10b6:a03:330::30)
 by PH7PR12MB6908.namprd12.prod.outlook.com (2603:10b6:510:1ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 23 Jun
 2026 11:45:01 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::ab) by SJ0PR05CA0205.outlook.office365.com
 (2603:10b6:a03:330::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.6 via Frontend Transport; Tue, 23
 Jun 2026 11:45:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 11:45:00 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 06:44:51 -0500
Received: from xhdshubhraj40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 23 Jun 2026 06:44:44 -0500
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
Subject: [PATCH v9 1/2] dt-bindings: i3c: Add AMD I3C master controller support
Date: Tue, 23 Jun 2026 17:14:15 +0530
Message-ID: <20260623114417.2578189-2-shubhamsanjay.patil@amd.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20260623114417.2578189-1-shubhamsanjay.patil@amd.com>
References: <20260623114417.2578189-1-shubhamsanjay.patil@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|PH7PR12MB6908:EE_
X-MS-Office365-Filtering-Correlation-Id: bfea29fb-5cf7-48e7-28bb-08ded11cdbb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|7416014|376014|23010399003|22082099003|18002099003|13003099007|9063799003|56012099006|921020|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info:
	2v7j1sjtQl9uTHRp14rbjRPkDRwQLIBPN+LWeUIlQMRiHgD7Hs7Bn6/9mN11MF/NpptwnyQOU/0O9J3cV8GZ8JXDEg3t4lyVuW6cDT7lDfsg0nMKuGP1BnMqqqvFxMkeoeaF4yfhMOJGDSzVKWoNKknw5zuzb/0R+Cj5nMA4Iv0/BTfrb/2pewA+sDa9t+N+hGsdS5oUpw9z+Y52TJKMpdtED3uMkncIwQQNUqsKPXbz0DNOoMOPog6vR06b6pIFf8DpuUSHnEZMe6rP+7kshymOSHuLpTMIVrks9Pc1UcAWC3VSWeAT1hFPTGMapNRaJtdTdbKl7K/FdB/1YI9uwC76zdYyBIhcxRqVlJC9UAzlLjy29yYyEdo6w4ot9Vd+mYZw8PLlYvpcxSsgwts/3DOf2WrtjILvUs2sBwj6cykN5WWmn0lB85R8SEx1vtnwg2qZWC2NzmBhO8xcvM4E9dFaLxO8CbeL6PEPhZGj7qSb4Zkh+3vrtOlFgTNl7Uk+Rg6e5hF2arRCOJDUaVM+2DiH2Jzq/ds7wvYRw95Q5lE7fb4xilWhySdAN4aGqNQj11uNjQ6rvrEPRFRwrY8y8uhn8HDPFfB1wTqrrAz90SS6wD5VMBfbVSMzzEgB6PGnyO8rskshHzbCA0jrxL6EwfGXHTz1aoSr5t3wFfzciDcyv9b/Cy1PKbnJsyGF8H3R
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(376014)(23010399003)(22082099003)(18002099003)(13003099007)(9063799003)(56012099006)(921020)(11063799006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6IE60MUShdAGNmooiGxX9WJ1ZKjK4nN1d5ffonz2fBwiMR68wSRa0UK4husKUzfA1O4aIzVLz70GQFLBsqlgsYldVUbhxsdELtqNZEo74jycP28yT9+p0bz7KxvXXzXiFlBgmifSAeqjEEjitxG4EFMQzlfTlQrfCjkAvmlTd0K92JoQGtHHnfiTKabFK4I8chpyZowB0V9HQLRlpX80DIufNvlArRL3dBS/QStZYGi3dr1m9voTPH6EeqvLfPupr0PNTH+DMHFHWVHvDEsXdIe5nscDMMRzSy9E/fRha2l79soRFXu0DKBWuEkj+ZLZEVJ4/rWyqkq+kG7hniRU1zdOcUY1EjXeRivxGvb4xWI1VVYjVyy4rGtJ7M+9FqsdvMC2tC3lh0lCuPRPAyCYIR2ZOaqMQH9YT/lYAUSWrswB+QiFGniBKWp23UESXqBk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 11:45:00.6899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfea29fb-5cf7-48e7-28bb-08ded11cdbb0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6908

From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>

Add device tree binding documentation for the AMD I3C master controller
version 1.0.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
Changes for V9:
None.

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
 .../bindings/i3c/xlnx,axi-i3c-1.0.yaml        | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i3c/xlnx,axi-i3c-1.0.yaml

diff --git a/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c-1.0.yaml b/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c-1.0.yaml
new file mode 100644
index 000000000000..75f677696f02
--- /dev/null
+++ b/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c-1.0.yaml
@@ -0,0 +1,56 @@
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
+    i3c@80000000 {
+        compatible = "xlnx,axi-i3c-1.0";
+        reg = <0x80000000 0x10000>;
+        clocks = <&zynqmp_clk 71>;
+        interrupt-parent = <&imux>;
+        interrupts = <0 89 4>;
+        #address-cells = <3>;
+        #size-cells = <0>;
+    };
+...
-- 
2.34.1

