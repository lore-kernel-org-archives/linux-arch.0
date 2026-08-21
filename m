Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021074.outbound.protection.outlook.com [52.101.70.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF6A47DD78;
	Fri, 21 Aug 2026 15:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787325508; cv=fail; b=c9WrOOIZ+2C4eNSiYeoo1UhVZaDBv0Y35A3/spoZ+46281v+/HhE1EMr/NG391WUMFz6lhb1synp5NdgOEyhVr3N0mKI7plS+k1pVG2e2WVVJvFhd/FErT9L9zVtXCkQ7Ywm8iQ4B3fGTQ+BrZr5vVdbICnKaO64gCHRzv9S3ZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787325508; c=relaxed/simple;
	bh=Hldp7ewlMcuvdLG3Vn5HRr48hriZfyjhvl9GR9wo66M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mXSlI76+bPEuRVyU1aZ8sr0/HsNnj7R0ijwct2YqE21qmY11lGF9+k3TfLNgTjBdy7Pjzy6vjjOZw150LejSDKa1jCAtxy44TP0B6QnH7Wm6NpQcJID235hlA+UE8/U0cSv/pUDuN0SuLEMdPX+f5klrHhkEJLinYiX8KCJfqWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de; spf=pass smtp.mailfrom=yacoub.de; dkim=pass (2048-bit key) header.d=yacoub.de header.i=@yacoub.de header.b=aG6twZ23; arc=fail smtp.client-ip=52.101.70.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yacoub.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yacoub.de header.i=@yacoub.de header.b="aG6twZ23"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bSyc+VvqaPLcb8963F9wCptRRwJzyUSiGLEgf28Ye3odlmo35/6rmnFVpGzWwDwINGFmyeh77KXbF6DnlwosQviV/DZV6cik01KOj9K8sWXoafa4KooohI5o0zzbQXakNnZFjXK3Ly5SOCkQKFpI2RdmZv8gX9W/sK1OLgwyTnobAUQxPt2deFyAkAN7vatOHBoq0Ea3TGh5Fgc++nIeWLwrA5vQJ5369QJuDyYl8ws4+MbljuZJVhdlPzf94rJMw7934bhra7Ud8X0Dm7Uvj76JPfvSDS6ohWgey0GqAfYgZV6t31Hb7+AJxvo2CzuNvd3JPy79/POSXa8nvH1BdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GTD4ix38jIyvdEfFR6UD3f1M85fDsXJ3Iom0skXErW8=;
 b=WIL4fwkYa3xplCfgS5x/G5KpDPT201jujIEvjOL69p+z+kP6p1mzIUuxG70aNCMySpu7HFAZB5AutzG184E6py00T8i9yHP+Xm6WmMtRzKPlw6ZcyiKFaiQVLZCyBA/lbjReeaVstFAoz3aud2V4e/y4m2CQ0EB6gOUO3hT7/PgWjslNp1Bd58SVcLyQnC/9bRDLRZHC1G1RAqoBUE3+gATfdvc6h6PR5wuulQcebw0OhHqh6kRWMmrI37cXRscYBb1xniXz18JDtBgMdxBsfL/sr+B0UM4bHuktpWxkIihEoKvimw2LMPBkkRzRGpISzOjvDxcAPB30apO/eY+7+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yacoub.de; dmarc=pass action=none header.from=yacoub.de;
 dkim=pass header.d=yacoub.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yacoub.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTD4ix38jIyvdEfFR6UD3f1M85fDsXJ3Iom0skXErW8=;
 b=aG6twZ23AVNOpLBmWjOd+E5FOuIorS9eUy7CBIrT5LzjFlM6HemXM79Yvt228JbQFhJa9j3XMMIprB5/dLWkKIjaUN/zQRRhu7V2rI8kZP54w2Lhwvlp70PBVSndSeoj/WQEL+tBB5TQ31zc+n2gbZ1cULfp2MO/dX5Qry59NahVaKqbKglCtG9maFavdBrBsaXTzQXzzjZZYcvRKpthLGjLU8wXNoVPKqeLJC/tN8r9cr4RZICgulEBXFMODAzJ5XhSGi7NZH1HTojlHQashzFJuN6rj+3IPW8TMb4arRulMs9KJerJaVfX9Mtm2xiWkyzRs4QDESOgv9ZvmqtffQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yacoub.de;
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com (2603:10a6:501:99::13)
 by AM0PR04MB6963.eurprd04.prod.outlook.com (2603:10a6:208:18b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 15:18:16 +0000
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809]) by MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809%4]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 15:18:16 +0000
From: Ramin Moussavi <ramin.moussavi@yacoub.de>
To: Michal Simek <monstr@monstr.eu>,
	Michal Simek <michal.simek@amd.com>
Cc: linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org,
	Sam Price <thesamprice@gmail.com>,
	Neal Frager <neal.frager@amd.com>,
	Waldemar Brodkorb <wbx@openadk.org>,
	Michael Eager <eager@eagercon.com>
