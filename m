Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4E12C15BB;
	Tue, 31 Mar 2026 16:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774973858; cv=none; b=GeUynQOS796W5VxvEvzLwP9iEEmGc6/gW3jYFncjRwPVMovQz/dSG1pgK+By0+k/3RcAlUHMfVWKSSTcqOAjS2t8xPeUpQUxAthoXMgJBVUwaCe9g5PaE2At29Oix5LJkMI42aJ0RWW9vpywAZiCyqL38CA2lWiseVuleiZzzeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774973858; c=relaxed/simple;
	bh=4dr8PUXfbrgq84H+mHgxTP35N7Wqw+KDeRuZIzRf9y0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eY4zLW/4HQM23MUHB9tz32iVeTZXvyYLqMkftlSiX+5zK5I15y2HfXcf6zZ2QedhrPMMY8A6qP9DBe6SaJKuJyXuL6zo7kGVxEjAc54TVMZCDJ42B/LsrvRfjNiujvn0hP7WT4Vx7gARbYxvu8JxbeedUbt+wRcgIxt1KM79uAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=MzmUOR9p; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="MzmUOR9p"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6514040C6F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1774973851; bh=WmpBWBdx107Bxh0at4HFA8TNqz4JmQ2baYL397MFDj8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MzmUOR9pwvMunqazLB6QzbwYsuzEiKYwkoXkdQmAO7D0bSdok9TJFhhZX5ShOfvVY
	 uLaP8OVA1dL34n9O8A0iPC8QPC7tf7kv1BMCVuUTcBfPtWeA9eky3p3LWO+Yef3u2j
	 9BBSXe3XLS7ewnhPAdVSQ+jpYYeK5vZhLWQt75U1DAZ5xVL/38Jw9poNoCRVyYoYyD
	 04SDHGE+tYC6S15N4nB1e5J6spgoJ7ktZypzFOybcRhUGsE/KYYqVAn98ZQGKrdVFj
	 Splu7OB5gC9FbpF1aobbsO6v8ii3fIGmgN4D3PP7uPPHKgz39y6WyreMjkqhboCFR6
	 thmamlBZCR2kA==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 6514040C6F;
	Tue, 31 Mar 2026 16:17:31 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mathura_Kumar <academic1mathura@gmail.com>, brauner@kernel.org
Cc: academic1mathura@gmail.com, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH RESEND v2 1/4]IPC: Added New system call
 do_mq_timedreceive2() for non-destructive peek on posix mqueue
In-Reply-To: <20260320052340.6696-2-academic1mathura@gmail.com>
References: <20260320052340.6696-1-academic1mathura@gmail.com>
 <20260320052340.6696-2-academic1mathura@gmail.com>
Date: Tue, 31 Mar 2026 10:17:30 -0600
Message-ID: <87jyuskm79.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

One other thing I noticed ...

Mathura_Kumar <academic1mathura@gmail.com> writes:

> Signed-off-by: Mathura_Kumar <academic1mathura@gmail.com>
> ---
>  include/linux/compat.h            |   6 +-
>  include/linux/syscalls.h          |   6 +
>  include/uapi/asm-generic/unistd.h |   7 +-
>  include/uapi/linux/mqueue.h       |  14 ++-
>  ipc/mqueue.c                      | 186 ++++++++++++++++++++++++++++--
>  ipc/msg.c                         |   2 +-
>  ipc/msgutil.c                     |  48 ++++----
>  ipc/util.h                        |   3 +-
>  kernel/sys_ni.c                   |   1 +
>  9 files changed, 231 insertions(+), 42 deletions(-)

[...]

> +static int do_mq_timedreceive2(mqd_t mqdes, struct mq_timedreceive2_args *args,
> +			       unsigned int flags, unsigned long index,
> +			       struct timespec64 *ts)
> +{
> +	ssize_t ret;
> +	struct msg_msg *msg_ptr, *k_msg_buffer;
> +	long k_m_type;
> +	size_t k_m_ts;
> +	struct inode *inode;
> +	struct mqueue_inode_info *info;
> +
> +	if (!(flags & MQ_PEEK)) {
> +		return do_mq_timedreceive(mqdes, args->msg_ptr, args->msg_len,
> +					  args->msg_prio, ts);
> +	}

You don't check for unknown flags here; that will make impossible to add
new flags in the future.

jon
