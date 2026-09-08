Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022129.outbound.protection.outlook.com [52.101.96.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9C43B2FFE;
	Tue,  8 Sep 2026 20:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788899565; cv=fail; b=cGDpr8sJOLdP74f0kymrDNsQYfgapWASGt2okm5m+PeWpaxsFe+/78qjmb6PYD8Hee7eaqQM5CF3wIKrIY2HjhY9wDwk/bbzMngWKBvFg9TUc0AOCu9sQFZzcA3OYGkbq7vFFUO64eVb1zRbdfIdTbd36FmRNDF4f8cuXEgjyiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788899565; c=relaxed/simple;
	bh=6yEWKeQb/SEoo+2lpor2jRQcRYZHkb4uTbjtAbKjQbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R2GTzjg4p09KrPXGoWkkcwnzQj5td0i/uGBSFNTIHaohuho24Spbwxco2gCzTHDm+dNVgV+0mespds6qgcmWTAuOhPKj/utIZA2s5vEdazNwLGhLUoLrkKQlyW68yJDXz/ogYyGbWWygFdoINQuz/HKafCe7P9Dua84icMpbaYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CBfHEp56RfU+lSmQcm5WSqz0s5PhHMrHGaNRdmDzB/ux1lyEaE+iVfBL7WFL4oYE0sZq7pnG7z3BUDWOR2BTtrPFAgvcOk/hwjidDczDjmPodT5SnAtVGFmtVMBlQygu/GNq6JX44UfxCDTcUHA7LUguuKqQmacn5MxmRW/MmWrwo1Qj7IcagS/sAaJjxVb+/EKCehsp00zXYMbm8Qb1fkMIAzcLRK6a/iQPuRFO4bo5Tl1haxvtvnElRWCkBXJJRBBzNKgK5nhdzKeH7QawLBbqeQUJGqk/fBjBFf8VKfZcAvr55y73sKG/uq9giX8QG14JU9/x9uxtFvl/v/2R1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=I6N2x9whj4JzC7LETE3SPsVQkRtwuSL6bGItzjlypVw=;
 b=khRtyFh9v6ob1a6xC33zCeC3smpAjLzGGKJvUNc4RT+XOBRC0dYRs6vHB/WK4eCQdnXW8N8ERtDXBwtNo9/lrNax4A/lOGpVyiV1Abh+M4Br6MHEYHLrjd9oyiMDuhgxIwRxwVSdgBBZeugN16oGuhyZFfcW5AFnwHXZcivkVn9NfiUvmIz9fEsq9Jv5kcBUdyFewNdp0hwVf0lzAEpZuZT7oh6gIDXJv3bgOKgPoG8xVK2rpjNHH0kATtmMec41MWKILFRbGNDnFUQ7W1Bmz9U+wg5qptR7Xrd8RE8E9Ri8ekvGHeCv++jE8NKcfPp9WPSgTm/OaIYvPZoebixKww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO6P123MB7126.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:341::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 20:32:39 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0406.005; Tue, 8 Sep 2026
 20:32:39 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: arnd@arndb.de,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	peterz@infradead.org,
	ojeda@kernel.org
Cc: akpm@linux-foundation.org,
	gregkh@linuxfoundation.org,
	mhiramat@kernel.org,
	boqun@kernel.org,
	atomlin@atomlin.com,
	neelx@suse.com,
	da.anzani@gmail.com,
	sean@ashe.io,
	chjohnst@mail.com,
	steve@abita.co,
	mproche@mail.com,
	nick.lane@mail.com,
	linux-arch@vger.kernel.org,
	linux-modules@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 1/3] module: Treat dashes and underscores interchangeably in module_blacklist
