Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4234437647F;
	Mon, 30 Mar 2026 20:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774900938; cv=none; b=khPUnc3a5Ai5Smnn/nrZFsfcaS4PSy4C8So+nieVgL8KSUFQerpRzWdZp/gE9CvauqxbXvOZ2pWBXGWQI3BAjw7CRRy8o4YKWpouJr2ED5Mywo0FHnZTBSmC6tTQRnyMcnOPOWQN7uac4dT/NpiHGpIHZY1vqefRfDJI7g5VQfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774900938; c=relaxed/simple;
	bh=V+NcacMveegugzis6ICoIVgTcKhrvN49QZp/qw84TSc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aCkqyUt3B72DbXl8IR59aNuGkvR8U7jRa1Y1iA/91JJhuWJ+wHab2heylHjpCeh1M4hLvuTJ+HWhJAqUnJeFknMEWN4W05qjnL0MeIVh4z5HU2LGW/xizxVRJyskNh92BIOn0+rYyWnMWkNiLnOYET9/GkTSz1XtFVuQZfxqZas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=AGJpfg1v; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="AGJpfg1v"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 888EF40C6F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1774900936; bh=gvxKdlVfj9crjkocpKlPUIrPoQndHcaebycm/F3XEHc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AGJpfg1vWF8xXcArwWdOwY+oHYlHJ7DQF1qR1kNBggB6W82wKClmysG6Ty1hstge/
	 ieZu22hmiHY3xWsO+DtnNcRlXndilQRE1PcTFVpXAmHu7aPrg+MyoKiH1WnXmwEr4+
	 k21IWST63At42MJA9fzMH5JeeLvlvVRS2U6V0Ju5F/dysXBIula1got+jJmUrVH3MN
	 rGuhpYBeRfPD4Ou/BpfuVrNQwszJLuTw8IP5QNsVfDBHffRR/fy56hZOHXarnI3aPQ
	 EiyZyagqmUldfDl9/dlTEY6V/ZzMrtFZSo1jHYWKzdAJAmNaTy5wT+hAEOVtv5hiEw
	 1/BhU75gLGLMQ==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 888EF40C6F;
	Mon, 30 Mar 2026 20:02:16 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mathura_Kumar <academic1mathura@gmail.com>, brauner@kernel.org
Cc: academic1mathura@gmail.com, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH RESEND v2 1/4]IPC: Added New system call
 do_mq_timedreceive2() for non-destructive peek on posix mqueue
In-Reply-To: <20260320052340.6696-2-academic1mathura@gmail.com>
References: <20260320052340.6696-1-academic1mathura@gmail.com>
 <20260320052340.6696-2-academic1mathura@gmail.com>
Date: Mon, 30 Mar 2026 14:02:15 -0600
Message-ID: <87a4vpm6go.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mathura_Kumar <academic1mathura@gmail.com> writes:

> +SYSCALL_DEFINE5(mq_timedreceive2, mqd_t, mqdes,
> +		struct mq_timedreceive2_args __user *, uargs, unsigned int,
> +		flags, const unsigned long, index,
> +		const struct __kernel_timespec __user *, u_abs_timeout)

So the pattern that seems to have emerged when creating this kind of
argument structure for system calls is to pass the size of the structure
itself as an argument.  That allows the structure to be expanded in
compatible ways in the future, so you won't have to do
mq_timedreceive3().  Is there a reason you didn't do it that way here?

Thanks,

jon
