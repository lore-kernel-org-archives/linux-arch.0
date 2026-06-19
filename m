Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F5F30F927;
	Fri, 19 Jun 2026 07:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781853817; cv=none; b=q3ZA21ywYpx+KvrDEO/AsW19pPz2jrMH6cIpG15vMoTo7nrtQYlBcY5fOTcxo+xWQaT3TvN3rmWR490CBrQCj7Y7kZCQudyWFgR1z1iFlMyR6+E88zluOS6cm5gGSyHMzW4RWCbr+s2gTd17ynlvUCcSjJRl76Us/I2vfk9UeaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781853817; c=relaxed/simple;
	bh=QkeHkE3g4wxMH5hB0NvQvJUDbnS7C2lZFlpit8rOu+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNzmOv4yrkfc2h/2cy+c900v1i0ad6vkulZs4iBKURfYjdz/se4ldtAgtYCGdGYFaSZwDXKcjR6xmFrjmzKjixOimUnti8NlMNXh1f/UG5ZPqc4vNBOIv98b5nFl06fLzgr4tBKP4LyfpJeTJB9gRJT0TZU1L7lkgRPOF/cfv6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2QGe8V2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2QGe8V2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394231F000E9;
	Fri, 19 Jun 2026 07:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781853816;
	bh=TtH5IhKUgd1+u0cPTAuCNhSuI0z3WmY/qXULu9PIz6M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i2QGe8V2YVe5021kDRz7YtlsDZlNPojmr/jMUfd2VtwG8kWW5GTTphjnwjVw6JsYf
	 I0xHDaybM6jGx7YBtJq+zOW+5cZg5cW1hONwcDZBftj3qMv2dzwdvB958w6V1MRMZs
	 t5ADsweGp1L3PkIBctpeF5HxyMFSZLSFfL5IYp3O3dckZSVOwnHl2M/fTSSN3xnttm
	 Pu7Hr8u1R0uaxq/okoIqbLX8nL9IZmj6YRVVRSl8i6XCAjtXk9hKFsTH6piBg2WqCK
	 NqpV1so47k06y+b6cjJI2xjMeBBfTmDfymlJP1dRvxmuWZ2SB7+Twj7E1G8QdXDNf5
	 sXumZmKFtxqYw==
Date: Fri, 19 Jun 2026 09:23:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org, 
	chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, ebiederm@xmission.com, 
	keescook@chromium.org, mcgrof@kernel.org, j.granados@samsung.com, allen.lkml@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] coredump/fcntl: Add FD_CLOBCOR flag to close fd before
 dumping core
Message-ID: <20260619-hiervon-kopfsache-rechen-efbdf4463544@brauner>
References: <20260618030700.2511668-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260618030700.2511668-1-jackzxcui1989@163.com>

On Thu, Jun 18, 2026 at 11:07:00AM +0800, Xin Zhao wrote:
> A coredump typically takes some time to complete. If we happen to hold a
> write lock with flock just before triggering the coredump, that write lock
> will not be released during the entire coredump process. As a result,
> other processes attempting to acquire the same write lock may experience
> significant delays.
> 
> To address this, we introduce the F_[GET|SET]FD_EX fcntl operation and the
> FD_CLOBCOR flag, allowing coredump_wait() to release any file descriptors
> marked with FD_CLOBCOR. We can also assign the FD_CLOBCOR flag to specific
> shared memory segments, preventing the coredump from including shared
> memory that we are not interested in, thereby reducing both the coredump
> duration and the size of the core file.
> 
> We actually considered using signals that generate coredumps to perform
> the actions we wanted in user space. However, since other threads within
> the process are not frozen when handling these signals, indiscriminately
> closing an fd can lead to concurrency issues. For example, if the thread
> that triggered the coredump closes the fd in the signal handler while
> other threads are using the resources associated with that fd, it could
> cause secondary corruption of the coredump state.
> 
> Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
> ---

Eew, NAK. No way we're doing this.
I can see a point in filtering memory that one isn't interested in but
that has to be built on top of the coredump socket protoctol by
extending it.