Date: Tue,  8 Sep 2026 16:32:28 -0400
Message-ID: <20260908203230.401020-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908203230.401020-1-atomlin@atomlin.com>
References: <20260908203230.401020-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:208:32b::7) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO6P123MB7126:EE_
X-MS-Office365-Filtering-Correlation-Id: ec0f18c8-ef11-43eb-1089-08df0de8539f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TzelBlaNS0ZydXdEGlcO5IrFyZT1dWnnNBcgzegTPI+XxX+XLqvvfXltSoYgh5M9NKOJp4fGgGrltBwnXO6hKQ7VSrC1RJbKqUtpM22q9eRyuoUiEji7z8K8ewD+I8vNpgAJmLJ/nF7CSbQCYHEKMMnzsv+KyL6+KtW0BsVZ8LfoFb9YB/eiGvzjaxXH7QtO1hFErKUEeqQGR1DjYbSoX8zDlArCizs+JsApQxTUamYpU+k8koNPDMQmLCc3+S2M3h3BVa8T27PTNP9M6sYUp7Eg1rAeWLnYh0AMGB6wsFDSkc4++WYfC6R6JLYcfKHphlm0MObMvKGpkUN9fEuIIUiD3hT3yVO1GFOoPZmog9CAFz4KX24FFS05W5qDtagnDM+H1ihe6QxIdQbBZXleFhp5uQFtjc8naAUYV5OxdItGusOSBz4UurVPJHkjhxjVJcNUa0m3AgK5E+U0Gcd7ZZo8ktac8GYxpicAgbS/WfH15yi4hAkq9eY0nrFflPMtZqC+KHFIcwJwRJR+ioHYbXcELNpYZvpkXLMHLWXNHL2hu5LLug0AONwuoPPi7E/cWgi4reHdOngiObBM0nlJHBHom7jukS0UToyJW99+NynL3RUny3s6c2fRJihCl8wzFh27vAI7C4xwVeW/vIS72R4UHi3jgwav+zRl1PNcEU4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?21hwkVtIWa/BEMenYrl+8hNVYHqmqIy+aAVlxuCsxmwm8SHV8mR/xmV2rc5n?=
 =?us-ascii?Q?41+F/66WyIg1WkVu7EDf6qNtxcRV4nWPDxvvea2rk6yI7pWFyJ/HqTx12LSh?=
 =?us-ascii?Q?qxVe9kUsLsSGlt6eeoVqvYFVAz9AgZC4C9PF91hHaktfDSOvG3WcGxME/ONx?=
 =?us-ascii?Q?VLoUWaBYU8jnM7Ann4q6noNNkmQJq6BWtiJhct4Kh7GQl9I7V96snSj0uZTB?=
 =?us-ascii?Q?WXJcL0ROZw3l0S2yWeYEN/Sh1Z/ybmKnXXZaIdRVEwaaHjI/884x/Lvb2o/g?=
 =?us-ascii?Q?fsunYGOkJ5A9Bd0XOzDkCXvADhbVMZUC4BuM77Y+dXVVRr2xYUIVtkCt5hI1?=
 =?us-ascii?Q?eJ44MP3BTqUs2pAlzYDk3hixiVUszSGgkkVagk2U2PFsq7PjQsdkcJlT43WI?=
 =?us-ascii?Q?BE+MKWowA5NYt6X3M40pbTwIWpbNZus/YwuK2tTr1nbPwrT+5f6p73U69gYo?=
 =?us-ascii?Q?fpbr0VjYU1hw7w0mq1xmhGVm+aAqDo30eYi5RlbZ5g2f9HJGGSf05q0wSlU1?=
 =?us-ascii?Q?W9xxAj84r+BraHOT2rmoI6EnbUya4bvHx+gSbwVNIK19g12yDB+UtzJmjRMf?=
 =?us-ascii?Q?/3z5STduaq+Fy91vutIkMmX1mZa7TNX3EGd7TmF9PTjrrXhQvUmGY7bU1JQ1?=
 =?us-ascii?Q?7+cBlxBOqTbLoqc2sYhHSoeFvOsJMRHD4Sfc5L9Ppqp3/VaIBcjqIp2CFSQB?=
 =?us-ascii?Q?ULG+ivksuNLbblEv//UmKIEXhGS4KZMxmH7EjROstSJYHDevudJdcxqIyr8A?=
 =?us-ascii?Q?H9IKEhx3hFals+N/Lfa+Z6KfjDq3Wv8P62vhV1IBTLGRBu9vRnYv1MzaMMI3?=
 =?us-ascii?Q?tlaTthBmj1m1vSej8SVEt0ulk1QGaYfJOEh/81sEUHb28sQ6j5r55yCSKtaq?=
 =?us-ascii?Q?o45aQoRbpm2XDSSpn3ldG0w0p4vsEOhvzVBhdoQuxhuXnl6uI/13OED7/J0+?=
 =?us-ascii?Q?5BZ+KAHeBtRSblrWhQbLJMf6ics611fbn3Jf1M+Zgk9IrV0nZeaFUNOYMTYy?=
 =?us-ascii?Q?4ePITDW2rlm8j9dkuf/X5U//AAiJOq2+89BE4c5GV4Eq2ve5c7Gan7cXCBhW?=
 =?us-ascii?Q?ndhm3i5aGU21WekBLMqQBBmyaX+CcQnknXG04xEQDZPSg3r8zvv1L8Ia3tgN?=
 =?us-ascii?Q?TySP4jB6LEAZWs0Zh7abeKVaaYYpkIwttNmwou5MB2jGXUwrDcNlp5S2O7mz?=
 =?us-ascii?Q?n8C0TBx5xAa0yx7U8G7ML4JaOdxO/U4yGTqZgrdowjj6TCfETo5nS3VFeN25?=
 =?us-ascii?Q?wchJ8FEGEzYtdlINKkEFew61Nt9fnKaxVY/LZm38Qrmf/0g1YklO3SEdLmtO?=
 =?us-ascii?Q?8f7aCGMqcT4P347FjUSJIkChJLSNyKOn6/SbYrakTmJFuI6m+vjbSD4Hlo6O?=
 =?us-ascii?Q?MXW9NfaXEdXr+z3UvCpBJQl1pW+MLjqr7qKma+yp8eMo/zpa5OC1dCfF1AXd?=
 =?us-ascii?Q?DTC5sFJiOgXOCIfZ/z7GR30IMAw29u5tqyILf+cjidheil/xlL7D/BPerf8J?=
 =?us-ascii?Q?8aUAsgCfxBWU6Ewi+WpM5PXFzofnXt2uv0XrpngxWTICnb3V1LqVdGfRar78?=
 =?us-ascii?Q?BaQGC2rNRTVSNX/LBI8cI20yJEE4JR/LZwxgoB8f//Wwir5qVbGhjZ9pWFAE?=
 =?us-ascii?Q?Ifjo2MVlleNWWZnlUg+bLLDHXvrPxJV75wtlZrAnM6XuiidiJyKfdqCNFU9+?=
 =?us-ascii?Q?Prg/qxh2of99VgZu4MA8qTy5kczZSa0XtLn/ckteqzhGrqTk/9bHYBfgL7T9?=
 =?us-ascii?Q?/bBap/L9kA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec0f18c8-ef11-43eb-1089-08df0de8539f
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 20:32:39.8535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XPQ1Z17bGXx3AGOCIra+Tj12sOVmcYfBMXyCu20LbOe2GyKZcAOIMrvK3+RAzGfbsx/ctkBmapDy220CqbdQkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB7126

