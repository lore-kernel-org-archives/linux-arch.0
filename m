Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CE01DE894;
	Tue, 24 Feb 2026 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771943494; cv=none; b=Un1E62Yfque03+eGZZ6SOStRChAdI/UlD+YAl48N4YMQgUetHl04jWhQz7UZS3ELYwby1cn3zOa31H6CJ/XBGaKILiPg6PorMZ1plQy1+XufDi/Ay6cxVnpwN7VvTX2HR42Icn94pkwVNhJZa3gAv2B9MbVLnRO0NmDhHt7W9mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771943494; c=relaxed/simple;
	bh=/bd114QHkC3A2lk/V0zjOM3mgCNoj5ks7ZlnedEGf0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aXVBNdnRawhKYUtv2OxSn4ZEOnNBAMJq8G5mGBNNnrwlZjI8LeV2GJ16pn5VfX7r1Y12KDVHak2PIQqahjD8V0EbyQ0Oh9QlgD6uTJKB6P1TXI8m2zbYGE/Q5ExNPICJlWMA1RXCEqvk60LlAwwWW7ZckeHav//6iXOfcPWPu4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KryYQSna; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KryYQSna"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF9AC116D0;
	Tue, 24 Feb 2026 14:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771943494;
	bh=/bd114QHkC3A2lk/V0zjOM3mgCNoj5ks7ZlnedEGf0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KryYQSnasbEt23Cyz4aYQsuaS1HKeuiqyRG/58RWhyDichRA3mvQ9vvIZOfOdBOn+
	 3nOD7omh0HwWUhmQWG7tbCfIbrc4rpY4/+KYhTnoCnPbE+UzjHx5EbHtlH7wtlzQU0
	 k7xmuZQbOAEwVqpgFJFCfbQ2tpH/0IseTEG8KO5VlWTT7hQA9WRNXWKG2akosAITBm
	 eZGgsChyGPjVR8lh8KRwpoCrjGoJ+r23WJZ1lD2ys2CCNnSatp+cb6FnoJtQLNqD+S
	 bcd67BTU1GGdLqyjrZXjl9XpXfBF7iyAPmQgg6x+sHBUPlje0ajyiLUYZ021AFa9Qz
	 95uQOFXKbPcpQ==
Date: Tue, 24 Feb 2026 15:31:29 +0100
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Jeff Layton <jlayton@kernel.org>, chuck.lever@oracle.com, 
	alex.aring@gmail.com, viro@zeniv.linux.org.uk, jack@suse.cz, arnd@arndb.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH] Add support for empty path in openat and openat2 syscalls
Message-ID: <20260224-einquartieren-lahmen-aa7e0203f917@brauner>
References: <20260223151652.582048-1-jkoolstra@xs4all.nl>
 <44a2111e33631d78aded73e4b79908db6237227f.camel@kernel.org>
 <20260224-karotten-wegnimmt-79410ef99aeb@brauner>
 <695828658.1952887.1771940100883@kpc.webmail.kpnmail.nl>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <695828658.1952887.1771940100883@kpc.webmail.kpnmail.nl>

On Tue, Feb 24, 2026 at 02:35:00PM +0100, Jori Koolstra wrote:
> 
> > Op 24-02-2026 11:10 CET schreef Christian Brauner <brauner@kernel.org>:
> > 
> >  
> > On Mon, Feb 23, 2026 at 10:28:24AM -0500, Jeff Layton wrote:
> > > On Mon, 2026-02-23 at 16:16 +0100, Jori Koolstra wrote:
> > > > To get an operable version of an O_PATH file descriptors, it is possible
> > > > to use openat(fd, ".", O_DIRECTORY) for directories, but other files
> > > > currently require going through open("/proc/<pid>/fd/<nr>") which
> > > > depends on a functioning procfs.
> > > > 
> > > > This patch adds the O_EMPTY_PATH flag to openat and openat2. If passed
> > > > LOOKUP_EMPTY is set at path resolve time.
> > > > 
> > > 
> > > This sounds valuable, but there was recent discussion around the
> > > O_REGULAR flag that said that we shouldn't be adding new flags to older
> > > syscalls [1]. Should this only be an OPENAT2_* flag instead?
> > > 
> > > [1]: https://lore.kernel.org/linux-fsdevel/20260129-siebzehn-adler-efe74ff8f1a9@brauner/
> > 
> > I do like restricting it to openat2() as well.
> 
> So would you want to filter the O_EMPTY_PATH flag from openat(), or maybe add
> a RESOLVE_EMPTY flag to the resolve options?

No, add a OPENAT2_EMPTY_PATH in the upper 32 bit of the 64-bit flag
argument for struct open_how. Then it cannot be used in openat(). But
let's wait a day or so to see whether we have someone that really wants
to extend this to openat() as well...
