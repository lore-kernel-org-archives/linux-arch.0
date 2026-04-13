Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010039.outbound.protection.outlook.com [52.101.201.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4817D19DF6A;
	Mon, 13 Apr 2026 05:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776058396; cv=fail; b=SZuGPfU5lYwyEKPlKp50ykOxvUdIGy4MHdUY6H+3rTxlDtMX+LGG8+BsnTcPn2kEQGVxf3IZbJHaVOpMMPwUlQhaitwMb55neP5L6GS6iaX2zs5mUs2vWCjAh0FRrL41FhBUhic+OCVpjOfE5HY+jCXB6d4ftrM9e3x6RoJiD4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776058396; c=relaxed/simple;
	bh=QaoctYu4na5I/KfYJ3YhpFysZ9xWgyjVIz/0WerbvHw=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=OdDvXk8t5aks5DjlOrXUbBVaY0NY53vO1MLLpxzYgYaX98WjWdoItry0ggCbU7DzDD5UTuwtgUFMUNcM9seWlujKyvlIVYlMyFqQNjfS8PY8RlaLIpZ3BmVySMfaWIdUH/XYgJtGjSwOrff8nv8tt80tBqZFJPWSulXWkcUgPyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Imhnpx5H; arc=fail smtp.client-ip=52.101.201.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Imhnpx5H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h3XWeZSjfBiblLm3gOqCmdAhrQcqEfk3iQXkZQzBxewHAjSp5R50lsNod3IdBAKiqMPdv9fLwqKRqwiZ9KHBrguhsKUJejzuEWJqPVx6+u/aHoNbkxkR5DKq3jJvGflBrAnXFHYGHL7ZjSWWfgF1ec61EnjXSUOIffVwlBt2cglli95M8brhJkzxvOrDkkYSf0piAAXYr4KN9SWiU8u+ilHOUC6kgpCtl/dO73FphCS6lmdaIwFZcSMz1mfzft+WkjbxRUeUEnbu9rWmP0A6weTHdvZszDB8MR6Bp0T4Wxlapz82pqs0Ip8sCzybqr44UVhMMQPGtuqs4lskVQQbtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ufeM67LjRdcteoiApXi2hnaCgJwv5c/e/jg11cMSN8=;
 b=Nf454I1wAH8fC5OtPXlepG7DrmJ1Dbyb2n+iv0EtgvuOE8SSRhVF3ommxQk6vHWoWAL+MtikDUjaKlVESeoLzMZKm8EkyzGfd8wrBYuhP7mWlVEbiy/2Q7piJ3MaXLSHp2KHYbRLBdjyoH+shdzpg78NhOcrlZPgVGoRoPX8MgqoYMV9bh2DtqqgLWzp+0qaQ9MRPflr+ZigKiml/1RJGxSSLUS5kBTRmZI5GWrLBHBfHWyptrZNfTPb9tH62QdtUAP5RUmey4SPewIbFKOJ9AWBjCLkOD3hjfyiUXKQ86N+S6llld6/jwByoHj+5PYjzh4JQkMSmlu8SOj2QyFcxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ufeM67LjRdcteoiApXi2hnaCgJwv5c/e/jg11cMSN8=;
 b=Imhnpx5HNVJcbHQ8Id5hD2xroXK3L4AcbODsgwZ2o2yMbfnfoNVB2vIprvnK3qpOjpo4OaXiRYJ3r71vuw7XNa304iWP48O2ZE4KTqBh5HjNpKjSsBC+OWnJfyVOwkJ5SgFWpIhEpJeBqzEWJtPVqFZtyj7De34dgvPFWuhh3c1/hls43rEFk7yQTHi86J6iqPgTHnUR4T4Lmg44AFStTG/SHpGOyxnKsypKgmTtRZJmdWKJYfb0/X6m4Dro2j3uQWdzT1DWZ1jxhiYz0P9wPpPNJB6bXf0XqorZKy2yb75jvtZm3bMwqzwowaEVntosdC/gA0W3Bjezl0OgDpLj/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by SA5PPF5EA4322E1.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8cc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 13 Apr
 2026 05:33:08 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 05:33:08 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Apr 2026 14:33:04 +0900
Message-Id: <DHRS5I7ZTI01.27WY0OTHA7ZMQ@nvidia.com>
Cc: "Alan Stern" <stern@rowland.harvard.edu>, "Andrea Parri"
 <parri.andrea@gmail.com>, "Will Deacon" <will@kernel.org>, "Peter Zijlstra"
 <peterz@infradead.org>, "Nicholas Piggin" <npiggin@gmail.com>, "David
 Howells" <dhowells@redhat.com>, "Jade Alglave" <j.alglave@ucl.ac.uk>, "Luc
 Maranget" <luc.maranget@inria.fr>, "Paul E. McKenney" <paulmck@kernel.org>,
 "Akira Yokosawa" <akiyks@gmail.com>, "Daniel Lustig" <dlustig@nvidia.com>,
 "Joel Fernandes" <joelagnelf@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-arch@vger.kernel.org>, <lkmm@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH 3/3] gpu: nova-core: fix wrong use of barriers in GSP
 code
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260402152443.1059634-2-gary@kernel.org>
 <20260402152443.1059634-5-gary@kernel.org>
