Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1E74963DA;
	Wed, 29 Jul 2026 13:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332605; cv=none; b=ixsCPTKeGkPFZfLikqir2xy8M0qwfjMdifMtD0B2DHqZlWyeHJrZnajz7Rjhac2XmHBpn/KXQtuniBeTDco+AQQ9CH8TvX8QAyO5Mb2m+WNV4S/9F3oeoyUTPPoLqfrrUUaWhRLRtHoVpB8n4mO01mVmhBwPPGvLpQhha2NHITI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332605; c=relaxed/simple;
	bh=z6ml+ytMiolfBSIN0QtR8EmUgQ25fO6ycUJNluIIBdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgN6OWAx+d78AJe9yXyyaeupBa4MhSG5anw7IGciRBeE4l7zQNe5rIlXPFE7WIkTSQmy6Y0p9JYyb4m8JfwqoIOdbvKzkYaRyJJLKaxVYWX0QlGygZUHmmODSmHmKj5Q/G2pf/9IeTiYtKJabP1IwNwifEWXkK33OfmAXGlqNi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjSuoLL6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjSuoLL6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E941F00A3A;
	Wed, 29 Jul 2026 13:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785332604;
	bh=PRcOiNq2tBTTPhKJmq+v2axNzroqRGfQ2NZU0eu9iKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZjSuoLL6lpaRqLc85ZT3LkyZzM0Zuhm/g6IAhMNxznnUHr+a6rLolhSNoCEWi/+XP
	 +k6HCNUh4cSAi9zyCrMgJ02jlIO4nJcZUm5LakKUb3pjQbfw2JjFATqCogerkzUdKu
	 5DtyggnyhvqVRAqVowYb9SwgJsscKYOfSP0OGJxeg/F1x0agvlho4n9YPqdCoWkemo
	 MSUrVc5OGlX5iUIMSdxmUF1lEVhqvsf443v/uXJD/wWFWvdytJ7kBBF2MY6kC6xMH4
	 hz2vLPNLN8qVdzpXNXCPMplDRgGhhamfwAgPHf3JuXPd6eVIuScvxjfLlZ57xhK8HX
	 Dias68Gw4/HNw==
Date: Wed, 29 Jul 2026 06:43:22 -0700
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
Message-ID: <amoDeloQAro0Zcsy@x1>
References: <20260421143154.1590156-1-guoren@kernel.org>
 <ah8N+UThw4JnOdDb@x1>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah8N+UThw4JnOdDb@x1>

On Tue, Jun 02, 2026 at 10:08:09AM -0700, Drew Fustini wrote:
> On Tue, Apr 21, 2026 at 10:31:40AM -0400, guoren@kernel.org wrote:
> > From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
> > 
> > The early version of XuanTie C910 core has a store merge buffer
> > delay problem. The store merge buffer could improve the store queue
> > performance by merging multi-store requests, but when there are not
> > continued store requests, the prior single store request would be
> > waiting in the store queue for a long time. That would cause
> > significant problems for communication between multi-cores. This
> > problem was found on sg2042 & th1520 platforms with the qspinlock
> > lock torture test.
> > 
> > So appending a fence w.o could immediately flush the store merge
> > buffer and let other cores see the write result.
> > 
> > This will apply the WRITE_ONCE errata to handle the non-standard
> > behavior via appending a fence w.o instruction for WRITE_ONCE().
> > 
> > This problem is only observed on the sg2042 hardware platform by
> > running the lock_torture test program for half an hour. The problem
> > was not found in the user space application, because interrupt can
> > break the livelock.
> > 
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > Reviewed-by: Leonardo Bras <leobras@redhat.com>
> > Reviewed-by: Inochi Amaoto <inochiama@gmail.com>
> > Tested-by: Han Gao <gaohan@iscas.ac.cn>
> > Tested-by: Yao Zi <me@ziyao.cc>
> > Cc: Chen Wang <unicorn_wang@outlook.com>
> > Cc: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> > Cc: Paul Walmsley <pjw@kernel.org>
> > Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>
> > ---
> > Changelog
> > 
> > v5:
> >  - Add Acked-by: Arnd Bergmann <arnd@arndb.de> for asm/generic
> >  - Add Reviewed-by: Inochi Amaoto <inochiama@gmail.com>
> >  - Rebase on v7.0
> 
> Hi Paul,
> 
> Han Gao (revy) let me know that there is now an errata entry for 'Writes
> might stick in C910/C920v1 store buffer for too long' [1].
> 
> Does that address the concern you had about documenting the errata?
> 
> Thanks,
> Drew
> 
> [1] https://github.com/revyos/xuantie-c900-bugs#writes-might-stick-in-c910c920v1-store-buffer-for-too-long

Hi Paul, could this be considered for the upcoming merge window?

Thanks,
Drew
