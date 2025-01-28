Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A9D1DE3C8;
	Tue, 28 Jan 2025 17:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738084012; cv=none; b=bCcaAsz9IKjMV1hFzBfnHDn59BKt8iwMuAY8eRlas+GakjuilqzMlLbQiY5u+v/AG16XxEbckuJaqMjFttQ3E5Cl1YpwOHqt0+AKAmOjF6RpOAex0NBYB++9ZTUz0mCI3GvAno6XCmTLgYfTPdRat9DWAHb5hXOtKegl1o01OXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738084012; c=relaxed/simple;
	bh=myg/gkfd4LnTT427Z+UcgcsGZg3mi3cT7Gx1WfBJ7M0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=fX7hgTs9Nd1ItD160Jl+NNU/8hC1h3GZ1pa5krs1fRztt8F/3CQgzBDt/znfrUU/dWy8Wxt04tcXDJrd+V39yEAcMLDjuP+JpcbHE0DIrZVocJ7YfbwbDr/7EDyQZyM0KL6zxj3y7dI9t4CNyUgf7bANwYJxwrZEAqL3Y/9MZa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRLVFdqp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRLVFdqp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A207AC4CED3;
	Tue, 28 Jan 2025 17:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738084012;
	bh=myg/gkfd4LnTT427Z+UcgcsGZg3mi3cT7Gx1WfBJ7M0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WRLVFdqpBp6a6O0rVz44BCbC9rHIYClW05DLClnZeEP9RrRnB7wO4usVWr/4HM3b5
	 lVCkgcJvMz8E1L68lXdR8pxvoZ024u7XSSqIBpOfN9twMrbATZ4eyEH0xhNk44a3Il
	 cnSKXeNBsxvcsAnrinlEuw5yAbSiYajA1gdNaRdjiUVdormm6QZPloezgbH4oUGH06
	 cncwPihVJ7++A8RwH8+qktivodu3NTbM3J0Iv1Dhcjrz+pdNb5/y6uDPbKeXe9auPs
	 jUbbfXNGPEOPcZ0CnovPMN47zq7iziNvySdths5KMdmWcNuqxHJ5rD/lUwWuL/PU4T
	 8aQL7r+qYjqOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEBA380AA66;
	Tue, 28 Jan 2025 17:07:19 +0000 (UTC)
Subject: Re: [GIT PULL] LoongArch changes for v6.14
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250128142654.301146-1-chenhuacai@loongson.cn>
References: <20250128142654.301146-1-chenhuacai@loongson.cn>
X-PR-Tracked-List-Id: <linux-arch.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250128142654.301146-1-chenhuacai@loongson.cn>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.14
X-PR-Tracked-Commit-Id: 531936dee53e471a3ec668de3c94ca357f54b7e8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9ff28f2fad67e173ed25b8c3a183b15da5445d2d
Message-Id: <173808403822.3856593.3099761193931979719.pr-tracker-bot@kernel.org>
Date: Tue, 28 Jan 2025 17:07:18 +0000
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 28 Jan 2025 22:26:54 +0800:

> git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.14

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9ff28f2fad67e173ed25b8c3a183b15da5445d2d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
