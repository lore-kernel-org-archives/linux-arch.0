Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464E4318146
	for <linux-arch@vger.kernel.org>; Mon, 13 Apr 2026 07:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776066065; cv=none; b=djvqiOXK0y/WSPBRavBw8nOigLwqg+7/LahVMuUClPsZ2Pxm/Di7hPVlRE7qf5v1cfGsuosBj5Bg384sfk25aIG63INe/NSLuBDGVTVoLFDvYENV9xLcVp5v9zm0xYbzpis8mWdBD8xpD2DQmgu4FHn5r+WIvdSagwilpuk5R/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776066065; c=relaxed/simple;
	bh=VVoE17TWJe17x90E317Ukeb8XekDsYNYp42O0reEOMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVwR2z24xHbg8pNiHxz/H1b5k/b8qVsoJeO+pF4ai79mtKZpNOCdE1rS2sk2J+XbMXmSvAqU9K54BWgKTFrwSqGSj6BRQNv6Kq/t6RmeP9w69Dl1cVMgr8dy/OQvU/Zisax+q95sulIpAUmSWHMqmbDWUTbaQPanVJipVSFMKNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FO6B9vqy; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FO6B9vqy"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c70c112cb61so2638771a12.0
        for <linux-arch@vger.kernel.org>; Mon, 13 Apr 2026 00:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776066064; x=1776670864; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XH03pGaphrFl/+YBvK4rXtUGkz/ZGoIf0lxOvNfwMWg=;
        b=FO6B9vqyWCtU2Ln1cEEQ1fmQtgMTGDAxD7dfRqZGvytRH7M/zGiQ3s5UfRb3s/9RcH
         PQxKtshxJiPaeE6eTUlTp41nDjh0Pa4QAD00qtxocuEmB04WvYqaqEV+T9pbgM70DQz6
         wnE1o0BbA6U0dFS+jtWW6eXxcOW8tjkN4AE4nzfKywsnYNRvTo+nwGclzwUG5JeBNF1K
         wC/dDp/zcDg0HJRuv+AmjtWM+oYEVik+xVcqSuDZM8hu9qQCSuXXqutXhGEoR2Kf0jnM
         xO2HkTcD4kLYYN95Rhwn4zFqbVtobSxqB2l64oM+ctKfWf/DK4cJ13Z7jETmDgRFQVrQ
         JWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776066064; x=1776670864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XH03pGaphrFl/+YBvK4rXtUGkz/ZGoIf0lxOvNfwMWg=;
        b=H5LWLZ8klwU0j3b2XbsKOlaQnNkwAKoVGL1eKQTXhxncXfSBz41cM7lxNIc1FNncjP
         1i+o+n/HPThoilJA5TtLRs6XhFMzUhXfWoNRE1d+FKw9uTcuqfNjBb4e5zyh4eF8Nbrr
         K1efXVMlIqSsYTci4A3x1VwoIJ3x2Gl4tTc9jn0PYTnCl6aTwNM13D9uersEMIGmy4S4
         94OAbC3a2V+rmcQZ+Y/n0zen0rNkxNk/O/2Jh/4vYVZhkC2lCz4T2Afe/8XpmJ+EpoGj
         KVxRNvC8s8hyo5yPRZ2qTgktqBWHGSFBoDGEWDewxogydy91no3uQG6LckhVF5SceHfP
         veJQ==
X-Forwarded-Encrypted: i=1; AFNElJ9d3KummVin1knslVlw36MGH1PiU7sIK9ux6dnJXPH/0INKHpPc9HAQDtjmwLlAxjq2voknTwvxB3br@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7nG9JHtu2OSRsLe6rhpn9E0YHQKoRcD2M85s5nZK1lX4N+e7Y
	jRhRAH8HbbXjgE2/39pUQ9TJ4T5N3tLqEIHqsZ+HiY/FkMLqPKcFLBZuZnBhVw==
X-Gm-Gg: AeBDievcoJ9ab7TQHMnDxgXSOSOUaokNH03cJIrTAMa9hK/QeTgC7dVJYwLf0D5Ghf6
	1CpYWzwTxI/jjlNciif46CbDjX1DZ3ng+VWmPw+uHNjNdOIWLGdGLbXxpPCX5Hf0ZN1YV4sSSo0
	MfbwldYjeSziR+ppQNTs5ZpI2xI8UoG6TPUaHwXMcNNptiEAcYPO09ELPA3ctEYnGm5yb1VZbZ8
	WlyUmEY5XwoOSYnOot06A0aThxHLDsz2IIC0433GttgJoS3n9HWVm+lGf++SpVdl828EwUZL7KV
	mk4U1cq3yUOzm9QdHxdY7yqQCBbn6lu3CXQ5aqtwi+HpzCLUVoBdLNsQsXS1mJ6SByigkEaYvzE
	rw/g6MjJ+jQQlURTk8FxjaAhurLV3YQPsF8vULFS5XmW61rdrge3UYnABQ2FO55GBtjg+/KmXCV
	dM5v1eojnB5cNlxsjL4/Sr7qmO+FITQ6s8TA==
X-Received: by 2002:a05:6a00:94f6:b0:82a:6d9d:3f85 with SMTP id d2e1a72fcca58-82f0c382d6cmr13702263b3a.48.1776066063355;
        Mon, 13 Apr 2026 00:41:03 -0700 (PDT)
Received: from localhost ([2001:19f0:8001:1b2d:5400:5ff:fefa:a95d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c4b2455sm10434535b3a.35.2026.04.13.00.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 00:41:02 -0700 (PDT)
Date: Mon, 13 Apr 2026 15:40:58 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: guoren@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	alex@ghiti.fr, leobras@redhat.com, djordje.todorovic@htecgroup.com, 
	aleksa.paunovic@htecgroup.com, arnd@arndb.de, rabenda.cn@gmail.com
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, Alexandre Ghiti <alexghiti@rivosinc.com>, 
	Han Gao <gaohan@iscas.ac.cn>, Yao Zi <me@ziyao.cc>, Chen Wang <unicorn_wang@outlook.com>, 
	Inochi Amaoto <inochiama@gmail.com>, Xiaoguang Xing <xiaoguang.xing@sophgo.com>, 
	Paul Walmsley <pjw@kernel.org>
Subject: Re: [PATCH V4] riscv: errata: Add ERRATA_THEAD_WRITE_ONCE fixup
Message-ID: <adyd86f4MJE8muil@inochi.infowork>
References: <20260412143116.1445893-1-guoren@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260412143116.1445893-1-guoren@kernel.org>

On Sun, Apr 12, 2026 at 10:31:16AM -0400, guoren@kernel.org wrote:
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
> Reviewed-by: Leonardo Bras <leobras@redhat.com>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Tested-by: Han Gao <gaohan@iscas.ac.cn>
> Tested-by: Yao Zi <me@ziyao.cc>
> Cc: Chen Wang <unicorn_wang@outlook.com>
> Cc: Inochi Amaoto <inochiama@gmail.com>
> Cc: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> Cc: Paul Walmsley <pjw@kernel.org>
> Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
> ---

Reviewed-by: Inochi Amaoto <inochiama@gmail.com>

> Changelog
> 
> v4:
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
