Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F5623ABB9;
	Fri,  2 Oct 2026 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955901; cv=none; b=QuF9uQ1BYfA5tk+l4jaUTbi302qpEZlSzqHmdDhI9JiCdzZurcetHeYMEjGbAuKC7BndGqfJEyVg2ACiEAYEbbhXMXzS82cv8fILYIJiXy+TiFAPxwnVbi+IjwFkkMa2gxDBEAx8gSUj+wQl6rXJYHmYUm5j7XPU62bw4ozxT+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955901; c=relaxed/simple;
	bh=48drsvEkUMUev5oMh48rrE53lNucXvGoZG6+Vb1T7hE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hgzLb4ssYPaerTKqQto4zy2WQpd9buLbf1w5+nhuTZco3vzs7po5KhNshcU+STtDUC6661Ys4x9jL9AnFfIqs+ELQXFSinBZoTwaoKvB1suGzEWOZYhlwDvKQPUwWCfItxwmdT22myka7cjt3WYKh+yDFrHbCUQ/ZZiaXeNL4Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhJAj0VK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhJAj0VK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0ECD1F000FF;
	Fri,  2 Oct 2026 15:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790955899;
	bh=WzthWWJd9P13T46qGyOdxjBjn0JhQpFDfciovQqcdyY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=QhJAj0VKfrhjJ+GZJa5NgKLNaLzKSHpKNBDRmtYfIJB7UfNo0SWmcq5hIo85sSJf6
	 zoCfkEwLnSE1dPa74cwEKsT/RhOYU0lfVu57iWm3pO+jnStQOQjh5KfmkIEquYK2ak
	 8zqFwN23g1v5VnZqyPUvcW9yjamXOsLoilxMD4eLUOyAgmVRAJSbFPi+NzmLk+T/od
	 ejriCmps6pP61dwLimdFZWPDqUJAy01PxMO8EqcNaF7r+uUGY9TtXRLhNS1WGTW9xN
	 lVTGe3dVz31H0FTWknDSKLd3THa7LjwwcDVRciIo2Zr2p6gAkAY2UxMk3BtS8c40A2
	 FWIxSNC/IXf6w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 479A3CE09FC; Fri,  2 Oct 2026 08:44:59 -0700 (PDT)
Date: Fri, 2 Oct 2026 08:44:59 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Kunwu Chan <kunwu.chan@gmail.com>
Cc: arnd@arndb.de, anna-maria@linutronix.de, frederic@kernel.org,
	mingo@kernel.org, tglx@kernel.org, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rwonce: Add READ_ONCE_THIS_CPU() and
 WRITE_ONCE_THIS_CPU()
Message-ID: <5a8136c6-5867-4187-a0dc-f1f4b1c4c43a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20261002151757.3605081-1-kunwu.chan@gmail.com>
 <20261002151757.3605081-2-kunwu.chan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002151757.3605081-2-kunwu.chan@gmail.com>

On Fri, Oct 02, 2026 at 11:17:55PM +0800, Kunwu Chan wrote:
> Per-CPU variables are sometimes accessed from different execution
> contexts on the same CPU, typically task context and an interrupt or
> NMI handler.
> 
> A plain READ_ONCE() or WRITE_ONCE() marks such an access as an
> intentional race but does not express where the racing accesses are
> expected to come from. This distinction allows concurrency tools such
> as KCSAN to tell an intentional same-CPU context race apart from an
> access that may race across CPUs.
> 
> Add READ_ONCE_THIS_CPU() and WRITE_ONCE_THIS_CPU() to identify accesses
> to a per-CPU variable which are intended to race only with accesses
> from other execution contexts on the same CPU. For now, they are
> simple wrappers around READ_ONCE() and WRITE_ONCE(), so generated code
> and tool behaviour are unchanged.
> 
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Kunwu Chan <kunwu.chan@gmail.com>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  include/asm-generic/rwonce.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
> index 52b969c7cef9..4d4e009a4489 100644
> --- a/include/asm-generic/rwonce.h
> +++ b/include/asm-generic/rwonce.h
> @@ -61,6 +61,17 @@ do {									\
>  	__WRITE_ONCE(x, val);						\
>  } while (0)
>  
> +/*
> + * {READ,WRITE}_ONCE_THIS_CPU() identify accesses to a per-CPU variable
> + * which are intended to race only with accesses from other execution
> + * contexts on the same CPU, e.g. task and interrupt context.
> + *
> + * For now, these are simple wrappers around READ_ONCE() and
> + * WRITE_ONCE().
> + */
> +#define READ_ONCE_THIS_CPU(x)		READ_ONCE(x)
> +#define WRITE_ONCE_THIS_CPU(x, val)	WRITE_ONCE(x, val)
> +
>  static __no_sanitize_or_inline
>  unsigned long __read_once_word_nocheck(const void *addr)
>  {
> -- 
> 2.43.0
> 
