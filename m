Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77484279907
	for <linux-arch@vger.kernel.org>; Fri, 19 Jun 2026 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781890406; cv=none; b=TKYJ/NZXpyMp23FN3iglgyC/0v/HLRMmo2t2V66JcxMvkvxazA1PBEtZRtHh4eZA3g9qPRBLhBzr6vgQDPyhgi93s+GGig53OvP1cirpnjOZtjD/5hqFSFKdMYiU9zPqNzj6lunmvtQ3jdG93hxNdhNk7SkK9Ew+1OIjZmaOeTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781890406; c=relaxed/simple;
	bh=3QOMV/PEdzRIArPqLGAEk3ALExzbBNdJAPRFE3giSiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1KKvcP5zqYTcXXSgx5dFIZMaEjOlQYR+0ekKdzLUJVAv4U1kfwlp59knoRsc5foKgqf7qx2dsgp5fw9u53G+2iB/UqnBz5SE7tvsvWiO9MZiJwOT+jVn15yy89/18vTFShLIp9Vf7rNGIigLmwPchVH2YmAPyEysyy6QRvFsWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2dvWrLS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2dvWrLS"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490b4a8e28bso17499085e9.1
        for <linux-arch@vger.kernel.org>; Fri, 19 Jun 2026 10:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781890404; x=1782495204; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FHjYtrrWSBHBDIRgPzMTC9IJiEE8dzQgsMSw62aomtw=;
        b=B2dvWrLST2TJnfnBkt4hvpyFGbmbAPck41mRNY96nhVbO8ZOjwR3KvrOcEeKFLF039
         JRdB/9jGNU07PTl8v0w+ruSBvrXmnxrQZX39GIgGLVOfz4EReQJOYok899yhBXRjszuP
         JUeRHNrsAT7/j6xLZIoAR2CwCRntWf4/Infzza3SHejxf8Jjyw1uZfX94jfTSEDtS2nG
         tXhCcY5UtXE0XX/eoT7AI/TsjfOxqJRVJBt4gWgFlxThmbUwNcUeNyOGrvdAPTdoy0vG
         pgy94vpA1J1Fe6h7e+Ck3ECS3jc+nIVTZ3MRGLGMhYNquEelcKUEe/887yXbB1fcJOXx
         uVOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781890404; x=1782495204;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FHjYtrrWSBHBDIRgPzMTC9IJiEE8dzQgsMSw62aomtw=;
        b=dInh9WtSIGZ/pw2WgSTqaEfIwyMhPlroZ3SsdjlcwmAUdsl4qZ1gZLjQf4EOu+3+AL
         Wjjyl387tj1RO2YXwyGQcMnc4DDlUhYQBEWCxb7aNO5mu+N0E74z85huQHkCPOBZx0ff
         CYSsgw+9dEa8Q1mfNw/VxP2naghpFVO3ApgulJkxHU/TCJ79/L8cDyx9NSP7a84y8XkU
         kmsb+YrpVwh9wHINyHiaW0wSJ/jeTxTolJ4qaZZm8q8/6WmKU/H7L7ZtQD2uGvdNcAsa
         TDAmyUu0ggo12/RRLAHV2eqMDLX89sDrB9anpXUOfG15ZaDJQOFMMpR6WiyrK00jIJwQ
         BWqQ==
X-Forwarded-Encrypted: i=1; AFNElJ9oH4OpjW1I5gu7B6lvaR3WGApCODWDOL5afIET2lKK6KHSclLUcZSi+74Kkho8p/mKRT2/zL7gdwQ2@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvf1NZU9c6SiZSXDAE3Eav/cxjZt3EI6xm8+0ju+0sCEgOn0Ao
	f2weRkYnH5lb0S4CxZwVNf8mWfeMTLHGSpiNzwdWLStjw4DnXEt4jG3D
X-Gm-Gg: AfdE7cnVV3qF5dcBmLK031Fzr6tz1z0vOmE88qmIJ+f1BHUFhN4X+SEYuYZS2jZRVN7
	GG1YLdpdt18ua6JT6Zo5nuHnh100c2paSzT+E07z3wh6WoskPr9AUztC7139xA33VtHEyu1HBr7
	ANlxXn6CIFUki2bkqEhoYTrU2IH0mqNJicZ6jYGjxvlEVxIpune/bgqWxHSh3tx0OovvmY/PG5F
	EkUevAC8WS4ghRyMZfSMwmqbU6qQNkW+qOFjUSVXIkE9j8pT/GYmBUiFXOS/U3WCOuLhdDqfLvP
	zMxjDv4LIP5y4S/Id36ReMgLahA8FDuwZ9uHWXMXCHIHCMJZ1xyoIL5BjE5+LXoeoTMGZfSMa+N
	Thxp+MA11MdLxAJHcAnNeNcVCovow8TRTINb5h+Uw9rSI3VCplzfkg1Eth5qV+NAfxX2UEavQdA
	/IOWnpHakJI3rxKcpwu1RpnJUdU8+IKKa6SyEXe1rpoUTeZ6D04pTsRJXSqyAa
