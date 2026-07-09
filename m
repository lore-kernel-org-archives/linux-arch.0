Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013003.outbound.protection.outlook.com [52.101.83.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3708E449985;
	Thu,  9 Jul 2026 19:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783625107; cv=fail; b=FuSrl4cJwC0rW8w+WbZeiEsDY8/eeqhnvYQlsmVmaYpWvWx63M8OCNLGJ62Lqn5vKT2HNRAt4SvuG/+itYM8zqUiNK4wdWBgJXHwWP4r0RY6nZEKQkjc7sKjL1LskBXJSKL/aZk7WBog1oVe2wr/xfM7nLsC4zhaxK9RbP/48qE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783625107; c=relaxed/simple;
	bh=zIE7HSk8xgMMBk9Oad8P4UlMyuIo5syFCxQWSC8/SOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mwE2jQwa20ZJWEolsxg+/5snghRpWYLqdJ+b3+uscJa7jRjp/4NSSwQtaQhwfK9uv12XTO3R7cZguN7gVrc7Oxpigy/0QkX+esgRKOG8Xe60cCX2squQRAAnLpQix5HAx4MVllc+ziFHzZwxkWv3PACT9Z+l1Ql7pfGNGjHjM00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=nuCulSz8; arc=fail smtp.client-ip=52.101.83.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="nuCulSz8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WCgW9iIQ6Hvekxzlm8hgKFkPTV1/FpJJ3s5CeWd/oVVU4ZTEI77e8vT4vw0nIoykoBaJNbA2shVMmScQzPaNzH6/owFPU4B+dXFUkYrXtVxwi8nCQ0KkZ1xBrPI5md+B78n39XJ6v1nmLYKVP92maE70iPlxIB3IIVRL1HeyC4FflV+0puPn642SScMmiQBRRNcWnuH/u1Si3HTYgaABdFLn/pTCe2TIOH0eb30RGmtwSbOKjyUnEQp2cayXX+Rpqm/1w7XMEDlGWBAY8IVwOKFH8y+LBMGrjTgL87grcKaMJAF19U4iTo1ixrWgs6AClm+79YmYOzSbp0T+v9NL1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zIE7HSk8xgMMBk9Oad8P4UlMyuIo5syFCxQWSC8/SOg=;
 b=ep6sVLK5g7wkwCgIi0HSegnsn4oAtFCBu733I9J1S9FnnoJYnnpZJLe450n0w5Mm3gtBtwIFk9JZlC0weYkyak9FaPJNuo7twFgQEt6SnxtIc5oSqmjEJKQhbIq2nkYa/eDuB2oKSP/uPCxv0ofoVC4zg6acsvOTCHN7ipxhS3iqzULDq1pXZ6ktL4xJwni3lArN49Gjp1evoU0kpDO1qpGXwqzxZZfAJ6F9TmwRJVsseTUGxoxZEArMKm7uEh3clDv8Fm7JTkebSiQt2mymG268ZADBsx3oUcwearblhAjpNZLgFP3J01T2XCufacUomSgKvGF8H47A+VRFNfjaBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zIE7HSk8xgMMBk9Oad8P4UlMyuIo5syFCxQWSC8/SOg=;
 b=nuCulSz80QtKG3flfQLsvmHswBYArlxzOSF7QFlYzFdHvkNEkl71QjzO2qoTqd9VIfi0gb00+PsFhpZK9iMdtKw6EbA0BekyGClMx2ukD7v93N/fsu8XU9WXAs+k7eRl5EQGpI3lOvrqgSSobYRaofg1TMg/VsQ4E2WuXzIpgUf4Xzx+amqaE5GM8yZ+KI42+riN46Y5dSOBCIdxGKn9BGRwYFdB7G0bsbHrezWM9bgwdd8SC/O4lhY079Sjvp8IxUa+ErCkKS7l/fZCs+1Wp8LpqTPj2n2p+znz+a753f7dWaFDa19c+B8IkAqTBwYmMpgOw09A0j8/6qFGeC30Yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by GV1PR04MB10631.eurprd04.prod.outlook.com (2603:10a6:150:202::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 19:25:00 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 9 Jul 2026
 19:25:00 +0000
Date: Thu, 9 Jul 2026 15:24:50 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Shubham Patil <shubhamsanjay.patil@amd.com>
Cc: git@amd.com, michal.simek@amd.com, alexandre.belloni@bootlin.com,
	Frank.Li@nxp.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, pgaj@cadence.com,
	wsa+renesas@sang-engineering.com, tommaso.merciai.xr@bp.renesas.com,
	arnd@arndb.de, quic_msavaliy@quicinc.com, Shyam-sundar.S-k@amd.com,
	sakari.ailus@linux.intel.com, billy_tsai@aspeedtech.com,
	kees@kernel.org, gustavoars@kernel.org,
	jarkko.nikula@linux.intel.com, jorge.marques@analog.com,
	linux-i3c@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-hardening@vger.kernel.org, radhey.shyam.pandey@amd.com,
	srinivas.goud@amd.com, shubhrajyoti.datta@amd.com,
	Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Subject: Re: [PATCH v10 2/2] i3c: master: Add driver for AMD AXI I3C master
 controller
Message-ID: <ak_1gpc6EpgQeOOl@lizhi-Precision-Tower-5810>
References: <20260709064233.1451482-1-shubhamsanjay.patil@amd.com>
 <20260709064233.1451482-3-shubhamsanjay.patil@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709064233.1451482-3-shubhamsanjay.patil@amd.com>
X-ClientProxiedBy: SA9PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:806:20::19) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|GV1PR04MB10631:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e15c3af-3b08-4d0b-eb55-08deddefc48e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|19092799006|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	OleXcigNERDBp3zqfnQPA+gSUhy1u9bvsEhBUsqW6LNS+r4GEM5m/e7fkGUDnthRcaKMta/NGSDiB9LyDXXvGka5rlyZcPPQR1sEncBa6Etz1w69uBFgQUCT9dRF22ZedvmfGcTC2v1wx4owPO6sU2ex7U7ke9qXTP2yCNMsQqStaQHr1hTCgjb4oUL3wNFtXXFPWt+fqYQoVQjgIWmF6RQyPARLMQ7tuTZBpC+NhuvhVJp3H6Ck0cqnO5pKumgJiUxehrFIECqiWag7F5oUmD51wxGcFB/45GwVaS1bPoZ9ur4wrhY9grxMmEO16Fd1ZCmOpe3kccNfogXTanFa9ZNPkHGU6Xw5jPATQfAIY1WisrSht2aVknE7NNKseEJc4qqlf8jDl57oXPVPhnsiTrPMbDZkSg2IdeBXUZcVT7oSvJBxOJ/+bDHH0UxmRg4n0Dgr+L4JT2qmcQE0c+Px9G+1kMBF2W/20aSTOWnr06ZYMUbHSHitrAceSawE6WOBT9xtnQTvN45iRA3lkJVTrH2dVD6z1GUITvijUogNcONk9pxGfzdZ/rZ0bOpCmZHdVjaIjkHpQmeRJLr9P+QovYpqIaRHkWAmitLFEEPjWLUh0hFeWa/qaj0o13z5yNDdYYXG35Q6KC9qvn2LiyaAnr6XDFJfT3YLL4pOolleZUY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(19092799006)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yi1/cuHs30e+k9bBzl8zv/ZLTsrM9yMzCPgA83AMk7F1VAazlMCaSd488FaZ?=
 =?us-ascii?Q?jSSSec06TBY80S9dE5FlvxWqJ9qATLYnpkLbmSykZlWs9mk6QMmbroGZESf5?=
 =?us-ascii?Q?P7tW50uMJCBme1E0/Uyx5klsajsnfSftds0Z3Ps2fYfHghLoaDflWpwrUd24?=
 =?us-ascii?Q?vBx+4Q33ozi63ICQkR/QTFOZpK9j+y5dfRGDHb/FgPhetPadz8xkAPm0T8XB?=
 =?us-ascii?Q?QRNlJjNFM5sY52ZpmsUeQP84AFP+zuk4oSH9Km6hRqqWrRy111O0SmMJ7U4a?=
 =?us-ascii?Q?eYUvqf94mXpzPvMKd4bHqkBZMeyo2vE6kO8a1j7BcTvLO3iL+c51wxQoyZlh?=
 =?us-ascii?Q?i7CH2z4pQ0ButUGCIYXY6jjnLO+sdEf+4cVnIqEpee1UiPCoIhSxOreGulVX?=
 =?us-ascii?Q?Qax/esIagLEYZHf0FIahkwlOYq9W0l0ygrcl4aquYIl4f15Ua2UoUmlKoxzv?=
 =?us-ascii?Q?yQPceOQ4yICw0LqbtD3kgwHt4ZwDQ8w4OCvnvjX1wTJ71uCZShkIzTsOiImg?=
 =?us-ascii?Q?A85SLJO0VzlikHRjmo71qE7IeENF0ZZxZ5Vd7ayye7EWZaM5Wza1DTm1gDD4?=
 =?us-ascii?Q?J+sMyNE981jxzYshde/kJsd6nqiq+TtzlWZxfMVWTynD48ycUOavD/ahj9Mk?=
 =?us-ascii?Q?Y4bNHI5xnGxKg/THyr8eQRe1RP/MHpiS8wXgm/R6Azl/HKmK+ZKRdgLcGV/i?=
 =?us-ascii?Q?a/8kXweOE6w9jvtlj94vQNHjfA4daz2FHvtc1XsBJeG9UrpC1fWu6vcdKB5l?=
 =?us-ascii?Q?cEE8lbReJtDIFS9BFmptAm23Zkmydnin67ex+Q4GnhD+Z8db6f1hMSDSu6MX?=
 =?us-ascii?Q?0g3IJ1O0mxEhN0TGX1lhcz46VRvytDfP8PD/zUJDBWpuOQogafwReH2QFWCK?=
 =?us-ascii?Q?FTJRbPnJxEH9cjpr5GYx/QOUO41kNZ7PU/TGVFc6sVjzwTTfT0c+tYgpYuv9?=
 =?us-ascii?Q?xjlvQ+Vvr9/CCz3jYmI42sdEXFbd37RCfPnr+Z6M0vkAhOKNYNyTm1cwlUYx?=
 =?us-ascii?Q?DpZtBq0hhXZ6O+/Kj8jM7VQRT9hY08ohttqseFKs2jj+IsVxu/afSfT4OCC7?=
 =?us-ascii?Q?EqtapyA+lLNyoeoiuXVhK4ClVB//IkzmIcT0DT4KWlfdOYNoWPAYXrTp7qRm?=
 =?us-ascii?Q?aDelmqkz/jm/DAfpA19SGTXGuMiQvTrNNTSVngvSUyUfFrjRWwkLPBeZnjVO?=
 =?us-ascii?Q?YAw+PjorSi1WKFLTePyazDRoTEzf2ZVYWXbuzRc1Ur7AOUvnHBdsI8cIaqcd?=
 =?us-ascii?Q?Ze+1DZub/tS+T0hLNPwsaAx8qZHXaBKiOQaCrItx0DihZbG7VrqGcayH2H04?=
 =?us-ascii?Q?ZBvIqXiJa3S/UT6xS/OFNG9YSaoBFLxeBaWMpt7xbCTjrxdu3d/0hWusVq83?=
 =?us-ascii?Q?wIIniGWyJlP9CYbADcSWPAD7mb8qn7Reg91yAY4+Ft4kKZA7gBWwSi5QaWOh?=
 =?us-ascii?Q?IeLqBW3XMJMw4qj1cEWZBziW+wowsFDAsfSbwr1b2nPFXB8pfcnvmb5ffVKo?=
 =?us-ascii?Q?pzIOGvhgNj1bEqQw8pIMGTePMkXikQf7CkJTYc2Bx33lTCqXmK7F2rYqARKg?=
 =?us-ascii?Q?ajKbkNbvGF4w4CAfOSB+qkAvKalBr+G+aFVwDkfEFxgWuiGrldpKg+14SB9B?=
 =?us-ascii?Q?MRomSXy4O16GSSXlwN4aLZnIkuAlDeR/nSut+xOBlBKZY/3If4kE72F5LvhC?=
 =?us-ascii?Q?3hBPXw5xzNb/N6ayUGRuCxCVPfW2K5OHEQVJilTrck37hLZIPaXwaCWj5AoK?=
 =?us-ascii?Q?Gm+6JxU/8jrd3YBuI7Rbu6HTB02N8NY2lPHxHajHHRKCRTzkR5N9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e15c3af-3b08-4d0b-eb55-08deddefc48e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 19:25:00.0290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mO8RMOhHIUULoDiyU0PiUxc8tpGbKxMoHuBBUUKNgs7pioDtxd8+XM6BVciPql6mLWPBpe2fROIz+YY+aW2i/53sGeDcNqPoui54JX5mfkob+WejgxK3G4Y7hr2WNetY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10631

On Thu, Jul 09, 2026 at 12:12:33PM +0530, Shubham Patil wrote:
> From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
>
> Add an I3C master driver and maintainers fragment for the AMD I3C bus
> controller.
>
> The driver currently supports the I3C bus operating in SDR mode,
> with features including Dynamic Address Assignment, private data
> transfers, and CCC transfers in both broadcast and direct modes. It
> also supports operation in I2C mode.
>
> The controller's data FIFOs are accessed big-endian; the driver performs
> this conversion locally using ioread32be()/iowrite32be() with the
> helpers, so it does not depend on any core FIFO-endianness helpers.
>
> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> Co-developed-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> Co-developed-by: Shubham Patil <shubhamsanjay.patil@amd.com>
> Signed-off-by: Shubham Patil <shubhamsanjay.patil@amd.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

