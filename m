Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8724207A;
	Tue, 24 Mar 2026 14:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774363050; cv=none; b=ZigZRw94NUcdvAcB8ED55RHGXJtKuxD2OY01XtU/KMcXyrQ2J+cVhXvRGDZ8xVRLB6Y5jHUJ/dWP2x2d0JIDegAhu31kQZlkvYcHfeT5Q9ispu85dwBY1Tih8/4t9OMg6pEqX0nDG9tgcs3Yp3eJw7SCIXnjnsuBbgonKyVbpg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774363050; c=relaxed/simple;
	bh=83lcskGFtr26z8P60Zmw50FYWLqcX0m/q7uMZBctmY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHOFeVYxWJxUp/ikZmS4GSz0e4ZzP1m3QuibxySBZeIzN0OWr8pVTM9Ccge2EtV8z5zZrMR2zC6sOZEg6xvEAzsX697JZu8IW4nIcStJZTjO28y1JSxTV7n2r2JEshylTCrqPWjc1LfIG4xQbMzp7Xr4puqxcJWNbVMkBOvvSAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HnGJ48Jc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HnGJ48Jc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8EDC2BCB3;
	Tue, 24 Mar 2026 14:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774363049;
	bh=83lcskGFtr26z8P60Zmw50FYWLqcX0m/q7uMZBctmY8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HnGJ48JcdZfob2PnxdDIqwjMp7HxkDyFydLjtDLYKxoAXyQDNHv7NN6BXWUWxDDPK
	 XDDFhnhF5Cr2mj/JDaBb6O2m36swmwTnclrFRoj740OVWvF8F+cgsQMcYa1ftZbcn1
	 4KixlHzRddXljgt97mdjPncm94ahHEc//JRN/J20=
Date: Tue, 24 Mar 2026 15:37:07 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>,
	Kees Cook <kees@kernel.org>, Penglei Jiang <superman.xpt@gmail.com>,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	wangzijie <wangzijie1@honor.com>, NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: Re: [PATCH] vfs: transitive upgrade restrictions for fds
Message-ID: <2026032403-slapstick-anvil-a68e@gregkh>
References: <20260323220029.765874-1-jkoolstra@xs4all.nl>
 <20260323220029.765874-2-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
>  fs/file_table.c                  |  2 ++
>  fs/internal.h                    |  1 +
>  fs/namei.c                       | 38 ++++++++++++++++++++++++++++----
>  fs/open.c                        |  9 ++++++++
>  fs/proc/base.c                   | 24 ++++++++++++++------
>  fs/proc/fd.c                     |  6 ++++-
>  fs/proc/internal.h               |  4 +++-
>  include/linux/fcntl.h            |  6 ++++-
>  include/linux/fs.h               |  1 +
>  include/linux/namei.h            | 15 ++++++++++++-
>  include/uapi/asm-generic/fcntl.h |  4 ++++
>  include/uapi/linux/openat2.h     |  1 +
>  12 files changed, 96 insertions(+), 15 deletions(-)

Any chance to get a test for this as well to know if this keeps working
(or works at all)?

>  /*
>   * Helper to directly jump to a known parsed path from ->get_link,
>   * caller must have taken a reference to path beforehand.
>   */
> -int nd_jump_link(const struct path *path)
> +int nd_jump_link_how(const struct path *path, const struct jump_how how)

Shouldn't that be "const struct jump_how *how"?

Or do you really want to pass this structure on the stack?

thanks,

greg k-h
