Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59273314BF;
	Fri, 26 Jun 2026 08:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782462066; cv=none; b=JvNsXrHd+0Ld/fkjNxGvH5Q4puzATU9OHBdUXjSSXBSJ7x7DxQdnod4Ko3XItKi/1wOTHTynXjlLHGMPMSXZgLw7Ea199UdywI4jurVZmiXLWfhpemNo/eVDeMjxgt6xqSEhNrMUhN9JDI56r6TNtkQYc/35ISTxrChJtwOq5i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782462066; c=relaxed/simple;
	bh=krqbnD0RWL5+ztLAtZGOwUnxeQ2CcqU2WADyRyD9FOc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RTTR/oDfMzMJpXolRGqUp5DB5KvO8obilz9aM9rt6HlZ1CTlytln29HXKLdBEJkFi5ee7yuBwFpibzcPQvB7Zm7QIdmlQehRdu8NG81NcyeF4W6q4DUPz32r8G5cnH+rdCUjJmXKKCOGjv/LjImviilUHPpHbZHi98QBp+j8TTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOmAVBiB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOmAVBiB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944D31F00A3A;
	Fri, 26 Jun 2026 08:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782462065;
	bh=Hd48Vo1zZRuniF2+TmHwwxThB9aCSuhA9WEZ7WkytJ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JOmAVBiBFCRy04ORniCItBvjcez5viZEntfi5bdM0eoVja301FBH1EojafOQ33Gxl
	 r+ASN8SgU2YzT0cp9FglIYfZMDCLlMs4jetT8ajc4wQyKyfZbidwNHd5z1FSNC5nzf
	 zN+zX4S4ZN1al7wVU/NLpU7/dBy85Drl2zC5TwsCSXcfUilSLg4RXMxH+HlHeSDNIg
	 8ql7G+Ufv7aAiHqq89wTeF5fdjNqNSq3hqQceVYmtGREIB0OUP2b/7gw3h6bNb7XN6
	 yzGny9NlauumObP0FEo6VOpvCEbybbxUD8HSoqwXVt9r9ZwKoKfOew3UEuRCokYyJc
	 HDyMD7tVwhWMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AAD39389E8;
	Fri, 26 Jun 2026 08:20:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/6] lib: rework bitreverse
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <178246205280.3816447.13667687327162917011.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 08:20:52 +0000
References: <20260430211351.658193-1-ynorov@nvidia.com>
In-Reply-To: <20260430211351.658193-1-ynorov@nvidia.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: linux-riscv@lists.infradead.org, pjw@kernel.org, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, alex@ghiti.fr, yury.norov@gmail.com,
 linux@rasmusvillemoes.dk, arnd@arndb.de, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 akpm@linux-foundation.org, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 ruanjinjie@huawei.com, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Yury Norov <ynorov@nvidia.com>:

On Thu, 30 Apr 2026 17:13:44 -0400 you wrote:
> This series is a resend for Jinjie Ruan's "arch/riscv: Add bitrev.h file
> to support rev8 and brev8" [1], my follow-up "lib: compile generic
> bitrev based on GENERIC_BITREVERSE" [2], and the fix for a build error
> reported by Nathan Chancellor [3].
> 
> No changes, except for combining pieces together and rebasing on top of
> the tree.
> 
> [...]

Here is the summary with links:
  - [1/6] lib: include crc32.h conditionally on CONFIG_CRC32
    (no matching commit)
  - [2/6] lib/bitrev: Introduce GENERIC_BITREVERSE and cleanup Kconfig
    (no matching commit)
  - [3/6] bitops: Define generic __bitrev8/16/32 for reuse
    (no matching commit)
  - [4/6] arch/riscv: Add bitrev.h file to support rev8 and brev8
    (no matching commit)
  - [5/6] lib: compile generic bitrev.c conditionally on GENERIC_BITREVERSE
    (no matching commit)
  - [6/6] MAINTAINERS: BITOPS: include bitrev.[ch]
    https://git.kernel.org/riscv/c/7b2c5b4e43aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


