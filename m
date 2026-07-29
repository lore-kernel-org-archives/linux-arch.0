Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013052.outbound.protection.outlook.com [52.101.83.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6994457A7;
	Wed, 29 Jul 2026 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.52
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785327765; cv=fail; b=kpEQpKq31WOrFH2qWx0c2/DMJjIYWxi2i2748c4Za/Y0TUZqDN/BycXECQR3OBE+H4RRyKfrYTb3lY8DOcSIZhKVhaUhkUh/VEK5OKDKyd20N2mWSQmoM5fWFnsGCQdlimybM3u12Pl4eFlYUB9XQPJPVb9/3/WyNxeNAZOzshA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785327765; c=relaxed/simple;
	bh=qzAkLXouebTeZaS1WPWKSgNGC8Q220i0dabvqrMjm40=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O/ur2z/pwA4fiV0s5jBtQgnqk6w8yQ93gLwiRdFyItMbePZqo1/Hr+6ulEo6DKkCnNoPyehAquoEAYY/XXnluhAwjJlehRgJiOwyCkZZau4nGKifQxQKWXXaLwxnDG8ePFqe2Zv+gApRroxiDCAKLJ3B9Jsre3SVjsi4DL6n89s=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=r8WBeMkl; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=r8WBeMkl; arc=fail smtp.client-ip=52.101.83.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="r8WBeMkl";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="r8WBeMkl"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=wHTI7BQO2TZZ8SyyU9bYlGGlhWZ13cSo0igcktPlfYIycGKB88rW611mbR/2bY81cdR6t765jGRFr2EXfD+bRoje8yBu4f3hUuf4pio6rmSw/ObDxLOuw4up4cqP1lolsTftCBaFZOr0JOsWF6vmgm7oxK1CEl2/NfagBipm18a8MWucGt1MtYWTb06XsHO1q8KUAR+lavQCrIYJNZDWGHgCuu3zHk6b5OKDGDJR4Bt19lv+gdauvkxO1qTFvGpbZDvOylICeHJ5/48xs85iTUvq1QbrPPF9qHjrnfTiPWqe8rBUMP8rmev/f/wD7zp4cUtzyrSBSWLIlQBx/ePuaQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UgLZ8i/inTOBt7S51j8e9s65/Rn6K9L71YfNghMwJk=;
 b=TRWcKo4eF/1a7f+oYAmjkAPpYcTrmiQkdTX0xGsdUWQfoHRyiDbghScnt1oTkrzHpGTpXeW6BZXKvx8F6VA2Xdnt6KrZcWIzIvXJyimPZPmbvZfHZPTRwQYJoIeB6gDW3MNmSE4Wn+tm8iCr/2eo7bZzedi8mu6zfRbtwYqTjHqKNlK38BMdpyzDYhLDcYyUxRI2DxXAQBo3iQct8gSjY1PskYIIhR9zUopSY58o42dKFLbTIa1CLARvcWKwMQ6NYuPGYLO59xb1IKgtxkgmOsSiIGrjinILI+gpnMSNAYtsg5sSYJfP4THr0IFrCSXCQSWP64c3ow0Ipd8/hWPdkA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UgLZ8i/inTOBt7S51j8e9s65/Rn6K9L71YfNghMwJk=;
 b=r8WBeMklmddGAm0lSTHYsLA4ZTQE1ZLuJSt/QUO0R3jXztqcZ52QnHl57B5GLKXAegA0tQaC7GvjVpfhAy0fK5EFF6auEUHIr125aMqiOmwDd64Jlo1Urdgbssr9CPVp7owoAL5Awk88acUmrPoH+9c50lz7JksulRlvoAy3iqE=
Received: from DU2PR04CA0360.eurprd04.prod.outlook.com (2603:10a6:10:2b4::28)
 by PAWPR08MB9616.eurprd08.prod.outlook.com (2603:10a6:102:2ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 12:22:37 +0000
Received: from DB1PEPF00039233.eurprd03.prod.outlook.com
 (2603:10a6:10:2b4:cafe::ac) by DU2PR04CA0360.outlook.office365.com
 (2603:10a6:10:2b4::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Wed,
 29 Jul 2026 12:22:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF00039233.mail.protection.outlook.com (10.167.8.106) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Wed, 29 Jul 2026 12:22:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0uKrjJBmHp7eTVLqZ+bd8ST87iOuHt2PL6pKLdHE2et8YzFCyOf5v6vEMT79ZoPloSxRT6rXnrw0n0AxV9G4RvGSmcMvAnwytTsqVIK1/eFumF/x4ewDceI37uMabTMvNcxD/Wj4cOU7mCo1bnpxMk/NKCy5/GH6hOG3PQ0qNihh3dadPSOgHKqJhXkPN2VAPzD1ql+6jczrAiVl8waWGEvZA9KsP9EGet4JDQipPt4O+Dunk+Rw0F5r/aLaNStPZldAOyCKae9KoT+ZFs1/K0HTqoBS7uUaFJ4X47ayVDEiZh8exmZP+WtIUM1GA2qCJbVQOAaGopIqp5CnToCvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8UgLZ8i/inTOBt7S51j8e9s65/Rn6K9L71YfNghMwJk=;
 b=PHuDnc5gnHlllAbPl+ssICaFV9QwlyirhxIKMRdOvP6LtpFytiCL1WR+Ed+n09EOtn4L3jDyT/98x4bmTAS1XghGKgZsuXZ8Z+M7n5SRkVSvzTGV2bG4mhqLhWXrM3pMew5fgpZpd2eeDn3oJq7IU3+G+x34AAvaNR8eJmbXpfdAFaAIPtIwa0FEUQ4B0NUGIwLFoQc787mZzf2uC7h7FyI+MYk09g8bKsxSr5ZpOMHhQI9w8pGvWKxyxkBk+Z7D19B1cEKsH0TIoDiIdc4WnlDUzGDp8e1h+oQE/jcZ1MpJMMOx/saBJV9N2Qfsk4R1RcqrhOrITvbtmlXXUS9NVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UgLZ8i/inTOBt7S51j8e9s65/Rn6K9L71YfNghMwJk=;
 b=r8WBeMklmddGAm0lSTHYsLA4ZTQE1ZLuJSt/QUO0R3jXztqcZ52QnHl57B5GLKXAegA0tQaC7GvjVpfhAy0fK5EFF6auEUHIr125aMqiOmwDd64Jlo1Urdgbssr9CPVp7owoAL5Awk88acUmrPoH+9c50lz7JksulRlvoAy3iqE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com (2603:10a6:803:80::16)
 by PAXPR08MB6432.eurprd08.prod.outlook.com (2603:10a6:102:154::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 12:21:32 +0000
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4]) by VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4%3]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 12:21:32 +0000
Message-ID: <38e14b3f-52b3-45d8-b151-776be75d44d8@arm.com>
Date: Wed, 29 Jul 2026 13:21:29 +0100
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
 ziy@nvidia.com, pfalcato@suse.de, ryan.roberts@arm.com,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-parisc@vger.kernel.org,
 xen-devel@lists.xenproject.org, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-perf-users@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH RFC 00/11] mm: distinguish PTE table storage from PTE
 values
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260727164715.2866609-1-usama.anjum@arm.com>
 <2c19247e-bee6-45f4-a353-2fcc60db26e6@kernel.org>
 <7813b5fe-e767-442c-a356-afc1a5c567ad-agordeev@linux.ibm.com>
 <6db0a8c0-b500-4364-be3d-d3a537c61258@kernel.org>
 <46319967-0338-4532-b953-dbea77084fe3@arm.com>
 <78a0402d-5436-4aab-a704-90fab56eec50@kernel.org>
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <78a0402d-5436-4aab-a704-90fab56eec50@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0018.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::14) To VI1PR08MB3421.eurprd08.prod.outlook.com
 (2603:10a6:803:80::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3421:EE_|PAXPR08MB6432:EE_|DB1PEPF00039233:EE_|PAWPR08MB9616:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aea7950-6810-4793-59dd-08deed6c1301
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|11063799006|4143699003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 4f4WJiVrE4oE00IPJF13mXr5bYm4gJicwuFnW0oBvatB6ToESonz8/pFQy9Nsoh59srkh7AJ7Js2OYOpcAZjgWNoJEqkc0gP81wULmr6D2jyl+sQ4oxvEoWrcZTA0CzQ1Atz5uiA3JPPVbImXlnBvXEGNnh9MFsN9M4fysD56roZQ36+Z+mfvQlsr+06zv9TOIuiNx5CQTVDQfSzDipWZOASj2dFGOrG7Nv5dqqV04LK70KToG0OnumY6SVGimaGR+L4qiUVCZrr6GO9XrPVWAJzlJCYM77mWF7597CV5OMNeRje+Kd2FuHRNXttxrP9npyuNGxf9WOO8WO+dAldb6+8x9YsqcOugQjPQkULwaNtWNEsOoMYGQFd5cn+mpdZKrCwluwtNHX6nO32lbsA8kgE8YdbeZa6Kk5bSk6i3NMEaARh7kAnJkiuEwel69qEKRHkugY8G+JyK2Gr4oyZh7rA0ZMLHofVvYPeJHu5TNUSDLbAhTRBh5LGSSfkS3vkjAMv2ZG9YE03lkRt5NqCps2MOQryWQni+2q21fSj6lrnQq+MLUauz74mQTETrdGvYYg5X+wNLCs67CVW3ft7anoiMo3J3xDexGhnzPKYslqwke0d1m40ni/pPA/SpIyRupazJHBUKUwhPHedv2wvv7Lzk0132SQXBc2eYhmYDWI=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3421.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(11063799006)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 Brip8dYa6YHQXD+S29uLLOT7LZIpu5N3EpgcLBC8QHeBs7dhjsgU+a7dW8lNCfj8di1XyQ7cYDQJ0BJ4Hjw+vuizJ78uwgbcMviGi72j/DZTDkcPvf93jvRj/sV9S5monBHQD3KNSVeUP18W2OegB8BQoe0X+ESoFIcM7+FxisD/UpULQrvsaQkb/nR3GXD26Kx/QjPdun8wOddrS8LQdCyFzxlN8rig+EDZuaJE0CFqO0P9NVrr9GvJbDHz/Okby+NyKpsQt0t3AkrHSRXiylYwvlGQb1NR96MdI+G62zSMf/Edt//mv7zM2dbWWp0DO4iqSZYTkjA+WL7ON3otCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6432
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00039233.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	26ba18ca-dbad-48bc-c3a3-08deed6bec90
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|23010399003|35042699022|36860700016|14060799003|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZIGqU36B0gyhuISu+hzqAHxQHzXCIWxncjxQuSli5HDWHsjU9CZAKvQBv/2qVA6g4IvFJYcplFnVsfzCNm9ZxzAui4+9VbDULzZ+0bboN7g1b24TghqGWf3AJz7+sRv/w+c+8vLfBQsvPziMqBz8tBsLiy2uUaEU1d51yOfDg6LXJwg17W2B+I1HNFhZoBZFkln+Oji67+9/Tftj71e4Pg1FCmSpb63nM0p22LmS5OJrKP3aFk5DlluUcPkaGgafsxtqw5atIe8ICWe11CgLJj4tBWB4IolEX/vx6cTu+EqHxG41VX3kIJz6QOyU5hijDwTkh57f5GX/BZytODrZ593np9FfaDIXsktrZIAhIFhPh+qKcadJSfZ6i7+jLdehUL46ZuglJmrj7mH0AMOMORsclCRGPAIj/tASopcYEi4iiTdhuNHnqqsje+Xu02wYXv1bIwkqvi+U7M9aXrymNYj+EYn1QpZljBlPJ+BYCyEpN1QMXfu89aQ8LQTKZA4zZA2nUkXfiJcTDRPjONLRu+mUlq8bQR7Lpk2v1NaVnBfbKkX4u2kTayg/BiG8xqWU5WwNqNYkB17xzCniPpwWP7Ue+0HTj1xZ6nIoyzdGRFug/tLlQwIcwUFAGh/a1S36Qt/ZOBnZfd3YcFrWz8Ta4UvdkEtP5OJjqyBK2NV4KJTlSkPFBPzZ99fMThxIOVv5Sf3II6YcfBpLcxuT5yl34A==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(23010399003)(35042699022)(36860700016)(14060799003)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	m0BkR8/X+Y/2YSrkkhKTipf4ehePcxOeGjGK/HMkPiYq7x39VpT9pGIXx7YjICzv3dRrqVt9sMng/ogk3QR9JPjPVZDXM1YgsAg+zgKYiY3e4gz87ekXnJD9bP9WANACldnpUqdaa35mxnTBbcd894orNH2g8SrxM9ZAn5W58w1zMGuaVye3TOZ83Oc/wNRno9jPD2BOXdvPD1yNIJUurQJQdrLaoa/ROMQmerFi43w6h1wEFavCUCRR+O/w724YL3ik/wRFKA1t5AkJA1gM/KUrdGpxK+MVxCHrUqKJ2Xf3pJSCGf6YLFYT5FpZ3awy7ih5nFESHUohIjTg1siXNBov8HTzWhXGdNSMXEaNMhXSOIlMbpHMNr09aLmPFt2MmnEVkvuwZE/n9ljUi2FCKQ/93R8Aj8Y2/N9mlIBkVF6PRjyP4qYyg2/llcQJ0hwg
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 12:22:36.3600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aea7950-6810-4793-59dd-08deed6c1301
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039233.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9616

On 29/07/2026 12:52 pm, David Hildenbrand (Arm) wrote:
> On 7/29/26 13:33, Muhammad Usama Anjum wrote:
>> On 29/07/2026 12:05 pm, David Hildenbrand (Arm) wrote:
>>> On 7/29/26 12:13, Alexander Gordeev wrote:
>>>> ...
>>>>
>>>> May be we need the generic hw_pte_t implementation as { pte_t pte; }
>>>> right away?
>>>
>>> Indeed, that makes sense. We just need a way for the architecture to opt-in that
>>> it did the conversion.
>> Yeah and architecture cannot opt-in until its converted. So we should leave
>> it to architecture to define hw_pte_t.
> 
> In the context of this series, we should have something like an
> CONFIG_ARCH_HAS_XXX and select the definition based on that.
> 
> So we'd have a generic variant.
I'll add CONFIG_ARCH_HAS_XXX config in generic version.

I don't understand why generic code would define hw_pte_t if arch optionally
opts-in.

Are you saying pte_t may have different definition in different arches. But
the hw_pte_t would always be structure of pte_t. Hence definition

typedef struct { pte_t __pte; }; hw_pte_t;

can be moved to the generic code?

Moving definition to generic side is fine at this point in time. But if
a arch wants to hw_pte_t opaque and don't want the generic code to perform
arithmatic (ptep++), it'll not work.

-- 
Thanks,
Usama

