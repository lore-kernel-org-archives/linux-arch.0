Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2083E3C4C
	for <linux-arch@vger.kernel.org>; Fri, 26 Jun 2026 08:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782463337; cv=none; b=IkMt/aw1nBgn6kXr/E9juoLodQ0j4Rh9AJzpCISgGRUgKGRqQWq8MRDlJlGS/QKdfBkmAaj41/jDhaRotuX6H8Cb7ZTxTjRKxqJQH5ClNUD5MadmZQCccqQ3HXopOfBxPdn5y3ETiUA8RIOjIj99m4JuzNMNSUsm2ByyvXGoPlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782463337; c=relaxed/simple;
	bh=vcUvLC6avRDTrJZEGsIvosWZLLA5HorAUzlVan0sQ3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDv+mxNgLr101zVZ2yxlG6rmGo3zPw0JhVeEXkq+fn8r0h2VCE+wst2Yc66lR8FiZ5aIl4O3/nbsaW7VJ9oF4kdl7oqAot3EM+kz1h4dwsj1ASKIYatt/jC6zTjfuW9KuzuLk1EXECuBJIx04KeoRd/cLZp3Htm3q7UHCKDvDRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6bNGbk4; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6bNGbk4"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c88b8fe9059so246525a12.3
        for <linux-arch@vger.kernel.org>; Fri, 26 Jun 2026 01:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782463334; x=1783068134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JsvSBjnG06bUFbh9b1fjdG1LZreCknqQFnMC8kjK6/8=;
        b=D6bNGbk4f93HZGWZUlxU9fqke940w6Tsk6urYJjs7EP4s5kwajSLmHLjyFpKD6wSVD
         E7tRhFVfKPUttoto8mdY14/eTmWODlPbqu3ex7kgy5jNrDDEAWcRk+eMmwYzKRZoYqBo
         mTFHTDpamwxLqAv4l7c5N1m7ulfBKE3c1O/6h4bIbsvi6zrk0EeH9//G5KYDgRMH31Y6
         kDJec5CzXWyOkEVGGvLjsX7DwB0TxcIz4rNN9kLJ+tJsUWuMuHUs+nwM7QNXIwHvHi08
         +c3cmcruz7tMX++e4qGy1IwSUkGNOLmky2ktNYJo16c3F7dFrZzOT2zXQmdVgpz//l6L
         ur7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782463334; x=1783068134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JsvSBjnG06bUFbh9b1fjdG1LZreCknqQFnMC8kjK6/8=;
        b=AF05wO8ggA8LfEo0YDMH7iXVWlUWHpi5AqAMoAroS0onjf3Tlx9aEuor28mz3wsyIq
         vggyRersarM+yue/kSCp78/tkpDdQCv2voZUK5OTDS+wwb2X/2DaXdVryOB94mZCEb52
         iQS2IDo9wQZD9rC7yueYZeSHutPHvVmxH2dOAPL66t8N3ZGvFCVwAHtLaWncHeR8DMRq
         lHG75tMmYtdVBU2rzPq0a/kQcDQ8+YTkLO0tJg4qd9BAfPdjH67ZYMzXcIqxK96wXAi5
         5N8PG2V+HG7xNsPsySaG/AolMo2TrSWc0cmiX6Xzi6SDYfGSNahx+XC/36y7IaRTkOgr
         Xf2w==
X-Forwarded-Encrypted: i=1; AFNElJ8ZkdpbKTUG/LFTCa6YiL0sTcrn8BTdXbLAQWYMhbziNY6FBtOlQhRZz4B9DGrAWADC0E+7Ja2iEFb/@vger.kernel.org
X-Gm-Message-State: AOJu0YyAM5I72tCetnpZbmT7WdjBY5zT0HGQYHJNyeCAtiPNp2/DgAJ7
	UJTcPLjnnFgnYmykPwnbpN5757xwZSnsXupUQ0+rpcbJB1h2eOoZExHf
X-Gm-Gg: AfdE7cmaFniH8SOUPBhAejOdzpdLD1SxODkcFqSG9p5ESQWFZBPrauM0fPDE+Clcf3c
	sG4jyMu1Sla8QnZ5i7DrUY2vB1cMYvAncnkQ8GS3/gd43eE6j27qB0gN8viFFte3IVKTfR6A0KS
	J6Th9h2qgX/Y2AWqPqmqS90NqmxuESxnqmHx3E3T4K5+BFbNqRH5xGuBFDUvLpbi2c6lotRKK7o
	ivB1nsb1YEn87WXYkqhc+aLTLqlG43B6mt3hQZhwEFhsBnpFeExgpbbGF2C4vUyWXq6VxQJSl+C
	ATVRIn+wZ8NZPsDoqZQr/xkz+1vimyDgaRAiuYpkm7QuGTucUx+q6Awl0dydasQOkwHLHRwtSZh
	KXDkNf7T5vjwZBngVo3DjjLUntSG28NZuL8YuDT8OP0E7x3yu6Zlfva/+ghExOeFE
