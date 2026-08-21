Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021074.outbound.protection.outlook.com [52.101.70.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41ADA30BF4F;
	Fri, 21 Aug 2026 15:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787325501; cv=fail; b=VYjZ970XY7sGrjhGFPv7csWas53Qqdd9f1CU0FWS5iqSTgMpmMSw0Yu404B6PemJaaWXmudm1/QUxuBIcZZGZtkhsHqq1j1ubNS625HQ8BOxAekREOW3mbl7YpOM/r77kruRU2WDNIKBXeAYg/uR/Sd4S0qvnF8RD/0dXItztJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787325501; c=relaxed/simple;
	bh=4MlY32o9imioGrow2WwwFCcZtoaXQ7NaWanAMurV1bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C7uQWe48w7cucwmSOpkGEzYDAYd6lvo/6TkFZYXCQDnPWrpAzu74DU/X9rwyjRLcXZ2kw2ZmZCTgTD89Rk67NCrVj3FcrNqGFIiVvew4Woi9tRGKmINd8tHjaJ5yprmWRmoZk3IqqSrVHDHlV5zMqLtep2kDfWyxzT6zzOULE7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de; spf=pass smtp.mailfrom=yacoub.de; dkim=pass (2048-bit key) header.d=yacoub.de header.i=@yacoub.de header.b=W7GhHKse; arc=fail smtp.client-ip=52.101.70.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yacoub.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yacoub.de header.i=@yacoub.de header.b="W7GhHKse"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQwxw2uISuCVC0k2VtlgZvGNpxX3KPH1grYag/K4Aivm0us+zDr2+noWYY9G8uGYOh1zmnOFr05FKeluaXa1PbEUQ7ST9yMftq45arTk3wDF7JfGuulvfOKSUsMhShK7OizjhLx38X+E/9udegBxR02Nt63GD1kTRR4xKhht7r6vFvm00W6fCiFTtli/WwOrfF8lbgTRo0ixVxYv+L45qcpEhaql2vC9oUEPVzguWeK/pT00ixzECxaDpikMd4RjUSLL18z1lZpqQFT7MLq9kF0X1HMMkNK7xFOPqZiaat2kYj6k6ktVOf+giZlSCIV0kBxYnP6K+YrW0wWng1AkJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0clhfyWKBx03k+1NNPeIVrDEwSsG5a86QmaQalvMuic=;
 b=ib8/MsI6U8pJSK34ICrACUu7Vk6czg4Q9EL625TSe/eTHXgw1F8P1+D+DpOI11DZGcTPmLgjBjQqz1uVlC12OgP4xinlGCcJZQ+GqOWOQofOs5+naa5I6ZWEknIP8HgN4bVOo835BsNVzeo2xsrnxQ9Zsz7FFp83nDL3drH498HoBuydSfC1IbP8pb9UPjRvD+EtL2XQmkN4FUO/h7keI/FDCy1TXpZsohcSm9/iDJl7N7Q0gnQLt8mw25GWE6ja0SyrIRbCQ5TJdqKbF/JfsmJc5t4PXwmjAPeEx/osdk5N+HytiXTKJlMfs5OMe2MJcK8CkG6j0rv9zu6tAxSAkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yacoub.de; dmarc=pass action=none header.from=yacoub.de;
 dkim=pass header.d=yacoub.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yacoub.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0clhfyWKBx03k+1NNPeIVrDEwSsG5a86QmaQalvMuic=;
 b=W7GhHKseLzc22hYINb8REl59HxqAmDYMqdmzvVfO6h4mkS0VVNVPoHW7p2u9GjQRi7MtvcFfaq34xaxBOLU0DyHeQznioCP7LvlyKYaVVGSmkj6Vmfkh3ULVLTSz8UIBHtqq9nyb4eA5NyoyYZgw9C1x1FlEHlAAViNmHMJ5aMpolRYDQ+IE5GjcdOxun0r4LvNj1v20yOqzqAte3XIYDMw/lfhJvaleGkt572I+Qj7R9LCQmvrkqCCr7w6C7Ea8gak9S+0j/gy22+V3ro1TuzeXikHXmuXuV8wDJV64KZfbVqpUVw8yQpr87CVICyqjEjuPyRsE7dp7QGSogfUGYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yacoub.de;
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com (2603:10a6:501:99::13)
 by AM0PR04MB6963.eurprd04.prod.outlook.com (2603:10a6:208:18b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 15:18:16 +0000
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809]) by MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809%4]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 15:18:16 +0000
From: Ramin Moussavi <ramin.moussavi@yacoub.de>
To: Michal Simek <monstr@monstr.eu>,
	Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Sam Price <thesamprice@gmail.com>,
	Neal Frager <neal.frager@amd.com>,
	Waldemar Brodkorb <wbx@openadk.org>,
	Michael Eager <eager@eagercon.com>