The "module_blacklist=" command-line parameter allows administrators to
prevent specific modules from loading by specifying a comma-separated
list of module names. The blacklisted() helper checks candidate modules
against this list using a strict byte-for-byte comparison via memcmp().

However, the kernel build system normalises module names to use
underscores (e.g., "my_module"), whereas administrators and user-space
utilities may use hyphens (e.g., "my-module") interchangeably.

Because of the strict memcmp(), specifying a module name with a hyphen
on the kernel command line (e.g., "module_blacklist=my-module") fails
to match the internal module name ("my_module"). Consequently, the
module is loaded despite having been explicitly blacklisted, defeating
the intended administrative mitigation.

Replace memcmp() with parameqn(), which treats dashes and underscores as
equivalent. This ensures that module names match correctly regardless of
whether hyphens or underscores are supplied, matching standard kernel
parameter and modprobe behaviour.

Fixes: be7de5f91fdc ("modules: Add kernel parameter to blacklist modules")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 kernel/module/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index d0e1e0bd2ad0..2b708c59f0f1 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2942,7 +2942,7 @@ static bool blacklisted(const char *module_name)
 
 	for (p = module_blacklist; *p; p += len) {
 		len = strcspn(p, ",");
-		if (strlen(module_name) == len && !memcmp(module_name, p, len))
+		if (strlen(module_name) == len && parameqn(module_name, p, len))
 			return true;
 		if (p[len] == ',')
 			len++;
-- 
2.55.0

