Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB5F2222B2;
	Wed, 21 Jan 2026 20:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769029177; cv=none; b=FbmPxtpl0avNJL5vO+QHgNG5QpD9ul0IA/t+INiPurM/INvWcynHHmlGBhQH0zg2DF+vp64A2xqiY4ueDGkDzpj3QxosZegDMLXDJS0jwj56cu1EYIwNXz9Dk/XtltxWqSs2Y1XIQYhq7d+7vpRMoyq2n+lJF6XY/DZWpB92DjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769029177; c=relaxed/simple;
	bh=DZKZe9o/vex0abn+022OFFxMN0oPrW7ZX6ZQyopm9bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+qnqXcYq8zBVrqWOHZud57uXyqUqSRrVd8njMea0u6qo7LNWkufNwM5WPnypKGC4d2A8qch/hZ0LRKvuVAu/EYtl6v6/Q7R7Ukm3klhgo8lR2MRBXm1di7tOqrAKCVxomDQrgkkaoj0tmNo6IukG4JC5OWiRah6JRKtqp4/2l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jp9UOPKV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jp9UOPKV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFEF2C4CEF1;
	Wed, 21 Jan 2026 20:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769029177;
	bh=DZKZe9o/vex0abn+022OFFxMN0oPrW7ZX6ZQyopm9bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jp9UOPKVJpJFTunxq2ZiJL5noEuoAvBsGN8RgEylkbAfJKBtPqA8cx1vlaPJ6y3gH
	 98nE0vXo3WX5iNdBckE56NvJ2j77xEPbDfiZtcKJlEEQNOTXAELJjtQrZmK4bHwWLa
	 HiKDQ3IbLfMQieMWou1GbzHxgfz4kIY/qzYcsSLnBdgWNq77uDRu97bwz30FD/Tlci
	 bIXR4h5fM1mC2Ptc0IQbGptQntENLxgX+ZhyBedyzLF3N/VIw9sExjrDLSC1bjc57e
	 lMC407bRjiei+6JcmT7M8+oLkhg/4GjALdN+JXQKIbkZt+HojTmvycA7o7JvSb/u2i
	 1jp3pXl26anTw==
Date: Wed, 21 Jan 2026 12:59:36 -0800
From: Kees Cook <kees@kernel.org>
To: david.laight.linux@gmail.com
Cc: Nathan Chancellor <nathan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH next 01/14] overflow: Reduce expansion of __type_max()
Message-ID: <202601211259.4DD2D15@keescook>
References: <20260121145731.3623-1-david.laight.linux@gmail.com>
 <20260121145731.3623-2-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121145731.3623-2-david.laight.linux@gmail.com>

On Wed, Jan 21, 2026 at 02:57:18PM +0000, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> Change '(x - 1) + x' to '2 * (x - 1) + 1' to avoid expanding the
> non-trivial __type_half_max() twice.
> 
> Signed-off-by: David Laight <david.laight.linux@gmail.com>

Sure!

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook
