Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.73
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792583687;
	b=eamdh3fCqit5Can8Fw0IfN7Ee0awzDnkj6+mds73fkYDjnPq6osgrT/GxYoavl4+9dyp
	 Ve48A4EmJR6UXgcvQCQxXqW4SHAq3EYwsttSQ9uJ2a90ZYcEzSH44BU5TWPK+BTfX4ZWB
	 RRu+d4VcUlXwRfLLMx2tc3xno/fEPaBgkpnVjmTlHk+OZRbv8Z1MYoDUSnyyRd9gp5eaK
	 /QG7KChodxVlXizTJQe3uSoJIqnt6BaI30B6jauDtlDRtq20ZdEeuKBKST5Wb+wrD2gBA
	 QzQUwmVF10Ecl9JB0BMxjT9waqsSSt2BWFSNSPs53NFuEhUvAw1CqEWO5wGT9WkBnfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583687;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:From:To:Cc:
	 Subject:X-Mailer:References:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	bh=yfY1KJHmmRv59xl04sP9amssRK9uBK+381cbO5hInSU=;
	b=xoZZSws7hC/nV36f1mO8Lobg4SjuC5lf21E0djA2VcKivrX8GDsMn+m/nDZX+Pp5Wg8s
	 KGnyXXyNR26EsGhjTbB3egztd8hAh/CF94VkHsnjeMuajmIBw88gXXbl9o28sCW83PJ6v
	 AMI8fgkSZpvToCWEXjaKTDJ7Aqv529dluERjiK/p0eCGetSQfJbgThQJSk7SvMf9bJdjB
	 CzBdPgw7dc12/KjoI3LUcYPuSo56y6WCNRMwtcTUJGu1SMVV5C8lVn6sd0TCzvVyCp7Ws
	 dWAFfxyVH0ZZ8Hfvo4xUEYFJBbwCwasGgs0ZCrmGqpGPnt1SF6WhuJQUF9sVpZORiyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=garyguo.net;
	spf=pass smtp.mailfrom=garyguo.net;
	dkim=pass header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=CA4GxKvW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.195.73
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020073.outbound.protection.outlook.com [52.101.195.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DF7606A31D;
	Wed, 21 Oct 2026 11:54:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5DF7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=CA4GxKvW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QrrjVreYewFPlDLvmFbOvPuZdyfP9XHgAi8UP26a41tZIE6YqRyA5T8yWcaEtMMPyIZPnuC+rEIf1CwNJc1dehT3sN9/c1MC5Pufu7XjwuBGWugVLCSL0f6gd5cCxlSqYg4HT9fbJGenv0zhXjEGJ9rPAL+tpBqGXGJUs8Rnp7JkSAfRmCfWsaBwbE+4zhUe9UuEcLUoWAfKer4Tj7vR/BWrfBjHKYB2D7E+YDLdgwz0HmJu+PDwH2SX7F63OWnCytueyvBNyyYLif3fO2pGEuuvBQiMrWOrZllbAbfBta0CEg3fpgFmfMYv5PLENTSTE8KRoJ0NCfL9BehC9WZgLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfY1KJHmmRv59xl04sP9amssRK9uBK+381cbO5hInSU=;
 b=UAN5WO3QUTvspsI9dPiBd2V71ULk6VNt/SjkYGGjWPc+czRN/sHFI5Ta5baaZBzIAgwL63wl902FtbqQSHUdlmv/KJA/oQHjLL3mvI8Cq7gKEoXOuV4yCGOAVljDftsGw9lP3jWHPtkesf+KSxYXzs73Ukgbyafw0XtN25ebjE+DS3oT7z9h1+7luR0BZaCaj6Ie2Rc/1zku6urImWb/hP2LeIIp2LaR7a3Oa0ANaPKjAsA3qDGzAQ7N8sRc9cGGDcjCIK+TLerZP0Vuy7r7q2vuD1H12hmB3lsH5S87J2y7Riwc2tgCjV/sTUOA/BT5iUjMxmFa307nHI/9ZFJaSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfY1KJHmmRv59xl04sP9amssRK9uBK+381cbO5hInSU=;
 b=CA4GxKvWIsuVPFiOnx3/qDs0Hfy9cCDXf11ZoMD1xzrELtWY7q24y+vTTcZ3Wao6f+5voNWkGYD1dBPMuleJm6S7uDmsVAei6rU4bKkOVEDlR1pOAOXbL1+6rjhFobj/LUNxAuRs3IXVgz6OhU5fE+xBkcKpkEnc43KqNPknRtw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CW1P265MB9418.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:29a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 11:54:42 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 11:54:41 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 21 Oct 2026 12:54:41 +0100
Message-Id: <DMAHVQLCMQAN.3G0TBMA1UTM6H@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Arnd Bergmann" <arnd@arndb.de>, "Philipp Stanner" <phasta@kernel.org>,
 "Sumit Semwal" <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, "Yury Norov" <yury.norov@gmail.com>, "Rasmus
 Villemoes" <linux@rasmusvillemoes.dk>, "Tvrtko Ursulin"
 <tvrtko.ursulin@igalia.com>, "Danilo Krummrich" <dakr@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, "Paul E. McKenney" <paulmck@kernel.org>
Cc: <linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, "Linux-Arch" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 1/2] asm-generic/bitops: Add set_bit_release()
X-Mailer: aerc 0.22.0
References: <20261021095512.1345191-2-phasta@kernel.org>
 <20261021095512.1345191-3-phasta@kernel.org>
 <9f4bbc9a-fc36-4e3a-9c42-d18419c9d025@app.fastmail.com>
