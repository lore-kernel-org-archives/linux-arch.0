Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6195C332906
	for <linux-arch@vger.kernel.org>; Thu, 11 Jun 2026 20:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781209875; cv=none; b=D3b30OQuIlG18zgsm2P+smkIJEJopxJUwmSfus4Zaa5F3VHmm8xotfTiDqNOLNlLT2GFav7sm7rdtMbu34vNn6rSqy04r1i8o+83FvmMDiuvKg8zzIQ4DkhS7ZAvj1tXVG2eSGxYUthyojPylcmItByPQ0WBBSFE5fGD+Go0Nn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781209875; c=relaxed/simple;
	bh=+V+2Bt8aeqRu87M3N691bAG9BGc32SN4iT30OCAZ6SM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=KiU9VaZygeBksoXUOb4xHYF0NrmeP8VqYihpmc2qPfgH79g9ich8Eq7xWgLhIvN/n/ju0CQ49NwPHFVDcaTG7KETxDcaFiEt06dSsa9frwS8QOuoT2LEGh8pOJG1ChfpyxH7pLxYYke/lqPHgOxIxkmW28uN9xYAxIc5/3h0KKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=ljP1Zyza; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="ljP1Zyza"
X-KPN-MessageId: 7c9d7db9-65d4-11f1-beab-005056992ed3
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 7c9d7db9-65d4-11f1-beab-005056992ed3;
	Thu, 11 Jun 2026 22:31:12 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 7cb85e0a-65d4-11f1-b5d6-0050569981f5;
	Thu, 11 Jun 2026 22:31:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=Nj9uT/NsRRDnT/bEZrTkDSds8VdAedxVCflcwnpiUps=;
	b=ljP1ZyzaVP/dH6/4aVmWUboP69GvqvDwCUeZcIk6TP2fXMxNrCGP1uBAfzaCmQcc3sdCwhP70xySA
	 OUTeYcmPf77GU41seyxkysRE0i+7ewclc23FoRABL2NeG1zuOyehV/wdy9z9UlgVc6uglOhCSgAAnZ
	 mJfTHZWM/UN5zB1cbaYCihiZ6QJzDLmrBRHUvUqb0SLkI0OM/bOPynX+HKx4ZRn/LUA00vIJvwoHa7
	 Pnk9IR9erH+uLjVoRlnsIfquk7QJ1d4E9+WlIO44PJYPmkht/RVtzn0Dn5Iue+T/V0KATMyA++xUzN
	 5fBqyZOyfzEU2pTxlOI0A35I5y7ovdA==
X-KPN-MID: 33|SQrKEiWgeLkhvj/bsvGxa1FQoW/YWMDF3t/ZVefKlFQiXVumDUF6EOfIwhYEsr8
 zSTfv8kZGm/boMeeayXiZCqkeAsNrsndLzuqTxH7wGU0=
X-CMASSUN: 33|TTAdw62m9d+5lzPGY4JjHnrNpOAwzQHTYO5Achz/8zPdgouk9RbIoIRmHQwDXS6
 sypjRETybbTTiVzI9LIMqlg==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh04 (cpxoxapps-mh04.personalcloud.so.kpn.org [10.128.135.210])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 7cad5b43-65d4-11f1-b8d7-005056995d6c;
	Thu, 11 Jun 2026 22:31:12 +0200 (CEST)
Date: Thu, 11 Jun 2026 22:31:12 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	"open list:FILESYSTEMS (VFS and infrastructure)"
 <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
	"open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>
Message-ID: <1512332516.1435503.1781209872436@kpc.webmail.kpnmail.nl>
In-Reply-To: <m5fqzr2ny4zb36u6zhmrrxgl36ycsxvlqnzf5idvsq4lxpfh3i@g276qtqgfv3f>
References: <20260531104947.6142-1-jkoolstra@xs4all.nl>
 <c5e32b78aeaa833d18d9b7a566358a6f71d09f23.camel@kernel.org>
 <xdknvjlda7wxwo35toe357nnyaydsllv5g65ogzsomxqgm7jfu@qwtugpoy2rcw>
 <2002074169.107129.1780331273724@kpc.webmail.kpnmail.nl>
 <m5fqzr2ny4zb36u6zhmrrxgl36ycsxvlqnzf5idvsq4lxpfh3i@g276qtqgfv3f>
Subject: Re: [PATCH] vfs: missing inode operation should return a consistent
 error code
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

@Christian, since you suggested equalizing the error codes for missing
inode ops, what is your opinion?

> Op 01-06-2026 18:50 CEST schreef Jan Kara <jack@suse.cz>:
> 
> We certainly can (and sometimes do) modify the returned errors. It is
> always just a balancing act between the benefit of the change and chances
> somebody will get broken by it. In this case I don't quite see the
> benefit, not that I'd be too worried about the a regression but there's
> always the chance...
> 
> 								Honza

No, I get that, and maybe you are right. I feel in this case it would be
really odd if this breaks anyone's application. It would mean you are
rigorously testing for receiving specific error codes, without handling
a general error case. That just seems odd, especially since some of these
error codes are not even listed as a possibility for missing ops (like EACCES).
I would say we change this and revert if anyone complains. I believe that was
also Christian's view in another thread, but I may be mistaken.

But regardless, it's just a nice to have, and I can definitely live without.
It is just a clean-up I came across while working on O_CREAT|O_DIRECTORY.

Best,
Jori.