X-Received: by 2002:a05:6a20:9397:b0:3b7:8027:dfeb with SMTP id adf61e73a8af0-3bd4aec7163mr7059290637.22.1782463334219;
        Fri, 26 Jun 2026 01:42:14 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92b96eccf8sm3107580a12.3.2026.06.26.01.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 01:42:13 -0700 (PDT)
Date: Fri, 26 Jun 2026 16:41:52 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Paul Walmsley <pjw@kernel.org>
Cc: guoren@kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Arnd Bergmann <arnd@arndb.de>, 
	Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@gmail.com>, 
	Leonardo Bras <leobras@redhat.com>, Raj Vishwanathan4 <rvishwanathan@mips.com>, 
	Djordje Todorovic <djordje.todorovic@htecgroup.com>, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Han Gao <gaohan@iscas.ac.cn>, Yao Zi <me@ziyao.cc>, Xiaoguang Xing <xiaoguang.xing@sophgo.com>, 
	Aleksandar Rikalo <arikalo@gmail.com>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, sophgo@lists.linux.dev
Subject: Re: [PATCH V5] riscv: errata: Add ERRATA_THEAD_WRITE_ONCE fixup
Message-ID: <aj463BBQccFwUoV5@inochi.infowork>
References: <20260421143154.1590156-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421143154.1590156-1-guoren@kernel.org>

On Tue, Apr 21, 2026 at 10:31:40AM -0400, guoren@kernel.org wrote:
> From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
> 
> The early version of XuanTie C910 core has a store merge buffer
> delay problem. The store merge buffer could improve the store queue
> performance by merging multi-store requests, but when there are not
> continued store requests, the prior single store request would be
> waiting in the store queue for a long time. That would cause
> significant problems for communication between multi-cores. This
> problem was found on sg2042 & th1520 platforms with the qspinlock
> lock torture test.
> 
> So appending a fence w.o could immediately flush the store merge
> buffer and let other cores see the write result.
> 
> This will apply the WRITE_ONCE errata to handle the non-standard
> behavior via appending a fence w.o instruction for WRITE_ONCE().
> 
> This problem is only observed on the sg2042 hardware platform by
> running the lock_torture test program for half an hour. The problem
> was not found in the user space application, because interrupt can
> break the livelock.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Reviewed-by: Leonardo Bras <leobras@redhat.com>
> Reviewed-by: Inochi Amaoto <inochiama@gmail.com>
> Tested-by: Han Gao <gaohan@iscas.ac.cn>
> Tested-by: Yao Zi <me@ziyao.cc>
> Cc: Chen Wang <unicorn_wang@outlook.com>
> Cc: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> Cc: Paul Walmsley <pjw@kernel.org>
> Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
> ---
> Changelog
> 
> v5:
>  - Add Acked-by: Arnd Bergmann <arnd@arndb.de> for asm/generic
>  - Add Reviewed-by: Inochi Amaoto <inochiama@gmail.com>
>  - Rebase on v7.0
> 

Hi, Paul

I wonder whether this is possible for applying? I think this is 
a necessary fix for SG2042.

Regards,
Inochi


