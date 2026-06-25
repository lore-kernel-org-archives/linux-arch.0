Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746F83E9C08;
	Thu, 25 Jun 2026 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782406569; cv=none; b=iKrC1z64ejv/kdxLU/ZQ9iWZUEWhxkWg4GbOVJBsCkinW4jwSjTzAkZKB4bpPpDHxQMwZ4AQpsgoZtEmcnNNMLQOKjk7DIC2PP5f7CnKe2qLCpSXsPiaomlA+bx7+3xWXAH23Z0x4ylthGLQAmbYNvyntERrQrYRktUW6PW8qxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782406569; c=relaxed/simple;
	bh=rSOFTgjUm3mbCIrgY69s9kZobfD6L890uJc3WAUchOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6dvx0sW4h2INDQYc4Ar6l8BM9Fv71l1/WIUgQbo2LIjJkgxc9bikQIfUCd2iwcFluL8gi79216LCSZbVKcDoBizpEMYeYREnUsdW6LM3+4Qx6LYj8/xX9Z3YNM4egYywHV7C35Ucs3aY83AIoA91A8VfOcS8SVdzB/m2bth3eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=hVaBQJKf; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="hVaBQJKf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ca3thQgy3hkYQeLMahjSUA8d4XyPM8+MNN/hTNDelBk=; b=hVaBQJKfhBl/asUbbRxclaQcT/
	wPXd8ws3uSTEzHX/PKkWmbtT8yC1vBqPDnVZThLpb7+CWq3VEnyHoiyg+pWV+zcp3UELv7gBr1iny
	U9VBrDo3Yku5X/qwFlELKVh1aUZElPPSkZgqCypuy2xnZhi6ddw8xq8Buebbfpi6/rzzQ0Ew9gLKW
	4+7NCfnEhQLePPXw3nZAZtD2f4EDwEWqrfhyfwOhq5078rufRFgcDlW8FBudwKUmXb09daQFW7PHW
	CbY3rMNm8I3lJ0469fvXAD0iBb23kxEaQfvxWC2L86Nf+oFVQ1B3ztA4RLmUZyah8xOXegCUR2Jly
	fV55qiWQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.4 #2 (Red Hat Linux))
	id 1wcnMk-00000003JNf-0vcA;
	Thu, 25 Jun 2026 16:55:50 +0000
Date: Thu, 25 Jun 2026 17:55:50 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Xin Zhao <jackzxcui1989@163.com>
Cc: brauner@kernel.org, alex.aring@gmail.com, allen.lkml@gmail.com,
	arnd@arndb.de, chuck.lever@oracle.com, david@kernel.org,
	ebiederm@xmission.com, j.granados@samsung.com, jack@suse.cz,
	jlayton@kernel.org, keescook@chromium.org,
	linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org,
	mcgrof@kernel.org, mjguzik@gmail.com, pfalcato@suse.de,
	rppt@kernel.org
Subject: Re: [PATCH v4] coredump: Add /proc/<pid>/coredump_pre_exit for
 pre-exit before dumping
Message-ID: <20260625165550.GN2636677@ZenIV>
References: <20260625-wappnen-drohbrief-wermutstropfen-c53538f01547@brauner>
 <20260625085018.989584-1-jackzxcui1989@163.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625085018.989584-1-jackzxcui1989@163.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jun 25, 2026 at 04:50:18PM +0800, Xin Zhao wrote:
> > [Severity: Medium]
> > Similar to the issue in exit_mmap_mapped_shared(), this non-atomic update
> > of file->f_flags risks losing concurrent fcntl() updates since it doesn't
> > hold file->f_lock.
> > 
> > Also, if a file has duplicated file descriptors (e.g., via dup()), will
> > clearing O_TMPCLOS here prematurely skip the closure of the remaining
> > descriptors? When encountering the duplicated descriptor later, the flag
> > will already be cleared, leaving the shared file actively referenced.
> 
> Currently, this flag will only be used by the logic we added, so I believe
> there won't be any issues.

What makes you (or whatever LLM you happen to use) think that file is referenced
only by descriptor table of the coredumping process?  Or that only one coredumping
process exists at any time, for that matter - and each might hold references to
the same struct file.
