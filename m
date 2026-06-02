Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB3214A8B;
	Tue,  2 Jun 2026 17:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420092; cv=none; b=E9OgL7mr8tObKQeVtnHho4qQrfs05gZXpy5gc4nKKJLG49T5IGRt2lRC+OGhatMuDJPoO7iK1nSGc0FVIL8Bb02oqyo2M9/ocitDF2NGwR9wcpbM/quogWAT00uQGyd13hPzcA5IaJZM+tR+hvJN+v/sph2GyVmDqJxZujeovmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420092; c=relaxed/simple;
	bh=bVoUGzeFV/a4oS4mOj2vaRdPDr6goyHhEV+st7FDVFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tAOc0s+5LFn+KQQye4q4ddpnF99Lz/4okkg+zAXUYwn4TSXnEOjwW+WcJiAnzp/DpuMkbYVp0TyQWkO4hOshMYsOAEyJQ51rpRnsQTsd+3JPecmzN+cOiydydElnDc/glkGQrBVhXGyvvR+gk6Kvdaly2Yu7r3HEBeRT2f/cfoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZnowGir; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZnowGir"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E661F00893;
	Tue,  2 Jun 2026 17:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780420091;
	bh=3M0vc+nnyZUAtCakqX25nvCIWIKoTxj8AwWEe+bdm8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OZnowGirIqJXWMIvwon10ID8EtU9ssuP9ICXRzhuOlVx89jK8wFqoDvteFmHS9KDh
	 E/z1KcDLeUR3zksorVBYqnA2wBMJcNpoTTm/GgaXO47EzUu2mIKYr3V5qDxBvia7nw
	 oF9kiaJYruPpDb19VyYLI0Nnjb9BMqFWhcRHhy7PghnPvY4IQyHiR9Cr9Lsv7VVP3b
	 /LZe7pmbipLvrVGKcSw3O5ka56Yb9ujEUi5xVi8KZJCtxTdE47JDFyf/EZVfhwP/9O
	 rGt7NCqeh6vvAZGbxCkIoksIJwENaE/R8Lrqdnl99CGtRimRZWGqqtTeDLxAuXCpdd
	 U5CSY4O9wwgyA==
Date: Tue, 2 Jun 2026 10:08:09 -0700
From: Drew Fustini <fustini@kernel.org>
To: Paul Walmsley <pjw@kernel.org>
Cc: Guo Ren <guoren@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Arnd Bergmann <arnd@arndb.de>, Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Leonardo Bras <leobras@redhat.com>,
	Raj Vishwanathan4 <rvishwanathan@mips.com>,
	Djordje Todorovic <djordje.todorovic@htecgroup.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Han Gao <gaohan@iscas.ac.cn>, Yao Zi <me@ziyao.cc>,
	Xiaoguang Xing <xiaoguang.xing@sophgo.com>,
	Aleksandar Rikalo <arikalo@gmail.com>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, sophgo@lists.linux.dev
Subject: Re: [PATCH V5] riscv: errata: Add ERRATA_THEAD_WRITE_ONCE fixup
Message-ID: <ah8N+UThw4JnOdDb@x1>
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

Hi Paul,

Han Gao (revy) let me know that there is now an errata entry for 'Writes
might stick in C910/C920v1 store buffer for too long' [1].

Does that address the concern you had about documenting the errata?

Thanks,
Drew

[1] https://github.com/revyos/xuantie-c900-bugs#writes-might-stick-in-c910c920v1-store-buffer-for-too-long
