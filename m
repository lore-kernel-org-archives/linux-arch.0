Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F332C2E229F;
	Wed, 19 Aug 2026 02:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787108368; cv=none; b=UcOPQtAMwIH9q5Tph7h3d1FyO5GcGmyRBLta4eKa7OAMRJ7zospKyWUCJkhTZSZMrqu1gl74TS9RPnI6ESZgWMhPP915WtxM7E/fjaaHFn7U5NSWU+6gRDyPF0jCVsgwFUvEhMxR+Sgo0LuZzLs32IhtbDxD4XykefHpHPIKUNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787108368; c=relaxed/simple;
	bh=jfoPCM9lMm43eLseF2tiizXvMe6pQiekxbCJt8yKBm8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=odKDmZdhz54c1hbWmKVlfvDRwDOropgeNxw9QPcNphYHcrRzRPEeMNgVs8nYZCwfYP3ybTt+XN50tyK8KBVNnqXS6GFsNxUYjN8PM/t/9SUriBlgSgkr3QBSwB36VS6MHJAghixr9FCdOokKt9b2uXFiSZDokTK4AkvIZkiSips=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pz1R9ZEr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pz1R9ZEr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBD41F000E9;
	Wed, 19 Aug 2026 02:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787108366;
	bh=cAeeYqG+ddn1Q7vay+bq1jt3637yxDX7uJC40y0DV1c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Pz1R9ZErB+cMC/WDiOqPKrrzSwRVb7mZcCU0E0oyS4Mf6MFvPzxxZmxh6yyKIVdWi
	 jIT3gz2zcgfI1gAaoAAolhRO2zMnkiGIVKQvt1/a5wSlCHZ139c85TOjZE7qsoV4xw
	 yNNPEkXCX+VDwS/bwGHLAIDgFgkhqhSBNIgtORa2R7syOAxnhCKa2yWAv2O0HVyo/L
	 HCtTdwNxVFYVgjCwXUbm3plgSa13yv4J6V3QNu/0GMvMTxfOTpRL6hdAXGjLfgLtj5
	 oLjjTwudaYOF+EMt4u0IjI+i6vgRRciPJ8sBAUGmCIOPhmQwkdNfBNPZEjqCJtf6N1
	 X0xCVwBk3M1Mg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198C8392706C;
	Wed, 19 Aug 2026 02:58:39 +0000 (UTC)
Subject: Re: [GIT PULL] csky changes for v7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260818000927.618275-1-guoren@kernel.org>
References: <20260818000927.618275-1-guoren@kernel.org>
X-PR-Tracked-List-Id: <linux-csky.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260818000927.618275-1-guoren@kernel.org>
X-PR-Tracked-Remote: https://github.com/c-sky/csky-linux.git tags/csky-for-linus-7.3
X-PR-Tracked-Commit-Id: abb81e5ce7d995baa41556b8125fa59e28ba3be8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d10e148b27cd746cc5c27e30686153eb97e8d8d0
Message-Id: <178710831756.2816674.8353320524170161098.pr-tracker-bot@kernel.org>
Date: Wed, 19 Aug 2026 02:58:37 +0000
To: guoren@kernel.org
Cc: torvalds@linux-foundation.org, arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-csky@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 17 Aug 2026 20:09:27 -0400:

> https://github.com/c-sky/csky-linux.git tags/csky-for-linus-7.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d10e148b27cd746cc5c27e30686153eb97e8d8d0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