In-Reply-To: <20260402152443.1059634-5-gary@kernel.org>
X-ClientProxiedBy: TYCPR01CA0096.jpnprd01.prod.outlook.com
 (2603:1096:405:3::36) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|SA5PPF5EA4322E1:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed4a32a-1c40-41c1-d0c2-08de991e250b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|7416014|376014|921020|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	vHvcTVRW5jzM84i9IPMm0DIIg5ePHfJTxxxj83oXFxTe/VX9DtGwJt3fPCNehtB8w4j3MsJ/+jqxDvVj5zq/rW2/rRJwlljh65kGXbQtGAvDNda0Ok2v+IPMKABnAcX+2j1NbcjQZQzSMbN3kyUo6f+Qs+HTBPedPd0cB13zC8BNjt0J6ylrgcmoFerpb8Ltq+NLiGy/RN1GSxCb4f/Kr2F7QKc/9lHlSyewhHsNhpNRStUGHhI3k698I88QRnKj44vGQAWIlt45bh7AklyNRAGFSQ+VnThN8Q8hzSP8dfdCICZQJ+ir5eRBHhmSvjWFNYkaQRCay6Ml3qE13RJhLzcx78Vq/mcJdI8PQOh7nTj13TYna8jRSDYceKhZcLSMiN1kDwLaGDeT8Rnw651bU2pH+x6BpZ7jNul7hSFIR67zYJ8eWNmKlWGZ4/JLiFI/c0GApUVbnXMI5IkODGcIkWHYRHF9a2IN3z0izGR2yrxxItqRwTnUiMpFRpVBOfVeGjd2HpjlFpY+Q5Cilv0lPZgVF4lX2Uh5gdpw6E8awJcDg+86VzCptk57JatlvhwQDlEvhgvsgAWj85iE9ImQdz4GgTrT45Xt5zvHAIZWTBwaTlwBQa+WZ9xs5jQ8bp3Y4uTT3DaPVWfLcF4DQzM7Den00ZhgegMU1swU7CGyOpJ6nz6luZXMkuI5EFxQey8BtaqKCVWsrz96ycrdbq5X5QxWIUCtAoQa76Z3PBcc7Mm86yO07CXP9Lwnv8oa3WY+Ca34nsOhLu95qR2p3WqOGw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2353.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(7416014)(376014)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MU55dzZwcC9RVDIyclE3dWtMeWVpaHpaOFA0eHhPcmZrL245cU41cjJSNEZZ?=
 =?utf-8?B?YVQ1K2Q3RGh1aTJCWGljWU94V0lqMldFM0g5RTQ0L3NBZUhWUGYxakpRVVVv?=
 =?utf-8?B?NGlhSDBlKzAzQzlnRHV2WHRGeCtEQWJ3TVBuZFcwS1d6RjZtVzdVbnNabUZW?=
 =?utf-8?B?U0JXSXBidmhSaUZhMWZRNnRreDl2TmpSU3ZLK2EwUUNBY1N4eE1MRnZtZWVU?=
 =?utf-8?B?aW1BVzFjS2t2S2IrNHlnajEyTHdrNE5zbUpQNHVkUzVETUdOYk5saGFjZXA5?=
 =?utf-8?B?bkFGQWZCTUp3OTdVZEZ3ZHl0NTVxeTNkVVJCTGdzUU9QNGcrL2tHWVMvRnNH?=
 =?utf-8?B?dExYTXlFNWU0SUcwMlZZc1RmeWtycFI2ZkMrQkJERGhhZm05dVlrNVYxRjcx?=
 =?utf-8?B?eEhIUnN1VFd0bzdZSTJadVNEcklsSjZXdlVoSDVibFhtUzlnSVVLZVVRSC95?=
 =?utf-8?B?ekt3NlpWVU0rTVduR0RqUTg5cmtjNHp2dmVVeVF0OXdJdm1sVzNQSEUvVjY1?=
 =?utf-8?B?Z1BIYjJVWEhnT3JvdEVEelNsUEpHRkJqbjhTaFBhb1ZUTWR4MWFTeG1wUVpC?=
 =?utf-8?B?S040bWpuUnJVT0hYRGpzSkwxRS9tNU96Q2lvMkFxZjd5TmdYTnhjV1RhWlpW?=
 =?utf-8?B?VzhvWUtIVk1Sa2JBN2FwdE1yV0w2YkpXRUYvNXZQczdTY1hoa2l4c3NZZUhn?=
 =?utf-8?B?M1FBZFRKL3pTcGJQVk1RSnp0eDFlU2ZRd3V1RDFmY01vUEw3Q1B3WmtBNWFq?=
 =?utf-8?B?S3ZxenNVclluU0ZCaXFKcXIwS1RvejdScEQ2OXg1ZWx1RTVEd0JBbnBRY1V0?=
 =?utf-8?B?OUJjTlZEVUxNWitDWTJIMUNUYVZia2ZzUml2d3B5Wi9oN0ZtRDFhNGJBWlZw?=
 =?utf-8?B?VzU1S1FXTEdNODZNcmlKR1NaYktXbVAxaEdqVkhFdmc3NzM0MlZFcVRQaEFW?=
 =?utf-8?B?ajN5Yllkb3U0QXNpZUIzRjY0YzAwU1ZLeFVuLy9uWjRxdW1yMFZ6WjV2bUJG?=
 =?utf-8?B?THV3Z05ISTU0U2ZYSm40VDlVd0dpS3Zyb2dEMk5mS1E1bWtTZkhsUHBXd2lG?=
 =?utf-8?B?RmNHNnlVRytNa0NSVXYyem9Vb3VXMXhpY2w1NjhJd29mV2ZFbHZ0N2hOREFQ?=
 =?utf-8?B?WXpmaC9PNCtVS0ZEMDcvMmQ0K0FlbC81T2U5TlJPL2JoU2NoQ1FtajByQlkv?=
 =?utf-8?B?eE16Z1M1eEdOSllBY2pyWHdjeFhoSGZGRElUblk5Ri9RMGtWUWRzZGs3RWN2?=
 =?utf-8?B?dWdlOWlveVBNdHQ5Ukt6ZHZzM3BzZlJQYVZKT24xeUZUR29yTC9IYXF5Ump5?=
 =?utf-8?B?MmZ2WW1WU1lCbnI5WENYdklQRDI1ZUJ4TlF0Vm84cFQ0V3N5T24zYTdsZlgv?=
 =?utf-8?B?aWRhT1dkbGdZR25JSkZ0VUZYT1dBQlZuZXJhalZOTkM4SVBrOERacU9QQ0xr?=
 =?utf-8?B?Sm14TXl2bXlwbWtxbnU2R0VvU2FLaWg5LyswdVFGTDU0cCtKbDNPQ3BocTE5?=
 =?utf-8?B?cHdlczhQR2M3Ti9WRFlkWm1ZdWtvNE0xUWlNMzcrdkxYamUvNWNFVTJXZmw3?=
 =?utf-8?B?NFpHZTlTcm8xczY2N2k1V3UzWFNzZCtjdmI0UHJhbGRCZEpQbnRLaDFibmQy?=
 =?utf-8?B?ZEZHNTg5YXJHNkRaNUFpemFicWRNdGhTWHJxS0xRcDNJcVY5dm40a0pwbkxF?=
 =?utf-8?B?eUFyZDY2NzdVWXNhNVJBcC9JaDBlaEpkbGNETXY1TTVXMjNxSUViUlBLcElC?=
 =?utf-8?B?WlU4YzZpNDJKVzBscG1RVzc0bjdhaWpjNTcrQ09tK25ibFFTdUVGQS93Ukt4?=
 =?utf-8?B?ZWdLVFhBU1IvS0ZoVWVLMGZFOGVxUjlwMkduclNJNWQxRFZSeDZOS2tQWU1t?=
 =?utf-8?B?QnZGUnFQNlk4d1B4SHF0NlluU1lyV1AxK055ZGg4K29kSnpOcXRXT0hFNTdh?=
 =?utf-8?B?L1lFc1pQdThpa0puakMwck54R0lxdXh0SjdWQ3EzdEYxZ1hISitnNkVGR0Ry?=
 =?utf-8?B?SzBZMGtqR1pjL3MxcVl1WXpNWjFBWEhXMUoyMkpiSlA3eHZ6UnhSWTF3TVN4?=
 =?utf-8?B?VktOdGFrNTg4eUtHRTJlcjU4ZXJJeDlkYmJCanlFVTNoMTN1WGl0WWtlTW1H?=
 =?utf-8?B?L2tuMkp2a2pVRldZdkFKLzF1Y0pWdFpjVEhDNXZYU3BBOUtRaEVieURBalk2?=
 =?utf-8?B?RTgvckhrOE1kYms5UU9Ga3REQmZXanB1VDVnT0I2azhZOWpadDFsV2pSR3FO?=
 =?utf-8?B?ZHdLOFIxMStxa2F6bGc5clBjU0phU0M4RnBISXIrVnJvVTYwMTBkakxzT2VF?=
 =?utf-8?B?OTVMVmZCMEpjTHpXdGk2WGs2dWx0cmpieHd5cktLQm1wSTNxcW02RDFTL0JZ?=
 =?utf-8?Q?ni10SaNK2/FmBwIaE4RGgPfUOWDsaMV+ytEHaGLxE/6LK?=
