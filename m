Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021074.outbound.protection.outlook.com [52.101.70.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA79E4248A9;
	Fri, 21 Aug 2026 15:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787325506; cv=fail; b=cAn0ylcFB2v+elT0NdXTa6YqNQG77Jb8RvuWgNqrhxOlf9c1GX/AK+tt3jR5vyrVx5AtOugMe/p3fX1dm6vY1lbWksXYQ91m++dVL8N+h99s+Gls3O/8Pjw0aCVU49c9XBog9P5VxIaKf0xms7e93lSqvi960ojCYESrC85dQFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787325506; c=relaxed/simple;
	bh=4UyUOWA/TosnQFT0IWbmbVEo1E6m2jJYZFHwVTjSuXA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Hj3wUDxKPJ0sW28QulEzYGNkjxMQFri+K5v+L4qDmne9yBKj42qEaEkdW8AuE+f6s7ME7IPEtYaZ9DKmtwHcBpeuERDZr73p69IrU+v7TLTWPqgxMpRIl/KvXhuzT9afSGjMIRDkDcBwxefJlnU8BHOWHtOsAhYxjEEMhbOcl0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de; spf=pass smtp.mailfrom=yacoub.de; dkim=pass (2048-bit key) header.d=yacoub.de header.i=@yacoub.de header.b=dETydO8z; arc=fail smtp.client-ip=52.101.70.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yacoub.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yacoub.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yacoub.de header.i=@yacoub.de header.b="dETydO8z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t2gOFKAsKUdE2x6krruvu0TCu0moRi1bsqxbqHVVgTVZJ6wL0mfiBNs6qX3WQofsGJNfTfbRb8T+SAM6ryB/yZ8JrvHodFrg0nQuVwen+08hEkWDJMYNIPhzfToPjci4XOm/X9YXS/hkbvPsJnc0a6lO1mai70bsE7+pTHC70vNf+SzTglJSeHP16pC5m/SWPldzDwChdU4xgbGVlPs3TMrAbQ0uCrBj3aZWAXf+//S5ij+88VPgP+g+EkCgXgtaWrYQC5LDk1fvcO2rkyTXDcTBMXf3lJ6NK4Sj74eXA1aT2l+luOOOZ1VhrcWgAz2y5YbcShUawjXVBTv6eJjhQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfSG23VD+7fSAe1fKaLKJ+CNGnPW8kMVrrruZ2yUDrA=;
 b=CHzAXFp9qz0mMl2BHqqR23lNE7pZz6Pvw8DozF0fQgtzKN1mSdQzOLckOx4D51Sp4gz0x/l7ThfGaQgt9EhXXvPur0w3Polm/haOt16vTyXwcXcwUq++yzRUrtTjnRFJg11ryvYLbMMd7ra0UICSeZliuHU2bFcmdyPvuY8AAtvCYFcSzB+w/Qx9kiiAbL/XHezdVpXGxAIc3jbeVyvcY3X8qSYfg9axBExUeZ1kQ3kL0j/sJYqazQXZ+O7TUJQi67ouzZuxuD8wR48f6rmhzIf/ixCH6p2/ER17eL2sjoGtrt11XY0a6Ba2PhYH1Ww1usJXxIPpJQ+oCprZACedeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=yacoub.de; dmarc=pass action=none header.from=yacoub.de;
 dkim=pass header.d=yacoub.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yacoub.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfSG23VD+7fSAe1fKaLKJ+CNGnPW8kMVrrruZ2yUDrA=;
 b=dETydO8z9HBnniEFg1Z+ASngGMJXBIyOE9YNucj7c+ZfMxttpbU3WLpA3aHOreqk7pzb4TXf+OAeiSaGchzXLtfPSnMuBQ4seeLu7MQeGa57G9uLdTp4/A+wRK5fI2EKIAzpcjihXmP9R4eVbDsMXXJMNhMv91Ba/jPbnaEkrmfcB6CNkzMVDcmXe52y+FaWrsq31QOQ+Ei1T0MxiEgpGQ2/erUHOSYkYRdVJ7R+7xThoRLREDqIH0FNcrHbhFfmkM2WeHAivz2LbScP18PL+wo9JBSw9RbySlbcGHDaoV9SDNqbom6pgYTSMGqYWIDoCwbH/fw/pmE1J48i6LPUMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=yacoub.de;
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com (2603:10a6:501:99::13)
 by AM0PR04MB6963.eurprd04.prod.outlook.com (2603:10a6:208:18b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 15:18:15 +0000
Received: from MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809]) by MRWPR04MB12069.eurprd04.prod.outlook.com
 ([fe80::37b9:4b72:7864:5809%4]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 15:18:15 +0000
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
Subject: [PATCH v3 0/5] microblaze: fix signal handling and the ABI argument home area
Date: Fri, 21 Aug 2026 17:18:04 +0200
Message-ID: <20260821151809.1233057-1-ramin.moussavi@yacoub.de>
X-Mailer: git-send-email 2.53.0
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
X-MS-Office365-Filtering-Correlation-Id: 7a04a5a0-8e23-45cc-4f1a-08deff976c65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|6133799003|10067099003|11063799006|5023799004|56012099006|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	K3Ro3rVpl3QZme9yp5TnHmwVSSzRZRJVLj29l5HkM0AA3qca0y38KuKKmPjdjYYAyhEZt4fJzt2n9CPwYOMLtJMDLpNb12iArHAX/tYxRYHodN146br+2u4N44wFSiepaM533SGPFYcNa4MhfwlefNdOMEy2HnQQffEwlrbgGrauUED0FnvSRC0+Z+jaVmxKhw+nkaAEWiVoutGIs7rBbVlTN6J8CAH6juKdzSULjiaV9rFmOGdtyuAWlbe80MMm5DxVVzFczpAgOya6z18Uh04thhApRmv09Jr0A8Ef9bjsvIdWvICCYtjgjt7u7QUlBDB0v8QtJuRVoe5G4wdp3ILYqsP9E6bmLUkPTJOyM/ejiHsQu4Nkv+Dn/A/0tD8QMOdiP3O2GLTks7lwDEWVbXuFhTQ3bPijLamcSQGz0oC/44BwBkVu093TEeeBtctcLJHLfPlfjfKR2XwC4EJ+Urti3MY9Im2VSxC8VnUg4z9kxmfY2MvlHAarax5r98lart5hAAWbORgG+xh6Ac4PeZetnoJsZwq+HbvPMAvIRyMeVieQXJkn741vmKuNoMXwyz0B3oSfPmiyJBKJslB2qEUYLU4cJfzOoVE+SSZsgKlO/krRbt9MQgCDul6u9h3sJJZBQ6v21/EhUNJAX8faSrw0ciZOXaxyoBQr6mI+2j4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12069.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(10067099003)(11063799006)(5023799004)(56012099006)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hf1vn5OXet1z0Mb8HXW25MNRuVJjdQFkZOl1Tlh8T1HHKXwQP4MsBNm4zqLh?=
 =?us-ascii?Q?LosS2M4d0buALne31BIBthewEm+r37WAAghIStYzaKWdzcoX5jOi9L9bII04?=
 =?us-ascii?Q?qVmVJzIhLBa2Vi2Z2P4CoI5JaUWZ1+JTjMXplZRZIsLACvJEWKQW6ifA/t+u?=
 =?us-ascii?Q?V2inj7IhMzfy1uJg1ljLyZKN0RpmO3ijhOndmN3wkViM4IbxRFiH5Sx1bNJe?=
 =?us-ascii?Q?tSUT20qfktLaZsUQrcIE2LJufrsOHA1ktFvFdqic6Ujgr2VAidvfyD6gC8ux?=
 =?us-ascii?Q?u1+9kxUikgXoDV2PzFuXQwLZElmR7/ujNIhdpIM8PxPLhjZEnkr4fBR8OZh5?=
 =?us-ascii?Q?YXND5/MLO/lmGudW24PNEFBYhIlvEXpDqqz6WdVFJerYWtGJgBxsteU/xUSn?=
 =?us-ascii?Q?wj7kVrJYnGaAlWCFaWqWRwLOZWlkSCC5DQIlwGYp9kZ8zq+X8uxivy7bFQ1I?=
 =?us-ascii?Q?qf+8Qc4jXSe82ltUc0PQ4vskFV3jTNrEoN22Qjwh7CYZZsrCBwmXeopyQg+V?=
 =?us-ascii?Q?6rkXScIGjIXhzjKNjv1PceW6slC3IvTZY5OhP2kOonVDSnE3ivFCC+EJRR1X?=
 =?us-ascii?Q?GWazNXChnQCmIce0QeJapdvbMhCO4x9BmoTRYRFpv38tadcV5aZ3dXQ3B5ZZ?=
 =?us-ascii?Q?CVj5ukQgdCgiEvYy6xlUR0bi96ZQ3dk8XTKZUlEuI3kWkXajW3DJD1zqFaYu?=
 =?us-ascii?Q?Y69VlDcO2LrGSMYNqQz9Z1Dye0oLL6wpDHpuDYjXyoKIBHqNt8VVXUz4m2m+?=
 =?us-ascii?Q?br2omeZ8eC82JtI67HvRl2BGLAEqvJvnn8C3RUyKF003VuaJQKb2YDNfsiaN?=
 =?us-ascii?Q?MFV8gcTYW90xt0BTfy6IJnIyqRMpk0ef+zuueiRT4HElNFnz52tnE1WeajED?=
 =?us-ascii?Q?CDGw7LGDVNmenLktW1o96G93gNoSSqcUMkZ6Do7cOzIiQzteMQjt1iDRmNha?=
 =?us-ascii?Q?QrzaYnmiELxUN46nXT64ET2az41x0KLC9xq7Yzx9JbO5asLPKcE/fWTSCzdx?=
 =?us-ascii?Q?aD2qi9GauTOA5rXRv15PINsy1xZenYiFxSJlamKRgc3TnFCNqBwgSDtHo9Yj?=
 =?us-ascii?Q?RwuY9Uv0ZPzKzIKldVQgcqOixXphHNUio6+kMh8PYVviQRbCsY02N1AnwO1Q?=
 =?us-ascii?Q?xH8XIRyd+d8eaOteFu8bnDb35UGjMd4uR9m0fBVXqHMEWCySQcVi903/WvfB?=
 =?us-ascii?Q?pvjP8imr7vfHTgKVXATsesfPUAIkAM4f+VAIHeGIJ6sUJWODPm1J961+omXv?=
 =?us-ascii?Q?ujMzqTwqBXBVWnZyxs8XhbCoIkgFZqrIgrCVZxAnHshLwRqMCXaITG9wKx8u?=
 =?us-ascii?Q?EjlEtDinXZVHv7abu9dgU/4AUsqyrIM+aeGAdOlxAfEQNg4dWysZqZRJZMLX?=
 =?us-ascii?Q?IZZcoCGuhg8lsYyJtdagII5wsjbqn702WvafeKIxSqiY1Cf0NVlQ+PnNjeMK?=
 =?us-ascii?Q?KZkIGoAl7ZeDtjt0rjsXIwhO7rTQXdWHyAYCqfuqxUavf3DkwPdk4axWOoP8?=
 =?us-ascii?Q?LAqsSgoY/Ft3J+l9SLZfpn2M635U5YrEoCpnC1IWTY+B/Jjhxp3TtuANRuSh?=
 =?us-ascii?Q?vU+AYBLz4FlfZ0lwsF3d59zGTfWCD81kdHBql0et+7/juDn4n4ISt4GzrkrM?=
 =?us-ascii?Q?9rTqvnkisy3AD5rNCMVaMRLBRN+EZ2uWwOubcZtVL9qLyNA9EsP5x+Nms8g4?=
 =?us-ascii?Q?0Sdg/EjY5RJJEw56YOQvcxrgz+blG1vIYVJwbFuGwCCYEe2ib7pg58P3t8h6?=
 =?us-ascii?Q?kQxYlhDOnb7fjum9LyRowCArkp42U4Y=3D?=
X-OriginatorOrg: yacoub.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a04a5a0-8e23-45cc-4f1a-08deff976c65
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12069.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 15:18:15.7736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2e96c4fa-c0f0-4eed-b0b5-8f85f5e8376c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GC+eqpSio7ZH4/8uku7EKxSNwPepFktB77loK/g4521BLKsOxnXcPOaijxqtj7xTmB/cmlFDQ5dl893S/tMw3S4ZKV7gTDtRtVckVVanqRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6963

Five fixes to the microblaze signal-delivery path, found while bringing the
uClibc-ng NPTL test suite up on microblazeel under qemu-system
(petalogix-s3adsp1800).

Patch 1 wires up sigaltstack(), which is routed to sys_ni_syscall even
though the signal code fully supports an alternate stack; microblaze is the
only architecture leaving it unimplemented.

Patch 2 reserves the ABI argument home area at the top of the signal frame.
A handler may store its incoming arguments r5..r10 into [r1+4]..[r1+24], and
r1 points at struct rt_sigframe on entry, so those stores land in
siginfo/ucontext and corrupt the signal state.

Patch 3 stops ret_from_trap from writing r3/r4 back into the saved pt_regs
after sys_rt_sigreturn() has restored the full register set.  Only r4 is
actually lost -- the usual *rval_p = regs->r3 idiom carries r3, but a C
function has no second return value for r4 -- which corrupts any register
live across a signal, e.g. the address held in an lwx/swx CAS loop.

Patch 4 restores the same reservation in the kernel's own frames.  The ABI
rule applies to the kernel's asm-to-C calls too: with r1 at the frame base a
callee may spill over the saved registers, and PT_R1 is the first slot it
hits.  This was latent until GCC 15 changed register allocation
(3b9b8d6cfdf5, "ira: Scale save/restore costs of callee save registers with
block frequency"); a kernel built with gcc >= 15 without the
TARGET_CALLEE_SAVE_COST workaround dies on init's first syscall.  The kernel
had this reservation until 2011, when commit 6e83557c38b4 removed it as
suspected v850 leftovers -- this brings it back, with 28 bytes rather than
the historic 24, which was one word short.

Patch 5 is Sam Price's: MSR is not round-tripped through the signal frame,
so the interrupted carry flag is lost across signal delivery -- the same
failure class as patch 3, through a different register.

Testing: v7.2 built with gcc 16.2.0, which carries no
TARGET_CALLEE_SAVE_COST workaround and so reproduces the allocator change,
userspace built with the same compiler.  The uClibc-ng test suite reports
759 passed, 0 failed, 7 skipped, unchanged from a known-good reference
kernel; without patch 4 the same kernel panics on init's first syscall.
checkpatch --strict is clean on all five.

Tooling, per Documentation/process/generated-content.rst: patches 1-4 were
written with the help of an AI coding assistant (Claude, claude-opus-5) over
several sessions and carry an Assisted-by tag; patch 5 is Sam's, included
unchanged apart from a blank line checkpatch wanted.  The assistant was used
throughout -- reading the microblaze ABI out of the gcc backend, finding the
gcc change that made the bug visible, drafting the patches and changelogs,
and driving the qemu test runs.  Everything was reviewed and tested before
sending, and the numbers above come from real runs.  Two mistakes it made
were caught that way and are worth naming: patch 4 first used 32 bytes with
an alignment argument that does not hold (STACK_BOUNDARY is 32 bits, so 28
needs no rounding), and an early version of patch 2 was folded into patch 4,
which made the test suite blame the wrong change.

Changes since v2 [1]:
  - From: now matches Signed-off-by, and the series is sent standalone
    rather than as a reply to the previous version (both requested by
    Michal).
  - Rebased onto v7.2.
  - Added patches 3, 4 and 5.  Patch 3 was previously sent standalone on
    27 July 2026.
  - Patches 1 and 2 are unchanged.

[1] https://lore.kernel.org/all/cover.1780647609.git.lordrasmus@gmail.com/

Ramin Moussavi (4):
  microblaze: wire up sigaltstack
  microblaze: reserve the ABI argument-home area in the signal frame
  microblaze: don't clobber r3/r4 restored by rt_sigreturn
  microblaze: restore the ABI argument home area below pt_regs (PTO)

Sam Price (1):
  microblaze: preserve the MSR carry flags across signals

 arch/microblaze/include/asm/entry.h           |  13 +
 arch/microblaze/include/asm/processor.h       |   2 +-
 arch/microblaze/kernel/entry.S                | 346 +++++++++---------
 arch/microblaze/kernel/hw_exception_handler.S |   5 +
 arch/microblaze/kernel/process.c              |   5 +-
 arch/microblaze/kernel/signal.c               |  26 ++
 arch/microblaze/kernel/syscalls/syscall.tbl   |   2 +-
 7 files changed, 232 insertions(+), 167 deletions(-)


base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
-- 
2.53.0