> v4:
> https://lore.kernel.org/linux-riscv/20260412143116.1445893-1-guoren@kernel.org/
>  - Add Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>    (https://lore.kernel.org/linux-riscv/1cfdf6c1-a384-43ad-9588-284335d073f7@ghiti.fr/)
>  - Add Tested-by: Yao Zi <me@ziyao.cc>
>  - Rebase on v7.0-rc7
> 
> v3:
> https://lore.kernel.org/linux-riscv/20260125063941.443777-1-guoren@kernel.org/
>  - Rebase on 6.19-rc6.
>  - Remove errata_list_vendors patch which has been merged.
>  - Add Tested-by tag.
> 
> v2:
> https://lore.kernel.org/linux-riscv/20250713155321.2064856-1-guoren@kernel.org/
>  - Add new header file for errata_list_vendors.
>  - Rebase newest kernel version.
> 
> v1:
> https://lore.kernel.org/all/20241214143039.4139398-1-guoren@kernel.org/
> ---
>  arch/riscv/Kconfig.errata                    | 17 ++++++++++
>  arch/riscv/errata/thead/errata.c             | 20 ++++++++++++
>  arch/riscv/include/asm/errata_list_vendors.h |  3 +-
>  arch/riscv/include/asm/rwonce.h              | 34 ++++++++++++++++++++
>  include/asm-generic/rwonce.h                 |  2 ++
>  5 files changed, 75 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/include/asm/rwonce.h
> 
> diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
> index 3c945d086c7d..4d3f13522da6 100644
> --- a/arch/riscv/Kconfig.errata
> +++ b/arch/riscv/Kconfig.errata
> @@ -154,4 +154,21 @@ config ERRATA_THEAD_GHOSTWRITE
>  
>  	  If you don't know what to do here, say "Y".
>  
> +config ERRATA_THEAD_WRITE_ONCE
> +	bool "Apply T-Head WRITE_ONCE errata"
> +	depends on ERRATA_THEAD
> +	default y
> +	help
> +	  The early version of T-Head C9xx cores of sg2042 & th1520 have a store
> +	  merge buffer delay problem. The store merge buffer could improve the
> +	  store queue performance by merging multi-store requests, but when there
> +	  are no continued store requests, the prior single store request would be
> +	  waiting in the store queue for a long time. That would cause signifi-
> +	  cant problems for communication between multi-cores. Appending a
> +	  fence w.o could immediately flush the store merge buffer and let other
> +	  cores see the write result.
> +
> +	  This will apply the WRITE_ONCE errata to handle the non-standard beh-
> +	  avior via appending a fence w.o instruction for WRITE_ONCE().
> +
>  endmenu # "CPU errata selection"
> diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> index 0b942183f708..fbe46f2fa8fb 100644
> --- a/arch/riscv/errata/thead/errata.c
> +++ b/arch/riscv/errata/thead/errata.c
> @@ -168,6 +168,23 @@ static bool errata_probe_ghostwrite(unsigned int stage,
>  	return true;
>  }
>  
> +static bool errata_probe_write_once(unsigned int stage,
> +				    unsigned long arch_id, unsigned long impid)
> +{
> +	if (!IS_ENABLED(CONFIG_ERRATA_THEAD_WRITE_ONCE))
> +		return false;
> +
> +	/* target-c9xx cores report arch_id and impid as 0 */
> +	if (arch_id != 0 || impid != 0)
> +		return false;
> +
> +	if (stage == RISCV_ALTERNATIVES_BOOT ||
> +	    stage == RISCV_ALTERNATIVES_MODULE)
> +		return true;
> +
> +	return false;
> +}
> +
>  static u32 thead_errata_probe(unsigned int stage,
>  			      unsigned long archid, unsigned long impid)
>  {
> @@ -183,6 +200,9 @@ static u32 thead_errata_probe(unsigned int stage,
>  
>  	errata_probe_ghostwrite(stage, archid, impid);
>  
> +	if (errata_probe_write_once(stage, archid, impid))
> +		cpu_req_errata |= BIT(ERRATA_THEAD_WRITE_ONCE);
> +
>  	return cpu_req_errata;
>  }
>  
> diff --git a/arch/riscv/include/asm/errata_list_vendors.h b/arch/riscv/include/asm/errata_list_vendors.h
> index ec7eba373437..8fd7c36307e2 100644
> --- a/arch/riscv/include/asm/errata_list_vendors.h
> +++ b/arch/riscv/include/asm/errata_list_vendors.h
> @@ -18,7 +18,8 @@
>  #define	ERRATA_THEAD_MAE 0
>  #define	ERRATA_THEAD_PMU 1
>  #define	ERRATA_THEAD_GHOSTWRITE 2
> -#define	ERRATA_THEAD_NUMBER 3
> +#define	ERRATA_THEAD_WRITE_ONCE 3
> +#define	ERRATA_THEAD_NUMBER 4
>  #endif
>  
>  #ifdef CONFIG_ERRATA_MIPS
> diff --git a/arch/riscv/include/asm/rwonce.h b/arch/riscv/include/asm/rwonce.h
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
> +#if defined(CONFIG_ERRATA_THEAD_WRITE_ONCE) && !defined(NO_ALTERNATIVE)
> +
> +#define write_once_fence()				\
> +do {							\
> +	asm volatile(ALTERNATIVE(			\
> +		"nop",					\
> +		"fence w, o",				\
> +		THEAD_VENDOR_ID,			\
> +		ERRATA_THEAD_WRITE_ONCE,		\
> +		CONFIG_ERRATA_THEAD_WRITE_ONCE)		\
> +		: : : "memory");			\
> +} while (0)
> +
> +#define __WRITE_ONCE(x, val)				\
> +do {							\
> +	*(volatile typeof(x) *)&(x) = (val);		\
> +	write_once_fence();				\
> +} while (0)
> +
> +#endif /* defined(CONFIG_ERRATA_THEAD_WRITE_ONCE) && !defined(NO_ALTERNATIVE) */
> +
> +#include <asm-generic/rwonce.h>
> +
> +#endif	/* __ASM_RWONCE_H */
> diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
> index 52b969c7cef9..4e2d941f15a1 100644
> --- a/include/asm-generic/rwonce.h
> +++ b/include/asm-generic/rwonce.h
> @@ -50,10 +50,12 @@
>  	__READ_ONCE(x);							\
>  })
>  
> +#ifndef __WRITE_ONCE
>  #define __WRITE_ONCE(x, val)						\
>  do {									\
>  	*(volatile typeof(x) *)&(x) = (val);				\
>  } while (0)
> +#endif
>  
>  #define WRITE_ONCE(x, val)						\
>  do {									\
> -- 
> 2.40.1
> 
