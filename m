Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC02363092
	for <linux-arch@vger.kernel.org>; Fri, 24 Apr 2026 10:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777025378; cv=none; b=ce16nh1e891h9eKdG9f/6LjRnpw/EtOld2Uyt7jVhk0Bv0ZdONmNsBrSPhwuoEN9ONDjfX0tu+uCJo+kHHQKErTCki/8r9Rb8QMq5H02/m1UbzVBygzMK840ywLU3YGOkcQM0xLfbPEqANpSMczZJn8Y7eTTr2dOI4tr0FpK9Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777025378; c=relaxed/simple;
	bh=RnpfrNhB3ccXPzS/+ABSINI7IqvVsyrA7HPYJ6nIkKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNX8RscRwZHbLMLy3yMkHQZT3Ey8SrXRMQb2Iro60TMLOhlkG1WXMu9NTarR5VfxGAzlwDVy7bWgD85gi8mbaE50VDCjekR3gFGzXoaNv+71OhNRLaeBKV80e8I5rfB546AKVmpIY/8Ajlwl4vAqHMnEiWGUVA3Tr/smmQLKMj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=em4CyCcr; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="em4CyCcr"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ba6838e76f2so732753666b.2
        for <linux-arch@vger.kernel.org>; Fri, 24 Apr 2026 03:09:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777025374; x=1777630174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sNHGdIi7azttvOU0ihx56z2No45BL/OntYqLbzQGkko=;
        b=em4CyCcrvXWZqUelsCcZXp7mVosMq3b/5qmbse4Mm3nVBQi9c0tyHcnSNxaIQdAyhD
         dJrdQk58qQp9yb3VDIosnoUNRoBySsQ24LCe71YTU0BDdKOjqXTHlurx5HDjmz2BNZJs
         lTNXDHuiyNPWTTIxi0iVkcVLJsBnsXgOC6gUWFITXjARgnYeYWTpmcn766s8q1GCYwoV
         qLWrGckVo8i8NGESUgnAEQHAHTIWBLWxeik65XizG8KTE7g10xByw2Emcw+GZpnw/DWf
         b+9JfCnHiKu8krbcJ5ko608uEIRAHtcn23aaoA3NgW4VlTzbbNY/az7Hp0cxG2moDBIm
         cADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777025374; x=1777630174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sNHGdIi7azttvOU0ihx56z2No45BL/OntYqLbzQGkko=;
        b=jjb9oVNNuSU+Go65jqlsPNNdi9TYfzdO3AYM4uC6j8yvc10DNVRM6iE9mZlDSzsXxv
         k9bY05wDj21i0j3sE42uF+6RsBQflgnZ5HwARIK3Fz2Ut+iMDg9/Ak7qG9BBLgblRPbY
         QHeieDESthcJi4zm9XlrvbLj41LYINnwWq4tUeGtkCidcBQxLFK/XUsQM5Ps9W+/v/Ql
         BbU+nXyAFu5BfbAti3GObTjtOPvZ8EQAKPrCR3YzTCQ2AnRiGHb4fZmufH6p/XZYHrKK
         Mfo3/gwwwpwbT45A7JKXBqTc9f67LnsnRgguVGGSBkeVGB50sjTbnZ0SnMBKVmlkjMS8
         /FNA==
X-Forwarded-Encrypted: i=1; AFNElJ+yyw8b7Z+GmprGSYSSJeQQVxTyALcqHjQ6eEgCILu2Vi1BwDjZqvc/F3wnV/nhr6y7nxCZLbqm4RwL@vger.kernel.org
X-Gm-Message-State: AOJu0YzJmxwmXMol6VXd3khFTN6NJ/eEx5ooZiU243bszfmcCIbUeEy+
	6XIs4rOeSH3BPAQi5kOlkO/Wy3JVM0/2p7GHN2BY1qRXF4OavmwkRkNB
X-Gm-Gg: AeBDieuxsKymmSXQZtet8ynR5Vrau4JuzB/DNplxIaSor7NjgO1zdk9jcbGLO8n0dbP
	qY6VxnuXxdk1xcV+JSaIVGf6QODhRk4DN8xoq9O3E+BB9ug4h66LT0rzevONR9RwwHbz3ameJNl
	D7tk/cZklbwNnGkLxnTzI8gC9CypvzI2ZaX3YCnt8nNgLmOgW9g4uBSzIZ1PNMKAA2HBq2mHyF4
	ml2wXceEWVt8FR/YjXdA8PGGEEx0eGc6r5is7eG4doGZSdU+4Tx5i7/rdT69p2cUEymT7XI9W/o
	cuqXjq/VFO8elUtKbEluPQ+aE3MzgssAFYanPpuMgPpk0dnRiIiYTjlkDJOAbf3JmWM5+GfKUs/
	/uLWqBb14K6ABG2xbXP2C0hVQz3xHOTfEqNSr8fC/8RLO0cezI+azVXtPOABucA2XYU33PeztMu
	stbGOl1AAUxoRA80Xz4Bl7R/q1qF4KuEkvBsvpWTraZGC3BZTDf53AbgY1Ikzic4vGhr6Sz2GQx
	bzGPfYEEA==
