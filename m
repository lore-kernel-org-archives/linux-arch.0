Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792595089;
	b=ty1xanr2S2EO0TEM+Nk+xc/o3rJpVSjOWrqyyIS0qJ0pcC/JswU5YU3zsSMXxHTKJ96Q
	 whN+0Af/XTxkRQd1H8pGKMERWQm8FXLttERrk8Z1YGFrgkQnR3fEZObRbHsF5YTwkINVQ
	 UzW3W7tvpKNVz8omxDNJwIECa9cQP9RuKXBD4xyje0QdCAX+IpAK4RRdzGqpm4GdK50AK
	 //ZpbV7xSfyuYIqMPh9Q8oNPLJFtXyOrKVQBo1PJ6hf94Pkavw4tamBINrF3mJFyDUcU+
	 Q7zYO6UewOsDHjjVrgldrwgz6GNnpC0cjVQONuBADdo0bNvYYhzwEDQCHMc1iqc5thQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595089;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=dzuTLeaQKuRFlQK0YFsx1ESeTVWWU7D3TB6SunqFq2c=;
	b=UbmHnG/cYSz3wRPLvokidIo9F2mYWSIEf3xVj/pi//vRd0pbMGacMXRn28dNZxMkUTds
	 k0nbCLf8YVSi/tVEX2vJ1iUfSceaFe5Tz02XaPK/Go9kmeN2J5Fgssu4YjomBoNzryrb8
	 apcwUKd0YC8JDwKbcZd/msscbRGUFlRH7Mcp+Bee3kSdeogD3qOUkidg2WZFaozriOijy
	 iMIFXZHtIKyFkdM0ghAPpvS46xzhlKOcE9uBb1hwEnFF2Cw/qhucJhnw4dh69atLCacbb
	 k+aGroBrc3i6v5357GzRwY5YSdZPFcz50PFdZN3yk8I9izPkCEdUr+cpv03jNmL1y1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fAPOGKKJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.43.53
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012053.outbound.protection.outlook.com [52.101.43.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373CF606A319;
	Wed, 21 Oct 2026 15:04:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 373CF606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fAPOGKKJ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f82rNHIgfCxTIKYyuKzXWTtP6DFrxlp++uSjOyeMgj44sJ46X2YJPz7c+pl0JwcY2vw6BOiGigsIaiIhwqU1C5bR7gTg5/96+k3xnya5uz+2gnwHfKyTUZU8m+IMLSnw0nv+i87rrXZ0srWcoaTxqnOBS+c2gRtzGYk5rg0YUGe4bb91bi5qCpRoawFij+wRBdJSBjhQPMQDD5TcuWcXYZ2R9ozecdHzu31LG1OKP9ctrcKCTRDWJH3Dp2uf9XPnJ5WhRJN6iztjQG6ZPCXNvRm1UVlEmXUGcDFtkeb0sZ6yOgOQsKak+PVFhHLZQ6dXVME1GfKMxY03uJYMLvmoLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzuTLeaQKuRFlQK0YFsx1ESeTVWWU7D3TB6SunqFq2c=;
 b=HQveOluOhhRxvs6k8MtfOBm9dtdC3wN6ft77LcS02YIZseiviVIZm+hi4FRwB6joxxQSHzyNpnFyQqGqBZV3DoMQzeFQw68UyI7ofqSlV1TGKnqFTwuoTfZ/i+75kotms6m+jkokmJsSUimsdc3RsM6KJDdmz3m4v9shD+XCxyuLr7FpXVrd91HAiA/k19QPlaSJmLttkjrB5kxpAVIcTTll27S50DRqNZBsDB9BDzC5Lch87xTnTIPEDL9tz4ygJaP5UV+jAfEsuAB3e33wM1lA5E7fhm3dZWVTkBhTKsfsBF7Tp64+WE+rQCEwP8baRyJ8rpfmpKHwCx1GWNw0PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzuTLeaQKuRFlQK0YFsx1ESeTVWWU7D3TB6SunqFq2c=;
 b=fAPOGKKJ+5qCfxBUkIPu97toe0Kg9R5HxaJDRPjQi4s4A0moCVNztfIt7poxXJl0QHU+6SgKBnVyp/PvE+ekCKldNFKwF8dhd9R39yFnCbMj6Y7nckFFNNY75+ldgFrRyjbbn9SlBxzYHEBg0IjGrsDzMIIwS2iUxfOJbNrcC+Q=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB6728.namprd12.prod.outlook.com (2603:10b6:806:257::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Wed, 21 Oct
 2026 15:04:46 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 15:04:46 +0000
Message-ID: <feabcd15-0874-460e-bcc3-3c9dce29fd39@amd.com>
Date: Wed, 21 Oct 2026 17:04:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dma-buf/dma-fence: Order setting of the signaled-bit
 properly
To: phasta@kernel.org, Sumit Semwal <sumit.semwal@linaro.org>,
 Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Arnd Bergmann <arnd@arndb.de>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>,
 "Paul E . McKenney" <paulmck@kernel.org>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20261021095512.1345191-2-phasta@kernel.org>
 <20261021095512.1345191-4-phasta@kernel.org>
 <ae7ae97d-cac9-451d-a0d4-bd52d0f063d4@amd.com>
 <0968fe5558e744f6f1ae2bddbbc075d016372e25.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <0968fe5558e744f6f1ae2bddbbc075d016372e25.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0125.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: f2662f3f-ecd0-43c6-3485-08df2f84a4c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|18002099003|22082099003|10067099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	q4uvE9GK9qCkIDmQcT/BF+L8J839Fa+kKU2Pe9H1WoIBH9XCZA1wo6uW5z965PPupXAX2sBI97LLZfl/DaROhrxIkmsNXlNPEZjm9m3ucXJ3pCB2UK5Bys+DQkNuamk7/NmZpz5oWTSPdjQPzSVqj+fGmNp/PiEVhtnEEy8ZWkXaoavC+bEkxJKsrs9rtsk1k9TzdbnIv4cD8Ch+DZoBFj00gZm//0xK48dw/KsSYekoFVn6UMt+xaAXRvbw6OmR892KMMiWVT8Ra6MHiT1+VNo37ebHRbjRjmP942MDbAAxIChPyFhPGrPZBqPUuejEs85cIY14A/B/j70rqgWQuHFjp6zNv0Hn33lrtGU4mYh2/dyJC1Mw9IT7PyW3RiZ60j2CwjGUNXwIDrVJTQrdd7F22HAd90UC/otEh/alYFClU3/MKuzTpAyShBlwc87AHF7gj/Olvas2qXCWjHiQv0Ts+lpTM2ZXHr6IQvG+ne7PPGGJoE27kG9AGNudD/oen6C/PKYP08eqDUTpeq5MdE8ZK7YFk+gtK5KTLDbAObB+kJI0WVDBzfVFn1A4QWLPFq/yxp0MDvnN8fRe/zPt58lTn/waJkLQ/QgxfyCGkbTLXid7m5uvg5dh5J1WgofPLktuUINqznDBye1XXRewiWcf7WiZQLHuHnFiAr9vIsY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(18002099003)(22082099003)(10067099003)(4143699003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OUVjdGZlYjF6bFpmenVwNnM3Zjk1dkMzY05yK2VRaUZad1RSY2J1TC9yUjRM?=
 =?utf-8?B?SWVkd0JkdDUwTnlUOGRhOVhmRjNSRmxHZjFHN2lOZkZSUHAzL3YxMENCNytq?=
 =?utf-8?B?d1N1QjlWQ09vM3NadVhzcFF3UXIyRGlwem9WSWxwSUx6OFFUVDd6MlNtWkUw?=
 =?utf-8?B?eUs0K1pXS0hYZ0plLzN4VEN1cDVrdnBzbUVGU016K2JTdnI0WTVORWM1SHJL?=
 =?utf-8?B?cFNaaDlTaHBIVFRNT3hQNnRKMXpiMmQ3RmdmL0w4UUk1bzFpOG50OFAyVjd1?=
 =?utf-8?B?WW5VdjBVNTRKZWRrK0hoY0prQVp1R29xTFJpNGsxNU5uaWxtWGQxMkxQMVVB?=
 =?utf-8?B?Z0FPODEvMGRCWmNZakFNRWhiZkd6blFKVnBLRXZrZkJMTDVkRkZxeVYyZUhZ?=
 =?utf-8?B?dlJwTzNpbVlBL0FmWVNiYTZWRjlSVzRHZm93dEN3elQ1d2ZhV3VrdGpYdTBY?=
 =?utf-8?B?NEw4bnVhODN4RFU3SncwS0dIRlp6SEJXVnA1ZVB1RVZ1K3lVazZLVEY1Tmho?=
 =?utf-8?B?QmZVaDVpaWhicFNaUkpCR0t4WWhjSk9URC9RSnpoTWd1eWVWOVFrcXBXamJp?=
 =?utf-8?B?aW9CSXE0ZVhldTJiQkZMSW0zcW9PdXVsZjZGTHZSZjdHUWFoOVFOUHMwNloz?=
 =?utf-8?B?YjE4STNnaDdiaGlZWndMdExRUkNYaGN4bDBrUzM1LzZwTmNpK1c1V2JlOHhK?=
 =?utf-8?B?TDZZMVYzWG9RUk5QdFNNYm9vdFFUNVpTZjR3WW4vdnYvTHlQelRnREZJZmF1?=
 =?utf-8?B?NWNKanpWZjBxcU5kK0FWeWhwTi9xVFVDcUxJbWhLb0Y2c3dtWTc5SlpwYXlF?=
 =?utf-8?B?eUx4eFY3KytMb001WDVRZmQ5OVFLVmF1dWUyRTV0TDRyNzdGWVptVFQ5YUZx?=
 =?utf-8?B?YlpaNUdzVXZkdDFxNWlrakFVSlMyUERoU3RlMDRDRVB0N09OTzlYQ0IxSTNo?=
 =?utf-8?B?b0dFcW1nU0NFeE1RcTdwWVhUQnp6NlFpK3NvdHVlU2kvN3dNVzlqNkNpY2tx?=
 =?utf-8?B?VDVpYlhSUVhKd0VWOHRQNG5oMXUxRTRJdUNoZjJWOU1JRHZmQTQ0eU5lYkdM?=
 =?utf-8?B?TEJUZm9tRXNlU1AvZ1hHVVRhRmN3WGV2S3RQUjB5d2dlYmlrZW1jN2dDV01X?=
 =?utf-8?B?S2xUa3I5b3BUcXBQbkk0TnRIdFp4TUFaK3pFWVBwUGsraFBPNEJIZVZ0enk3?=
 =?utf-8?B?cE5NbE53ZC9EK1MyWExIVFN6d0pUMGlneE5QUEc4dFdvckk2S3lxL0k5S1Vn?=
 =?utf-8?B?ODlCYkxlcU5heWU0Y2VCVG85ZjNFQ0N2SDJxcWlwcW1LQ2VOTklKb1dlTUZG?=
 =?utf-8?B?S0hMN0l3b0hXemE4bDhtSE9EL0hpeHZkU3RKUjhqSE1JcHorR3JHZG83dEFD?=
 =?utf-8?B?MklHc05vbGNyQlRGWmpCeWVYN0UzblFOV3dqd1RQWE9WSUdUclg0MGc1TnpX?=
 =?utf-8?B?U2p3cUdDd2pjVW5HUEdVV0Q2TGZwY3NibllzdEQxYlBNVDZ3dnFKbWJlMFdS?=
 =?utf-8?B?OWFZZEZ1SmltMTJ1bnRkOXUrdFFEZXNwaS9HU1IvaTlkQUE0bTRnR0I0WjBo?=
 =?utf-8?B?Nm5qdzhLNWhzbmkrMkNUSFN1c2p2dkZ5TkNRdXlLbG05K05LaUZ2Rm53ZG9a?=
 =?utf-8?B?S3hDUVdMSHZvN1llMGdrL2ZjaVJ0OHFOL0RJMDRlT3VHaWdpRldGVjFpMGpJ?=
 =?utf-8?B?TkJnWkF3ZE81amI3S2hOUlM3YXovNEtidGhjV0pKS1NnYWN1aitZUlJ1VDlq?=
 =?utf-8?B?ZUVwZmhwanBSckdqYXJNMy9oVS9NRmhMWmpaVDRCNEpRUEZuVHB1cytmNE83?=
 =?utf-8?B?d3pQck1NNUpmQnZSSDVVYTl0bSs4WEJpdjNYUkhSbGRKaDI0RVpMZitYUlNq?=
 =?utf-8?B?OXZXV09ERm80c0l3YzB1TUFTSXB3M3pBbG9wK0MyRE1LYXJOMzNrZ3hlcnlK?=
 =?utf-8?B?cE1YblAyNHpkRURwZ01Rdjd5cGZYWVNBR3FzNjNucE1JU2s4VG9RYXZqVEFz?=
 =?utf-8?B?eGEveTFyUjhxVE03dGQwKzY1VkJvWEhYRURPLzJtT1Z1M1IzRE1xbThVaVo5?=
 =?utf-8?B?aS8wWlZNRWVZQ01ZMGdUd25GWHlXUnl4Q3VDNmpWS1VGbVZ0SEVLanRQcDNq?=
 =?utf-8?B?cExkZ0hsSS9KZnFHNWJIM0ZLKzNjMVE1cFNibFJXZTIwWGgwMUZTV0VOekdD?=
 =?utf-8?B?N1dnTTFEUFBicDQ2ajVoa0d4aHphd3JwR3hjSjdFTWlsSG5VWCtHM09Lb0FL?=
 =?utf-8?B?T3huUkFQd3ZuYy9FcVp0THA0Q1FIaDV3MGRDeDllNUg5WCs0TkQvMHFia2s3?=
 =?utf-8?Q?S/SAFXU/EY7M0PLimk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2662f3f-ecd0-43c6-3485-08df2f84a4c9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 15:04:45.9087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9M9aas0mY5hoOPGWuwp2khD7Etj6ieEQxWubZQCCqvoDh9Y9KdLNKYOWFtuwJkB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6728

On 10/21/26 16:52, Philipp Stanner wrote:
> On Wed, 2026-10-21 at 15:47 +0200, Christian König wrote:
>> On 10/21/26 11:55, Philipp Stanner wrote:
>>> dma_fence_is_signaled() can return true *while* the fence is still
>>> signaling. This is fragile and has been involved in at least two bugs:
>>>
>>> 	commit c8a5d5ea3ba6 ("nouveau: fix client work fence deletion race")
>>> 	commit 7c703a7d3f2b ("drm/amdgpu: Fix one use-after-free of VM")
>>>
>>> The signaled-bit is set under lock-protection but read without it.
>>> Adding the lock has been rejected on the grounds of the lock-acquisition
>>> shooting down cache lines of parties that merely want to check whether
>>> the fence is already signaled.
>>>
>>> Make sure the bit can only become visible as 1 once the callbacks have
>>> ran. To achieve this, read the bit with test_bit_acquire() and set it
>>> with set_bit_release().
>>
>> That has been suggested and rejected before.
>>
>> Background is that the signaling bit must be visible before the
>> callbacks are run or things like dma_fence_default_wait() (as an
>> example) just break.
> 
> dma_fence_default_wait(struct dma_fence *fence, bool intr, signed long timeout)
> {
> 	struct default_wait_cb cb;
> 	unsigned long flags;
> 	signed long ret = timeout ? timeout : 1;
> 
> 	dma_fence_lock_irqsave(fence, flags);
> 
> 	if (dma_fence_test_signaled_flag(fence))
> 		goto out;
> 
> 	if (intr && signal_pending(current)) {
> 		ret = -ERESTARTSYS;
> 		goto out;
> 	}
> 
> 	if (!timeout) {
> 		ret = 0;
> 		goto out;
> 	}
> 
> 	cb.base.func = dma_fence_default_wait_cb;
> 	cb.task = current;
> 	list_add(&cb.base.node, &fence->cb_list);
> 
> 	while (!dma_fence_test_signaled_flag(fence) && ret > 0) {
> 		if (intr)
> 			__set_current_state(TASK_INTERRUPTIBLE);
> 		else
> 			__set_current_state(TASK_UNINTERRUPTIBLE);
> 		dma_fence_unlock_irqrestore(fence, flags);
> 
> 
> That function evaluates the flag under lock-protection, with full
> ordering. The bit is only ever set under lock-protection, with full
> ordering.
> 
> So currently, the bit is 1 before the callbacks ran. It becomes 1
> before the callbacks ran, but dma_fence_default_wait() can only see
> that after it took the lock, and it can only do that after the lock is
> released after the callback ran.
> 
> So behavior for this function is unchanged, unless I miss sth.

Yeah that argument came up before and no it is not correct.

> Actually, this barrier makes things more robust, since things like
> 
> if (dma_fence_is_signaled(f))
>   ts = dma_fence_timestamp(f)
> 
> could misorder the accesses to the signaled-bit.
> 
> 
> Do you have another example of what would break?

Please search the mailing list. We had the same patch like three or four times already.

It was even applied one IIRC, but yes it immediately breaks things.

Regards,
Christian.

> 
> 
> You see, the bit sometimes being locked and sometimes being lockless
> causes confusion.
> 
> 
> P.

