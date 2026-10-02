Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010030.outbound.protection.outlook.com [52.101.84.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9D023ABB9;
	Fri,  2 Oct 2026 15:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.30
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790954056; cv=fail; b=fHkFVWGOO0CV+Z+m4BGZFsw94KF4La8xbm3IxDjtSoC3yuph/PVJYscofAmu6TVg6gz29QLL4VbaG+t33xMURayGA4wm8jVSu1MonvWQ4+OmW13tVy3YNU9UsdzSxXRFM/B7PqFTiHhbA9FDpA+vCwsSvR3+jXj3+CWD6lIwsbU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790954056; c=relaxed/simple;
	bh=/BcyJcHb1pOu8gCrkpafap36JTgtru7MG3FqW8/bI/A=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=haz9GHQy4nth9It143fjk4s1TRBFNVDoTWgCR82NggapqJiOeaU/mhnuCLFfCUpi05O8dIOdfTFqEL1BuLWM60MhtGNUySuy9Y1qn9b5El2uxIuzQTfR4RtolIPDR7JJjv2D7LpoJlIHJ+9wOdnTgBlK8y/W77gkldRRuXXwVlE=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UJcWlmHQ; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=UJcWlmHQ; arc=fail smtp.client-ip=52.101.84.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UJcWlmHQ";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="UJcWlmHQ"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=DI4gBIOBFe1jnFnrysZMcSksAW/BrF9bkDTF+ZxLsRw0DCXiycennxSkUiALk9ein2IWvS6Myla2zSK324f7TpNLieldvMdZqPr9/e2nvMu9kNAtBt2twiTVQw/oavBtYxUCQTtEC2YCPaDkYZ22a0+E2J43ccGbc/zdPVO+JcULulPE7z6PoNmN21sagJ/8NrgyVGgvFbxv46/dvAbQTtidy8JYX1U6/ovNomjySRE5nJzaH4Ctm5AQmcxJdua76LIEHB0BSNf6fVCvAGSpFELRz36JDs/lV9PeGcUYPnjnjy1HdJf+bC1WREeBcMcV2JW0ChG8aCF3mITsClBqCA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3Ah6swvMtWzeWq4SM6XIIUNRxfAhr9a8O2D5gmTT3s=;
 b=EwQJlOwyoFbiPNVyr/vkWSS3sBKpAF7o+M9wISzwyURzbKk7MhSt5FRS3XxbrOQCbEHeRknEp2fK2unzLoGEySsDjPkTYb61r9QWtKip5zQE+EhGeKh49EFgfhMv447W+9reEWcJ5Y2J4v1+Z6bmEbNAbcrd6fhWUXUZca1G8dKOUVNd3CxGTBDNxbZn0JJfBSLk4++8pI7wnWguLghYgn0eA3EZNXDawFqRWgIZu57g6Nf7nCL2nI7l9SdIoIkjss/5UhQgd5e27h4J7zR4zpaP5eRqSBgS25btijTZPLodUCwmR4zJNXFqOEJLJPocqT9U+RjgrrSpNK+7saUv3Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3Ah6swvMtWzeWq4SM6XIIUNRxfAhr9a8O2D5gmTT3s=;
 b=UJcWlmHQHD1z6UzAsf0AsXyWIx/n+YuOAR8uwm4lC4UsM/1VWXYStnqfg9poduspEls8OzGsiySlaYVY4oB/MorRmaNyIUCPBYKvmdCg1HJJnA6z9kcFuEy2+Bcb0H0JeQMlbUZK8KivhGoCbOw4ao+1HjGBB/BvBK2I1xV7EEU=
Received: from AS9PR06CA0006.eurprd06.prod.outlook.com (2603:10a6:20b:462::25)
 by VI3PR08MB877902.eurprd08.prod.outlook.com (2603:10a6:800:379::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.12; Fri, 2 Oct
 2026 15:14:07 +0000
Received: from AM1PEPF000C1ADA.eurprd02.prod.outlook.com
 (2603:10a6:20b:462:cafe::97) by AS9PR06CA0006.outlook.office365.com
 (2603:10a6:20b:462::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.18 via Frontend Transport; Fri, 2
 Oct 2026 15:14:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM1PEPF000C1ADA.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Fri, 2 Oct 2026 15:14:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qf1ioclt6CZLsZI5sbHKKNFSAw7r3xz4tB6DNEdFGmiWnjOu4Kz4KF+DzZeXzE5HJpiiXiCP6cwF4g3zJGcExLuEFgfePTraNXmMR1pzCXtJmUHpOwPmrQAm+xjKTQxdlPsr63yZOIVYgPrIp+NsWOYn2YTFQ60InG0yTZG6A4lUgPwjg5O+O+b1XpX0MMu9w5zvTTsIgMbeRlWzrAKUkNoa5M+hRFB4VhS6U+h0hDS+AC+S/qFszAb/1OMd47g2tdM2zzR4k5nl6dIKwEj6gXb3kjV/dn6j7D/JTjLbsFRCXECWq7fhORVbvwWdee0fUlbZqXGM1uCj2/n6q30rfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3Ah6swvMtWzeWq4SM6XIIUNRxfAhr9a8O2D5gmTT3s=;
 b=mm5FZi7KiBf/IpnKgskI5Q8S4CYFgRFxXU6qHkW1QRE2f/adMulUNbzu58a7+D0WjlxHVTy5AD1wqskKJmJgT/PUuAJ73Vxc7VP4YQW2xYVzY3IjG3/LZ8NJhFSnF6Hc9YSR4Nvx08SL0aYa2GonfzXPlB4w9sXdtZm1ZDk0okUiaB9SkjKtbnBb2pr4x6XANDziWk1KJCTBDZd5JJB/LR+EgHza5b9XtxD8NX/QLrd9j1x++hHIQqeU+WEKUV4hvepEFdD+ujiQ3dROlfvA28nevX2u3BfGBOU+yvijUYCPmfgzoh8WUR5RVCNDE62BrmJvcSz2tzapYtJkAa/uKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3Ah6swvMtWzeWq4SM6XIIUNRxfAhr9a8O2D5gmTT3s=;
 b=UJcWlmHQHD1z6UzAsf0AsXyWIx/n+YuOAR8uwm4lC4UsM/1VWXYStnqfg9poduspEls8OzGsiySlaYVY4oB/MorRmaNyIUCPBYKvmdCg1HJJnA6z9kcFuEy2+Bcb0H0JeQMlbUZK8KivhGoCbOw4ao+1HjGBB/BvBK2I1xV7EEU=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com (2603:10a6:803:80::16)
 by GV1PR08MB10856.eurprd08.prod.outlook.com (2603:10a6:150:161::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 14:57:59 +0000
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4]) by VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4%3]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 14:57:59 +0000
Message-ID: <72ef1c9b-9712-4e08-8f92-3984de7df54d@arm.com>
Date: Fri, 2 Oct 2026 15:57:54 +0100
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@arm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-perf-users@vger.kernel.org, damon@lists.linux.dev,
 kasan-dev@googlegroups.com, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, xen-devel@lists.xenproject.org,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, Jann Horn <jannh@google.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Pedro Falcato <pfalcato@suse.de>, Arnd Bergmann <arnd@arndb.de>,
 Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>,
 Youngjun Park <youngjun.park@lge.com>, Uladzislau Rezki <urezki@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>, SJ Park <sj@kernel.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Leon Romanovsky <leon@kernel.org>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi
 <nao.horiguchi@gmail.com>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
 Johannes Weiner <hannes@cmpxchg.org>, Qi Zheng <qi.zheng@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Tvrtko Ursulin
 <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: Re: [PATCH v3 5/9] mm: convert PTE table entry to pte
To: "David Hildenbrand (Arm)" <david@kernel.org>
References: <20260922-pte0-v3-0-5670b8cb9059@arm.com>
 <20260922-pte0-v3-5-5670b8cb9059@arm.com>
 <e94dd0fc-3381-4545-9ede-513fcb2b8243@kernel.org>
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <e94dd0fc-3381-4545-9ede-513fcb2b8243@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0501.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::8) To VI1PR08MB3421.eurprd08.prod.outlook.com
 (2603:10a6:803:80::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3421:EE_|GV1PR08MB10856:EE_|AM1PEPF000C1ADA:EE_|VI3PR08MB877902:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e52dbe5-4311-42ef-3312-08df2097cd6e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|11063799006|4143699003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 0dhx1+S2wgcHNIZ4qGb6jCMd5Ad4vFWeOzSxNAuAiD0L95N8XDyuGx6rLwOXJL7u2B3bOGcN89zRKgMuyPe0q6si0B+kude0c+MDcBEnHlA/q073+A9lvG65InILmDoD1YcAqKXz95iVytxna3n1/AVgcSL///yDu/oDy/LD2A3/oeuYF3RLd+KcomCEIDOJ+U20NsbWQ38nb8/1FF5nSorWji1cdy76fj6UJHxl2HtLS5GuGbCZmCeiZ0IBTVXvP7t7613u8/cbaiSstnBCLA7cdi6E3oHaiueEllKmVyhwyqhgKCNR3JnZife+YMG/wgvj4CRGbbFWaSAfx8FF/LUa4BdGC+nlj/TwhYk7sL2ppHk+0kWDxZrB00TJIAqU8RXwj+XQD6LGoCVHyumk4NPvVsAvFFClaErEmd3KpYu9cCHUyiXEb0JCgcnUjE+yFrle3no3zw5uust6hdCiJR5vXYo+VRlN8gPOaFEuycTP9F43C7N129xCbhOnRZ9ffOnIqw0K8+azdr5GDhQ3nN0Gg8xgBlhGYfqgHWJvyox2eRpy8pO+Scq4qgPzsgWxQ0AciYsd47Q6mrpVrNwrScBMOCu1p275K37EQEsJUxo6XQST2AWF2YkEhteHB+GDgIPdIp1vEjJX9pvUNyirTQ==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3421.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(11063799006)(4143699003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 0/bqb1pcygz+orArl2yLvdFr2+CAcusy52mCrAntYx/z75bRz4YGBpeFBJL8hevynK/I35PHi6CiCOo37zbLgE/f/8sDnEada73834TrXRDGWJwPLh16iquDV58pf/xECOVta/qXB5sKLJ12//Iw7Ii4nna+UmtTsAOfm1kJOZWY6FlnPXNZG/LZcW+/ZQTChENDFBhvMyX8Tzm34fTJ2nYi78qbDfS1u+wzyt9EZmdN812OEhJwP3Ijvn9TXiIfZqheZvrMMxs3TlqyiMwWNlknrXvgZmCVyphpy5Ez84SDkEixbQuHGbg+RbATsUJx86/OPFCl60YmuyZuk/8KOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB10856
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM1PEPF000C1ADA.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8e313be2-c88d-40c6-d962-08df20958cb9
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|23010399003|35042699022|1800799024|82310400026|14060799003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QPCFYMVSCrMxbcp6HMqvdzaqGnWXwD0aqJ3cuVTEO9Ua0ljLpQvLwRR+wzNPbPpJiznO+J3oTZnTDBUARwdjz6FZO5XKWYaf/4jdMufV0CV9i0hyyruG0baXVvA/5UnEtDQz76HW4BrJvGNRhtP3BbcQmyXfC6xb4ZmBDvlCmKMzU4TZoFiIGN9BKrUyktnU8hFXsSNn7Vla62KY5uNs/67kFEfH/sHLK6iEUl5KD3p5XxoVkIPAzGtnTyPkNdyOaIsixQcgB/EMwx7tMfOu1fbwLO4HeCkTiPruVqKuOmXoE+2poORmpDBHwixcQ6AoGPo4acVmKaqhf2vifZcOS2ycsIxcgYv5vReo0sfT79rJRfhK2lUILFS0oh0tIUQg07mWCnxiFsob3t7fsMwZH/3T8l4GL2yYRPrNQkOejLhLqTSJHqeBbT0s/ax056kYERWGMemasmPO6V5n18IN3mSHp+28Imc8QuVqtk4mG2p9Pr4+aSDjtp8LTX8GEEVN4xYYm0etrUu55LQU4etj11x4g/Mj2R2QDUg26jqSOrCh+1tyGaZCJKIRhRmPDgEHsLwPiISP0tYkQ2RbPpOJQRIAX1ECquW7lU2t6Ozs5vX85KwAw02glaJfWgKwtEekvj7zy55V974iGalA+N+6aBbZ+VGYXOyDHKtFh6SEgshgzp+CqkmPJwgQfcOboHsm
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(23010399003)(35042699022)(1800799024)(82310400026)(14060799003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RiKg7Yb3QIJO+FF097cXhVE7HsvO1eb5g+CvfFoDij2ov2auRzu9zwKoQ5suPE23ycAC/TST22/RxTgeigQs34h5WBwN2DNpryDYLwo+55/+zTVPiud3beEg3JeLOPU75PpTE3lUWqPQ2UXulzmNevVd3IStYz3rn/o3Y3QCptUUDwD2EO/hW6TjdbLQAiT0e0EpYkYy4e5WyfrIPqZYNOgasaKByqijaeTP+ghz2XfB7SQY92qJO8+/Tbc4eiN4wX9Hqf2VfnNSa8RJAT1OKIXOAKuxrkd3ZI6KlX6NTfuPunMe6kxlwjd7eOmIEd1csO7kt1a2+xHaDup3QwKGLSIW6/HIwZ3YxIu3GlOUY2RzwQVM9F+TI20Auhdk6WA0RL1e9FcGFoLH3O7yJ4e8bDcR9Wf/UjEO9Gy4xqCNLm+2tOl1mH5NEu4XUlt99bq/
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 15:14:06.7632
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e52dbe5-4311-42ef-3312-08df2097cd6e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000C1ADA.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI3PR08MB877902

On 01/10/2026 12:17 pm, David Hildenbrand (Arm) wrote:
> On 9/22/26 19:12, Muhammad Usama Anjum wrote:
>> The non-MMU stub receives hw_pte_t but returns a software PTE value. It
>> has no attached PTE that requires ptep_get(), so convert only the stored
>> entry through __pte_from_hw().
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@arm.com>
>> ---
>> Changes since v1:
>> - Explain why the NOMMU stub does not use ptep_get().
>> - Use software PTE value terminology.
>> ---
>>  include/linux/hugetlb.h | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>> index 0d2101facaa50..637fc863d3687 100644
>> --- a/include/linux/hugetlb.h
>> +++ b/include/linux/hugetlb.h
>> @@ -1278,7 +1278,8 @@ static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
>>  #ifdef CONFIG_MMU
>>  	return ptep_get(ptep);
>>  #else
>> -	return *ptep;
>> +	/* No attached PTE that requires ptep_get(). */
>> +	return __pte_from_hw(*ptep);
>>  #endif
>>  }
>>  
>>
> 
> Okay, that looks quite odd. No NOMMU code should ever be calling this helper. I
> can understand that some NOMMU code might, for some odd reason, end up including
> hguetlb.h where we have !CONFIG_HUGETLB_PAGE.
> 
> But let's see who actually calls huge_ptep_clear_flush():
> 
> arch/arm64/mm/hugetlbpage.c: only with CONFIG_HUGETLB_PAGE
> mm/hugetlb.c: only with CONFIG_HUGETLB_PAGE
> mm/rmap.c: only after checking folio_test_hugetlb().
> 
> I suspect we can simply do:
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 80a5a03e9cee..8642c863c1b7 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -1268,15 +1268,8 @@ static inline void hugetlb_count_sub(long l, struct
> mm_struct *mm)
>  pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
>  unsigned long huge_pte_dirty(pte_t pte);
> 
> -static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
> -                                         unsigned long addr, pte_t *ptep)
> -{
> -#ifdef CONFIG_MMU
> -       return ptep_get(ptep);
> -#else
> -       return *ptep;
> -#endif
> -}
> +pte_t huge_ptep_clear_flush(struct vm_area_struct *vma, unsigned long addr,
> +               pte_t *ptep);
> 
>  static inline void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
>                                    pte_t *ptep, pte_t pte, unsigned long sz)

Thank you for digging into the code to sort this out. I'll confirm
and update this patch in the next version.

-- 
Thanks,
Usama