X-MS-Exchange-AntiSpam-MessageData-1: CzuWpURCUK0+eg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed4a32a-1c40-41c1-d0c2-08de991e250b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 05:33:08.6693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y+F3EDO7RGhGMEa1op4j8PKl9MsesZac/8K13v1XdR38fxqOYVJ0rJ27G0G0CTnvVh4LAHOc+7AkisUlJClUSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF5EA4322E1

On Fri Apr 3, 2026 at 12:24 AM JST, Gary Guo wrote:
> From: Gary Guo <gary@garyguo.net>
>
> Currently, in the GSP->CPU messaging path, the current code misses a read
> barrier before data read. The barrier after read is updated to a DMA
> barrier (with release ordering desired), instead of the existing (Rust)
> SeqCst SMP barrier; the location of barrier is also moved to the beginnin=
g
> of function, because the barrier is needed to synchronizing between data
> and ring-buffer pointer, the RMW operation does not internally need a
> barrier (nor it has to be atomic, as CPU pointers are updated by CPU only=
).
>
> In the CPU->GSP messaging path, the current code misses a write barrier
> after data write and before updating the CPU write pointer. Barrier is no=
t
> needed before data write due to control dependency, this fact is document=
ed
> explicitly. This could be replaced with an acquire barrier if needed.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

