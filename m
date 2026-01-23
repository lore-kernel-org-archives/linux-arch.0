Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5722F2BF3CC;
	Fri, 23 Jan 2026 08:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769155274; cv=none; b=WRczHmqRQqEDhmXmTvAJjTWz7YFmEaIpXKV838VGbfFHfTDnr8H8vaixxruazTBl4HLwov6RjboiTshwO7p/jqg5mjXLLJc+9yUZwZ2800I8Ndy9eUKaRECD6M1kCUjZP/xuLhuijKfYc6glKxCszvs3wFPUf9LFw5f8PFvGhSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769155274; c=relaxed/simple;
	bh=jA0nIGlSFCoO5clU2/Vm0KGTikWt2SZVuYyg1s8QNsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e0zudvM7pLEDRLtu4GibEa5QwTguTy/2IPeAKv3syyMgIgzQzDff5oBXFJWeOiCGwqX0LdPii84fiav8QjMS30kBx0Ozj/ZzOWRjCHrmpyE3kJnUMWws2lCT/BZiwUAR1BAAcLP1SUgmci+qgTZZPyUuJ78Fx9W7duH+7rn4E8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Krs/YL+k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Krs/YL+k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC51C116D0;
	Fri, 23 Jan 2026 08:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769155273;
	bh=jA0nIGlSFCoO5clU2/Vm0KGTikWt2SZVuYyg1s8QNsw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Krs/YL+k4dMDFZGOntJwBxp9s1aWP7XzQN3y5A5IVHdmsm2Cn6o4ohWo9dOMC2zs9
	 gN+VJSV4vFetiAhLEpX1INcD8zwF0eb9rQJugBxR+0kPA+tgUwBsAp4E/y/qh6mMLy
	 /oeajz+f7+8iYhYzD7+Vuy65lFsIvZ/BJGL8nu+XCSIOOQLN25RRknJfuO2WqxXh6S
	 3jq5X5brp+aVTbUycm0Um0YE7CDqcX0DGzsalepQxnrKS+uvn3J8OFSm2OiBNxN96i
	 DTQbuMja9W7oLxMBYp7l6t6IgjDKsuEurEdZ9Tx+3EyE/j+kXDWAOdLTeGBnxLRIMs
	 iro7ohwYHD2/A==
Message-ID: <b49c9993-7676-4d33-a2d6-9f6b77b0fd34@kernel.org>
Date: Fri, 23 Jan 2026 09:01:04 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 11/14] bit: Strengthen compile-time tests in
 GENMASK() and BIT()
To: Philip Li <philip.li@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Chris Li <sparse@chrisli.org>, Al Viro <viro@zeniv.linux.org.uk>
Cc: David Laight <david.laight.linux@gmail.com>,
 kernel test robot <lkp@intel.com>, Nathan Chancellor <nathan@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
 Jani Nikula <jani.nikula@intel.com>, Kees Cook <keescook@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>, oe-kbuild-all@lists.linux.dev,
 Linux Memory Management List <linux-mm@kvack.org>
References: <20260121145731.3623-12-david.laight.linux@gmail.com>
 <202601221237.soiAkwkN-lkp@intel.com> <20260122103337.26473d1c@pumpkin>
 <aXIzpC6wpdv47cSH@smile.fi.intel.com> <aXLOELiIG8MHKcIO@rli9-mobl>
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
In-Reply-To: <aXLOELiIG8MHKcIO@rli9-mobl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Adding the relevant parties to the discussion:

+To: Al Viro
+To: Chris Li

On 23/01/2026 at 02:25, Philip Li wrote:
> On Thu, Jan 22, 2026 at 04:26:44PM +0200, Andy Shevchenko wrote:
>> On Thu, Jan 22, 2026 at 10:33:37AM +0000, David Laight wrote:
>>> On Thu, 22 Jan 2026 12:41:22 +0800
>>> kernel test robot <lkp@intel.com> wrote:
>>
>>>> sparse warnings: (new ones prefixed by >>)
>>>>    kernel/kthread.c: note: in included file (through include/linux/bitmap.h, include/linux/cpumask.h, arch/mips/include/asm/processor.h, ...):
>>>>>> include/linux/find.h:209:45: sparse: sparse: Variable length array is used.  
>>>
>>> Can we stop sparse complaining about sizeof(VLA) ?
>>
>> First of all, the LKP should install the fork of sparse by Al Viro. That will
>> fix tons of warnings that are related to modules and speed up the process
>> itself.
> 
> Thanks Andy, i will switch to the repo from Al Viro for sparse.

Al Viro's fork just adds 8 commit on top of the upstream sparse repo.
Wouldn't it be possible to just merge those?

That would be much less confusing.


Yours sincerely,
Vincent Mailhol