X-Received: by 2002:a17:907:97d4:b0:bad:5231:d5c with SMTP id a640c23a62f3a-bad52310d9fmr173197566b.47.1777025373429;
        Fri, 24 Apr 2026 03:09:33 -0700 (PDT)
Received: from f (cst-prg-93-232.cust.vodafone.cz. [46.135.93.232])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6771dfcf628sm1496915a12.24.2026.04.24.03.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 03:09:32 -0700 (PDT)
Date: Fri, 24 Apr 2026 12:09:18 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>, "H . Peter Anvin" <hpa@zytor.com>, 
	Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>, 
	Andrey Albershteyn <aalbersh@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, 
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jeff Layton <jlayton@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>, cmirabil@redhat.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/2] vfs: syscalls: add mkdirat2() that returns an
 O_DIRECTORY fd
Message-ID: <5xexygc3rvvlir4smdfn7gndwjgbuijqfummwwumivsnosijux@ygqs3iqxmovh>
References: <20260412135434.3095416-1-jkoolstra@xs4all.nl>
 <20260412135434.3095416-2-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260412135434.3095416-2-jkoolstra@xs4all.nl>

On Sun, Apr 12, 2026 at 03:54:33PM +0200, Jori Koolstra wrote:
> Currently there is no way to race-freely create and open a directory.
> For regular files we have open(O_CREAT) for creating a new file inode,
> and returning a pinning fd to it. The lack of such functionality for
> directories means that when populating a directory tree there's always
> a race involved: the inodes first need to be created, and then opened
> to adjust their permissions/ownership/labels/timestamps/acls/xattrs/...,
> but in the time window between the creation and the opening they might
> be replaced by something else.
> 
> Addressing this race without proper APIs is possible (by immediately
> fstat()ing what was opened, to verify that it has the right inode type),
> but difficult to get right. Hence, mkdirat2() that creates a directory
> and returns an O_DIRECTORY fd is useful.
> 
> This feature idea (and description) is taken from the UAPI group:
> https://github.com/uapi-group/kernel-features?tab=readme-ov-file#race-free-creation-and-opening-of-non-file-inodes
> 
> @@ -5276,6 +5294,10 @@ int filename_mkdirat(int dfd, struct filename *name, umode_t mode)
>  		if (IS_ERR(dentry))
>  			error = PTR_ERR(dentry);
>  	}
> +	if (open && !error && !is_delegated(&delegated_inode)) {
> +		const struct path new_path = { .mnt = path.mnt, .dentry = dentry };
> +		filp = dentry_open(&new_path, O_DIRECTORY, current_cred());
> +	}
>  	end_creating_path(&path, dentry);
>  	if (is_delegated(&delegated_inode)) {
>  		error = break_deleg_wait(&delegated_inode);
> 2.53.0
> 

Last time around I pointed out fd allocation being an issue.

The general problem is introduction of a failure point after mkdir
itself succeeds as there is no way to backpedal from it.

With the patch as proposed this remains a factor -- dentry_open itself
can fail due to inability to allocate a file obj, and even if that
succeeds there are several ways for do_dentry_open to error out.

For the patch to be viable some rototoiling is needed to make it so that
all the prep is done before issuing the mkdir. The only thing which can
legally happen after is installatin of the file obj in the fd table.

Now that I said it, the open handling is already buggy in that way.
do_open has the following:

	error = may_open(idmap, &nd->path, acc_mode, open_flag);
	if (!error && !(file->f_mode & FMODE_OPENED))
		error = vfs_open(&nd->path, file);
	if (!error)
		error = security_file_post_open(file, op->acc_mode);
	if (!error && do_truncate)
		error = handle_truncate(idmap, file);
	if (unlikely(error > 0)) {                                                                                
		WARN_ON(1);                                                                                       
		error = -EINVAL;                                                                                  
	}

Suppose O_CREAT was passed.

There is no attempt to recover from the LSM returning an error, in which
case the file is left on the fs. The only LSM even using the hook is
ima. Even if the user being able to create the file implies the LSM
check will pass anyway, the inode itself is not locked so root can sneak
in to chmod it and trigger a failure. Suppose that's not important.

Things proceed to handle_truncate:
	int error = get_write_access(inode);
	if (error)
		return error;

	error = security_file_truncate(filp);
	if (!error) {
		error = do_truncate(idmap, path->dentry, 0,
				    ATTR_MTIME|ATTR_CTIME|ATTR_OPEN,
				    filp);
	}

I'm going to ignore the LSM situation and do_truncate failure modes in this one.

AFAICS nothing prevents the same user from racing against file creation to
execve it, which starts with exe_file_deny_write_access. Should the
other thread win the race, get_write_access will fail and the WARN_ON
splat will be generated. That is definitely a problem.
