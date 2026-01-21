Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305B633F8B2;
	Wed, 21 Jan 2026 18:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020994; cv=none; b=LCTFaXzyrwJvzgZnY5Li1gFkyntZ0xS5ohlTldpUHCvHr6WU0I6kc680ZRA3WNVcAfTiC/cfDWGN49bsaduAg6BdJrgJAj7AoA3+yIMnZraFZ4rMr8IV2dzSoKgaqBxH2CibvvPm7NIUCpayNi95/UpM8Q+Bbab4qzoiOA5IUhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020994; c=relaxed/simple;
	bh=bUcRg8M6f7x4yk/YVNM6zo6XZNb1VSb9sff9R1fbbEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=BasE8STUZ95vskRkoRrFMcKTNvif3vnqnXA3aRdfNHFjS8zLkl5Ni1T7B+o0Xi6/mfIsciv3ycdpY391nWyoWnFqRAN6BWzuGVL89oOPRTqxXr8YJ7wmiIP8nd9TxKHkSHnZY/N1XL+SNm7FhIlqwYs94ieXnbnxwlUE5zP701E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSJBUmeP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSJBUmeP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03FB4C19422;
	Wed, 21 Jan 2026 18:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769020993;
	bh=bUcRg8M6f7x4yk/YVNM6zo6XZNb1VSb9sff9R1fbbEU=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To:From;
	b=cSJBUmeP+9FSJVPzsdxPiT0L/zhndxauXEAcfRWca17eR5cuNeH9O6SmkszV3krm1
	 UEUB7A9yESTYEHIZbS4PlbHplRaPLeyC6e7CY3/PxuK0fMSFXKXWcrMjK0xvVNWEhO
	 o3PkX/7T01SHw1sFee3yPtQ9xYoBsmh7Ve1O4myLhBQHcJP7xlKy8eKkVW07r0E2kY
	 iVfYK+PEwenwyLCiKxNxDppOVJDJ9Pi5c5NRItSFRg0liV24ZB+DkjOMUMBr9ZxpIM
	 09v02YaFKdRbuZy4+dRZsVf7L0RS9CTf6dqGy3DxpEjqddE3nJAfL4Tvq8PakFBBte
	 /KQa8t+205AWw==
Message-ID: <1ed83fd2-575b-4b22-9a01-b3a2110af78f@kernel.org>
Date: Wed, 21 Jan 2026 19:43:07 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 11/14] bit: Strengthen compile-time tests in
 GENMASK() and BIT()
To: david.laight.linux@gmail.com
References: <20260121145731.3623-1-david.laight.linux@gmail.com>
 <20260121145731.3623-12-david.laight.linux@gmail.com>
From: Vincent Mailhol <mailhol@kernel.org>
Content-Language: en-US
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
Cc: Nathan Chancellor <nathan@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>,
 Jani Nikula <jani.nikula@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20260121145731.3623-12-david.laight.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/01/2026 at 15:57, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
> 
> The current checks in GENMASK/BIT (eg reversed high/low) only work
> for 'integer constant expressions' not 'compile-time constants'.
> This is true for const_true() and -Wshift-count-overflow/negative.
> While compile-time constants may be unusual, they can happen through
> function inlining.

Did those new checks actually found any real problem in the code? This
adds a lot of complexity so I am not sure whether this is a winning
trade-off.

> This isn't too bad with gcc, but if clang detects a negative/over-large
> shift it treats it as 'undefined behaviour' and silently discards all
> code that would use the result, so:
> int f(u32 x) {int n = 32; return x >> n; }
> generates a function that just contains a 'return' instruction.
> If 'n' was a variable that happened to be 32, most modern cpu mask
> the count - so would return 'x', some might return 0.

But then, you only solve that shift problem for GENMASK() and
BIT(). Any other usage of the left/right shifts are not diagnosed
unless your check get copy pasted all over the place.

I think that such a check belongs to a static analyzer. Speaking of
which:

	$ cat test.c
	typedef unsigned int u32;
	static int f(u32 x) {int n = 32; return x >> n; }

	$ sparse test.c
	test.c:2:46: warning: shift too big (32) for type unsigned int$ cat test.c

So here, I would rather keep relying on sparse rather that introducing
the W=c logic and all that macro complexity.


Yours sincerely,
Vincent Mailhol