In-Reply-To: <9f4bbc9a-fc36-4e3a-9c42-d18419c9d025@app.fastmail.com>
X-ClientProxiedBy: LO4P265CA0104.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::8) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
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
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CW1P265MB9418:EE_
X-MS-Office365-Filtering-Correlation-Id: c99e6332-f617-4a39-652f-08df2f6a1789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|10070799003|366016|921020|56012099006|4143699003|261009223027099003|10067099003|18002099003|6133799003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	iWL5sZdTd/iuz2n2xFcy1RXuOjol+5n49x9HkdL7FEkcfABdJy+L9or8gnSg/kD4szKpS4VJy5tOM494ampA+WqvuwR/RDhYgVHBdATU3b13/XDyc+5Sk7BI9tL2Q0U0t6POwipaosN/56IRxDjG0LdJWUbIMPSRQhnQ22tR/QQiCQpYZAcIshY/R2Gf9iGjdJpLt3QMk/FE87duBbQ5ixxfhnpEDtO3W1TbKEfRDvgkFR9R3pn/vvayR7BOhL4VQEHVx9OPbQsKE0t/yxosOHg6AXQ88fLxDRK6Rjv3JW94/oojlZ/w+rTP4twmLy4VV2TpWv7mKWDj3CkDyku3lR8G4SbsWjDgHyppXrSV8chEw5kBgu1N/VwnmFLa22yG3Zl/A1XmSDXiBW+YxxV5kzNMNGCedp12u+ko8H/UT5qfKPT0Dk4QBvqHL4aiK4itUvB1lTm8lSvN1ccv8xRyYW7HVSP3YtviWzSz/9cdeuvp4qhDq1g0sm+B3I5+p1k4KXD/0IV55adeUcAE4H0Yak/0kMbqh5OrC9+3EDw27eYgvCZJ+g5DTxI7WlGQ+4YJj285PgTDRLpJdGeyqEe6oIuna966cwusdnflobUjiVSMd0wGzarkwHa/QIfIxFFi4BIwCT5ZK6aG/lHSlgqqa2oJsZaLkt4InGSHP6bLRdIOi2VoqgcVSlOPpQowZ/cqm9I2387tDVVBwmtCMmPt6g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(10070799003)(366016)(921020)(56012099006)(4143699003)(261009223027099003)(10067099003)(18002099003)(6133799003)(22082099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2VmbXh0ODk3TE5xK1lUQmhxajRWTWpFK2pucUVrT0RDQnplUEc4OGk3QTRs?=
 =?utf-8?B?MlNRcGRXNUNWVE8zdUlYdnlhSStqbFhQV0YxRGhKRGxPUk9jTEh4Y0R5M2ZR?=
 =?utf-8?B?a3ZQeGlkbklEMXJIUEV6by9RVDBKenNMRWczYWtNVlB5R0F3bmk2N2h2cHE4?=
 =?utf-8?B?SDVPcHB2dU1ILzd5U3ZvdEN5V21nTVl1aURrR1dyRVhuMHVnVGVvdEIzVTNW?=
 =?utf-8?B?d3AzOVdOMHdBcWN3K2FCbytBMkZ4QjQwVXhINmNVMGFMV010NC9QWjdDbURl?=
 =?utf-8?B?Z0V0TVE2Q3dEdVBtUUNNS2pJRklXWWlHeTIyamdwMHVFN3p1aUR2QWQwcklF?=
 =?utf-8?B?ejYwVXIvYW51MWRkRGthR3pHOEZCdlIrWUJBV3FBdTRJZlFoYmN0WUJWblNP?=
 =?utf-8?B?TFlzemt5WU9wOFNOYzd0WHBqbzl3bEw5S3AybzV1U1N1UTJWR0xtWmVCenpk?=
 =?utf-8?B?VjAwOGxYM3FXN2piRzZ1WjJqd3dSN1BhL3VXNzZnaXBPNjhWVWR6V1J3Z2Z3?=
 =?utf-8?B?R0daelJXN013dEpJc1llVzR1ZmtMSm5KRjA3ZU81cHROMzBIaGxIcXlOaWVB?=
 =?utf-8?B?TDU2Z3ZnY3kydENsdDd6QU5zT20zcXFteTdrcWQyZmFpMG5KTDFFNFdjNUgr?=
 =?utf-8?B?NEozbDZkeVVvaGMvcTBvNWF6RFVOQ0JkSmRXZzBKMHdnLzMyODlpc1l4dTNQ?=
 =?utf-8?B?YWljVWQzcURIKzFYVVNGOEdJUVI0N0dRdDdMSWNleWkxNUFKOVRGT0lUZTAz?=
 =?utf-8?B?K0Qxb3hTSkZRL1EyZ2JFVVQ0TXgvWWEzUWlqeWdmMmZIT3QzSGJYNk1NRDdB?=
 =?utf-8?B?eWs5NCtmeVV3NUhYWjlTanJFNzQyY1lYYU5XaU1iL21nVkpJRndvYnlBdHVs?=
 =?utf-8?B?MVd4R1htTXVCSVhFeHFTaHVkUE1XNStJNVpPSVBuMytHVXFIaStTczQ0YjdL?=
 =?utf-8?B?ODBQVkhWTEJwNDl4V1VxYzRvYW9YaWc5NVdsVVVJaGpDWG1rY21QQ1pXZGIy?=
 =?utf-8?B?Y0doTkdUSE94Nnc2R2YvTFFOM1AzUG1yWlp4M1RENHlGZW9sOStZNG9yUjdV?=
 =?utf-8?B?bTFQbVNyOFVTajNQbmo5MlJQd3R3SFZLWjVrUGEwZHo2b0NDZk1mZmZaNjgx?=
 =?utf-8?B?dEJSSWx0bnc4eWdqc1JadkdITUphazQ3VWtZdVEwQzhHdWUzVkg0RmlxdFc2?=
 =?utf-8?B?OWs0OHdyM0l6aWNhZWFaMEhPUW9LN0t1YzYrdTliaDRiR0NKM3drSUFxbC9t?=
 =?utf-8?B?Q2FDbkEwbkt3OFRkdURpMHlpWVVlZjNWSUtnMTBXYUx1T3NQMTBNTVJFZkpN?=
 =?utf-8?B?SHI4OS9ENzFFNTRVRlFIOHNNYWYxakpzczZEMi8xTldsU2NITnJ6OGdsbHRP?=
 =?utf-8?B?eXRQd0tLZUZiak9VTVk1UzRJekFEdy9weFVHWFlPeThJWWQ2LzY5MEdFV2p0?=
 =?utf-8?B?ZEtrSkNOWFpZUDZwOTVOOVFySEZLTEhVUEVNOXBFQkxkVlZqQmU2bEdaa1BF?=
 =?utf-8?B?bStaRXZZb3dVemcrb0dWMSs0ZXJsYStSc3FyUURLY0ZoUVlVcjJheUJkZVN5?=
 =?utf-8?B?UG4ydTU1eUdZRmo5V2xMZlFJVXJidVZ2dkRva1pYS094bElHNDlMZ3Z3elpD?=
 =?utf-8?B?eVVMa1I5Z2pXRjNyK0k2RWtHRnNjTG40UFdiRXg0b0pLNFhpVWxqcjhWamdn?=
 =?utf-8?B?RmtvWmhnWHhsMnova21BMDFHcTZPYjg4eW9DU0tMd3FMNENWbUtBVkl6NGhI?=
 =?utf-8?B?cXR0M2o1VHJtVzJkY1YvRHRuNUR6NHNLR1pBT2VLemtiZXdaS1BqZlZnVVV1?=
 =?utf-8?B?a0UzN2JoK0Z0ZFVmbk5oQ05ZQVo1MUMyS0dKdWJoTXcyNk02cVFDbkhHNGNH?=
 =?utf-8?B?VTFXM2Zub2ZJL1hzSDlHN3BjU1IyYXBvL1VUMGluTHdCVExOdWhGcmFMdkRs?=
 =?utf-8?B?anZOWll3ek9jV3lrRTRhVHFkZWFXQ05MZWx1Yk04Z2thakM2OVlNZUVCSU1o?=
 =?utf-8?B?ZW5qYk5adjhTMkJwd3lGa21RK1pHVUtGaS9vVDE2NjZuS2k4N05RaysxQjdR?=
 =?utf-8?B?QWtkUEFtcjRsQkhDSTk5VlNaLzRDeTl5WEtLcFE3S04raHFldVZpQlNWT1Ru?=
 =?utf-8?B?ZkdtRE1hVjBCaW9paVVNUVZlaVNld0ZNS2tGOUlhTFFiM0NQV3gxZXY2a0FS?=
 =?utf-8?B?NXJQYTV2QTFmS2szcmVvd3JmbUNHQXpIWFhwZmdIaWFHM3JoM2VON0lYaHho?=
 =?utf-8?B?eWk1YjM1WlJYWk1XcTBHN0FzVGF1TWlPeFJTNTRWNktTcUZiK2hnYnF6L2VC?=
 =?utf-8?B?UGFleGNJM0RsdDRncm9MQW01UUNrUTkzMnBvSU9jSXV1SzlIQmtSUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c99e6332-f617-4a39-652f-08df2f6a1789
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 11:54:41.8664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nYun2Ifu3n4tm2zQREZllMe+x73lBsRMSC1hCDmqBBeKSd5ARo52KAuFf7iYtQ+iLO7Ju7vyL7VjQ0lk5meOhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB9418

On Wed Oct 21, 2026 at 12:33 PM BST, Arnd Bergmann wrote:
> On Wed, Oct 21, 2026, at 11:55, Philipp Stanner wrote:
>> The kernel already has test_bit_acquire(). A set_bit_release(), however,
>> was missing so far. It can be expected to be useful for parties that
>> need release ordering, but not the stricter full ordering of the other
>> bit-setting functions.
>>
>> Add set_bit_release().
>>
>> Signed-off-by: Philipp Stanner <phasta@kernel.org>
>
>> +/**
>> + * set_bit_release - Set a bit with release ordering
>> + * @nr: Bit to set
>> + * @addr: Address to start counting from
>> + *
>> + * This is an atomic ordered operation (implied write memory barrier).
>> + */
>
> Can we fix the mismatch between code comments and documentation for
> the set_bit()/clear_bit()/change_bit() barrier semantics while adding
> this? I'm always confused by this and the new function makes it harder
> to understand in the current form:
>
> - Your patch description mentions that set_bit() has strong rw
>   barrier semantics and that set_bit_release() would be a weaker
>   write-barrier version of it. This makes sense given the
>   set_bit() implementation based on strong raw_atomic_long_or()
>   in arch_set_bit() and the text in Documentation/memory-barriers.txt
>
> - Contrary to that, the kerneldoc comment over set_bit() mentions
>   "This is a relaxed atomic operation (no implied memory barriers)"
>   and leaves out the kcsan_mb() that is in test_and_set_bit().
>   This makes the new set_bit_release() sound like a /stronger/
>   version of set_bit() the same way that test_bit_acquire()
>   is a stronger version of the (relaxed) test_bit().

set_bit has relaxed semantics while test_and_set_bit implies barrier. RISC-=
V for
exmaple will generate the amoor instruction for set_bit, not amoor.aqrl.

Best,
Gary

>
> As I understand it, the kerneldoc comments here are incorrect
> and trace back to the include/asm-i386/bitops.h file before the
> git era. The patch below should make them consistent with your
> patch and with the actual implementation.
>
>        Arnd