nit: should this have
Fixes: 75f6b1de8133 ("gpu: nova-core: gsp: Add GSP command queue bindings a=
nd handling")

?

> ---
>  drivers/gpu/nova-core/gsp/cmdq.rs | 19 +++++++++++++++++++
>  drivers/gpu/nova-core/gsp/fw.rs   | 12 ------------
>  2 files changed, 19 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index 2224896ccc89..7e4315b13984 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
> @@ -19,6 +19,12 @@
>      prelude::*,
>      sync::{
>          aref::ARef,
> +        barrier::{
> +            dma_mb,
> +            Read,
> +            Release,
> +            Write, //
> +        },
>          Mutex, //
>      },
>      time::Delta,
> @@ -258,6 +264,9 @@ fn new(dev: &device::Device<device::Bound>) -> Result=
<Self> {
>          let tx =3D self.cpu_write_ptr() as usize;
>          let rx =3D self.gsp_read_ptr() as usize;
> =20
> +        // ORDERING: control dependency provides necessary LOAD->STORE o=
rdering.
> +        // `dma_mb(Acquire)` may be used here if we don't want to rely o=
n control dependency.
> +
>          // SAFETY:
>          // - We will only access the driver-owned part of the shared mem=
ory.
>          // - Per the safety statement of the function, no concurrent acc=
ess will be performed.
> @@ -311,6 +320,9 @@ fn driver_write_area_size(&self) -> usize {
>          let tx =3D self.gsp_write_ptr() as usize;
>          let rx =3D self.cpu_read_ptr() as usize;
> =20
> +        // ORDERING: Ensure data load is ordered after load of GSP write=
 pointer.
> +        dma_mb(Read);
> +
>          // SAFETY:
>          // - We will only access the driver-owned part of the shared mem=
ory.
>          // - Per the safety statement of the function, no concurrent acc=
ess will be performed.
> @@ -408,6 +420,10 @@ fn cpu_read_ptr(&self) -> u32 {
> =20
>      // Informs the GSP that it can send `elem_count` new pages into the =
message queue.
>      fn advance_cpu_read_ptr(&mut self, elem_count: u32) {
> +        // ORDERING: Ensure read pointer is properly ordered.

What about a more specific comment that describes exactly what is
ordered, e.g. something like:
Ensure all reads of message data by the CPU have completed before writing
the updated read pointer to the GSP, since it may overwrite that data.

Maybe this is just me but it's a lot easier for me to think of the
orderings as a pair of (load? store? -> load? store?) which works for
everything hw actually supports except for ll+ls+ss, rather than mapping
'Release' to (load+store -> store) in my head. e.g. here IIUC we need to
make sure all loads by the CPU are done before we do the store for the
pointer, so we need to make sure loads don't cross ahead of this
barrier but also that stores don't cross behind it, so (load -> store)
should be sufficient? So, depending on what you want to do with the
memory model, this could be tightened IMO. Unlike the one below that
only needs to order stores with eachother (ss).

> +        //

nit: stray //

> +        dma_mb(Release);
> +
>          super::fw::gsp_mem::advance_cpu_read_ptr(&self.0, elem_count)
>      }
> =20
> @@ -422,6 +438,9 @@ fn cpu_write_ptr(&self) -> u32 {
> =20
>      // Informs the GSP that it can process `elem_count` new pages from t=
he command queue.
>      fn advance_cpu_write_ptr(&mut self, elem_count: u32) {
> +        // ORDERING: Ensure all command data is visible before updateing=
 ring buffer pointer.
> +        dma_mb(Write);
> +
>          super::fw::gsp_mem::advance_cpu_write_ptr(&self.0, elem_count)
>      }
>  }
> diff --git a/drivers/gpu/nova-core/gsp/fw.rs b/drivers/gpu/nova-core/gsp/=
fw.rs
> index 0c8a74f0e8ac..62c2cf1b030c 100644
> --- a/drivers/gpu/nova-core/gsp/fw.rs
> +++ b/drivers/gpu/nova-core/gsp/fw.rs
> @@ -42,11 +42,6 @@
> =20
>  // TODO: Replace with `IoView` projections once available.
>  pub(super) mod gsp_mem {
> -    use core::sync::atomic::{
> -        fence,
> -        Ordering, //
> -    };
> -
>      use kernel::{
>          dma::Coherent,
>          dma_read,
> @@ -72,10 +67,6 @@ pub(in crate::gsp) fn cpu_read_ptr(qs: &Coherent<GspMe=
m>) -> u32 {
> =20
>      pub(in crate::gsp) fn advance_cpu_read_ptr(qs: &Coherent<GspMem>, co=
unt: u32) {
>          let rptr =3D cpu_read_ptr(qs).wrapping_add(count) % MSGQ_NUM_PAG=
ES;
> -
> -        // Ensure read pointer is properly ordered.
> -        fence(Ordering::SeqCst);
> -
>          dma_write!(qs, .cpuq.rx.0.readPtr, rptr);
>      }
> =20
> @@ -87,9 +78,6 @@ pub(in crate::gsp) fn advance_cpu_write_ptr(qs: &Cohere=
nt<GspMem>, count: u32) {
>          let wptr =3D cpu_write_ptr(qs).wrapping_add(count) % MSGQ_NUM_PA=
GES;
> =20
>          dma_write!(qs, .cpuq.tx.0.writePtr, wptr);
> -
> -        // Ensure all command data is visible before triggering the GSP =
read.
> -        fence(Ordering::SeqCst);
>      }
>  }
> =20

