Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012030.outbound.protection.outlook.com [40.107.209.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936BB3E7166;
	Fri, 10 Jul 2026 08:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783670785; cv=fail; b=l7PgtDXm9zlXN90QM2NX2SfJr0GVogCuiTgLVBsr0OXq4W5sJTIlcTla57dwkDlJA+/tNabfcYQFqj0sB9eKPSAMxguo5rUbtOnOvrBFGbA5uA/fJSPrkc3gmX1A0Jmhz6ejRQADD9MtzZe78F1TkVyjCdcqAl/CTnLQUdh/WHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783670785; c=relaxed/simple;
	bh=z1l7d9U5nHyYOoAmCsxqz/FNwgFArZgHloQSDKKuJ50=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Lu3XY1JZfxWst+sP7linK7xyv2b1AwHT5z6npzzK92wLrqjXINGs9GijlfJEAMaGCeXpERGFt+MKPsBucUAGT0ILPzZB3Thn4NsZnJkusMed/am4DfxSY0wnpB6Z33n4bS7X6CeFObhQK0OJa2IdTOlTEfspoi9Jv4rukkCTKB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gn2r2MY0; arc=fail smtp.client-ip=40.107.209.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gn2r2MY0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NQjS40NVJ3STwA3Xj4NWGR0joRxHiPFRTr+zQoFr4n078SBxj6DByxl4iy5H0sANtorOH37bYz0r6uVWO4WMuVOLHdRYkKZzd8UAzGdyR1AgHP0VCdx079cOuEasfB+K7UcS6AuVM1OWRIhFUB9+md/o+L6uK1cYXNT72XoPoLKNY9QC+B2FV8uH1ziADCVslqmiY3QxtRRf7+uk6Id7J9am2HlojD87xECngHsm5yN2AelVdd7zCS5JZOO5PM6Gf9aGlhWUdzhhC5MsRL/lLQ72XQffIrNJXAOuRhD2p/LMc2DbUs+QcVuBBlJ1C4C/xun0besdU4qOziGK066l9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MteYI04ndZIi/hLliOGnf+hIvTQT1wRPHIjWZQ8Ie4M=;
 b=G83/5SEqiv2EIGPFMK0IBLr0Her1QeM69CWLw3BhTzM8w11PaZ2p7MeLaZ9eZQ8b2UwmTWL3k1DeuaCT8Md7DYG8ik1M2ttViHHkxq3p7mP9Jh0Fjb6ni9ujbodk49JamrmYym5doVJHDaHRx311PJStRto4PquzlcsiqOpI0utj1ekepLAEJS0krNneQi3Luwj/S5RS568XizcIYMNtEOi9vhrIi6wvKkjX+QMVW35ugWw8iuBMiM+ssTPvgvWULy5uxnaPj8pxdl4aICT+uGZhlQm0KcMBiC9QzKyw615ZInuz8YP7ZevfX8FJ1NsUiNJQJONypWkoeJeHe/Qurw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MteYI04ndZIi/hLliOGnf+hIvTQT1wRPHIjWZQ8Ie4M=;
 b=Gn2r2MY0lIK1KMQc85feNpv8nbNH9SPmfvR8xdc7yp7owOYW7Xv6EN2q3FkDuqpahfsfguYNWtk7UMTmpkJGt6/jlRcY8cupem/ouDD2WwteOcJsRuQwqQirCUt9g/yli8oSuFB4gn1Y2KJjiaYtGR5WLmLUGDiL9ls787fS1NA=
Received: from SA0PR11CA0051.namprd11.prod.outlook.com (2603:10b6:806:d0::26)
 by SA3PR12MB8023.namprd12.prod.outlook.com (2603:10b6:806:320::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.18; Fri, 10 Jul
 2026 08:06:08 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:806:d0:cafe::5d) by SA0PR11CA0051.outlook.office365.com
 (2603:10b6:806:d0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.12 via Frontend Transport; Fri,
 10 Jul 2026 08:06:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 08:06:07 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 10 Jul
 2026 03:06:07 -0500
Received: from [10.136.35.241] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 10 Jul 2026 03:06:06 -0500
Message-ID: <2e3a18e4-8746-4df5-b4b1-2d76b3d16940@amd.com>
Date: Fri, 10 Jul 2026 13:36:05 +0530
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [peterz-queue:locking/core] [futex] 58141fa298:
 Oops:general_protection_fault,probably_for_non-canonical_address#:#[##]SMP
To: kernel test robot <oliver.sang@intel.com>, Peter Zijlstra
	<peterz@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <202607091538.58e3f39-lkp@intel.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <202607091538.58e3f39-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|SA3PR12MB8023:EE_
X-MS-Office365-Filtering-Correlation-Id: cb1ad86a-3a04-45d5-23e4-08dede5a18e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|22082099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	+sIDjq2acLMJ4bvd9v7eeckKYhbaUknYsb6Mn6GOHBaxJtdcf0Mdu+xNo8dQcTfums03n/CLpOcBdMRY79GPnI6f118Np9z8s5RNdC51stetOSaHsmHPPIqXQ2Xu0kEu0J3efE4Mmwfzw0dQHmjAxF6Cp/kw4PKczmTP57DzCGcvwAAlIMFXGmzRbneU7oDj2M1sATKnqyFQLYdlhmZpbdPDAoBKS42MUyHArcW/jB28cJ7oWVW307ZehbgunVCSqkXFhvaf7FE10vFpfvwzk3iYypGHjLlOe1xTkc6oDyJhKx/cXoSWPGVco+sQKjKuRnkyAt6YyvUSp+q8beyfvMr8Ww3XcNa40t5gQCZ70IdRzW6NZVcTcprMlH0uMmfASr1aGfETKjLz/zjDh1bkOZldnIOJIr51iWDdsRiwre1RdKf1JT8KQ+JL4aiLMokGupYxMoJWSd/OpQ564VKaBOTfOk+hiz9Khn5UT9CvWSdOKU04P6rnddFd2L5ZQIU7OTi54g+AOFHkXfgRa8ym+UyNkmR6ckN+G10Ce6DMObDuPxvpvHqXP0wIthIHQj7LGvdS4khdBS00ChY75tgJ5QXB3mID8CJs4cYxoWE0Xy0WTdKB90VncQtKSRQhFQne52IebCyQcNfrJ0A8J2SZB7LBYXkdqwjvX9HGYK2p4KGDY7XyWwtDzFaF4p1q8538++OJ56s63drF+fyQ+l9CbA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vW6QSdJmmT1BN2E8Yur6V+8DmUg8yS2T6vErSByjn4qLHx5aelS3jtME9XBWe4Q6hvB1cYuNXWQ6GWr/mPvKiyVGmy50u8LFJi5xpP79WYE9DyaIyrmJ9VsZiXhTMmh/M2bSQ6lTSTD/1XUy5VhlgPpV4J7m9WyQdjEZMTuKlXvXurZD1fBkX3bnGQIsRqUTmhQuhTUSUMXKGAf/HSdJSZf2yjCdc220O0r5sPF2GN674B4jbh6K2QXbQWyPC/Jazg3MLYS6D8pIRZRWht1cFtrkaOv4inEEKTxj7FJijBn5h65ms3cyfUGu5TcGDijd0gbBnqNSsxrgDUKItOgNCX/Y8ujCCYDYZRcyYW92J0PyRzPMVe2pjs1zhJQrfmtBuOr/hZXxCVxmMyfCV5ymDu7jKoIYvzgA1+qYL0fpgHGbJqqeSVrKZZQ9JX0+JvQv
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:06:07.8982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1ad86a-3a04-45d5-23e4-08dede5a18e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8023

Hello Oliver,

On 7/9/2026 1:47 PM, kernel test robot wrote:
> [    1.259631][    T1] Running RCU Tasks Trace wait API self tests
> [    1.261867][    T1] posixtimers hash table entries: 1024 (order: 5, 81920 bytes, linear)
> [    1.264376][    T1] Oops: general protection fault, probably for non-canonical address 0x123456789abcdef: 0000 [#1] SMP

Thank you for the report! This is an unpatched address for the runtime
constant which suggests we are using the address before it is patched.
Following seems to solve it for me on your config:

  (Prepared on top of queue:locking/core)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index c6af6edf5d7ae..0864c6e8cde78 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -2027,6 +2027,8 @@ static int __init futex_init(void)
 	runtime_const_init(mask,  __futex_mask);
 	runtime_const_init(ptr,   __futex_queues);
 
+	barrier();
+
 	BUG_ON(!futex_queues());
 
 	for_each_node(n) {
---

Could you please check if this is the same issue you are hitting too?

My default config seems to have been much less aggressive at
optimization to have exposed this problem.

-- 
Thanks and Regards,
Prateek

