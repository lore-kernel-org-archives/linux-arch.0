Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A494C298CC4;
	Fri, 23 Jan 2026 08:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769157167; cv=none; b=D1ypNvyFc17pnUpiIyUCfGnsOLIFBQLpwQHaYUmIqBNHZC4o4sqx/jKFU91nBI4gN1jBIWqt2Kacs1+G6w91zG3nUoxQzvQVvkVW7iNTlg7E+A0eA71XcOqLMpCflaI4aaBPzNZTq9i+47SRpHoyCiRtNtp0posQhRCzKLIzfVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769157167; c=relaxed/simple;
	bh=RPXHsjJJodiBfwtnVTgxBFEggh4DJsOuIORgyKkLh64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sc2xZRkfBc2VWy0yARcSg/oe5wnph/3+84RrL+K0zz5P4Qf/msPdszQXJRd8e9ZHZTlRNuMvU1uA/CdNotfpE25mtR+QE7lpMOm7TtVJTBfcjvRkqUbzfVfHPWJFaktTmDJGNH/2Xf+P2HKlhbdUz88XSM2Utfwnj4QQf/f3OzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PA7PbPpE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PA7PbPpE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3F7C4CEF1;
	Fri, 23 Jan 2026 08:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769157167;
	bh=RPXHsjJJodiBfwtnVTgxBFEggh4DJsOuIORgyKkLh64=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PA7PbPpEa1KvnGFm3KBSXJd1gzslvA7DmJdy6klvyzNAO0JpcYbj+FcaC1vmAWUyF
	 eXK3jX00afgTm45yoCmEKnyZyglRywyWkJUrV/F+1KnoZmCC7MQwbdCtRz9zadPJN7
	 NaqOeTCoJc7Qi2bhldmBjL06T0y+pKQv/2OME1kEzjqyxM91CY955pVN1L249o1KZb
	 2IxcOO1jj/pavF6Mc9CqwQwbkXnyXs+4J5YGCUK5OHBGzLVpOe4AZtlGFB1v55lqtB
	 r6woavprdaP+2FXoMf+WYX+0vum7rQEH3MozNwL1lfn8q9nYik4hBKTCpfidQ5GZHL
	 CVRGdX/7D7fpQ==
Message-ID: <f9fcd1c6-373c-4345-b413-9bb6c1cd2d3a@kernel.org>
Date: Fri, 23 Jan 2026 09:32:39 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 11/14] bit: Strengthen compile-time tests in
 GENMASK() and BIT()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Al Viro <viro@zeniv.linux.org.uk>, Chris Li <sparse@chrisli.org>
Cc: Vincent Mailhol <mailhol@kernel.org>, Philip Li <philip.li@intel.com>,
 David Laight <david.laight.linux@gmail.com>,
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
 <b49c9993-7676-4d33-a2d6-9f6b77b0fd34@kernel.org>
 <aXMtJ_JurQjvN4tU@smile.fi.intel.com> <20260123082027.GJ3183987@ZenIV>
 <aXMwIcH7Zh-1yNq3@smile.fi.intel.com>
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
In-Reply-To: <aXMwIcH7Zh-1yNq3@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/01/2026 at 09:24, Andy Shevchenko wrote:
> On Fri, Jan 23, 2026 at 08:20:27AM +0000, Al Viro wrote:
>> On Fri, Jan 23, 2026 at 10:11:19AM +0200, Andy Shevchenko wrote:
>>
>>>> Al Viro's fork just adds 8 commit on top of the upstream sparse repo.
>>>> Wouldn't it be possible to just merge those?
>>>
>>> Ideally yes, but you also should kick the distro's asses to update it, and
>>> the sparse should bump its version...
>>>
>>>> That would be much less confusing.
>>>
>>> Seems Al become a sparse maintainer de facto :-)
>>
>> Huh?  What happened to Chris?

After the project hiatus, I can imagine that there is some confusion :)

But Chris is back in his role of maintainer since September 2025. See:

  - https://lore.kernel.org/linux-sparse/CACePvbXDO1ZybDu3RaFhED9D-9gC6LTMpWrxoh5xD+ZO5SLdzA@mail.gmail.com/
  - https://git.kernel.org/pub/scm/devel/sparse/sparse.git/commit/?id=67f0a03cee4637e495151c48a02be642a158cbbb

> I don't know, but upstream sparse haven't applied any solution for
> MODULE*("FOO") stuff, nor reaction on my ping in that discussion
> (I did it like week or so ago).

I am out of context here, but were the correct people CCed?


Yours sincerely,
Vincent Mailhol

