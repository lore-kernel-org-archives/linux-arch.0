Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8451825B0A5;
	Thu, 18 Jun 2026 04:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781757070; cv=none; b=Z7+6+2IqXncMF5EzwUAwz3pRWbKQCskX0VrYn2djbmNoGxQQ4l4WFNNdXh9/xXZqRNNjZQLiNYg3uz1w0FEEg7PYXN9wxCD3OqiWwQFF7JDRitdts3AmhRib6Tw++90fpD1yEA+kQ60XfQkHJt+wWJVtH0qCLzt/lz8oddc8xRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781757070; c=relaxed/simple;
	bh=Lkp1Glwrn4V2FPjjc6zQTlhPvx5SSViVg6j9pa85d6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBDFLY+8Rq7ek03vTT8wpoJWRZ+hdIEpJo2GdZsVU4p09SVmRaGSzBd3am5wDfQaGjr/sfjNyJsfdAQ+kkJkCNfQQI1nNCcjMmp9daQM9KRCbno24oQ23iIkyxPyGWo/C+OfbnYamW+QDb1/gXka68qBX/oYH0Z67Z7DYR7UDDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=JteKDhJS; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="JteKDhJS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=53nJE5yfvEdxUrQYbIGpK+dMXSI/Enf36jfTMWDU0oc=; b=JteKDhJSgZbPh55LkHQpV9XyWn
	QkLLGgaGHtrf1Vc9XCGdL4l5+zeIMdQ3JQvQW7tFWbrpiEQcPGvLNaRNjfydfyD5sUFonskBEtoDh
	WtdHTa8MUljOM8z6tWt4dfqHY8VuBXYl7NoaS96U3wNCX+kkU72L6DFT2G2l9zq4HYG//+buAboh1
	0wnMHWtkjUZlT8fJz85fOTWqZBnd7Ik1vjeiweepzxHQKvd2ckty43f018lGLSZz68fDxcDD88NXi
	2F6gYZjaqhdhNd5561VhP2vvjb3BvZ+4VsYUUOBpzLrXK8Egd8+gXoOEOjrtg7WW7fvQTyNJinoLe
	j/OQAb0g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1wa4P0-0000000GWOo-0mvJ;
	Thu, 18 Jun 2026 04:30:54 +0000
Date: Thu, 18 Jun 2026 05:30:54 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: brauner@kernel.org, jack@suse.cz, jlayton@kernel.org,
	chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de,
	ebiederm@xmission.com, keescook@chromium.org, mcgrof@kernel.org,
	j.granados@samsung.com, allen.lkml@gmail.com,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH] coredump/fcntl: Add FD_CLOBCOR flag to close fd before
 dumping core
Message-ID: <20260618043054.GY2636677@ZenIV>
References: <20260618030700.2511668-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618030700.2511668-1-jackzxcui1989@163.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

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

No.  Leaving aside the unasked-for overhead for every process on every system,
whether they are interested in this "feature" or not, this

> +static struct fdtable *close_files_before_core(struct files_struct *files)
> +{
> +	/*
> +	 * It is safe to dereference the fd table without RCU or
> +	 * ->file_lock because this is the last reference to the
> +	 * files structure.
> +	 */
> +	struct fdtable *fdt = rcu_dereference_raw(files->fdt);
> +	unsigned int i, j = 0;
> +
> +	for (;;) {
> +		unsigned long set;
> +
> +		i = j * BITS_PER_LONG;
> +		if (i >= fdt->max_fds)
> +			break;
> +		set = fdt->open_fds[j++];
> +		while (set) {
> +			if (set & 1 && close_before_core(i, files)) {
> +				struct file *file = fdt->fd[i];
> +
> +				if (file) {
> +					filp_close(file, files);
> +					cond_resched();
> +				}
> +			}
> +			i++;
> +			set >>= 1;
> +		}
> +	}

is just plain wrong.  You are leaving references in that descriptor table,
whether you've closed them or not.  It *can't* be right - no matter what
you do after having called that, you will either leak file references
for ones that were not closed or eat double-free for ones that were.

Have you actually tested that patch?

Note that above is _not_ "fix that thing and I'll have no objections";
I think the benefits of that API are nowhere near worth inflicting the
cost on everyone.