X-Received: by 2002:a05:600c:348f:b0:492:4636:87ae with SMTP id 5b1f17b1804b1-492463687d1mr36060355e9.17.1781890403634;
        Fri, 19 Jun 2026 10:33:23 -0700 (PDT)
Received: from f (cst-prg-85-255.cust.vodafone.cz. [46.135.85.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666788547sm610491f8f.18.2026.06.19.10.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 10:33:22 -0700 (PDT)
Date: Fri, 19 Jun 2026 19:33:16 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Xin Zhao <jackzxcui1989@163.com>, pfalcato@suse.de, 
	ebiederm@xmission.com, viro@zeniv.linux.org.uk, jack@suse.cz, jlayton@kernel.org, 
	chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, keescook@chromium.org, 
	mcgrof@kernel.org, j.granados@samsung.com, allen.lkml@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3] coredump: exit_files() in coredump_wait() if
 MMF_DUMP_MAPPED_SHARED is not set
Message-ID: <jt7glnz6scdbnbzzl7l3slvnu4vtr2uzlbwe74znxp3sxeqdtc@dhrwwjhhn6md>
References: <20260619122419.3954581-1-jackzxcui1989@163.com>
 <178187726633.350634.1366346571707417413.b4-review@b4>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178187726633.350634.1366346571707417413.b4-review@b4>

On Fri, Jun 19, 2026 at 03:54:26PM +0200, Christian Brauner wrote:
> > A coredump typically takes some time to complete. If we happen to hold a
> > write lock with flock just before triggering the coredump, that write lock
> > will not be released during the entire coredump process. As a result,
> > other processes attempting to acquire the same write lock may experience
> > significant delays.
> > 
> > To address this, call exit_files() in the end of coredump_wait(), if
> > MMF_DUMP_MAPPED_SHARED is not set. Note that early unlocking a flock on a
> > file allows other processes to lock and modify the mapped data protected
> > by the flock.
> > 
> > Signed-off-by: Xin Zhao <jackzxcui1989@163.com>
> >
> > diff --git a/fs/coredump.c b/fs/coredump.c
> > index bb6fdb1f458e..70698d06ec9d 100644
> > --- a/fs/coredump.c
> > +++ b/fs/coredump.c
> > @@ -548,6 +548,13 @@ static int coredump_wait(int exit_code, struct core_state *core_state)
> >  		}
> >  	}
> >  
> > +	/*
> > +	 * Early unlocking a flock on a file allows other processes
> > +	 * to lock and modify the mapped data protected by the flock.
> > +	 */
> > +	if (!mm_flags_test(MMF_DUMP_MAPPED_SHARED, tsk->mm))
> > +		exit_files(tsk);
> 
> This doesn't work - at least not unconditionally. Tools like
> systemd-coredump or apport go through the fds. Specifically
> systemd-coredump does:
> 
> 1) /proc/[pid]/fd/ — opendir() then, per entry, readlinkat() to get the symlink target.
> 2) /proc/[pid]/fdinfo/ — for each fd it reads the fdinfo text lines
> 
> The blob is attached to the journal record as the COREDUMP_OPEN_FDS=
> field. So the open-fd list is recorded as metadata, retrievable later
> (e.g. coredumpctl info shows it).
> 
> Also, irc some clever implementations use pidfd_getfd() to preserve the
> files from a coredumping process to preserve them.
> 
> So you break all that - and only in some of the cases which is really
> opaque to userspace. That's not acceptable. If you only care about the
> case where you dump to a file then either special-case it to the legacy
> file coredump format or if it's generally useful make it an optional
> argument that can be passed to the coredump pipe and a new flag
> extension to the coredump socket that makes the coredumping process shed
> it's file descriptors.
> 

The claim is the coredump takes "some time" without specifying what kind
of window is it (seconds, minutes?), nor where said time is spent.

For example it is known that a big mmapped areas are slow to dump even
if they are sparsely populated.

So I would suggest profiling what exactly happens in this case. It is
virtually guaranteed the time can be shortened, but it is plausible even
with fixups it will be too long.

Which brings me to the next point: the issue is not strictly any
particular file is still referenced by the target process, but that the
lock is held on it. Perhaps it would be perfectly fine to walk the fd
table and release these here instead of much later?
