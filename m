Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E303D0929;
	Wed, 22 Apr 2026 12:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776862410; cv=none; b=ONs+EQ8JCzeFoDO9BHyNP1c8W9yyvB0AHERovFBpSnjYSF2MmIM51/LcNLvdMhfe2HrWXU+fxTAwR6ruK7Vr4lzF2Ih4xySVdRV0yvUBBrbIEyOea3MaX/ICEuQb8+CiFoMNpWp2139SPDUwBJhzm/055m7Dh90jf748gFXt2bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776862410; c=relaxed/simple;
	bh=PNnDCzGsRm+eFMvCWAZgnBoDZdSimelEoS72QwaSIaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HmIzq16W/lX6ISbbp5iE/GdjbZ2gHyL1w4sWJCFUhK5TAe+8tmM6KJF3qkThfn5Iy+k1WkWCXaBZdNkrvccmK7mh9jwmwGj4Bve3Hp6SSYy2Vf7yi6EaDsOXqwt5hD/KZP0GT6+QCmhWlvd5qJlTxAM2Uee6l4upoeacz0g6Wos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwEm58Xl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwEm58Xl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AC1EC2BCAF;
	Wed, 22 Apr 2026 12:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776862409;
	bh=PNnDCzGsRm+eFMvCWAZgnBoDZdSimelEoS72QwaSIaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UwEm58XlP+PSxfHAM+HdlxiRw/Y67epyVMYqaKBJNdG4EM3+YLiEJa0IEdNZsrPe+
	 V3m1fNzu27l3EdSz9N70T/AD7xaP7BPQCZ5gvA+Bof8azwhKaR2K7lP6koJMkDU9MH
	 OJRsCfKjsv2ezYNN6NTZal/GROPgxw962Pi8NnNIPc9CX+YtOehtlPQOmh/ciPejhS
	 TJdiwo0BthlmpHBUBU8eJaDITg0TkGdsUqUAadeEk/hpe0FXGbaJ5oWa9ASK9C8NRm
	 Wz3gFgPz6HTag5MCTaZacP4FxgNkH+HKRrpB1xsEBqvUqHzPFwQsb8UnjB+IP13kN6
	 fUL+uTqj7KV5A==
Date: Wed, 22 Apr 2026 14:53:24 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Aleksa Sarai <cyphar@cyphar.com>, cmirabil@redhat.com, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Arnd Bergmann <arnd@arndb.de>, 
	"open list:FILE LOCKING (flock() and fcntl()/lockf())" <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v4 1/2] vfs: add O_EMPTYPATH to openat(2)/openat2(2)
Message-ID: <20260422-zugegangen-schlucht-d8b4d629cd13@brauner>
References: <20260419131800.486788-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260419131800.486788-1-jkoolstra@xs4all.nl>

On Sun, Apr 19, 2026 at 03:17:49PM +0200, Jori Koolstra wrote:
> To get an operable version of an O_PATH file descriptor, it is possible
> to use openat(fd, ".", O_DIRECTORY) for directories, but other files
> currently require going through open("/proc/<pid>/fd/<nr>"), which
> depends on a functioning procfs.
> 
> This patch adds the O_EMPTYPATH flag to openat(2)/openat2(2). If passed,
> LOOKUP_EMPTY is set at path resolution time.
> 
> Note: This implies that you cannot rely anymore on disabling procfs from
> being mounted (e.g. inside a container without procfs mounted and with
> CAP_SYS_ADMIN dropped) to prevent O_PATH fds from being re-opened
> read-write.

That's the only thing that really always gave me pause about this.

So I think we should try it anyway but I want to prepare you for the not
so unlikely possibility that we will have to revert this because some
userspace program relies on the legacy behavior.
