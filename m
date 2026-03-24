Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C425732B99E;
	Tue, 24 Mar 2026 08:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774341675; cv=none; b=hJbBUXrkc5DOLVtM6QiA0TbdDR2Uc4/9xcnDdSvcI809j5aNxQrVm61KIPseVwYIgUQihJACabh7BMw3qT2TyDsaVs/Wu1xLlJ6MKsAD0mSFLoa7maCl31d4EYdcXPqStaRoAbZbccnqwc7dgbvNJB+e4x/T24zE2t4zJUdCguQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774341675; c=relaxed/simple;
	bh=kaxXuUw9f9HNEqP5C1ENWfdiZ/OfkthcRuF6+brNpyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLicPNXI6GVhdPB9pwSwoeFECs951a/PH097bk5/1fxmG1O7Pu0hXxEHiDCzjCjaFP5AK3MJGh1fMBWSg1NMMVQBDZ19BmbDDzq4yx3Vj0AlaLfygw7gIeIvCSjvmAxL678Qajf8/m0qalzcSBLhYaYvewXKB+Y8573CmKVT6dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qVp5gsDy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qVp5gsDy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B1EC2BC9E;
	Tue, 24 Mar 2026 08:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774341675;
	bh=kaxXuUw9f9HNEqP5C1ENWfdiZ/OfkthcRuF6+brNpyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qVp5gsDy6O4wH0UbeioFGCcCEBx9HSVxTJtZvlf58qIiaTIsXAavL5i0u6dbBNrao
	 QjYdshXvgYJVz0Iz4mFALxmJ74yILe7GwWodeytEeckvOAshV+i6ACGMOPOOYEt3l1
	 KQTZxQRsvkqXRnfERrB6Zs/Zstu968oJP3jhk1TgqiF0tDranWQA/7aAh4nkIQ/+0F
	 +JEw+nJCbOoJqav4U2fdu4VbSkvNP590MRu2FdKWK0zmeeZJ5lkdWzBQ6uvQ1IlSOv
	 Ju21ps3PgppNorHCg7rBghl+CMKMpX1jGstyqbhCZtLrtvB4D2X7f1cXYoJ4Ql3EiU
	 n2Dm4hKCABJUQ==
Date: Tue, 24 Mar 2026 09:41:06 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>, Aleksa Sarai <cyphar@cyphar.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
	Alexander Aring <alex.aring@gmail.com>, Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <ljs@kernel.org>, zhang jiao <zhangjiao2@cmss.chinamobile.com>, 
	Kees Cook <kees@kernel.org>, Penglei Jiang <superman.xpt@gmail.com>, 
	Ethan Tidmore <ethantidmore06@gmail.com>, Oleg Nesterov <oleg@redhat.com>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	wangzijie <wangzijie1@honor.com>, NeilBrown <neil@brown.name>, Amir Goldstein <amir73il@gmail.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>
Subject: Re: [PATCH] vfs: transitive upgrade restrictions for fds
Message-ID: <20260324-konfus-gegeben-50960bd07b3b@brauner>
References: <20260323220029.765874-1-jkoolstra@xs4all.nl>
 <20260323220029.765874-2-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260323220029.765874-2-jkoolstra@xs4all.nl>

On Mon, Mar 23, 2026 at 11:00:22PM +0100, Jori Koolstra wrote:
> Add upgrade restrictions to openat2(). Extend struct open_how to allow
> setting transitive restrictions on using file descriptors to open other
> files. A use case for this feature is to block services or containers
> from re-opening/upgrading an O_PATH file descriptor through e.g.
> /proc/<pid>/fd/<nr as O_WRONLY.
> 
> The idea for this features comes form the UAPI group kernel feature idea
> list [1].
> 
> [1] https://github.com/uapi-group/kernel-features?tab=readme-ov-file#upgrade-masks-in-openat2
> 
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---

Aleksa has thought long about this feature so I'll let him do the first
pass review here. Historically this was a bit of a can of worms...
