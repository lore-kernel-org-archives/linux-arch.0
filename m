Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACBB3EBF3E;
	Sun, 22 Feb 2026 22:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771797975; cv=none; b=Zw4TvcXSyIboHq+CadZnEh/kNtCy2tZ01HWqMW7NMULJhfB5+O3rJqRx5J/yzUGfJ+vwAUCS4r7ELYFn1o+mLyRnJplqI1Zzgtf4ZWjSiehwWEa+fN+iK4VYJenGUCiXszzPs+vvfjFcKY++OseJMb9aSQ4yY8lgDJbP/i+lPfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771797975; c=relaxed/simple;
	bh=4eFrB51vniyDERNmsKInct9htMUnpN6fsZBWfR52QiQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W77O9s5VqxrfAvU7naSsHqe8ojOQW8pmZtF0Ua6aWAjvcZxbjbV1gmntQHiZJ6HwFn7DMDh0R16wEZGJdnbTXAq+tNIecOxXgMXN6VwJ3X+33B4iUOSPq78nbKc6rAxwfNQu+sA5h93OmTDboQZ+kukCanGe1NA7RoE6G7rnuso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cn8vgPj4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cn8vgPj4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B60BC116D0;
	Sun, 22 Feb 2026 22:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771797974;
	bh=4eFrB51vniyDERNmsKInct9htMUnpN6fsZBWfR52QiQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Cn8vgPj4mxX/Ll0NNxY1rQwyJ2pusRMOvLr6phG9p6gsGRAzlf4/BqZMz0IR1eegO
	 nD41Y1xg/GrK6J+HZQBAX4DqPTDV6jWZ4b9MpwmBVQHs7wsv2oY4rqo+x7wAzQCHPX
	 d7iYEf131h0dO4lq+ddQLExi/dcglJM9/+SlLW1ZF8dsMTPgM3V6WAWaV74e1l4jvB
	 WizgJtcqW1z2zolPD8uM9Bxdc/FMrhvx/JSOH3lz6ZLEn7AUWZrHbrKYd3Krd/IYhT
	 8rLK7nnQmo7/XHmBdPjYCnMTO4jL4vyM+aJdRTEhlhm49QCigwEgT/ZvLJGqMJ3w/G
	 HdtVVrM7tMQqw==
From: Thomas Gleixner <tglx@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
 <alex@ghiti.fr>, Guo Ren <guoren@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-csky@vger.kernel.org
Subject: Re: [PATCH 2/3] genirq: use runtime constant to optimize
 handle_arch_irq access
In-Reply-To: <20260220090922.1506-3-jszhang@kernel.org>
References: <20260220090922.1506-1-jszhang@kernel.org>
 <20260220090922.1506-3-jszhang@kernel.org>
Date: Sun, 22 Feb 2026 23:06:11 +0100
Message-ID: <877bs4wi0c.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Feb 20 2026 at 17:09, Jisheng Zhang wrote:
> Currently, on GENERIC_IRQ_MULTI_HANDLER platforms, the handle_arch_irq
> is a pointer which is set during booting, and every irq processing needs
> to access it, so it sits in hot code path. We can use the
> runtime constant mechanism which was introduced by Linus to speed up
> its accessing.

The proper solution is to use a static call and update it in
set_handle_irq().  That removes the complete indirect call issue from
the hot path.

Thanks,

        tglx
