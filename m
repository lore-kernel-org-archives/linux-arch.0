Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D19439E162
	for <linux-arch@vger.kernel.org>; Tue, 24 Feb 2026 13:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771940170; cv=none; b=ZhyakChlEx+edh+lemHR0AS0xr2wpkvPACHG99G1RZbGy7/eCJA9CFp6kKmLeiRu1D8qXoBf+w7fcdkZoVRy/WSO+sAAW2Mcvv8gkrQzJAhp3H7EZy4mqGdwpHQwvYjG7zXeJmZ0C+oJvZMpDNOs9cq5jm1I+ZUdtDdkBADk5lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771940170; c=relaxed/simple;
	bh=OoD7JAHwm9O36mk6PbNskGpkXMgV9cyxrrozT+uNL2g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=F6lHdQTxKYfz+gF/aVGY7gqutRfEJT5jqIvCNwy5AE6+QKTc2JbB3F/wKrjWCvmF0/FjDMOWbKTtvr6/35JTYCgLDCk5DTUlZXvXJFyfgpBJEk4NS1f8kfhfs5t+il6Xw/XoCNCyYcXkLGslZOMTXm1AN/qUzdAfLJljN60eu8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=NzfOE5Xy; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="NzfOE5Xy"
X-KPN-MessageId: 9e560ea5-1185-11f1-afd4-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.188])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 9e560ea5-1185-11f1-afd4-005056994fde;
	Tue, 24 Feb 2026 14:35:01 +0100 (CET)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 9e54fa9c-1185-11f1-80e7-00505699693e;
	Tue, 24 Feb 2026 14:35:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=MGMbcjG9yWINyKUjmmh5Y/Q4xHGot+ypOWnbV7Xk/xg=;
	b=NzfOE5Xy+wCDQ+63wDZc5o3gsbOH7qHgGDutKD0sar2SBB6Q+MocUVxZ9geVtFkML0sRg9Q0+u964
	 sc1ubeycxv/ZoLdLJ+pnoisDJG8z+2pXKmnxEJXaAZksAn5MYE9e2ewIczLhDwV1gfmiheRNseufan
	 oUGfCghLISATELfbmFWlfzRmpyvALjECh+TJSHhRdPE4qKP7xPFLJqTQ4bHH6Dtx1QR6TzUOrgilKF
	 P71RfQpbLXxKjroOyBWxCfxl8BwI+WxKygPIYoPDF9E0V0F2z7a2axQ01q6tnLQ0MMbuNh+cVDFvuv
	 t8fjTG7Il1Dfdlgkd8qVi2+w35fRtxQ==
X-KPN-MID: 33|+3gTJu8PmtJ2GJE3YqX4nz+uwXyydx9ulTKgQuTw87z7vFgOOy3f58t66cMB0D2
 gN4XUHMjAM4OjEZO8eqN7aIRl9SrZA1aQGTpz5vveSgA=
X-CMASSUN: 33|xHrH2hb1Q/0iV1uxKpkYGgHDBJwIPuU/+H5UoCx1OC5tVfBjHmPkUzqP2O15MFV
 BlFoQfIlDUIGwba4xKLB9pw==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh03 (cpxoxapps-mh03.personalcloud.so.kpn.org [10.128.135.209])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 9e453f50-1185-11f1-94b1-00505699eff2;
	Tue, 24 Feb 2026 14:35:00 +0100 (CET)
Date: Tue, 24 Feb 2026 14:35:00 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>
Cc: chuck.lever@oracle.com, alex.aring@gmail.com, viro@zeniv.linux.org.uk,
	jack@suse.cz, arnd@arndb.de, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <695828658.1952887.1771940100883@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260224-karotten-wegnimmt-79410ef99aeb@brauner>
References: <20260223151652.582048-1-jkoolstra@xs4all.nl>
 <44a2111e33631d78aded73e4b79908db6237227f.camel@kernel.org>
 <20260224-karotten-wegnimmt-79410ef99aeb@brauner>
Subject: Re: [PATCH] Add support for empty path in openat and openat2
 syscalls
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> Op 24-02-2026 11:10 CET schreef Christian Brauner <brauner@kernel.org>:
> 
>  
> On Mon, Feb 23, 2026 at 10:28:24AM -0500, Jeff Layton wrote:
> > On Mon, 2026-02-23 at 16:16 +0100, Jori Koolstra wrote:
> > > To get an operable version of an O_PATH file descriptors, it is possible
> > > to use openat(fd, ".", O_DIRECTORY) for directories, but other files
> > > currently require going through open("/proc/<pid>/fd/<nr>") which
> > > depends on a functioning procfs.
> > > 
> > > This patch adds the O_EMPTY_PATH flag to openat and openat2. If passed
> > > LOOKUP_EMPTY is set at path resolve time.
> > > 
> > 
> > This sounds valuable, but there was recent discussion around the
> > O_REGULAR flag that said that we shouldn't be adding new flags to older
> > syscalls [1]. Should this only be an OPENAT2_* flag instead?
> > 
> > [1]: https://lore.kernel.org/linux-fsdevel/20260129-siebzehn-adler-efe74ff8f1a9@brauner/
> 
> I do like restricting it to openat2() as well.

So would you want to filter the O_EMPTY_PATH flag from openat(), or maybe add
a RESOLVE_EMPTY flag to the resolve options?

Thanks,
Jori.