Subject: [PATCH v3 2/5] microblaze: reserve the ABI argument-home area in the signal frame
Date: Fri, 21 Aug 2026 17:18:06 +0200
Message-ID: <20260821151809.1233057-3-ramin.moussavi@yacoub.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260821151809.1233057-1-ramin.moussavi@yacoub.de>
References: <20260821151809.1233057-1-ramin.moussavi@yacoub.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0250.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::8) To MRWPR04MB12069.eurprd04.prod.outlook.com
 (2603:10a6:501:99::13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12069:EE_|AM0PR04MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b6cb89e-9547-4d94-1210-08deff976cfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kgNRuGZZgkELVhk+UhzWQV+b0mQJcYX95kLz9qC994np/9tLdNKW9TGLNDdw0AlqYjqvz71j6sf8h73RlDwdhk6sco4csP8uf7STLEaaPo+aGlXZQDQwF8R1o7TJNXciyrcQd+qvCw9OoH3bg6Q0h0p4khUqN4doJaNzWdqyBv4KEnkSUUekPXmkRu9Cn2TXJp5no7he5zzft8XgkwUjsMfZV54xtPoVU01YwfNcqgMPuCman5tfpSGWv4y+l1xO2bPHobNR+6ekIUqv6CNapjzMwUoU7gkAQSm1PD2GzeSN3krEgz297Gf5UWNHeJwA4FeubqLBq9NzTjK95CB4GnN+D7uhsUKLJaz8jAfgHQbA5slTazYta2wjToYr34eBZXangPiObLuDNRjotTfMLPlbg4jp6z94AEm0OC/YM0PK9AC6FYg/z6PcUvfBGMtfiUg9Zxr8VHZKvlNIErmE99hyfXnOgxvbHuBh8J7aTRVzn1NRzeKMJcKRZnqNAN02D3vEsHkqdxXzRIqBqhsV8rZUNrpz6TMO9TxvKXEZzw/9nl4ul6WSKYDSUxgBis6oDW6NxgnaYP+sXaTqmwDT0uhgl7ryL/vtXJ0gReWKCZsMFZz4o8/qnyTkGIUFnpdV9ZhJmeIPxGvXH4zhBQBlXvmgwwzw3Msrbc5cYOaFDro=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12069.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u+kHMIjGvXGZG1Kk77mCvEEeBvzXqNKkMGXK1hGFLjpg6VRX1hHFGc8xImEu?=
 =?us-ascii?Q?9nz8vKM9nb+TRxzpRzcqGXftOs+MayTKPMlbdLR4lrf9kM1IuKTazZzXPC59?=
 =?us-ascii?Q?rWMkV+gIR36vObofWDRNY0kEw3QM3HRPhP/6UxCVaddonguzW79UfXCpTN/i?=
 =?us-ascii?Q?vMSyyqHC5wkxqUl7J84SL+NMBJPIMK3KpVMc1YzCAae4ONMpTxcokVEexHU8?=
 =?us-ascii?Q?25VTSdcb2Js0HULS8GNgnslU6c3rwo4nl8FvSO4BVuIDEjzpOCuxbbYi1R01?=
 =?us-ascii?Q?v6+GN8t5Nw07EMO14DLbDX4XSXJENIRtsAjTZyAV9e1otyoYMycG0mQVXndS?=
 =?us-ascii?Q?/tQiC3ZBv4DSfn2H1fSPmrruTo28+brEgJAusHu1FU+vtlneJzVg0FJL88Qa?=
 =?us-ascii?Q?d0DApv/635S3DoObec7UnuuknXApQMEi9FMcDgygsASqxvUw6W/G75IgmKLf?=
 =?us-ascii?Q?sBq5+kENWpgM51gb+zeixMyu0DSBxmdJ3uNUXjOl0aTed4Pli8i9OvFAYYus?=
 =?us-ascii?Q?HU1PAibl8BIhH9dPyhF2JJU+X4Z+cEfVYZ4vJ6l8wAPZX8cmKDiztir4SvpD?=
 =?us-ascii?Q?0aN5ZdrOTMuGt2NGPNY76IyUvrDqTeH+Ubs9VSP0jW5LgBDvXT7dtQRe4OHw?=
 =?us-ascii?Q?ozIS24bIfnODKCFeS9AKblpheThYWZVbMbNEVlzuoxsgyYwI2fxhQk/0WY8X?=
 =?us-ascii?Q?Myk8YgH6lopSFS1z/LbkmHxSwQvWrHk9LUSg2Lh0cpFx0zXNFDvAY9696189?=
 =?us-ascii?Q?eSL30MtJZ/X2OzLNDMqJNqVo1bUnWj10wJ55Wp0zVQFgtZMKXKqVf4XbVi9h?=
 =?us-ascii?Q?pV9MKBNLwjwL6IJVd+jDEbEzu6vbgaOlhTnFolm8rW3ElTvFokOcPSfmflO+?=
 =?us-ascii?Q?zBSSkCuNUI0xqq74BLbdT/v892USOWDS6KWcQPNQ4lVH6oPW2ghWp7NxKZR6?=
 =?us-ascii?Q?chE2RgZZx88e97EPjuitNWOXOlD7ZHML9WU705GaiJposLhB5ir5E9Sz5w1P?=
 =?us-ascii?Q?pD7oHO1Zic6SROOTOnJQuxsDj1SiQVLWTRVCVoQr0rJN7CLMuTAgATIeYD1E?=
 =?us-ascii?Q?dg6t8PoZupDWAy5md4SRpbXm+IwPzuWG3hUIHh8b2GZDEvy7xNQ/fBd0EjVJ?=
 =?us-ascii?Q?eH3bbTq4hZdGZh7C2gLxvsjCNy4TeoQWYtXM9WlTiJ+1azVHSpYyKq/EOkIY?=
 =?us-ascii?Q?bymmqVQpc1dkIpJj5FvhGAjO2nAFUNewWeoWlZKqGfyacvDTCD665XaomLW1?=
 =?us-ascii?Q?xBSbeB4rvau6JQ0uiFQ62DjWjBS0ksbnBuOIJXVUsYMCAU37G/jZMYC2UGvl?=
 =?us-ascii?Q?Jrr66hrlH3XmAYpLb8dIhmwwWxnbRV3/CGcWKCNseASJCLzKDDOX1KpOwQzF?=
 =?us-ascii?Q?L220X3HJs9HyX1JreKrZH60csKynpfPSeHalFFwlVJvsrnkly1WPtgxb9axw?=
 =?us-ascii?Q?sItVN+0zKTiDlIEiYDk4DfT5lu1Q3BzdEr4QDEiAMcjIosuww3e6oJetBOd+?=
 =?us-ascii?Q?on39O1AfnUKCF7qJuSfXNDguXu2ijwyJ2kGbXVRmEV/PFVxIa0NLsNiP12FC?=
 =?us-ascii?Q?+FiMASI4mc66JLODAOs6pH6+vKQQtKIaEhY7LR94aebzUC3UJZKDqYIHmBSk?=
 =?us-ascii?Q?iZiX7k20v9Ev8Gn1Qip0lhwAivVXmNWgr7/YhDl+MpViAw1qReLSdGzMs3ab?=
 =?us-ascii?Q?G/KMXIqI0+8PpavzcPGmwwVZane68KO+LplhC7DIHvu5epn6ahHQJE+XFHs9?=
 =?us-ascii?Q?rHktlo7ceQ=3D=3D?=
X-OriginatorOrg: yacoub.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6cb89e-9547-4d94-1210-08deff976cfe
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12069.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 15:18:16.7630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2e96c4fa-c0f0-4eed-b0b5-8f85f5e8376c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sMjc4SnCphLKrx3K6RIdHwndmKtptYrGg2CF7IRxlRjcAne6mWW+ZZQJJ7FuB2VpZl0Vba0yzzPNxlAzB6twdarrFTlQZpWo0/KBUpqh2SU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6963

The MicroBlaze procedure call standard reserves [r1+0] for the return
address and lets a callee store its incoming register arguments r5..r10
into the caller-provided home slots at [r1+4]..[r1+24].  When the kernel
enters a signal handler it sets r1 to point at struct rt_sigframe, whose
leading member is the siginfo prepared for the handler.  A handler that
homes its arguments - which an unoptimised (-O0) build always does -
therefore overwrites the first 24 bytes of that siginfo, so an
SA_SIGINFO handler reads corrupted values.  The stores stay within
siginfo (128 bytes) and do not reach the ucontext behind it.

Reserve the home area by making a seven-word gap -- the return-address
slot plus the six argument slots, 28 bytes -- the first member of struct
rt_sigframe, so the handler's argument stores land in scratch space
instead of clobbering siginfo.

Tested on qemu-system-microblazeel (petalogix-s3adsp1800) with the
uClibc-ng NPTL test suite: tst-timer4, tst-timer5, tst-mqueue5 and
tst-signal6 pass; before this change they failed because the handler
clobbered the signal frame.

Fixes: 2148daa9c45f ("microblaze_v8: Signal support")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Ramin Moussavi <ramin.moussavi@yacoub.de>
---
 arch/microblaze/kernel/signal.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/microblaze/kernel/signal.c b/arch/microblaze/kernel/signal.c
index c78a0ff48066..4956014a9937 100644
--- a/arch/microblaze/kernel/signal.c
+++ b/arch/microblaze/kernel/signal.c
@@ -49,6 +49,14 @@ struct sigframe {
 };
 
 struct rt_sigframe {
+	/*
+	 * Home area for the handler's register arguments: the MicroBlaze
+	 * ABI reserves [r1+0] for the return address and lets the callee
+	 * store r5..r10 at [r1+4]..[r1+24], and r1 points at this frame
+	 * when the handler is entered.  Without the gap those stores
+	 * corrupt frame->info.
+	 */
+	unsigned long abi_gap[7];
 	struct siginfo info;
 	struct ucontext uc;
 	unsigned long tramp[2];	/* signal trampoline */
-- 
2.53.0

