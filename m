Received: from sphereful.davidgow.net (sphereful.davidgow.net [203.29.242.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9A13D3318;
	Wed, 22 Apr 2026 12:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.242.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776860508; cv=none; b=urFGmtA8NcBL/n4kU4sKMbLUOivhXFfU5drPNEbyaCT69rCXCZ8PJt+SNIuyFEvM1wPAJXSQHwAuI/eP5lyNWAdJ3HjCJdy0GIvFBSQnfl2Y30emusGLjoCA1hqGT8AWYc2c0swvwDfInllM/lhIi1m0AlkOxCIDIC9DEK4IPv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776860508; c=relaxed/simple;
	bh=e5yQOm1rGEYi4XdegDATFL+BQNYVwttW0giv42dfL3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XlA1P1JJmaWnLokFR6+/A0eaWAKqkehxFjGjn+yi1wOD6f4SMAjqhXR4NR5m+WnX4oOU2lNrEHZGlbUvkrvgk6Bl4942ZTN2YPGdOUbbb93vRvX/+qWbTxJsbqfGxRa6QqLoSklr2LMrrEyMMAtaE/WYWjFyBrNw1KhAGrBc4Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=davidgow.net; spf=pass smtp.mailfrom=davidgow.net; dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b=gJ4E0plX; dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b=DdR24gg0; arc=none smtp.client-ip=203.29.242.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=davidgow.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=davidgow.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b="gJ4E0plX";
	dkim=pass (4096-bit key) header.d=davidgow.net header.i=@davidgow.net header.b="DdR24gg0"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
	s=201606; t=1776860502;
	bh=e5yQOm1rGEYi4XdegDATFL+BQNYVwttW0giv42dfL3c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gJ4E0plXxD4HUkxFfqmum7RHNJDb5ztZChSXUXFkegLzLxi/OVo6dtwfQeiCjCmor
	 cuCbb+0jz5GZJ4m6CdlNja69AWRT8Zdz6c83hvVLrG5HiQ/y36dVS9zyyKRm1jXSRl
	 4TW2bDHTxLeC8uS8lGVXF1/F4krhQySHuKhpf++Unci4fLdCaVQh1OlaYtZrmizvRL
	 uCAWfVX+QAleudjsb6llPUB9ECQta/5sthxXY1xZcNcx2hQQ7tMRNx52wKLq751lHo
	 aJN4Ql7n6J+KqtiQYR29EpnA4/fT4b7xOId2U6lbJ9zz+9r2mtYRgEeVYejc0K5VPX
	 Lk1lc/rC6NuzZtJkcYd35XGBBTJqD026m/W7oU430oAIujap3glcRAWwEAITU9KHfU
	 rNfCFpmtUPMOZmTyJJwxzmN9HHmGNKEXiSpMXD4xTdb4NH7XhhVL4Np9qHOuB0awJ1
	 ftVNVjFmOkH6dbnKQYwXgOg8506wyLIobnJfZJ2FDsL9Zzxynp9kOl2MOMsWTdFCda
	 2tcs+/354DY8bsJlyAlvqMY6jRwR0GPP+uk5l6Jnnfi8uBEYPf6W7xgBft8BDlkdPG
	 IHJS+22K5KHeTIDiFhZPMFHQ0y6NfXJ7tm1cnu35xheSvP5Mz/u74aC3pJdV1XgpoR
	 hEWWsASBJq8sJD8rpgUD/HGU=
Received: by sphereful.davidgow.net (Postfix, from userid 119)
	id 775411E8D97; Wed, 22 Apr 2026 20:21:42 +0800 (AWST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=davidgow.net;
	s=201606; t=1776860398;
	bh=e5yQOm1rGEYi4XdegDATFL+BQNYVwttW0giv42dfL3c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DdR24gg0Cxg6wLTgSbV8VJ67X0GgJX8STV7xvpvA6sUHhdcFHgHw0PsstbvxGkZk8
	 Uz5fULFsng8DNvmCD9dJoPZ4vxIzHwZdERDtzrV+duLdnJCY55/UGMzBu34DDhOHla
	 KAbZ86wfU8LcO92dWf22UhlcTrLvF1YeexNfVptdzo+mfT6sA9WBG1VlDjT1IdOizU
	 eeCfNkKx//D5PNbsZS6VUc56MxW+xL4EuykNmacyQQ1aLVODugVubYQwYhkJlu3Mqt
	 BnCE1j3mw8ucAKHs/N25IZGckCKbHUqQ6RDlqHfOqYqp5GYODRFONx2cOo33cNDowj
	 66qhZSAxmkhw1tJUKgmF1Jb0gxHdfGSsByQ5ruLkqFnWFgeDMuAkH9vekkxDed0sSc
	 ju2KnWa/StRUfnjnMvybSl/5ELmx/SI6Kq5JKNBmtrdB9EeJmSnddwg/VncVR/v0LY
	 qMN8gXcxLBfpgxFP8u5YpcwcqSY/9nt8odTrpEKqfLObS4MmypGNBv/0XKu19wGzjy
	 Roh03XuymR5wkiO4RFLvnrWnsg3GV12bscSy2sZ60oD5wKsII09krqO993aBaQYGIb
	 mkUZKuzNUny6UkRnzsmJwAtF8iTmqGIAC74Yd/I8ouqllvj3mpfIcsU+20Nlig9Rvi
	 iKcDyb8ClgUUFyILSB6zHLkY=
Received: from [IPV6:2001:8003:8810:ea00:ed87:ca88:5326:e11d] (unknown [IPv6:2001:8003:8810:ea00:ed87:ca88:5326:e11d])
	by sphereful.davidgow.net (Postfix) with ESMTPSA id 796C81E8CAF;
	Wed, 22 Apr 2026 20:19:58 +0800 (AWST)
Message-ID: <a1ddabac-8e50-4730-b936-4ddef949487e@davidgow.net>
Date: Wed, 22 Apr 2026 20:19:58 +0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/5] bug/kunit: Reduce runtime impact of warning
 backtrace suppression
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
 Alessandro Carminati <acarmina@redhat.com>
References: <20260420-kunit_add_support-v7-0-e8bc6e0f70de@redhat.com>
 <20260420-kunit_add_support-v7-2-e8bc6e0f70de@redhat.com>
Content-Language: fr
From: David Gow <david@davidgow.net>
In-Reply-To: <20260420-kunit_add_support-v7-2-e8bc6e0f70de@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 20/04/2026 à 8:28 PM, Albert Esteve a écrit :
> From: Alessandro Carminati <acarmina@redhat.com>
> 
> KUnit support is not consistently present across distributions, some
> include it in their stock kernels, while others do not.
> While both KUNIT and KUNIT_SUPPRESS_BACKTRACE can be considered debug
> features, the fact that some distros ship with KUnit enabled means it's
> important to minimize the runtime impact of this patch.
> 
> To that end, this patch adds an atomic counter that tracks the number
> of active suppressions. __kunit_is_suppressed_warning() checks this
> counter first and returns immediately when no suppressions are active,
> avoiding RCU-protected list traversal in the common case.
> 
> Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
> Signed-off-by: Albert Esteve <aesteve@redhat.com>
> ---

I'm not sure how much of an improvement this is.

It might be worth putting things behind the kunit_running static branch.

You could even add a new kunit_has_suppressed_warnings static branch, 
though I doubt anyone's too worried about the runtime performance of 
WARN() during testing, but with no suppressions, so it's likely not 
worth it.

Have a look at, e.g., kunit_fail_current_test() in 
include/kunit/test-bug.h, which uses the existing hooks implementation 
and static branch to reduce the overhead as much as I'd expect we need. 
That'd also potentially let you move the backtrace suppression code into 
the kunit.ko module, so you're not even paying more than ~a pointer's 
worth of memory if no tests are even loaded.

Cheers,
-- David

