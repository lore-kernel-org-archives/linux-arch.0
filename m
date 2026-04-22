Received: from sphereful.davidgow.net (sphereful.davidgow.net [203.29.242.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BB02E06E6;
	Wed, 22 Apr 2026 12:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.242.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776860673; cv=none; b=arOvpt5THYoXOPBaSCdDf5M7/6ta1QUg6TWSMObbIr8L+HmpzIRsAZpmXbsXhgbIoYIP0YsDjhgyhse7+2BbQ3z8RMqxN/iJAdwIuIo+4SXCCNmwrn5gziU+v1KAqW00zqfVuV16ApKkaMzGfl2lsynljdeJiOyFr/Y4SPyQBDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776860673; c=relaxed/simple;
	bh=ny7vkY2fzG8mTBwVqO/QMWlF9EzgUJFVVOKu/qUlYIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KgiR79Oy5gwZXEZNYFvXCUI2egpUWuZ+L6XXsVWZ15pvmT9VHw2CJdyFAvQWPY+EoX9JoiHJetlXpDMJ2/iN31ChrpjYAt79s+u5Nt7jQUZRHIspehY8V54EsYjY7xayEggrgD0UZBuneXVJ4EWnVsqUiMsHawvH8Blzc52vAig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=davidgow.net; spf=pass smtp.mailfrom=davidgow.net; dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b=qRCsrzNZ; dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b=n6gHOe9B; arc=none smtp.client-ip=203.29.242.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=davidgow.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidgow.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b="qRCsrzNZ";
	dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b="n6gHOe9B"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
	s=201606; t=1776860670;
	bh=ny7vkY2fzG8mTBwVqO/QMWlF9EzgUJFVVOKu/qUlYIE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qRCsrzNZiGWtSdrdwr/hmGo/C8Z/qq6pUTCWmlRWVwbJQfGR7erqeOGfZ28AFDDDS
	 t6ZlYnqoVr3YHODm1Jesc7GuiF8XUECcY/nJiNxPDlxFZwkQv9dmfl02Ry/mbVCQoN
	 XAtJY8syOpjXHtoyF7sKnIIvpdgN77ZxVIWTpCOUx4K+wvBtmEMfU0zoV6WpvTxhF6
	 z0yRNqTc139QZX6AkgvzkuBJ658k1pLPjLv33fNKOUv7OCfkwFvjfRZPWMi/96y6c+
	 4QjbVBCVIpUunvx6q2WKkN//c7PiZMzUXn54zOEAjG2ILkV9BaCG+WJc5379nGZn4O
	 5EyDv1mRt0rTSdAlGpG7usEb5v+TsIL6BkTL25di9TtVzcBjPeP1dYA3DIEK4+Tr6k
	 uTpEBZnETOqomLZBZEQLujWkTNd7jBhPzSWSB6/ockOALkg0CuOxq0lW2giBwdlUVQ
	 wMbtRwyDYeJVphzVheQ/XSILn5gQqsTnyl0EzkygOaxAGMvClG2EAnR8ayNusJawoR
	 xYNtafNn/L2idzLW2H3PMH5QIxvxH18/MEXxxuzhzAXZVlfDuRygE7folOBcbMKxT8
	 QxVH8SKrc87a/z3jDY6YXLQMmijzk/Uozad3R87117mOPOu2DHBQloh2Ysp/IxuVUH
	 Gb2PvUznx50Uq8KuXBQCBMGw=
Received: by sphereful.davidgow.net (Postfix, from userid 119)
	id 968261E8DA3; Wed, 22 Apr 2026 20:24:30 +0800 (AWST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
	s=201606; t=1776860426;
	bh=ny7vkY2fzG8mTBwVqO/QMWlF9EzgUJFVVOKu/qUlYIE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=n6gHOe9BzQy5I3LJfAPshR0ULJLuaobMTsQFvc9SrmIERn8nsNVk7EqptPSNkMfO/
	 cxx2CYXvt38+3n71zY7BgVrGflkZlKVu8Fwv2bw5vbcJYZvLVr5dxrDWLPW6j3IYVV
	 a1EzTAinrVYdri3M5EACB1zKxq6OOoxvAzxXfbmORh/Nn4VA7wg4EdvOl4gDfzGp/k
	 yL7VLMqzA0AmRw9PWueFo487n3Q3IIgSoFxFFFBeeTPi21T6iz4/VRYSuuysbstjKh
	 M3qYq1cbK7WIttnxGU79k5IjeRo7Cdbd6UVELtrREnkKuzQX8Bb3wt9RVUuJHIOKH9
	 /sw0wkPu1e7r7mzTOmcHyS51v/uirWu3K0xtsm8XKSFoLCkYNXEwj/DX4mO9BSUXVY
	 dqroH6mm63smzh1FyucpJpLnPwZ553BMSBy1+2j7LeDQPMYihOhZaP6wSSb8jtryAa
	 VZDaFmc6SW7woWtCbaceE8iZykCpmW/dBWKYOqebaSh7Pb3jNCFr88wk/htV6j4D/k
	 Cu/QEQ3zPJU+z3k2yiEb4DJ3wySFGBj4P1vwirHw3q4udLumafxgfoPswZpOFuDdPI
	 uLjPnuRfU4/mm1wa56MN62Ya5mopAUSGL39f71SfNN1YrCQe1yScgo4cLDEuJYk2nj
	 U1bsR2ays0hRqFVvOz0Xvthg=
Received: from [IPV6:2001:8003:8810:ea00:ed87:ca88:5326:e11d] (unknown [IPv6:2001:8003:8810:ea00:ed87:ca88:5326:e11d])
	by sphereful.davidgow.net (Postfix) with ESMTPSA id 943BD1E8D95;
	Wed, 22 Apr 2026 20:20:26 +0800 (AWST)
Message-ID: <0bd3f863-207d-4994-92cb-ec9999c0bc1b@davidgow.net>
Date: Wed, 22 Apr 2026 20:20:26 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] kunit: Add documentation for warning backtrace
 suppression API
To: Albert Esteve <aesteve@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <raemoar63@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 dri-devel@lists.freedesktop.org, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, peterz@infradead.org,
 Guenter Roeck <linux@roeck-us.net>,
 Linux Kernel Functional Testing <lkft@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Alessandro Carminati <acarmina@redhat.com>, Kees Cook <kees@kernel.org>
References: <20260420-kunit_add_support-v7-0-e8bc6e0f70de@redhat.com>
 <20260420-kunit_add_support-v7-5-e8bc6e0f70de@redhat.com>
Content-Language: fr
From: David Gow <david@davidgow.net>
In-Reply-To: <20260420-kunit_add_support-v7-5-e8bc6e0f70de@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 20/04/2026 à 8:28 PM, Albert Esteve a écrit :
> From: Guenter Roeck <linux@roeck-us.net>
> 
> Document API functions for suppressing warning backtraces.
> 
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Acked-by: Dan Carpenter <dan.carpenter@linaro.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Reviewed-by: David Gow <davidgow@google.com>
> Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---

Thanks -- it's always good to have documentation.

Apart from one note below, this looks good to me.

Reviewed-by: David Gow <david@davidgow.net>

Cheers,
-- David

>   Documentation/dev-tools/kunit/usage.rst | 30 +++++++++++++++++++++++++++++-
>   1 file changed, 29 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> index ebd06f5ea4550..76e85412f240e 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -157,6 +157,34 @@ Alternatively, one can take full control over the error message by using
>   	if (some_setup_function())
>   		KUNIT_FAIL(test, "Failed to setup thing for testing");
>   
> +Suppressing warning backtraces
> +------------------------------
> +
> +Some unit tests trigger warning backtraces either intentionally or as side
> +effect. Such backtraces are normally undesirable since they distract from
> +the actual test and may result in the impression that there is a problem.
> +
> +Such backtraces can be suppressed with **task scope suppression**: while
> +``START`` / ``END`` is active on the current task, the backtrace and stack
> +dump from warnings on that task are suppressed. Wrap the call from your test
> +in that window, like shown in the following code.
> +
> +.. code-block:: c
> +
> +	static void some_test(struct kunit *test)
> +	{
> +		KUNIT_START_SUPPRESSED_WARNING(test);
> +		trigger_backtrace();
> +		KUNIT_END_SUPPRESSED_WARNING(test);
> +	}
> +
> +``KUNIT_SUPPRESSED_WARNING_COUNT()`` returns the number of suppressed backtraces.
> +If the suppressed backtrace was triggered on purpose, this can be used to check
> +if the backtrace was actually triggered.
> +
> +.. code-block:: c
> +
> +	KUNIT_EXPECT_EQ(test, KUNIT_SUPPRESSED_WARNING_COUNT(), 1);


It might be worth noting that all of these must be in the same function, 
and the KUNIT_START_SUPPRESSED_WARNING() must be first. (And, in 
addition, there can't be more than one START/END pair per-function).

Of course, if the implementation is changed, that wouldn't be necessary. :-)
>   
>   Test Suites
>   ~~~~~~~~~~~
> @@ -1211,4 +1239,4 @@ For example:
>   		dev_managed_string = devm_kstrdup(fake_device, "Hello, World!");
>   
>   		// Everything is cleaned up automatically when the test ends.
> -	}
> \ No newline at end of file
> +	}
> 

