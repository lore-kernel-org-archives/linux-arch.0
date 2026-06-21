Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776C633985;
	Sun, 21 Jun 2026 13:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782048475; cv=none; b=Wxqq9eIJhBv502gKabWWsWuCrVgJvZHtfMJzCX2cPvrUf+/80esQd5V1O4q67YZg9wqmU13chMn0lpNa4thZL/Dxgi34X6sNCOHXVI7Orp5rsXVDv9QYgDJdLPKe+1X4+UQNcl/qFNcj6wndZrfpOI397g6fIsbY0AcXpXwC7XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782048475; c=relaxed/simple;
	bh=xkJEW9pKFU4yPVjDyWcwx/y0yl+P+BcNaKhlnYBDm2c=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=E5yZJrh0gtP7sltJKakg6w+FbwGou3azszE7sENrgvzk+U38jOLlaOMUmwxLd/2i5VDCZ+gjCgj15M7OXpFrgqjis8u7rhd8u657sL7A5c5mjiUJTzolJFNcFu3a/GslngRqhWIYRt9p6wHcg+65ctVwDpIRI9BYrwKOtqaHQbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9uayeuf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9uayeuf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47951F000E9;
	Sun, 21 Jun 2026 13:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782048474;
	bh=mcHi/liLSd8GB2joSaWN2acFn+aDoc7uhNOGOZOvcro=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Q9uayeuf/qZ0uLVTmbe08op55ejKZzIwGRJ8gq+OLoMrx2D/MktY/M323BAsNg3pw
	 tEBzyDryAlE7dk8jfuekcsCwCzNmeiVTuBwY//eQwqwBLUy+nNL2/p1kYu2grvZREn
	 MQBZ1LAxH2KfqMuKTlLNjV+t2q7nzn+pjBJmAFjTAhUtme8EjHYj52l+H/oeOc6i3T
	 Vg70Pcjdipsz+vIWvlnFkEntHlFR8MBVwCuO6yxIa2tcn7ObIYoAmkX+1dusdrcKHL
	 SeDzfiIoUasOVyzJwQgkPD54NPql+ocvECj4YDpSnekJuzm7zRZRDdc/j/a2nUZgKk
	 lrfeNeLM7QMLw==
Date: Sun, 21 Jun 2026 22:27:50 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Thomas Huth <thuth@redhat.com>
Cc: Naveen N Rao <naveen@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] kprobes: Replace __ASSEMBLY__ with __ASSEMBLER__ in
 header file
Message-Id: <20260621222750.9cdafc543ab0bca9ad16f730@kernel.org>
In-Reply-To: <20260619161434.88270-1-thuth@redhat.com>
References: <20260619161434.88270-1-thuth@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 19 Jun 2026 18:14:34 +0200
Thomas Huth <thuth@redhat.com> wrote:

> From: Thomas Huth <thuth@redhat.com>
> 
> While the GCC and Clang compilers already define __ASSEMBLER__
> automatically when compiling assembly code, __ASSEMBLY__ is a
> macro that only gets defined by the Makefiles in the kernel.
> This can be very confusing when switching between userspace
> and kernelspace coding, or when dealing with uapi headers that
> rather should use __ASSEMBLER__ instead. So let's standardize now
> on the __ASSEMBLER__ macro that is provided by the compilers.
> 

Oops, good catch!

Let me pick it.
Thanks!

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Note: This patch has been split from an earlier bigger patch of
>  mine to ease reviewing.
>  
>  include/asm-generic/kprobes.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/asm-generic/kprobes.h b/include/asm-generic/kprobes.h
> index 5290a2b2e15a0..16f16963d503d 100644
> --- a/include/asm-generic/kprobes.h
> +++ b/include/asm-generic/kprobes.h
> @@ -2,7 +2,7 @@
>  #ifndef _ASM_GENERIC_KPROBES_H
>  #define _ASM_GENERIC_KPROBES_H
>  
> -#if defined(__KERNEL__) && !defined(__ASSEMBLY__)
> +#if defined(__KERNEL__) && !defined(__ASSEMBLER__)
>  #ifdef CONFIG_KPROBES
>  /*
>   * Blacklist ganerating macro. Specify functions which is not probed
> @@ -21,6 +21,6 @@ static unsigned long __used					\
>  # define __kprobes
>  # define nokprobe_inline	inline
>  #endif
> -#endif /* defined(__KERNEL__) && !defined(__ASSEMBLY__) */
> +#endif /* defined(__KERNEL__) && !defined(__ASSEMBLER__) */
>  
>  #endif /* _ASM_GENERIC_KPROBES_H */
> -- 
> 2.54.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