Subject: [PATCH v3 1/5] microblaze: wire up sigaltstack
Date: Fri, 21 Aug 2026 17:18:05 +0200
Message-ID: <20260821151809.1233057-2-ramin.moussavi@yacoub.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821151809.1233057-1-ramin.moussavi@yacoub.de>
References: <20260821151809.1233057-1-ramin.moussavi@yacoub.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0250.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::8) To MRWPR04MB12069.eurprd04.prod.outlook.com
 (2603:10a6:501:99::13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12069:EE_|AM0PR04MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: 664af97e-bc4b-49a4-0345-08deff976caf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QwBLPpnPwooHJY3Pa445EhKwwiWzdYtNS0E7y8KJ1YAL97UKKxFurquA3LpPI27yprOqeRmbE9tsA9W6xqj+EpkM4x/N/UnDuKbrhFhOPmB3aqgDE81JjKbTZJ+nSbrQ3cRrkiEb5CZdnCcgs+ENKuW9rWE8bFbr/pi3FCWynwauYx5vKeFzRXqYOOUI1szeCUtYflFOx/8KpOYQWoA7CoE/+LbmkakgieXA4CZ6X58bCknGokxLoxZKFRB64gcbqzDShoiSNAVN8kIjtjlR7PlNPsqS4lwRU/GZzp5SrYEU42OfRYnBavlJoKZOO6EX93zZtwJKNxjoZ2m+0g1dGjyOMcvCT5v8FxqLfOCiHBGppMonWGtk7NJFuN/GpceTqLJGRY9A6yGeOLR3FxmZA9MxgTiK8SJYZbKVAaeHIQUz/rT56CiyI4VCptAqymvdN+vpe19Hq1OMWCJJa7+tTmLdWHhUhpNyahCFTGFn48W3Kho5vkqcdDX0/hRPpNq+r/zz0lXXBB//jrNhVOLPSIBt2BIvLyPXoBUjM0uWOW/2W3/UfP8qXrh21JIpcAqkPwaihdTrfBG7cNrjHms4BL1cLM/DsgP0zIfNyU+y0ZTlfOhV5YJCf6M45x6buVGLvBMGoTVPJcYW0dEVp6JVkveDqFotrfZPZL5b8VRipOs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12069.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CM/nTUN88jDIWEgVYrB9vnv0IN/oc+w+zNhASfoS5VOtD0iI8kPJY9rzhRCo?=
 =?us-ascii?Q?txIt8qxXm9acgD8LtHNiPdVPlrTyjBkZzu/i34eC6b/w1uJFyoimiezeibuL?=
 =?us-ascii?Q?uv2iqaWl+I1JO4z05PwhbCjeq3yUPW757ixtpp+mrZiqUPLDDXPssl/7LINw?=
 =?us-ascii?Q?9+3NL4at8YRoSzkjrMsRPC0EHEAIf30m0wi/ggY0WKRm2sSp03EkqzuQlzwd?=
 =?us-ascii?Q?0adPBmdOmyQ3IrS+5Gcm+g15qq3QgcAF4C7wCvpg0vCu9m9IjWN01cHy2uPe?=
 =?us-ascii?Q?9i/WNi8BMSqpIcJgjKfg3MfAtI5tO4FOYg7cL9fBsMX43RhqVNwDh+aK4iyl?=
 =?us-ascii?Q?ldX73yK0myVUMrHhFaFtgOAKASMlLNIERQXkmpTbwgPlNVVkjoek8rnkmWv/?=
 =?us-ascii?Q?OHgOrcghZS0QxagN0lEztJ3NNhHaPq39s9KbpQpWqMSPQ1KYUjMK9sf3rtOC?=
 =?us-ascii?Q?S5dzsinfTCZ+xKEK3WrNBO5pXpr4xjimHbw0mvKhTErBM3nqqmp7UEf9CQYe?=
 =?us-ascii?Q?wdei2yf4/yRhQUEw1mG6DxOmLC7KgH1J+cfPZS5l8zNlIg8cbl7Goa23oIu8?=
 =?us-ascii?Q?9aNr9HbUtdu7QdOJu7JlVpK2t977B7QUBOp8Dv18AraII2TM6v/z378g4p1u?=
 =?us-ascii?Q?aY9HPtWmaLHjCf3kyj0cBdzpYCq3/2kt5SunrU297vXj3h4TfxOH86SkvTto?=
 =?us-ascii?Q?BfiEGIv7MltllAixODTTEaVluWxd4Ssf+LjcO/xBOpeF66NEPdWK2acxX8FR?=
 =?us-ascii?Q?aCVCnupAoQMCveexu62TxAmAiWDGFxlrh7NrKDnRe/ICy5IJ8/VeQy74I8rm?=
 =?us-ascii?Q?1AADDkaSgyukb+mDtAUNBRGGaqINSRZUkY0hNaNsol3V9dUXu01q7TRYzPle?=
 =?us-ascii?Q?IMd26y/XriZo4rAA47cgOvkrPDFiedwHJp8QzTxxPBWBAxV7Zfxt3ENsH6VB?=
 =?us-ascii?Q?/wvh7Yv+HgHeN1DsQinXY3HSk/xyIsfjwzlDBli5ER0fT4JCeD3GroUsg7+t?=
 =?us-ascii?Q?lfiDYgsBOb6YVFLfPN3BU6J88d47papEvpTidr7gY95KPAlBhM22knmZh19r?=
 =?us-ascii?Q?T21CgPoimAHEmMRh95R8DSs0y3O33AL2pQJN3cnsPgJzAPdgQZ8Kc1xC/u8b?=
 =?us-ascii?Q?GZUQtkeSFgjcBP/c4C24X6Til4yL9zsphAWGLPYMNMlEYKOY+1rn55AS6d0u?=
 =?us-ascii?Q?5bgStNI92XrXh0w5xdCsM4hxYoHa0r69foFu1rtV0ysZP60yRTgJhi86OhpG?=
 =?us-ascii?Q?JxCd8niA9TZL+h56K8zXMIFuAMqkfnfrXPrsN5C/O3QAC+OUI6bnZrI7rOaF?=
 =?us-ascii?Q?ddeUPfya5k8uHCDzYeZNqfoZk+Tqcgb7OlHBd7Gq54KMj1dql7Ub4fnv5Tc+?=
 =?us-ascii?Q?HpY4KxdNEQ4bX/40SGEEEnpDs4APqkDUk1XaoF0pLDY0+EWKdbFVkTkl2wre?=
 =?us-ascii?Q?md9IvseNWMVqYQEI5+GztAzNsnQg0vUqKuMjFhCTzQZGFTbiv3ablvrgvTMJ?=
 =?us-ascii?Q?ApaihMf3AOCnqizFp2Wsa/mg8OHnzPC48g+Q94oK8UoLMysFSCn3qDpbxQ3X?=
 =?us-ascii?Q?fN5/yYusTh9Gc4PnZ4Y8t36MvhIsmApWOFLewC6OYaOLHpZ+3iC3+wU8tvLw?=
 =?us-ascii?Q?er+1qxM37M18t8OeKyI+tD9z3qtykGLTu5D3lSUOb3A9Lr5OXbxsQTfWV1Gk?=
 =?us-ascii?Q?SUicqCEtXKu51w49sC/kLI5TBbe3tN4P2hrY+FynzdcnuZylFMsx7plGuhtB?=
 =?us-ascii?Q?boYR8ktUTg=3D=3D?=
X-OriginatorOrg: yacoub.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 664af97e-bc4b-49a4-0345-08deff976caf
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12069.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 15:18:16.2688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2e96c4fa-c0f0-4eed-b0b5-8f85f5e8376c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PtjrfnnsUlob33QyCOVtVHI/koBvO1YQxSZ69bYJrxZEI8lNHYE9NsDqgtD2z9JvLLP8q25CQUyxl1SBYruWdfCAWXKInN3axLW2hYhvx10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6963

sigaltstack is wired to sys_ni_syscall - microblaze is the only
architecture without it - although the microblaze signal delivery code
fully supports the alternate signal stack: get_sigframe() picks the
stack via sigsp(), setup_rt_frame() saves it with __save_altstack() and
sys_rt_sigreturn() calls restore_altstack().

Wire it up to sys_sigaltstack.

Tested on qemu petalogix-s3adsp1800 (microblazeel) with the uClibc-ng
test suite: the five sigaltstack-dependent NPTL tests (tst-cancel20/21,
tst-cancelx20/21, tst-signal6) pass; before this change sigaltstack()
returned ENOSYS.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Ramin Moussavi <ramin.moussavi@yacoub.de>
---
 arch/microblaze/kernel/syscalls/syscall.tbl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/microblaze/kernel/syscalls/syscall.tbl b/arch/microblaze/kernel/syscalls/syscall.tbl
index 223d26303627..b4ce48e8a874 100644
--- a/arch/microblaze/kernel/syscalls/syscall.tbl
+++ b/arch/microblaze/kernel/syscalls/syscall.tbl
@@ -193,7 +193,7 @@
 183	common	getcwd				sys_getcwd
 184	common	capget				sys_capget
 185	common	capset				sys_capset
-186	common	sigaltstack			sys_ni_syscall
+186	common	sigaltstack			sys_sigaltstack
 187	common	sendfile			sys_sendfile
 188	common	getpmsg				sys_ni_syscall
 189	common	putpmsg				sys_ni_syscall
-- 
2.53.0

