Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68795111BA;
	Thu,  3 Sep 2026 20:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788467379; cv=none; b=NGFJ9yyikt8e+8kIpwReQxgvGirmh4JQJVx7gtwvyiWEaaVMT+FvHXOGdK1ANZ6l+alByI2JNg7gE9qJcPvDXfihBgxfJjJ0/djiCqmB+eeOzPHOlAAt3BqY+FDXE3FE7FdPUsYKb2r8JwCb2Jctb1dk6203YSkHTMsScPQXTtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788467379; c=relaxed/simple;
	bh=6k+x2dOCqaSK3RVJVQ4Hq6Sw3tTDk0keqGm7UmlEMl4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KdSvolt2Rn9x4oHnZC70F61d8DujH2tdZ8E3GAmGIX9xPyLGVVUW6mXeZw08RKrC0hDDB6t7v5xJbDBv8S9zSdkSqjiIrHuhVK6u1LljIi9wc5skBB78FnntnNfyCnLeBkgspYaF2+54wPyvB1MjpDfk7Fxw1WT+6c+/FKciAcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=wLix/Utx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="wLix/Utx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73A6F1F00A3D;
	Thu,  3 Sep 2026 20:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1788467365;
	bh=Q3CSb5LHrQ3tY+SHb+AfzsSK5Bg1/F3JbLS1pHS5bvI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=wLix/UtxEDahVPbY7L0B1R2ekc+j59TMJk5JC4P0uA/d4Zsb867x4UoFlPb+rRW6q
	 UL+UZAc4f0u2ij5wXrp5R5A73muh9oHDjTE9DrkvvYZ1+l5J5IRjbFwUyfWi+1Hk1d
	 z12cz4oWnDAFPuB6eFIXxxQ20SrQgGBsGhdx9YPQ=
Date: Thu, 3 Sep 2026 13:29:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: arnd@arndb.de, mcgrof@kernel.org, petr.pavlu@suse.com,
 da.gomez@kernel.org, samitolvanen@google.com, peterz@infradead.org,
 ojeda@kernel.org, mhiramat@kernel.org, boqun@kernel.org, neelx@suse.com,
 da.anzani@gmail.com, sean@ashe.io, chjohnst@mail.com, steve@abita.co,
 mproche@mail.com, nick.lane@mail.com, linux-arch@vger.kernel.org,
 linux-modules@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 0/2] module: Extend module_blacklist parameter to
 built-in modules
Message-Id: <20260903132924.7a4d1b84791d30c706b394a1@linux-foundation.org>
In-Reply-To: <20260903185557.183224-1-atomlin@atomlin.com>
References: <20260903185557.183224-1-atomlin@atomlin.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Sep 2026 14:55:55 -0400 Aaron Tomlin <atomlin@atomlin.com> wrote:

> Currently, the "module_blacklist=" command-line parameter only applies to
> loadable modules. If a module is built-in, the parameter is silently
> ignored. This patch series extends the blacklisting functionality to
> built-in modules by intercepting their initialisation routines during early
> boot.

Why?  What are the use-cases and what is the value of this change
to our users?

Important, so please don't skimp on the details.
