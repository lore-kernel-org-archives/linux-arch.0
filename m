Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010052.outbound.protection.outlook.com [52.101.46.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D413619D07E;
	Fri,  3 Apr 2026 21:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775252016; cv=fail; b=iZGbSeW8iMpnkjw2TttF/M4GeSw8+8t38ey2RNQX7830cz+8esch1MjwLDpT5ghA/l7FYtBBtPuxaltRgl0GfGN3vD4Qtos0IG1U0KEXbHHfmaHKtRHB3rdFr9Il7ndSXSpfR5xsGkIQL/QFc/IjbEApIWev5cuUkUqXC5Iw0ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775252016; c=relaxed/simple;
	bh=20FIem9ld2X+tLjWM9GtbwB3IycxDa5sVDgdye5/T6Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sHp1oHH8WEizhapkEZPWtcnfhLN43dAhfqgN5CQoKFtwmY8MBZTGIODc2eIlg3jKHJ2xYkamhJR02Xow53ihkUL8XaiYNPleMT9eSAbq6fRSORxdYsXbp+B1gPne1Pvx7KXKRLFyo9AjDZk2NkYtOImSEetyFHfnuHcQlIIYmVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KpYMQidC; arc=fail smtp.client-ip=52.101.46.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KpYMQidC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+CvlcTGLgqKOTPEwbTzKHerdUdyGm2kluopLfqrsEqHUbOVqurVuCZ1dpxSGXYixSr/kZxL+00l3H4Izd7PMwEgrnKNwEbq6IffHBTlJFAP5AW9ynSt8SUoeQm9OYb89pQxAgJX0ooxAMEJglhXcZmlSEUus0cqDax61Crk5go32GFWSogd+XXDBxub5cCGqKI5oYtO9GGVh6p3dJVmo+YD8UOKFkahrxkz+U9GRjhHnN6zoN5bniJCUYCY1fStd1StLW7M8pP/8njeppMOLhFZtixfmfPV9YNPnuHn1csaTs/E8iIqqiZgvEemrx5USwTNvrsN8x7uOuJCDRT/gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yJjYpjW8oiAnjYVmvljerKoybr7J7AVm55jyVJ/+RY0=;
 b=E/+kbDAT/X0LRTV0FOAn8s+9POwP5GagpmDIHXZMMXKXJYA2J57KkKDxy3jmrLZFTqJwBsGZFrVSvRcsIxa82K9BYgkKm3ntso9NkpyC2nCcYUI+mrmkAjO0vEyUBOBMTttTIHqBu/7ldeAnHc5z0EVlW2maEBTaHvebGGcbvHPe78MymAwqLkpVbIwx3AnIEKq+6AgssxAgrXhlhNefGzi0wdFRnSJv5AnoWxrhfhEpx0qceyf/frgp05VDvIZyP1+keCzX7Tt/auVG8eyrCamJ87rVd1a7ryauUE9/gmiBSrI4Jvz8a7lWQpj8TjBuiB/iLez+nteFi4BiPFqFjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yJjYpjW8oiAnjYVmvljerKoybr7J7AVm55jyVJ/+RY0=;
 b=KpYMQidCzRwhrEL8QNk4F2k9o0wH+ydhFhw+xUW07lD1WnNLaYQpFEQyAwFXJRMq54T0fRDx3AZGEBoUAeZH2TjqgJtICCK7gU7xVLg6XWcllktkrEIpkqCnDskD6szGF5hdc8UCNQpyDnygKXf5A9pshB7yt9Wjk7z7OXTTGi+vajgxZXh+YRguNzIKQb6XTSeAtXRsV6SYURF/xkclu5WWI5R+TUPkrLIZJnlRwj/rvUIiutSmY9FEmjl8NBgFpwW9G28zRfzCQ90NeNTSDGCMCFfTfgx84ehkJR6LZ5UiAsR3CfMasDYpCKkPL+boV7g1ky7WbfvWYO7M9Odb+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 CH3PR12MB7738.namprd12.prod.outlook.com (2603:10b6:610:14e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Fri, 3 Apr 2026 21:33:29 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9769.014; Fri, 3 Apr 2026
 21:33:29 +0000
Message-ID: <00c387ea-d49b-40ca-bd82-89dbed6ef3cd@nvidia.com>
Date: Fri, 3 Apr 2026 17:33:24 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] rust: sync: generic memory barriers
To: Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Mark Rutland <mark.rutland@arm.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
 Andrea Parri <parri.andrea@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 David Howells <dhowells@redhat.com>, Jade Alglave <j.alglave@ucl.ac.uk>,
 Luc Maranget <luc.maranget@inria.fr>, "Paul E. McKenney"
 <paulmck@kernel.org>, Akira Yokosawa <akiyks@gmail.com>,
 Daniel Lustig <dlustig@nvidia.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 lkmm@lists.linux.dev, Alexandre Courbot <acourbot@nvidia.com>,
 John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Eliot Courtney <ecourtney@nvidia.com>, Alistair Popple <apopple@nvidia.com>
References: <20260402152443.1059634-2-gary@kernel.org>
 <20260402152443.1059634-4-gary@kernel.org>
 <620eaaf3-0569-4633-afd9-74ec18dccbf8@nvidia.com>
 <DHJ2YICMLZBL.1GJR8TQHG4A8C@garyguo.net>
Content-Language: en-US
From: Joel Fernandes <joelagnelf@nvidia.com>
In-Reply-To: <DHJ2YICMLZBL.1GJR8TQHG4A8C@garyguo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CYZPR20CA0020.namprd20.prod.outlook.com
 (2603:10b6:930:a2::25) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|CH3PR12MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f79e4c5-bcc4-4edf-a938-08de91c8a584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	ESy3VlgFtp41Hg5PFng6SqO7XVvqAd7XaXqvxm8wC5ylHsALgzA4JymsXSVqLyPgwes6RGX5g55eXuH5aVa6+D20tKryq2fnZx6Zx0sEU2lt3BHJRtZ2USRmNRU9yBDqswsF7qELBqez8Cf8+D7yBr3Q/tUg/Ifp9vp+xPnlSKGelMooyAusq3bA5CvT98/3GMLg9+7DR2yJVbi9hf6kTmlWtUZmwEL5SzJ5sxW8mxMxxdpne5txEqY/ezMehUuce8rj/gymZ/v3lSQJ2Iyen0lJJAuxNhOr0Gp+2daN06kVpfEcY+M8Po2JRNNBfWgJjHJJuCb1RZSot0Wc9+o1MCtWdhgvM6fn2AqTLGJygCq3Av3h+JOuH52Uaa/Taq4dscxakQaIdxaV8EMqHR/o6ssio5oRowkMe1DY9fpjJS1+vQmB9pT/D/CzIL/TDzAs9Zq1PFClpA1M1BejNur9e6lVZr5yOHA9JVHXHg33tjFtk8OK4+Mix3TFELeSoTuA0CY0O0sI2cqXcAxrzitf1haI30dQE+SqaFrYiUCP/VOoQIJVhj+h+gOWWipX7GNlGQd6NWP9SJ/3SXrPTwOuCi/6iq7DD3dfqg8QGb44TVpJT7txs3vMWU66GHVCKPMOJXZxJggIfIsk4v2L6aK3bVGThjMnO+nSLYz+pbmWCAGsjxJ/Rw7jhiDhcjSw4VVbQypv8w2+AFhknCkUA2y58SCMVZSFQnJ3QWSq9zuqA9WKifxfssO+0aQ9khgmheZk/RMmz/EjrilKSEE+/ygtQw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6486.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mm9Jb3VYM0t2SXp1ZWxFYWlna3A1Qm9sOWZ4aDdQWUpLWnVvY0JOUjZ1RFQ1?=
 =?utf-8?B?VEZXSXN3Nmh1a0Z0VURNTHdRbFo5REtiMnFpdEpva05GNlh0V3NzSzYrQ3ov?=
 =?utf-8?B?OUhOMDdtSW56cEM3eUR2QXpPeU5BR2lXeE9SKzkwZEZEcmE2UHFic3FoVmNu?=
 =?utf-8?B?RFh4TWM1N2hrZlNpcXBUb1hWRENtUENTbTI5cHNBK3V0bWRQUThDYzZ3VlVC?=
 =?utf-8?B?Rm1BRG1kOW5jK1NSWjk1VlY2Q3hKbUV6K3NmRE9pYjJWazBmZ0pGQ3I5WjdL?=
 =?utf-8?B?ay85aEpsdldOcTFZQ2hHQ0xPNFJ6cVF0aHVTdmFxWTZSTlNVUmZnU2x0ek0z?=
 =?utf-8?B?L0ZScVYwTkxPUi9oRTFXYlBzUWtsalF4MDlWR21jUXFKM21oUGo5NkhpbWJk?=
 =?utf-8?B?cDUyQXg2S0tVQzFpRlJydFU2RzJ0dkVTU2NlT2NXalppT01wajF4YlhiL0VJ?=
 =?utf-8?B?L2h2YXNBakVMeFRZZzd5Q0Exa0wvMGV3djRqNDFkejN0cW5kRDNoRzdvdXRN?=
 =?utf-8?B?QjV6QkxDbGtLTHFaTFYrSFo3cm5kd2ZtbTVpRWxJak9jdnR5eXliMnBsaWZ1?=
 =?utf-8?B?YVJHckxkTUJ5UFBsbWM0b2FLb0p2eXFYSE1oZEVLWEd5S045QmMzWGV5U2tW?=
 =?utf-8?B?YkZWTHFaTmtab1R5cWQ3UXI3Y1lUNDFlYy9GVU1PSzBra0NuckNtR0hkamNF?=
 =?utf-8?B?K0JuOHF6WTZNU0RwRllCUjZBdEovdDBNYWVTV0syOGVRNTFyeDkvdlc3emk3?=
 =?utf-8?B?aExTeSt5NHJRcDBUdjRhTmphdmM5VVk4cndnOEVFeWpiL2JpOWlUYXl4TEFU?=
 =?utf-8?B?a3p3Rk42ZXJTQXpuUzR2TlQzTDViSStqaUNrWG14Z3N3SzRlQU53WU9heWpU?=
 =?utf-8?B?OE1sN1dnWEsyVXpXc2FHOEQxNnNDa1hCTXBiZWVRd005Y2JsbVY3RlRnWEdG?=
 =?utf-8?B?K2ZBd0x2Ry9PbEVNeVhrVWhpaGlZaXpmWlR0TFZpekordGE1Uk9ML3V4NzFq?=
 =?utf-8?B?UUxmbGhJSXV5cGQwdlZmY1NDc1JZQnlaN2puWEVod0FZQnlxOFN6QUlFSTFa?=
 =?utf-8?B?UWYrQUE4QzBqSmJacng2UVVrQW5wVUJtdGJUT0J2TTduVEgwR0hUQS9kSW54?=
 =?utf-8?B?V1gvQ3FyNmdDcjZrWFdLUDdOeURMNjBPajB0czJSamtUWUZwRlRXS2V5UXgr?=
 =?utf-8?B?ZWpKVEttTE8xMGhhZ3JFV1NGWDZHTE9UaEpzZUp2L1JsdjVDNnpuUm05MjF2?=
 =?utf-8?B?TEhZU2xmSVh0TktNc3ZON1dCN1dUdWs2dGhVYUhFTlhmWFl3MGJjVml0c2R2?=
 =?utf-8?B?SitLelZROTJ4MmZYTmFQeTNEL0NBNU9zYXVad1A5aEovN1FtOHV6WlNyanNX?=
 =?utf-8?B?c3JEYi83T1pBdjMzZDVIS3daRER5cS9iSmlHUTNySGxsNjMrYVplN3ljNHF3?=
 =?utf-8?B?aXkydk9RdlY4Ri93Zkx1aHdrWlpjV0ZDcmZoR1pBbzRaMVcwY3ZGZnZUYWNJ?=
 =?utf-8?B?NTREekd3KzJ3a0hqc1RpNUxrWlE4Ukw4ZkI3akx2WDIwWFp4Tlp4UnVsMmgx?=
 =?utf-8?B?WCs4cFptOWJTOFdRMHlUUEJiVFYvcXBISGo4NHJTQkR1b2d0YXVjVDlLOW5P?=
 =?utf-8?B?akMrelBiYnlUTDUvZ0V2ZkZiSCtTTmtJUmk0NVhtelFBS3R4blY0c3NKVVlY?=
 =?utf-8?B?REdxV3kxY0tCMTN1Um50WXdqSjkxdVpzeWdNN3lXOGlDbzF0VFc5QTNDMytI?=
 =?utf-8?B?VFlDSGFpWHFwaWJtMjZiWHF6MGJJL1cxUnB5K1llakhaK0FzbWlqQkxrSFlY?=
 =?utf-8?B?bmVKREkrSlg0THphZXppSmw5Z1hzeU1BaXJuckdUdnVQTTdiK1B2VlJWa2FG?=
 =?utf-8?B?WWo1cERRL0M2NFhWWFlQN1R2U2JwZFlyS0NVdFVZZVhJN3JESmxKYkFQTU15?=
 =?utf-8?B?d1IvbjZBejF6UE9OWGJkUHg5bDlocXdmNERWazFSN01rdFBDQTJ6bmthZG1I?=
 =?utf-8?B?cjFNMi9WcGJ1aFBoSjc1ZE5vcWl2SDNaM25SMjMyYk8wSGFTK0t2Z2VyNjI1?=
 =?utf-8?B?NllWbXZlbFp3dFhQZUNpNkdDaWhuTXhobUR5d1A3d20ycWNTUjllQ3dkYmhX?=
 =?utf-8?B?RkxmbEZYblBUNFpFNDNwL0FtOXZkUzlNcjY0Vis2dk1lbmFmVUdWZHZpYjRL?=
 =?utf-8?B?MkwrZDF6Zjl5YllvME0rQ1NLdjhHUXlrMkh0R3ZCN1VnbnlwTEJRRVR6dkl3?=
 =?utf-8?B?anYwbHdQNTlac2lqS1NTbUQ1MFZiVG9Nc05aN3Qxazg4OURDZmRTZWZYZ1pO?=
 =?utf-8?B?QUhpekx5clNIZFB5TTliUlA2QkFjT2JqVkc2T3crSzVheUJhRlJ2dz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f79e4c5-bcc4-4edf-a938-08de91c8a584
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 21:33:29.1072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RLjVdfAIB9+rZfdkqf8HQEaKTUaVdoS3r2BRa0Neg1cuUFcXxRQPcMZh0y+QKe2xn6qGa6OmTJff3WlgtSTB1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7738



On 4/2/2026 8:07 PM, Gary Guo wrote:
> On Thu Apr 2, 2026 at 10:49 PM BST, Joel Fernandes wrote:

[...]

>> See also in Documentation/memory-barriers.txt, ACQUIRE and RELEASE are defined as being
>> tied to specific memory operations.
> 
> That's what we have today, hence the implementation upgrades them to full memory
> barriers. But ACQUIRE and RELEASE orderings doesn't *need* to be tied to
> specific memory operations and they can still make conceptual sense as barriers.
> 
> C11 memory model defines Acquire and Release fences, and it looks to me it's
> relatively easy to add it to LKMM. I was playing with Herd7 and I think I've got
> it working, see the attached diff.
> 
> Another thing that I'd like to note is that in all architectures that we have
> today except ARM and PARISC, the smp_load_acquire and smp_store_release are
> actually implemented as READ_ONCE + ACQUIRE barrier and RELEASE barrier +
> WRITE_ONCE. I'm planning to propose C API and corresponding memory model change
> too, but I want to gather some more concrete numbers (the performance benefit of
> having dma_mb_acquire/dma_mb_release compared to full dma_mb) before proposing so.
> 
> Note that marked dma_load_acquire/dma_store_release (and their mandatory
> versions) don't make too much sense, as AFAIK no architectures have instructions
> for them so you're implementing these as fence instructions anyway.

Ah, so you're proposing new memory barrier types that don't exist anywhere
in the kernel yet. I thought you were just wrapping existing ones so it got
a bit confusing.

My suggestion: fix the nova-core issue in patch 3 using dma_mb() directly,
without the new barrier types. Adding a new standalone release/acquire
fence semantic to the kernel is something that will need broad consensus
from the LKMM maintainers IMO, independent of this series. It's a bigger
conversation that could delay your nova bug fix.

Once smp_mb_release() / smp_mb_acquire() (or the DMA equivalents) land
properly, updating nova to use them will be trivial. But the correctness of
the fix shouldn't depend on semantics that don't exist in the kernel yet,
even if they currently degrade to a full barrier.

That said, I find the idea genuinely interesting, and thanks for keeping me
in the loop. Standalone acquire/release fences that are formally modeled in
LKMM and A-cumulative is interesting as you showed in the herd7 code. You
would want to update Documentation/memory-barriers.txt too.

thanks,

--
Joel Fernandes

