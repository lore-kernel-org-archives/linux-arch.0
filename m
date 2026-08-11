Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010025.outbound.protection.outlook.com [52.101.84.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824D33AFD1C;
	Tue, 11 Aug 2026 11:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.25
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786447694; cv=fail; b=WwKvmEDtkJ2pE97ggOGRDn8cRm2JlDAdUYLd9taf4tE0IlYRNaqcWV8F1l5noZVa/1iJVnz9h/g2b3IjMF3Y9/wjNo8tp9uhi0dav3b2bPPriDOcWWF+gm53tSUynFlM/WSS6J1ZfPYxKNbqh+wZDfeSswsidCD2L27oPvMEFbY=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786447694; c=relaxed/simple;
	bh=QHesBVyFEEVvzGlxlYJ9IHg/wUB4RGCz0EN7ohT0vWc=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MI9k4fQSYbBidKy1gOpyPxyUKvfg2NGy0X+U+4Nii3fOwV3sqCYIcS8qoliitcyp1vHTawHnG73fz3TaEAGSEhFVCFh21B5DDD3qFd/vEEED4xMyMkEEItKnBfWTTSc9MJibFX6/BrIfYumvOVmKe49+KE0YJhstdvaVSPme1W8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZUpGE89U; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZUpGE89U; arc=fail smtp.client-ip=52.101.84.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZUpGE89U";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZUpGE89U"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=qoS21m4gqpl2A6mSYODK138AgZwscC6N6PBwKh0DY+U4/TY/d+9O22I+jnT6RZQ1qRmAbHotdmjz24h5HLuMHt2xruX853hADfuN6vM3ogka7+wik6xxKKcTFwHu7PtzYakC6Myv0tXrUbbdk1QdAOhE/6C3RCxk18Z5okURGuqvdXeUhwSCteSgY/PFWRSf/ibAUzhFYrFJFUzMdZYOsC5p7ihZV6k89/8jsGVt5koH2dtKgIS6T9ydUNiqRKgiv/tuhR+Wwz6RUfw8Tgf4hhzLqCY+dDo+bvZwodjNnzpyNCFt70WuLC6WYUXgkPGwTinVi6xnlV43aTLXM4CJzw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJvqjQtYhPn+5rlwiCulIyzL4lgkY2x9AtSglnQ/lYY=;
 b=QVqwLDL6dU8ENykUrSBX3azgWcaNBU6rqxz+4rZeM+oyBC8GK/x3lCMDcem5YrIRmulghNj6VZuwOTenlfLgwKxoRyvMvv4DcMLhMsYZysLvJ+bXVj/umUVRJ+GXV6RG9+cyZPlmF7smr3sIzUdtipk3EJEAjvh/cCSxy4yW9t6nm4GaD3LzSwVuTpWgTr6IqF2QCAn2ay0QSAMvb6hWnHsdsYwC49R0ozqycBMAzPrkyb8zntGg9EL26TKTJ0RoaOp3AOtfQ7ZObsG5F01dT/jSmt/ufiJ25S0XpCnqXiFUiPX8vCaGjUlPl9KLA7lmU4xdE8T137K9YLQWtx7kyw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJvqjQtYhPn+5rlwiCulIyzL4lgkY2x9AtSglnQ/lYY=;
 b=ZUpGE89U93omH662/JXtCNc15E3velUKg/MY+8EtCB58awMrAJ55DvQpiyUbXmRWgGbeUbeaF1kB4Mf/vJIUzh9u5D1IYs0UbuSUkN9eR4mUz6yAUzJl+btZ4QsOeyW8mPHysbYosEhYL1r7OxUUxylALgW+wLqgDL+K2823ehs=
Received: from AM0PR10CA0002.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::12)
 by DBAPR08MB5591.eurprd08.prod.outlook.com (2603:10a6:10:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 11:28:02 +0000
Received: from AMS0EPF00000197.eurprd05.prod.outlook.com
 (2603:10a6:208:17c:cafe::1e) by AM0PR10CA0002.outlook.office365.com
 (2603:10a6:208:17c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Tue,
 11 Aug 2026 11:28:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF00000197.mail.protection.outlook.com (10.167.16.219) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.6
 via Frontend Transport; Tue, 11 Aug 2026 11:28:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TtAUGRcJ6AWlPqIQMLOFqdpWYxlTC4E2nUnOT3chDTEIsmQcnbc7C4Y2sSB+uTDKwOvo2ZRT6Em8+BPrJnX7eXUTotZQn8/QVz2bJayIE79ffJW5RQRmoE9taCWO1CRXKXSMtue7nY/k7SBTekqwHh499iyRUbYpsQOFjkQrA0ckSpbIO9s0kAJ7nZE0iUrOiqvUKvT1dA3BtLcz5cjBQsNYUdJq+D9dJ9nsXo7du0pJvj30fC46fGjK2Fb0oDCav9SQ6O8F+n4Ny5fHFBYw4zeGzzIlme6w72w8fxAFJJS2I8DsZiwUGAxrBHih8QF8wD9eb0Gf3vg1RbgJMx1eYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJvqjQtYhPn+5rlwiCulIyzL4lgkY2x9AtSglnQ/lYY=;
 b=BUubzy05M5a0o/rrnDSXc2KdVNLdPVbJYF1vXwuI3/COJyE/qtHU44Dl3N54SOa/fu/35NVq+uVAGrPBVNXLVeUge3lOZz6SgrGkjDkjsf0CCohtaUm397MMHWHoKlzfgWUPT0NDVZ/OILkn8pomnIoZgwZ7XLrU1HMBt+mc3XClJEnNlKc2NFjlgVA2oaBTo1lN3Mup6A5NInGri1ekKwe78rvvGzamNFBrREnJ2nEKadoQ5NFB3sW9jYunsvp1SIMclM93siICuij+o1E10npQlj8GB80SeLV7W2OsvQivrs79f+K5bjWjAMnQrVdUTAr1zajM6lpYD7FbYq4NXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJvqjQtYhPn+5rlwiCulIyzL4lgkY2x9AtSglnQ/lYY=;
 b=ZUpGE89U93omH662/JXtCNc15E3velUKg/MY+8EtCB58awMrAJ55DvQpiyUbXmRWgGbeUbeaF1kB4Mf/vJIUzh9u5D1IYs0UbuSUkN9eR4mUz6yAUzJl+btZ4QsOeyW8mPHysbYosEhYL1r7OxUUxylALgW+wLqgDL+K2823ehs=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com (2603:10a6:803:80::16)
 by AS8PR08MB7790.eurprd08.prod.outlook.com (2603:10a6:20b:527::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Tue, 11 Aug
 2026 11:27:27 +0000
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4]) by VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4%3]) with mapi id 15.21.0315.008; Tue, 11 Aug 2026
 11:27:27 +0000
