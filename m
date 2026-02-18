Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B78302779;
	Wed, 18 Feb 2026 12:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771416426; cv=none; b=cvfBJ+CpIu8Yi/xpvKev+jFqTXQ6cuCTzqGp6H5d2rmZ6vDo/dbNw3H7BmJe9YB8lYNJ/Hque1sOUotAtf4/fjq6P54En3FUsD0bYrtVVDGaAwZoN1bW1slmKobKLRBULUAbd5NTW2EiTykEwtEXoxf8rXbIvp5zg3mlzw8CbiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771416426; c=relaxed/simple;
	bh=JJMJGb5i+iHg8m+rXVti4oKM42dl/LwMw4HCw3cPHhc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QJ6G5GumjcnXgsGtXvZjzkGOpq8bUSQXNNsFUA75a3iEKzr/0UkgGXQXpVsxyDGF2GS7gmXTyEQ9IK/TD4B9uz0yRShKZqFbjs1EPCy7yGggj3kwEaO84zvBy9++SdysKZGZSTyTeY+4NkJEdj2VpJ9ON7GzKTrsEj6jnay4938=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from smtpclient.apple (unknown [58.38.117.196])
	by APP-01 (Coremail) with SMTP id qwCowAA33WhJq5Vp5ZUzCA--.1761S2;
	Wed, 18 Feb 2026 20:06:34 +0800 (CST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH V3] riscv: errata: Add ERRATA_THEAD_WRITE_ONCE fixup
From: Han Gao <gaohan@iscas.ac.cn>
In-Reply-To: <20260125063941.443777-1-guoren@kernel.org>
Date: Wed, 18 Feb 2026 20:06:23 +0800
Cc: Han Gao <gaohan@iscas.ac.cn>,
 paul.walmsley@sifive.com,
 palmer@dabbelt.com,
 alex@ghiti.fr,
 leobras@redhat.com,
 djordje.todorovic@htecgroup.com,
 aleksa.paunovic@htecgroup.com,
 arnd@arndb.de,
 rabenda.cn@gmail.com,
 linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org,
 Yao Zi <me@ziyao.cc>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 Paul Walmsley <pjw@kernel.org>,
 Guo Ren <guoren@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3F85D6ED-6C47-46D0-96A3-165F4DE0D1E7@iscas.ac.cn>
References: <20260125063941.443777-1-guoren@kernel.org>
To: Paul Walmsley <pjw@kernel.org>
X-Mailer: Apple Mail (2.3864.400.21)
X-CM-TRANSID:qwCowAA33WhJq5Vp5ZUzCA--.1761S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuFW8tFykXF13tF45Wr1DAwb_yoWxZryfpF
	Z0kF4FkFZ5GFn7A3srCw45urn8J3yfGr13K3s7uw18ArsFqrs8Jr1vg3yjqr9FvFs7Wr18
	GrZ3uFy2k39Fq37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9E14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6ryUMxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbbo7tUUUUU==
X-CM-SenderInfo: xjdrxt3q6l2u1dvotugofq/1tbiCRECDGmVUIGCHgAAsn

Hi, Paul

There was a response to this patch in Patch V2, but no further action =
has been taken.

I'd like to ask if there are any other issues with this patch, or if it =
lacks sufficient review feedback or testing.

