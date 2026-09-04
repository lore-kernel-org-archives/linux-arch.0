Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEB43A7F66;
	Fri,  4 Sep 2026 11:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788521612; cv=none; b=cAjZGIgh2nhIx0jog0aQl75hZItot5ZgHSUKdDdDQWRKA7RGUf2zlSVyZ5jdhNbWKzQcMaN4mVus/JaCa7cL+TjMrmTguWrtW5FQZyq5epcu0ce6JtxNoE3mt9bMtJeaiobIQJ417KjftctaEW2W0FRlvgw9gaHNNbjFgyHZLt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788521612; c=relaxed/simple;
	bh=VIJ2WXmSlEg58OF8f+qh0yaMlAEiqivy+d9JveM+TkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgLv2o0i+YPQD141FyGdiI5tCeggK+ggBu0aWKqCx/j+jwn180fXZGXHLV1wXC/XDdOQ6n+rhKK/X25UBGsuATegBQ1nk3cVBE72NZJAA28/MLv3e2IhAetnXRiovcEFiYImCwmvgEyYt9nF6EEswYBot6oAzPfepJqkQKU/+NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArITN7yA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArITN7yA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA091F00A3D;
	Fri,  4 Sep 2026 11:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788521611;
	bh=FeajS+4YaPDd6gty4X9F+WxnhBoIVDGa6h4QptmunEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ArITN7yAfyimGYK3B7nopyWFl1AACUToH1JFjRSmV5dnLZV0CInD0dtkdXmr3qp6O
	 nlJxUWjY/3zPY+M2Mt19ThZSZjqks2APzxYCFwTdqK0KwloocXooB7KBi0IMOIS5xe
	 g/YOCRo6P8RUNV39v60Mz7H/iZaQQ/A62mGzqtvkg7VNz3XEmziSp1FxhNom90vl0N
	 yuosb1BH8MzeXsivAh9peF/fzOG/2FZuXVVSFiJiBvUKuQqsCe+cK/0zeYR13XIvUw
	 C3EmtdAxmT8zdGIoHSmkwabn+o/mcZjVAdlgFnUlN6ngSHaf+WzrU6N0e6gmRnSyBi
	 NMpohIJqJXecw==
Date: Fri, 4 Sep 2026 12:33:26 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, David Hildenbrand <david@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/5] asm-generic: fix typo "explicity" in comment
Message-ID: <apqsBpALCmN8S-qw@gremlin>
References: <20260904104854.25272-1-hemanth.selam@gmail.com>
 <20260904104854.25272-2-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904104854.25272-2-hemanth.selam@gmail.com>

On Fri, Sep 04, 2026 at 04:18:46PM +0530, Hemanth Selam wrote:
> Correct "explicity" to "Explicitly", reported by scripts/checkpatch.pl
> using the misspelling list in scripts/spelling.txt.  Only touches comments,
> no code changes.
>
> Assisted-by: Cursor:claude-opus-5

Thanks for acking the LLM usage! Appreciated.

> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

Please make sure to cc everybody on every single patch. It makes it a nightmare
to deal with your series given the volume of mail I get.

I may have to write a bot to auto send this :)

Anyway LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  include/uapi/asm-generic/mman-common.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
> index ef1c27fa3c57..cf1418649b3a 100644
> --- a/include/uapi/asm-generic/mman-common.h
> +++ b/include/uapi/asm-generic/mman-common.h
> @@ -62,7 +62,7 @@
>  #define MADV_HUGEPAGE	14		/* Worth backing with hugepages */
>  #define MADV_NOHUGEPAGE	15		/* Not worth backing with hugepages */
>
> -#define MADV_DONTDUMP   16		/* Explicity exclude from the core dump,
> +#define MADV_DONTDUMP   16		/* Explicitly exclude from the core dump,
>  					   overrides the coredump filter bits */
>  #define MADV_DODUMP	17		/* Clear the MADV_DONTDUMP flag */
>
> --
> 2.48.1
>

--
Cheers, Lorenzo
