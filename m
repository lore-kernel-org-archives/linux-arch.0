Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011049.outbound.protection.outlook.com [40.107.130.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F063E49F2;
	Fri, 31 Jul 2026 10:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.49
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785493257; cv=fail; b=aPa/maGNfBXYfPc78yFIswlSBCbb17b5Q63AqmEl6qpnWT9v711B0CDVSZEtJltdUbC2knN6uUFNusEr516olmASCWoZiaxOb2PVBdu2qXff3kWriY4m+OlHUoU7koHvnuub8M5Z4qZ4CpMVUXb8W7bUccKfp3Hm/HzsaQps8vE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785493257; c=relaxed/simple;
	bh=G3Eh3IC8JdoxA1wfLL1nnEp0F/oOArq7XJw0erj29AE=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h/OjlypPYgvSARCV1fXQzKxyH2P6znM/4pVWeT8xlpC75w2y5U2RXMGC6GBU6i6vRIJSImRYEc72eYBdl5IJrsgNVSAx7Y52zAuJoPQiTk9HAX/lBHgYcd3GTDnKnC1HtMeAmMcc68p9UguqAGYGXIXwo4UR8QS16JGHg3gZ9fU=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cB5r1Whn; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cB5r1Whn; arc=fail smtp.client-ip=40.107.130.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cB5r1Whn";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cB5r1Whn"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=tfvxCysufYP2/Aj3rVfYlV7QM0IRfSDedX6Nae2AXjuVqubo/fX49ecMAZMlOqYh6nAqbPlpyWFYfJ6Xe/wr2IQBQ4t18+oiY2ak5dVmQCr7CGcHYr7gpW8pMpps5C1itk+U84qnS3ZVx3dBnkkTHTPi6PzVxv8fwY4n51ZFZm1SzGNmUChbia3+AbT6aZwe8o/3fHUVFk47H/40wPo8BopKtw807TAEp2z2wKVP2JKL3Yy18UBT4oh2HbB59Ak7qufDzfCAS0QEwbh8KLm1cNh3yBrXoQaQuxocVrTmacM7RayClBb2TLPBqt39M4dGRsu6HPkIiDQEXsObcrjsWw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9bGte8eqdxuMMzc6Sl3gDguhLqQI6GBUeVCbvVeu8A=;
 b=mNVZB9SyaxZ6Xj3wn+Uvbe34FtEqty4UzniTgmvDHVr9e45fZgqPwaAFPghqIw14E3asWrQiCwDRS+BBwXiGVYYh0qmh2cuXkIUy3oFKPbeQ6+OIpVJbUdGj6kOth9oftC+QcdGgOD4Br4SwQCoAReXhRmyhDqHHszC2ySV7Wv7GMwtkwVbzAbLX/p5hHn0Gsg0/7Qctu2XiVyKYXf8X65hTZ4+k+cWUFnN3H+W2aB+PWkI5YxQaUw007litHRpBC9qT+02G9Up2v0Kryz5Rir3ei0bym9uVKBkM4XQHkJGPdaLBw6YAro1ya6MC+FhBsWw28QTKhKcwzKPmV373+w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=suse.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9bGte8eqdxuMMzc6Sl3gDguhLqQI6GBUeVCbvVeu8A=;
 b=cB5r1Whn7zm4IjrU8ljCV0Q7/8waXW+Snz5qDVSFDT6iJQDf0Zs6ZV0KTsHR/rkcn4OBTHXCurcfBr79XtPVWA0L5Wdq7yzDThpWX+1uv0kvDXKB+/ZRMO+e2OcLAUCpFyIKwzCRYSTg/RxY/sHXEpuGqUrl+r5LTCe6RAf2ans=
Received: from DU2PR04CA0220.eurprd04.prod.outlook.com (2603:10a6:10:2b1::15)
 by DU4PR08MB11717.eurprd08.prod.outlook.com (2603:10a6:10:643::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 10:20:42 +0000
Received: from DU2PEPF00028D04.eurprd03.prod.outlook.com
 (2603:10a6:10:2b1:cafe::62) by DU2PR04CA0220.outlook.office365.com
 (2603:10a6:10:2b1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Fri,
 31 Jul 2026 10:20:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU2PEPF00028D04.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.5
 via Frontend Transport; Fri, 31 Jul 2026 10:20:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RA36WTR3u3SMRbdo4Q+GY9qftlofBtyl26SpHhVA1QL3wPiNHvi7neI8BbiGFjcNhz1+h1QDKcE0ZH29no90uYmqtrLrQnwRJD280YKRU7/gqA0+0tIUTJFKURvMSdpBS7eVPTouH84B16YiKeL88sietYvZ7XOa71dlK+ScH4hQhGonkDNwW4F/HaN4Nyh4duISMR/oBfVW6+GEH+aluV/FbgSsThnzenNYe2xxWAHtZIGyfkN7TPij1BBo+UJtNXsts1wyxh1TmDRLjnx5oc+i/7JjfOgPTZwDIaMTQt6vUTHSC5NoadpfnbkxWOFTla/gP6QR0jbh50pkYvcHGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9bGte8eqdxuMMzc6Sl3gDguhLqQI6GBUeVCbvVeu8A=;
 b=g05P1/GLRVOKiLbD7Hb/VMYlyYCDfmaEF5OIYvGINkGPWcIpqHcFwbqMc0/AWM6+ODDDSdiJpDyVHnpd0FgL5QoOLa4CXqhA66pWz1YIkKejm8m0xccvKH5Uf2JK2DOaHrqRyEuyXM/tSe6/2ajwLwYxrWeEAzDI60Z1jX6CtU0kSJzN1NDxpWBMqJfRS4KJG6uG36/NayfVcXgpDfQZ0uiyJynnKgLdvaqB8OMJbDhMLUfxgeKSCY1pf/MDs5FtIpO0SH5u3N668OxAR5xp4xyyRMpEpZ+kXYeUJ1kqePf0+jMbrTuI7OlNQsxC6CaqVaoszEtJ6wUT2nO3X0+cmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9bGte8eqdxuMMzc6Sl3gDguhLqQI6GBUeVCbvVeu8A=;
 b=cB5r1Whn7zm4IjrU8ljCV0Q7/8waXW+Snz5qDVSFDT6iJQDf0Zs6ZV0KTsHR/rkcn4OBTHXCurcfBr79XtPVWA0L5Wdq7yzDThpWX+1uv0kvDXKB+/ZRMO+e2OcLAUCpFyIKwzCRYSTg/RxY/sHXEpuGqUrl+r5LTCe6RAf2ans=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB3410.eurprd08.prod.outlook.com (2603:10a6:208:df::33)
 by GV2PR08MB11278.eurprd08.prod.outlook.com (2603:10a6:150:2f9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 10:19:34 +0000
Received: from AM0PR08MB3410.eurprd08.prod.outlook.com
 ([fe80::b6cc:973e:a807:c3d3]) by AM0PR08MB3410.eurprd08.prod.outlook.com
 ([fe80::b6cc:973e:a807:c3d3%6]) with mapi id 15.21.0270.009; Fri, 31 Jul 2026
 10:19:33 +0000
Message-ID: <9ac33752-b587-4901-b5f2-473e573d7ede@arm.com>
Date: Fri, 31 Jul 2026 11:19:32 +0100
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
 ziy@nvidia.com, pfalcato@suse.de, agordeev@linux.ibm.com,
 ryan.roberts@arm.com, linux-kernel@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-parisc@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-arch@vger.kernel.org, kasan-dev@googlegroups.com,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH RFC 01/11] mm: introduce hw_pte_t for PTE table storage
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
References: <20260727164715.2866609-1-usama.anjum@arm.com>
 <20260727164715.2866609-2-usama.anjum@arm.com>
 <6xah74eadjmo2bozyr62wcxo4hhpsiufx2mshh7tztyy2dzzps@63m327m7pl5u>
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <6xah74eadjmo2bozyr62wcxo4hhpsiufx2mshh7tztyy2dzzps@63m327m7pl5u>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0321.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::12) To AM0PR08MB3410.eurprd08.prod.outlook.com
 (2603:10a6:208:df::33)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM0PR08MB3410:EE_|GV2PR08MB11278:EE_|DU2PEPF00028D04:EE_|DU4PR08MB11717:EE_
X-MS-Office365-Filtering-Correlation-Id: b9a6f79d-2568-4a69-150e-08deeeed5fa6
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|18002099003|22082099003|4143699003|11063799006|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info-Original:
 N2wlK7+ZRozJGmK0N2Kg0R4yJ5wOgZ0BD8bcmN9ckzK3UKJ2F4czXbrv7jZaWgvVUj2tZLGIy6TXZHVj8n7cCBGjmutqs1o22knL3OyEpVQm205U7W840n0BzB93Ls3ya0MZ3n6q0MiN1ZCHJEdhHH4FmcCqbn8amDqXdOS2JFy534KAR6w8Hode3mZKdiNOi4XHA4EMm4R4NmgNqv8BTHU1o1mrdwRGbDcLLTL/Uhcr5Zj2H23tyNGUWdzcb9/6Z+9bMpCyFaPdcHduC8sbRRNlTmKgEgaDWxAsRtFcZniZDxYHOO0wMLuvu/FIbZEpfc9mggB79qJPf78hwUaK6sCBMcFbFO1lIgj/xFLfWAMPLe5iSzSFLg+eGHiNLL7zlhllC5XRJ7sba3tAP1A5lpnMKQQ5InaimxmgfYr2EcWK5+6aNVUYhSXkZdPq7CHlTQ18QsDrrhmDdOi8MKesiDc4vc9VxGb/uuv4aw5rgyKAM7jO0sO/zN+AdxTpB9Vtc10PElC4ddyBnsaMt+zoJSiIhtu0ZzbyjOzgxOvSTZh9hr8fCJVH9BN7z4kFR0HmSW0uqGKEUsWoW1c6OA7FbV3EauzK0vM4jQZyqMS9znmYSKnSFtSl9lnT1Aih3rkG/pMOiNT7X9Xk05Vfb8Gxfo07Avde+ZzbUlyDqgQmWys=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB3410.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(18002099003)(22082099003)(4143699003)(11063799006)(10067099003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 jppYn+MrAjPlJcJEzGfQ1jvETR90CuL564Cvd3s5pQpSXb3FjdEezsTcu1l7Aw7vpXIhIhpPA4Fvjw06egzld5SxxNDODfBO3WGFQpssEDJnL8PWJRIWECUYo7TnCKu253Ngg+5ToeXKLgfCk4brktdsgrj7zk4W1crtnbpBsYC4BT30W2CElHRbMGQdk/8tVzUPeMqdRQtqQ59xKrgLxPMc3xsyjg/9StkRA3HpzyMoGJG+NEI4gVuZt6ij1C/0H9fj2NUUWGDqXiOrjsESkwvO2Ls29lOKFjcW8bSAMO3Y/NNJVoKjg8ty9x9AJ/wLhzWBu8NL0DMS7x6LKw8FeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB11278
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF00028D04.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8eb83e79-85e5-447e-8f2c-08deeeed372f
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|35042699022|376014|23010399003|14060799003|82310400026|1800799024|13003099007|6133799003|56012099006|10067099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	+cxUqkDAVXwJfo0/J+Unmn/UU7Qxuv/kG8jo/E6OUUholiIyLeeBG1dyUMGC+JTI9/jnKsgcOlSVUIBuMMp3/3ikCCv2hJ/V2g5yI1OLgpVuMK+GMlXGoJtSKO1RMevMxcrfaMZou7AdqgeW2JMX0/XGmyl0uMrkiB9oKgwkc3A63dlnJXUhvlQVXVNxDZt6eywKtDPuF8dUfhX0VF+bXa6O9rbSBVEymm+otUnW1knYJyYfyibDgoQMKcfmIdMEqSoJLQ11wplggq5TvNEDSxz7teq6AUCxWxMBBZVFyaP8PVD/04Yh2ME91ljkkyWMpDlxBIUY8opxOs0RLDbXZ/Ja2cbme9xQ6tbxbWQTrGqorky5G2ImsDl1F6GCBMknxiouThBH4HDrLiPURJtdyNY6JOepeeZyOQHOBLfmJQRMsh1O5L+y5ZUFHC50EF1Z54PU4auvrz9v3uu+cShBKToUDud39c30jHhrAI6XYaXolrZLzMmJtESd9+1DR1bQfg+V5fekbrMwodajnxapLGRksztZgQPm2BJ76/syx7w3iVWoZLJ8ARJhmzWnsmgyCPKnMtkFO67yBs+G2E2F5gRyAouK63Bt/OYPIAx8k+XFNslT0pGZeinwIQ0zoPsizMRGODBD4XgLp8hD2elCKAETHGbAIZ/Zq8dWJhpohwnTgqc8vFEGqKUnXtJIV7qEN5eKWDEvXQBX6SXujBOsug==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(35042699022)(376014)(23010399003)(14060799003)(82310400026)(1800799024)(13003099007)(6133799003)(56012099006)(10067099003)(11063799006)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RBLROo5LiXS9uRgF34qTjim0wy19yK/eljpxXW0xvMggAoapFBz7lMXDw5Mwvqv2Fs3OGn1gD5anpvnhGf58NYa1Tk+IDYCnJ5kwjQkQ/koCnaFQp4JHJ9KgOIXnbj5bHJd+BEzgzzkuKX7a/5n9xPS7GbQDLZN62PaLbQxFVXUgYRkJR9ggJeHL3xiLcIJ5MzT62aKAKva3MI16Rc6y9uurr7Hsm9UGFdmC+GR9lCISR21RBLN+na/snbZrYb57C6grujG9yUHTbBopj+KIB10zX8OWI0IunkHd2NFpteTKd8WUZ0arTedwGYlI5/dETTMvtV+hj+hCWxB8C2Xb4PMbgL5u7ZD4CkT12KrJecNDeC0MEdggInAVlZv2peDghr0BwJQEFld88znFQL2v8a1OF8pRuyTqfhrvVZTPQUIL4KlUpwX8uk7u5PiNHSSD
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 10:20:41.1870
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a6f79d-2568-4a69-150e-08deeeed5fa6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D04.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB11717

On 31/07/2026 6:49 am, Anshuman Khandual wrote:
> On Mon, Jul 27, 2026 at 05:46:52PM +0100, Muhammad Usama Anjum wrote:
>> pte_t is used both for logical PTE values and for entries stored in a PTE
>> table, so pte_t * does not distinguish a pointer to a copied value from a
>> pointer to table storage.
> 
> Should we rather call them as "Linux PTE" and "HW PTE" instead ?
> 
> Some like "Logical PTE" does not really sound very clear on what it represents.
Yeah, I should make distinction more visible in the cover letter.

> 
>>
>> Introduce hw_pte_t as the generic name for a PTE table element. Define it
>> as an alias of pte_t by default so architectures retain their existing
>> representation and behavior until they opt in to a distinct storage type.
> 
> Makes sense.
> 
>>
>> Include asm/page.h so pte_t is defined before the generic alias.
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>> ---
>>  MAINTAINERS                   |  1 +
>>  include/linux/pgtable_types.h | 11 +++++++++++
>>  2 files changed, 12 insertions(+)
>>  create mode 100644 include/linux/pgtable_types.h
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 15dd00c7ffec5..78aac05949829 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -16981,6 +16981,7 @@ F:	include/linux/mmu_notifier.h
>>  F:	include/linux/pagewalk.h
>>  F:	include/linux/pgalloc.h
>>  F:	include/linux/pgtable.h
>> +F:	include/linux/pgtable_types.h
> 
> s/pgtable_types.h/pgtable_hw_types.h ?
I prefer shorter file names.

> 
>>  F:	include/linux/ptdump.h
>>  F:	include/linux/vmpressure.h
>>  F:	include/linux/vmstat.h
>> diff --git a/include/linux/pgtable_types.h b/include/linux/pgtable_types.h
>> new file mode 100644
>> index 0000000000000..ed5dba42a4f8c
>> --- /dev/null
>> +++ b/include/linux/pgtable_types.h
>> @@ -0,0 +1,11 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_PGTABLE_TYPES_H
>> +#define _LINUX_PGTABLE_TYPES_H
>> +
>> +#include <asm/page.h>
>> +
>> +#ifndef __HAVE_ARCH_HW_PTE_T
> 
> __HAVE_ARCH_HW_PTE_T macro is a better approach here or a config ARCH_HAS_HW_PTE_T
> based selective platform subscription should be introduced instead ?
Moving to CONFIG_ARCH_HAS_PTE_T from the next version as suggested here [1].

[1] https://lore.kernel.org/all/78a0402d-5436-4aab-a704-90fab56eec50@kernel.org 

-- 
Thanks,
Usama