> On Jan 25, 2026, at 14:39, guoren@kernel.org wrote:
>=20
> From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
>=20
> The early version of XuanTie C910 core has a store merge buffer
> delay problem. The store merge buffer could improve the store queue
> performance by merging multi-store requests, but when there are not
> continued store requests, the prior single store request would be
> waiting in the store queue for a long time. That would cause
> significant problems for communication between multi-cores. This
> problem was found on sg2042 & th1520 platforms with the qspinlock
> lock torture test.
>=20
> So appending a fence w.o could immediately flush the store merge
> buffer and let other cores see the write result.
>=20
> This will apply the WRITE_ONCE errata to handle the non-standard
> behavior via appending a fence w.o instruction for WRITE_ONCE().
>=20
> This problem is only observed on the sg2042 hardware platform by
> running the lock_torture test program for half an hour. The problem
> was not found in the user space application, because interrupt can
> break the livelock.
>=20
> Reviewed-by: Leonardo Bras <leobras@redhat.com>
> Tested-by: Han Gao <gaohan@iscas.ac.cn>
> Cc: Yao Zi <me@ziyao.cc>
> Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
> Cc: Paul Walmsley <pjw@kernel.org>
> Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
> ---
> Changelog
>=20
> v3:
> - Rebase on 6.19-rc6.
> - Remove errata_list_vendors patch which has been merged.
> - Add Tested-by tag.
>=20
> v2:
> =
https://lore.kernel.org/linux-riscv/20250713155321.2064856-1-guoren@kernel=
.org/
> - Add new header file for errata_list_vendors.
> - Rebase newest kernel version.
>=20
> v1:
> =
https://lore.kernel.org/all/20241214143039.4139398-1-guoren@kernel.org/
> ---
> arch/riscv/Kconfig.errata                    | 17 ++++++++++
> arch/riscv/errata/thead/errata.c             | 20 ++++++++++++
> arch/riscv/include/asm/errata_list_vendors.h |  3 +-
> arch/riscv/include/asm/rwonce.h              | 34 ++++++++++++++++++++
> include/asm-generic/rwonce.h                 |  2 ++
> 5 files changed, 75 insertions(+), 1 deletion(-)
> create mode 100644 arch/riscv/include/asm/rwonce.h
>=20
> diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
> index 3c945d086c7d..4d3f13522da6 100644
> --- a/arch/riscv/Kconfig.errata
> +++ b/arch/riscv/Kconfig.errata
> @@ -154,4 +154,21 @@ config ERRATA_THEAD_GHOSTWRITE
>=20
>  If you don't know what to do here, say "Y".
>=20
> +config ERRATA_THEAD_WRITE_ONCE
> + bool "Apply T-Head WRITE_ONCE errata"
> + depends on ERRATA_THEAD
> + default y
> + help
> +  The early version of T-Head C9xx cores of sg2042 & th1520 have a =
store
> +  merge buffer delay problem. The store merge buffer could improve =
the
> +  store queue performance by merging multi-store requests, but when =
there
> +  are no continued store requests, the prior single store request =
would be
> +  waiting in the store queue for a long time. That would cause =
signifi-
> +  cant problems for communication between multi-cores. Appending a
> +  fence w.o could immediately flush the store merge buffer and let =
other
> +  cores see the write result.
> +
> +  This will apply the WRITE_ONCE errata to handle the non-standard =
beh-
> +  avior via appending a fence w.o instruction for WRITE_ONCE().
> +
> endmenu # "CPU errata selection"
> diff --git a/arch/riscv/errata/thead/errata.c =
b/arch/riscv/errata/thead/errata.c
> index 0b942183f708..fbe46f2fa8fb 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -168,6 +168,23 @@ static bool errata_probe_ghostwrite(unsigned int =
stage,
> return true;
> }
>=20
> +static bool errata_probe_write_once(unsigned int stage,
> +    unsigned long arch_id, unsigned long impid)
> +{
> + if (!IS_ENABLED(CONFIG_ERRATA_THEAD_WRITE_ONCE))
> + return false;
> +
> + /* target-c9xx cores report arch_id and impid as 0 */
> + if (arch_id !=3D 0 || impid !=3D 0)
> + return false;
> +
> + if (stage =3D=3D RISCV_ALTERNATIVES_BOOT ||
> +    stage =3D=3D RISCV_ALTERNATIVES_MODULE)
> + return true;
> +
> + return false;
> +}
> +
> static u32 thead_errata_probe(unsigned int stage,
>      unsigned long archid, unsigned long impid)
> {
> @@ -183,6 +200,9 @@ static u32 thead_errata_probe(unsigned int stage,
>=20
> errata_probe_ghostwrite(stage, archid, impid);
>=20
> + if (errata_probe_write_once(stage, archid, impid))
> + cpu_req_errata |=3D BIT(ERRATA_THEAD_WRITE_ONCE);
> +
> return cpu_req_errata;
> }
>=20
> diff --git a/arch/riscv/include/asm/errata_list_vendors.h =
b/arch/riscv/include/asm/errata_list_vendors.h
> index ec7eba373437..8fd7c36307e2 100644
> --- a/arch/riscv/include/asm/errata_list_vendors.h
> +++ b/arch/riscv/include/asm/errata_list_vendors.h
> @@ -18,7 +18,8 @@
> #define ERRATA_THEAD_MAE 0
> #define ERRATA_THEAD_PMU 1
> #define ERRATA_THEAD_GHOSTWRITE 2
> -#define ERRATA_THEAD_NUMBER 3
> +#define ERRATA_THEAD_WRITE_ONCE 3
> +#define ERRATA_THEAD_NUMBER 4
> #endif
>=20
> #ifdef CONFIG_ERRATA_MIPS
> diff --git a/arch/riscv/include/asm/rwonce.h =
b/arch/riscv/include/asm/rwonce.h
> new file mode 100644
> index 000000000000..081793d4d772
> --- /dev/null
> +++ b/arch/riscv/include/asm/rwonce.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef __ASM_RWONCE_H
> +#define __ASM_RWONCE_H
> +
> +#include <linux/compiler_types.h>
> +#include <asm/alternative-macros.h>
> +#include <asm/vendorid_list.h>
> +#include <asm/errata_list_vendors.h>
> +
> +#if defined(CONFIG_ERRATA_THEAD_WRITE_ONCE) && =
!defined(NO_ALTERNATIVE)
> +
> +#define write_once_fence() \
> +do { \
> + asm volatile(ALTERNATIVE( \
> + "nop", \
> + "fence w, o", \
> + THEAD_VENDOR_ID, \
> + ERRATA_THEAD_WRITE_ONCE, \
> + CONFIG_ERRATA_THEAD_WRITE_ONCE) \
> + : : : "memory"); \
> +} while (0)
> +
> +#define __WRITE_ONCE(x, val) \
> +do { \
> + *(volatile typeof(x) *)&(x) =3D (val); \
> + write_once_fence(); \
> +} while (0)
> +
> +#endif /* defined(CONFIG_ERRATA_THEAD_WRITE_ONCE) && =
!defined(NO_ALTERNATIVE) */
> +
> +#include <asm-generic/rwonce.h>
> +
> +#endif /* __ASM_RWONCE_H */
> diff --git a/include/asm-generic/rwonce.h =
b/include/asm-generic/rwonce.h
> index 52b969c7cef9..4e2d941f15a1 100644
> --- a/include/asm-generic/rwonce.h
> +++ b/include/asm-generic/rwonce.h
> @@ -50,10 +50,12 @@
> __READ_ONCE(x); \
> })
>=20
> +#ifndef __WRITE_ONCE
> #define __WRITE_ONCE(x, val) \
> do { \
> *(volatile typeof(x) *)&(x) =3D (val); \
> } while (0)
> +#endif
>=20
> #define WRITE_ONCE(x, val) \
> do { \
> --=20
> 2.40.1

