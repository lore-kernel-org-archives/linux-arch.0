Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013056.outbound.protection.outlook.com [40.107.159.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4DA430CDD;
	Thu, 30 Jul 2026 13:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.56
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785417164; cv=fail; b=huqQ/+1k5HKfts/O9bdfD/NwLlqwD+nqhyHMFH8VZL8gwZ7UkYIZ4HB7LHpG6xu65/O10/T1cN4ojSh8yhvwhA7S7qJU9F+r685vHJFDBdIuQIjQJJJgIaCk189Xg7dOPu0EtsiiYxgzE+1ig/7/bsA0LTlnS7wHnu66/FAU1tQ=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785417164; c=relaxed/simple;
	bh=bpn/LFLN3msSY6Ht+LB4nxVHc3r1RmBrv4r+CAfSmdk=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QZypxWgxEDTs7bDns4lIfecMd7z/IPqriCLFa5F7uRF8IVTdZLxcF0AWpOBEkajjrEpoSzgG6sMIOdboG2kuTfH8KPYDGxkjCT06Xf5+hpccZlvMUBBIpAOFVJ26svOvj7riiWGwG9kt0TmETe/kRYN7yzhO4epZw4Nc/bhIqm0=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lJAVj20T; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lJAVj20T; arc=fail smtp.client-ip=40.107.159.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lJAVj20T";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lJAVj20T"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=pEc6fa3mEJOvXiB224Jt+RUwMBLfyyppWSKKSlGBGDlBR23quMtPG3UMWAgFfn/F/iPOxpvZiAAlLgtSkGw+WSRH04mGi2zJZNbJUMEkRjQFPmFqeclv35FY7QYuqtvx2OCky+ssKX16iUQTuKjH5ylyI6VH5UzYYuhO0S0cnZgI5MIpmYsXN2O7kdZlX9NVnSykOj+nhfw5CGCbSr1c1c0FBfnp97vulyeo8chu8FYxIQjCWA04bEETvPqw4SzhBWWn6/olEoDw4t2Evs0ISqjm9HrzCjL4vaCtWw2wE90bnQTzClcuFHj2AtntpqGt9xfi0AT929dN72JYmxhqUQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQZW+B7zgckTDD0haxJi9xCCLpf7V5m2hM0k7yoDU4M=;
 b=vk69tWtE6zg7lIV0xZKpGypN1G3XMmiiumB/NFz7fv3UfBhCiOxt1E1+58F/mC+3eYSn07CVbZgz0VWbEfR7MWuJj8L4LTaaWro8YeisDAJqrOACvBT9Ier3hhlf8h/TPufDLjeD+H1FnedvG5Z/O1QNIG4RuMkXuYmOCelZLXW0QAFKj9Z0cfIVR0EORlyV1RHayogu0Z84X/EmfoROUMGBOyog5e8b6u3EAcMdBrO7yWmlzMB+7uOcC0Scqo5pVCKD1xnajtc9rM/1d3IuY8olsE3xM4DaLlMSYos8sWQ1hsVq4ywn5MuIZFtyErWqDX8reGQiOGj41QMaaS7X8w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQZW+B7zgckTDD0haxJi9xCCLpf7V5m2hM0k7yoDU4M=;
 b=lJAVj20TaOQoNE2FeZbkilvS81u7tHGQZ3LZZMIShp1rOXFQDO28HhereLybauXTgTLFkKhUqGQp/vI3TCRyw1s2aeDxESh77xfSSMQxJkVB6e6nJ7PgVVvV/QsyTjX8EEHGerKuQE7S6/DeeMbekH16okby3YYu78cKGgsSA+Y=
Received: from DB9PR01CA0002.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::7) by AM8PR08MB6548.eurprd08.prod.outlook.com
 (2603:10a6:20b:314::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 13:12:34 +0000
Received: from DU6PEPF00009524.eurprd02.prod.outlook.com
 (2603:10a6:10:1d8:cafe::3f) by DB9PR01CA0002.outlook.office365.com
 (2603:10a6:10:1d8::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.14 via Frontend Transport; Thu,
 30 Jul 2026 13:12:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF00009524.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8 via
 Frontend Transport; Thu, 30 Jul 2026 13:12:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRaIZg0OtleIlPYF9fRGjQgEDulFFA4oqKbKEgDZmJsS1026axwXb3wSL8u76K9bcnOfOdJDW0J8O9Stt4YwDTwjWhsz0Pf/JveP07mUskfbm01vTppSS6Mx7xE7HgtA59dH3bFmKGPAzdtFDW/SgGa/WtIYKL8Xe+eepsiEELlhSQKbGBR4w5nwPWO6+Gq4CjBtrjfupWwR0xOlTcc/J2UiSSdmDhWQH33OAFaeImWgvP1Pxq+7zr3FcHdBF9/Hw9uZprvjXApXb4ThZuunrxgPnSYkKQAcWF39sJXBJTGTrLh9OlRMF6WT6KKrBc3fxmJrbO1Jf4nBp45ZukFwLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQZW+B7zgckTDD0haxJi9xCCLpf7V5m2hM0k7yoDU4M=;
 b=YOToT8jlJfifOb3Pqsmabq1zSS0Ji07lJFrUlvNbWkaZkCzsyYLnfH8r/PL9SjNAgs7OoAFXoL6Z0ZXDuSioc2dvGAfYJXxKb8v0IzDHDti3DiInLnuUQdlYEGlYTHLob8rV7Ptz4vpOdZ8ZoemoWOIWWqv6gY6cYPDF6HP2oBe9qnoXSbi+SiaERsuHN2AR0glncLLkIyCO2gn16MLgU7ZmprOPwox536LYo0/j6ZZILqA0lNNdgs9I4zoQqLvTeg/o2gJ4oDtbdfutyQuylCowSyIU2E2mtOjmOSPQ0YMGfrZm+y+nphPvk8wcf7YmOFPyBklUOGKgASMxnNKJgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQZW+B7zgckTDD0haxJi9xCCLpf7V5m2hM0k7yoDU4M=;
 b=lJAVj20TaOQoNE2FeZbkilvS81u7tHGQZ3LZZMIShp1rOXFQDO28HhereLybauXTgTLFkKhUqGQp/vI3TCRyw1s2aeDxESh77xfSSMQxJkVB6e6nJ7PgVVvV/QsyTjX8EEHGerKuQE7S6/DeeMbekH16okby3YYu78cKGgsSA+Y=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com (2603:10a6:803:80::16)
 by DU0PR08MB8953.eurprd08.prod.outlook.com (2603:10a6:10:464::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Thu, 30 Jul
 2026 13:11:27 +0000
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4]) by VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4%3]) with mapi id 15.21.0270.009; Thu, 30 Jul 2026
 13:11:25 +0000