Message-ID: <00e4f324-18b1-4120-bdd0-2715cb8c8481@arm.com>
Date: Tue, 11 Aug 2026 12:27:24 +0100
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
Subject: Re: [PATCH 2/9] mm: make hw_pte_t visible to generic PTE interfaces
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 David Hildenbrand <david@kernel.org>
References: <20260806083926.1807279-1-usama.anjum@arm.com>
 <20260806083926.1807279-3-usama.anjum@arm.com>
 <7xbai2nyu6nuyr6otqv556dnphpgwaqsmvwkqwoqwbh5nvj3ns@ddy5ezgvb7w3>
 <85286df7-363a-4671-bce8-8157ae5c8f02@arm.com>
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <85286df7-363a-4671-bce8-8157ae5c8f02@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0528.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::10) To VI1PR08MB3421.eurprd08.prod.outlook.com
 (2603:10a6:803:80::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3421:EE_|AS8PR08MB7790:EE_|AMS0EPF00000197:EE_|DBAPR08MB5591:EE_
X-MS-Office365-Filtering-Correlation-Id: 844557b4-3d08-49e0-57de-08def79b9ace
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|11063799006|56012099006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original:
 MTpsf3IvsMf7LVKWeyhvKaEhr96cF7yvH7aAkJB0bN7Dz2cNvpHXLH1fyHZGxfSN239QNIaI0+Jcok45W8o6dR4xsKN68cgbWwRp1dzQPww8VsZXlkd40hV+KhrcssadBi6n0BtjeK57do7GEQf9oFzJbDCKBGKEr/aV+5jAIFyIZeHeh5kMOB9Qrjk9lo8ssRQA+eChm6iIsXGtD+CSOW4NioxM8SGHVL3AteUAnM8e4g774whpKM+LAnfDDjcLSX4MFF9hSkCzLPofT/OqYQzv+EwMtqda4QQ3+eunavGYKJYsOeegTMveEFkeBGvj6JTMm/hOKqolApr0MUGBdr41GqT/ssdVZNPKYsYEt9xqPyShcC5PyLIgKCnX0v/tTebELHCxdk51b5+2EAOWhVI77v4UDPfelMHZNmq21/aREZCxR9W6n0o5k4YLX5a3uijZLV6UVlfpJNgZ3QuTO2Bc6BphO3IM+ARnj71zys1h3r+Kd1pb9EbS1Jq989xaLY051Ts6i4KRA6aMFZo9LueNV/CeTUhnbiREzQtnXolfLW9GvmLGkm7fnud0MoPESxMefIj4l0ubl/7OWFxpNp2b3IZPQBAFKTvfGCVWSb5hVvqbhexADPkBEFLs81yOY+RJW4pds8/DrhzuSgfKHQo42UznNPz83AM+zvWSmgA=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3421.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(11063799006)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 hdQ7nn26YN7Vq0hE6oTx+kKoU45kJvqrMn0abldXFwKud0iJoW85VnYLUJpGpJvIJxgBFh5raADG36uRwV2AaPoefUNSSsVWUW5Y0zg8xQjIC+gS+uPl8TNSAFyKERlMdMsUi0xE67L6J47pXwlISmSbpRVwkLFrYG++90jViVROoUAQ0CjGmPthS/NBEXTu9BnqGOFLyjUMftDMlwsgCQzUj+8ciRZetLxOt7/pjNpvjEIqP4rEUksxKtNuI3nmtRimaXmtBqx+3z5zVXMWLYpAPEr4PTzqyXYAU22s9MqBWyN4hojABhxaeNE2vm0Mc7y2GYdrTtg6FpMnYERIRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7790
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000197.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	18d48398-875e-496f-3753-08def79b8605
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|14060799003|35042699022|36860700016|23010399003|22082099003|18002099003|11063799006|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	2EUmajtFjD2DNOQiqDYJhx/duHHhmL0owb4dTyfZ9bsnUL0uoX2XHDDcNEc8ffXH0yXFMc54S3eDdd3FK7Rgvf4oSdqjiuUijkmLVLhvYqiCS6p8fA/HIzvhi6DErNoUOFkJy4QHGrQyelLZh56K5hTOBUnG1R5SLFbyT4aPXHyPwsw8wUBIP9Y9rXgptG6nI/+P7u4RJRImjY27HbdHVXIJgwWS6rL/yVVXlDfZuS4eh/6+ZD5HHB9ucDqX4VFdjRdQxF8HJxek3eSNARe4FG/qKSh70eBDyPnSouR7KyaGJMR/2iMOrQaTK7DsGNaNX9Rm2OyL+30OXWY/2qczX+GyRC5rN9DAiEQhB3Nwo4lOeinyDhdoGapUIK+wGhd2NmJ7dikDhU/t+9ZF/O0XmDzmqlpA16nEikeqk4T9qWAuMIphpCWAnKhVQ0lg0uDbNpFs7KJXbDVsHyPCmrHptMgrtBPYXWY7zodgjZzIcSCYwgXWfLiBRhg6tbathu7RR3dFRTSo4E0WFqB9nQYl46Pyb4ttMR/EQ3BkRR83ob34C+egtvZWEdiZtbTCwt5jBuwjLoWW2cFDMx6CMCdAgWQz9boCtXX+LZNxDTVtT2tu7m0Y3zuKxbu+sK5MaVwhDmgDFOgKIqWUBggriZgqwdFaqZsSSnIl4BQlXlIEigG9yMV6bK1RxorlpjUUuOJJMGm8LrT2Y7fiutRFecm12w==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(14060799003)(35042699022)(36860700016)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WyhUxGQhEoSVrTLtM6KTQBdls8wJsW8gVWLkbWdx6cT7Xk/GYLPsBmlh93x9ztJFgtKrG41K/BR325MTqhuTQWTOaCrXraK0rMkVwnxR47oSdh9fsdqsKI+B3VpHMqo4o/Hv/BDlEsUXshXASkbsuTmzu1uD1bz0cGpBPcmOfP+Iid0iyfWDi72D4I7Ue+JJkSYEQYbepcZRsEhuGUIVVkfPWqPOga74+qtzICPnzDmuWc7QVcFVVVv0fZsfk7ZGiKMz8epspjJVn9Q/22nE55LUCy6f3tDgfOUCAEc3sw7T0cSYCJK554b7Cfd0iG/qiST8q0ESTYex1eiK8/ENww5D0y1dJNo92UpI+ykfXr+eBR4Azp5L80JDcstN4cax67P2PQm3jW1TJPF8UYWxA82cG2ywWMYG/z97+a9N57pgyA+k9Yizy3VGl1dJjFYh
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 11:28:02.1748
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 844557b4-3d08-49e0-57de-08def79b9ace
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000197.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR08MB5591

On 11/08/2026 12:25 pm, Muhammad Usama Anjum wrote:
> On 11/08/2026 11:15 am, Anshuman Khandual wrote:
>> On Thu, Aug 06, 2026 at 09:38:40AM +0100, Muhammad Usama Anjum wrote:
>>> Later conversions use hw_pte_t in page-table checking, generic page-table
>>> helpers, and vmalloc interfaces. Include linux/pgtable_types.h from the
>>> headers that declare those interfaces before changing their types.
>>>
>>> For vmalloc.h, replace the direct asm/page.h include with
>>> linux/pgtable_types.h. The latter includes asm/page.h, so pgprot_t remains
>>> available. It also provides either the default alias or the opted-in
>>> hw_pte_t wrapper.
>>
>> Stand-alone header file updates are not ideal. Why cannot these changes be
>> folded in, where hw_pte_t gets used first time ever in the above mentioned
>> places.
> That's correct. This patch should be merged with the 3/9 patch. But that patch
> is already too much big as it was generated with the help of Coccinelle. So I
> kept it separate.
> 
> Do you still think we should merge it as its a special case?

Sorry, I wanted to mention merging this patch and 4/9 patch (instead of 3/9 patch) in
my previous email.

 
Thanks,
Usama

