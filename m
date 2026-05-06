Received: from sphereful.davidgow.net (sphereful.davidgow.net [203.29.242.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C553ED132;
	Wed,  6 May 2026 09:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.242.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060605; cv=none; b=QRfRstNcmwzgHjfpWjTYEy5aAJiX4TKd1sGVKqSWD02cHcLAYDweT4STwPv5fX0bjkWZtYNVwaDHj8c9iJ/6Tm1MZcbgfehJM/Juf1tE1SlOItECCs4s/RFh199dhHyWnWuR4V+I3HhEFZfm39ba65beVMjLdmD7kS3GL+yToAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060605; c=relaxed/simple;
	bh=ETJfHEFrnP7uwEuXnhfD4Juu41Z9IVYsTPtyUojN4Ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ti+d0TjJRrwva1hiY4Q2YE8sF7PhhPMfA1tQ+ldCkTDvu4QX8PcvjkwWl2iJU578ktzvRQ3Y3FPHM6sJP2YuSKSgi6y3vtv+HDh34aCbpyucCOhQQtNBtxS5cqKhDbJkHAw5ZXIt9sZO0n2F3dDNEc3NibKur2oJVRXeKQGgZpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=davidgow.net; spf=pass smtp.mailfrom=davidgow.net; dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b=hdXdu5Wl; dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b=kpsixPmy; arc=none smtp.client-ip=203.29.242.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=davidgow.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidgow.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b="hdXdu5Wl";
	dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b="kpsixPmy"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
	s=201606; t=1778060602;
	bh=ETJfHEFrnP7uwEuXnhfD4Juu41Z9IVYsTPtyUojN4Ls=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hdXdu5WlAF1V+jHGbBER8FnNw0uk2QVDnS4aZ/LNyvg6Op1oyWneMl18ioDr18wVM
	 HBb/z14czsU7cuz2O0Uj+Bw8qxVoO1xY16laB7eLbDQ3rjMwq9t0i6RvMIpPD1mVUt
	 pumL68Vxx/189xVhfrS4TTwZu/aUFu60ur4aWv8p+5UEBfoSUWfenFwtskywxIohl0
	 CcyFICx1vr4FB6YJtQgRwNA/ylD3AvVyJs3OKDf7omgMWNIVGMaWzEWj+6VBL2F73c
	 xebK1vedrqIOOL/LpeEpVgnl6blVqrU8SAfodV/tuCLzJsYQpJEIIsXk1dYQGjiRAa
	 T5Vc49l1EbD9mFC60XZk2TQX1OHmFkcEc+Vk5D8i2ohEDe1k0iNoM+N4CBZMAPlKzp
	 TC+LHye4pgreLUJgB1mYqgGirztwmUBn1EjX6zgue6L7wUDYjRRRq3fr8dygoAtWbt
	 VlHkCyainczSzURhfADuKKZHJS+COnecxw1vwKqU5sVzS+ZE0YSzsgmfokpraJxHwI
	 fU9ygY9mC5AWBg465+hvsJkcwdhr08QnG/fv0TghYBeISzwFvU3l2bFJXXiMfD5zgH
	 pEWpMR4O4hW7I+UhlvzV8zUX70XZ9QzbYNyAj0kA7NelfsCdjT8BGDZiKbIIA6T2o6
	 QDnPxspcA4P3MmyIzOMKwEeA=
Received: by sphereful.davidgow.net (Postfix, from userid 119)
	id 031931E9362; Wed,  6 May 2026 17:43:22 +0800 (AWST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
	s=201606; t=1778060332;
	bh=ETJfHEFrnP7uwEuXnhfD4Juu41Z9IVYsTPtyUojN4Ls=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kpsixPmylB0V+dRd32N8gl5QYouI/mT0Gr4xvKSSZKRcR9jfgZqq/ItCBGAzdhpUy
	 97MynWIjsQAKdu6u93rZGz3wSEpT74sORdYEWxwAISJzKp/jsYQy4r+zcD/XN4x8or
	 IQg3smj8AnZUFrQgTGNDZ0yZpmz/JOVw2FjxmwENeAijqYMqDTMVT76VtU1NDmbB06
	 6Z4bvSCn9NXN88opGdeyVxAd8mIU2fHaUHZKLkCcJDG45p14lobHJmYYunHm4GL3XX
	 otLPaJbmNdYoLi87IMFMMYnteJ0uh2b3+Pizz9ZEKD1ok0GUGeheVIoDuwYPGPUpY8
	 f3TlhhQS/sYpNS4uPGaD76jbApZJZC9rw9HEUHo8Nw/B5IlyrecB3CIZnQ2Aba/qtb
	 2Y9KaCieioXCSHIsNY5DzmwaBVZhGizJJSN2TlKSIiTLJ9zLIpaGrOi9vt9lXLFZK3
	 wDUhoiZjH2HEtVsUzrrTsSnmZOqZleaGOzmlVtNA2qXSWL89TBQ0m/po1SUZoGagyp
	 pp+PPO76CEBmjXMFWTzNQOydgMBwcFvMeCAxdhfrk8eSou5jjkybFGOsTuhbDwdEdZ
	 vFW5+Dcz3duTxlS3xTrBeVD4mY9ZZRKFYWTsgbc4COYx8uV5Ue3CUhy0FiEd0++qkS
	 6/4suRNaadZ2GBZ+65hdkh/I=
Received: from [IPV6:2001:8003:8810:ea00:ed87:ca88:5326:e11d] (unknown [IPv6:2001:8003:8810:ea00:ed87:ca88:5326:e11d])
	by sphereful.davidgow.net (Postfix) with ESMTPSA id BB24F1E934E;
	Wed,  6 May 2026 17:38:52 +0800 (AWST)
Message-ID: <428e61d7-bd94-4264-bf7b-950f1dea2da0@davidgow.net>
Date: Wed, 6 May 2026 17:38:52 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/4] kunit: Add documentation for warning backtrace
 suppression API
To: Albert Esteve <aesteve@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <raemoar63@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 dri-devel@lists.freedesktop.org, workflows@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org,
 peterz@infradead.org, Guenter Roeck <linux@roeck-us.net>,
 Linux Kernel Functional Testing <lkft@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Alessandro Carminati <acarmina@redhat.com>, Kees Cook <kees@kernel.org>
References: <20260504-kunit_add_support-v8-0-3e5957cdd235@redhat.com>
 <20260504-kunit_add_support-v8-4-3e5957cdd235@redhat.com>
Content-Language: fr
From: David Gow <david@davidgow.net>
In-Reply-To: <20260504-kunit_add_support-v8-4-3e5957cdd235@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 04/05/2026 à 3:41 PM, Albert Esteve a écrit :
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
> Reviewed-by: David Gow <david@davidgow.net>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---

This is great, thanks!

Reviewed-by: David Gow <david@davidgow.net>

Cheers,
-- David

>   Documentation/dev-tools/kunit/usage.rst | 63 ++++++++++++++++++++++++++++++++-
>   1 file changed, 62 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> index ebd06f5ea4550..25724f7e72969 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -157,6 +157,67 @@ Alternatively, one can take full control over the error message by using
>   	if (some_setup_function())
>   		KUNIT_FAIL(test, "Failed to setup thing for testing");
>   
> +Suppressing warning backtraces
> +------------------------------
> +
> +Some unit tests trigger warning backtraces either intentionally or as a side
> +effect. Such backtraces are normally undesirable since they distract from
> +the actual test and may result in the impression that there is a problem.
> +
> +Backtraces can be suppressed with **task-scoped suppression**: while
> +suppression is active on the current task, the backtrace and stack dump from
> +``WARN*()``, ``WARN_ON*()``, and related macros on that task are suppressed.
> +Three API forms are available, in order of convenience.
> +
> +- Scoped suppression is the simplest form. Wrap the code that triggers
> +  warnings in a ``kunit_warning_suppress()`` block:
> +
> +.. code-block:: c
> +
> +	static void some_test(struct kunit *test)
> +	{
> +		kunit_warning_suppress(test) {
> +			trigger_backtrace();
> +			KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
> +		}
> +	}
> +
> +.. note::
> +   The warning count must be checked inside the block; the suppression handle
> +   is not accessible after the block exits.
> +
> +- Manual macros are useful when the suppressed region is large enough that
> +  extra indentation is undesirable, or when the warning count needs to be
> +  checked after suppression ends. ``KUNIT_START_SUPPRESSED_WARNING()`` must
> +  appear before ``KUNIT_END_SUPPRESSED_WARNING()`` in the same scope.
> +  Limited to one pair per scope.
> +
> +.. code-block:: c
> +
> +	static void some_test(struct kunit *test)
> +	{
> +		KUNIT_START_SUPPRESSED_WARNING(test);
> +		trigger_backtrace();
> +		KUNIT_END_SUPPRESSED_WARNING(test);
> +
> +		KUNIT_EXPECT_SUPPRESSED_WARNING_COUNT(test, 1);
> +	}
> +
> +- Direct functions return an explicit handle pointer. Use them when the handle
> +  needs to be retained or passed across helper functions:
> +
> +.. code-block:: c
> +
> +	static void some_test(struct kunit *test)
> +	{
> +		struct kunit_suppressed_warning *w;
> +
> +		w = kunit_start_suppress_warning(test);
> +		trigger_backtrace();
> +		kunit_end_suppress_warning(test, w);
> +
> +		KUNIT_EXPECT_EQ(test, kunit_suppressed_warning_count(w), 1);
> +	}
>   
>   Test Suites
>   ~~~~~~~~~~~
> @@ -1211,4 +1272,4 @@ For example:
>   		dev_managed_string = devm_kstrdup(fake_device, "Hello, World!");
>   
>   		// Everything is cleaned up automatically when the test ends.
> -	}
> \ No newline at end of file
> +	}
> 