Message-ID: <2203157b-0a88-4f42-9c15-b1696614d74d@arm.com>
Date: Thu, 30 Jul 2026 14:11:22 +0100
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@arm.com, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dimitri Sivanich
 <dimitri.sivanich@hpe.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 David Hildenbrand <david@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, SJ Park <sj@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
 Mike Rapoport <rppt@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 ziy@nvidia.com, pfalcato@suse.de, ryan.roberts@arm.com,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-parisc@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH RFC 06/11] mm/kasan: use hw_pte_t for the early shadow PTE
 table
To: Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260727164715.2866609-1-usama.anjum@arm.com>
 <20260727164715.2866609-7-usama.anjum@arm.com>
 <e3bca247-0644-48ac-96c0-ea69b23cb11f-agordeev@linux.ibm.com>
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <e3bca247-0644-48ac-96c0-ea69b23cb11f-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0481.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::6) To VI1PR08MB3421.eurprd08.prod.outlook.com
 (2603:10a6:803:80::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3421:EE_|DU0PR08MB8953:EE_|DU6PEPF00009524:EE_|AM8PR08MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: a9915b72-a3d9-48ae-0244-08deee3c384d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|23010399003|376014|7416014|1800799024|6133799003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 A3geUA+4p5re27ojxPsMilqcXfe8IJ7nI4+D10DCbVZaXhB1UI0fkgENFQvlp++zbEYirHCtgaZUBpLkHWwrCyQJohIneLa3tuj/61DV+DCJVtR57C9dq5LrHAO3sVqaGvZsj5agrY63c5wMB1FR94P3Gt7QhDVLu5cACXNz534fif7gHSgBHK4wBj3h+q9jXvZbde2gflnmlDEwIMHWS0CAGcVQmoH4PhIQio5UvYBKtwdbHGZpi1MSxg80hZ+ZEX+SVgRJKVWbPjuamkmFEcQ4ls+kIr1ODilp9YvLSEyrgexN56udDGyGcIqxKfY4e5NZ4fUEDH10iSh2RjToHcMrSHqXqBfgg2LLdBwIOaK3xYxpTPLWMN2bd27YZBI8aiP3Be4TFTH2Wkp2J4FooGl3lhPffk09pQIv8KIheJRm3zqKzuaWwyPSrO3CzGNlhacqPW5xAZLvsMRhZYvX/5yVF6AKxLj2uPOlobCeKhy6Dl5yEcSJw/ukaMhmKrfDHu1chfllhaf33QukxyMjKGqi0GsNliwTww1ocVnCmbokO9+67cjdNU5uHB5NoaUXF2rYmNL8wSXTUmVIllDikFU7cWnCwkL5caa4nfmRpKVxHpX/joTt0HGkJecPkfvS+3pAikU9LsvgbZbONBulpswO3cMkybt56JsNdI6vaC4=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3421.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(7416014)(1800799024)(6133799003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 pGNMqoFxLradfRwtZU0HeZlDsmECcdkuaLVRTDL6qPOVnXuuGO7JtOkW/QGzUUum40KYRW9JE20k4bMoR/JVQObFFCh8SMBrJ1LKWlC5KnzCtIAjzTMrA0H3bIvy8aY4tM/+cKxg92fwbS/30ixXRzG7gDQiNkih2WzNy/tDl0qoZIhyA42NNxZ3qW21lYesTDKEDV1tEelcwrj1oVNVNsvC2OT+2Lzl/cP1yigX71cV1ujvMIAZXBkyN7kxbJ614cB/v/WKUu+t0qcy9ChYHwAbVmAlaBlARTkZ3Q+TX+IE7vnN8i0wbCnaSZactLK9TEIfnJmqitXZEm7sIcZOIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8953
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF00009524.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d350bb23-b4b7-48a2-6f00-08deee3c0f46
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|14060799003|1800799024|23010399003|376014|7416014|82310400026|35042699022|11063799006|56012099006|10067099003|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2VYZMdAeudjMl+4Dw1NODUR9sYMjct+es23eEH/LR/ozPMPhRUjz1GtgrsImVSOeFq75OOzYFfwcfJn77IVzjEuRpBJrVLdP8r8VFlbizJce7FbHP0CH7qcv2f0f2hOVqfBpV5EFL+Q/g/LWYR4QhNTKzDoBMMh/4dEzT/5An9FBBvSKgNbYSma2tXuL7ZhJBIFmF8VNoRNQAdOt6R24wPFIUrQOpvIof8lEphqtXIhR0XOFqQ9oa0gmfoIbX8ZvBsGWSheTDicib88lLGXV8EvclaB4A4kWb6Qe+HaeCgB0n/Dmn8E+GM4SD0TKHI5ysvyI8LPCqR9fqXifYAZMJGDTdNHJn0WLbcxxGymSePQG1hUoAAUrCkOFk8NGqFG1T9Nhe2xlxdFHpFVZg4YUgV23c0h5XTiPMW2jtxwXL3DNFvfm+x5uzppT4S+qpi/ik5RNVttl0/WzHJqCoBWJPxkmrCbHWev3squuVaSIsO0fbgQh1qxCLAIp4JISKo6Afchf431Kn7rllI3xeGpFSO2ZEyidRDxVi7Q1hGorY98tPhXTxqJMJ6bd5AHkmAcVOt8DpkhnZzs9GgJiUi8G2u2rtiq8f4AmhWpOMazkKyDuGtG9aPBD4YQSoeQoXcOV/8qHC9LdGdPbUuRHQRQkOkf9Iua7eHmazLLcCED9vpqtETJXE4MllD5+I+L238F1N7TdIqU9yQp9csPwCZEz8w==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(14060799003)(1800799024)(23010399003)(376014)(7416014)(82310400026)(35042699022)(11063799006)(56012099006)(10067099003)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ysRyGaFXeBl76+d9ZdjYsPiabcZ+OXNtSjZrivoKU+JFNPFEGnvPH5X3YJn5bdOAE8TEGdpenCnm1eAdX+DGF5tUTawanZZqgAH2UoB2xcteoyfORc20iusBxBgLq2vlEgfx2ZUT8g/nUESSV7jEiZm5awYxBjtBBH/Yz3dn2mcbD7gDaYSzo/FiDYujp7WiwXdFiaiYQgiuVBQLOruAfjGdVI7CFcE7p6Rk+iiXvZDVW3Hhh3FLIJeosBx5Vj2HQjLFCSKYrh4EwWJm9LPwHHYfMMfEjQ6DjLJ6zeiA7vdnrEanR7eMal7vBarvuU/VOezPAu+GEab0JnULqd+WqDHtbf3fJPoW0cdwASIO8LbpLV2/aQ9lbeYFeIRI0DZmnksO51luoBLTB4PxbNxvTrzJE0Y3ugJJimkmmZuOUzYs8ijq27WR3egnyO/XBSK/
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 13:12:34.2554
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9915b72-a3d9-48ae-0244-08deee3c384d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009524.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6548

On 30/07/2026 12:26 pm, Alexander Gordeev wrote:
> On Mon, Jul 27, 2026 at 05:46:57PM +0100, Muhammad Usama Anjum wrote:
>> diff --git a/mm/ptdump.c b/mm/ptdump.c
>> index 376880071ca2a..8f19f20be3c44 100644
>> --- a/mm/ptdump.c
>> +++ b/mm/ptdump.c
>> @@ -19,7 +19,7 @@ static inline int note_kasan_page_table(struct mm_walk *walk,
>>  {
>>  	struct ptdump_state *st = walk->private;
>>  
>> -	st->note_page_pte(st, addr, kasan_early_shadow_pte[0]);
>> +	st->note_page_pte(st, addr, ptep_get(kasan_early_shadow_pte));
>>  
>>  	walk->action = ACTION_CONTINUE;
> 
> I suppose this chunk could be posted as a follow-up to commit c33c794828f2
> ("mm: ptep_get() conversion") independent of this series.
This hunk has to be changed when the type of kasan_early_shadow_pte is changed
to hw_pte_t as note_page_pte() expects a pte.

-- 
Thanks,
Usama

