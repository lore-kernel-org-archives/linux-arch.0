Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1F038AC84
	for <linux-arch@vger.kernel.org>; Thu, 26 Mar 2026 11:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774523421; cv=none; b=HDqMmkLR4N6uGUCkd92i/5oz+nx99Wd2IdyGOlDemKveqfcm+r2SZqEZdDWF7zCCQ+soeLWNFeK8m6sLVJwb1POQ0x/NIJa3pcGIA7NEqtSpL8H4mPOxcaxfmVjW8NHaRkhGFljydoT/Zmtyy3B45yJx+h7d+K9bYkCl7u6ddSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774523421; c=relaxed/simple;
	bh=RU0wq9XB/MAwM1WSxurR/DyaG7Wt9DpT1Mu3ktbvqOw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=F8LYfRXFNWCi/G+EnW9PZUgq3eEvpOgUR+b1Rncz0t2z2AqJSe8aJsRJ2aQ7SnZpscVwO17V+Cuv13YS4Vy4WRY3AjTKDTgxQ19uJ5xNhIU7ycy42NuWCOVvRlPSLn1/KTHkF3eyWzw9kG77sbQGd6yQA67Sqt0CRPTpUmOyDJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=oGttYA8/; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="oGttYA8/"
X-KPN-MessageId: 36136a8e-2904-11f1-afd9-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.190])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 36136a8e-2904-11f1-afd9-005056994fde;
	Thu, 26 Mar 2026 12:09:08 +0100 (CET)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 3600e017-2904-11f1-99ca-0050569977a2;
	Thu, 26 Mar 2026 12:09:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=FBQEkVriU2wQC8scK1vGpQhIBNeQY+LoczBK8oqaaIQ=;
	b=oGttYA8/jVRGnNmabXbqO/JnFL/u9KHRZFwiN2Op1XrWQAYwU+IeqRohCe0Cg6eQGlsJbSH55248/
	 Lub3tVFs/dWvWTJOfsmAnP8gJoMXzx9rrucOqyIcC7vbp6axmM+lZ2GUq2sDxUrSBlmgoJ+LrPsQFd
	 4M5gd/akuQEJJW257LwDoNpzXljLuRtDZqyui/00c97SUQCZ026zFerTl2XrrLkTHxNV/1/3fqQfRR
	 w5/8bbVdjws3MeU6OV9qKI4EjidJYw0XB+kNMW+XnNXthAeYjEPER4rVxy3c2l/YXTqO48OrnfI5iw
	 5PymsZFfUJlb6Rn/JMsHQxu1M9QaKKg==
X-KPN-MID: 33|DnRppIcvz0vvgRLIHtLFb6wr8BW8Nrya+E6RlY681GJcrLw1+uzD2GsRXRSmn7+
 MFmaWA03LXeZFR7ym+GV5SL6OR7EZxI3jwPOZTcjhD7I=
X-CMASSUN: 33|AXbHEZx6/A3wNjLkkM4q5BDLM/E3sHISRdkWlQ4D8he7ebvHl/Ihv7Wjozv0SR1
 XbhjVVcykIWMYLGeWg/zWOA==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh02 (cpxoxapps-mh02.personalcloud.so.kpn.org [10.128.135.208])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 35ef7f62-2904-11f1-b8d7-005056995d6c;
	Thu, 26 Mar 2026 12:09:08 +0100 (CET)
Date: Thu, 26 Mar 2026 12:09:08 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Greg KH <gregkh@linuxfoundation.org>
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
Message-ID: <95547355.15637.1774523348666@kpc.webmail.kpnmail.nl>
In-Reply-To: <2026032403-slapstick-anvil-a68e@gregkh>
References: <20260323220029.765874-1-jkoolstra@xs4all.nl>
 <20260323220029.765874-2-jkoolstra@xs4all.nl>
 <2026032403-slapstick-anvil-a68e@gregkh>
Subject: Re: [PATCH] vfs: transitive upgrade restrictions for fds
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


> Op 24-03-2026 15:37 CET schreef Greg KH <gregkh@linuxfoundation.org>:
> 
> Any chance to get a test for this as well to know if this keeps working
> (or works at all)?
> 

I do have some tests, can shape them up a bit so that they may go in selftest
(if this fd stuff goes through). How should I do this? Send all as a v2, or
inline it as a response here?

> >  /*
> >   * Helper to directly jump to a known parsed path from ->get_link,
> >   * caller must have taken a reference to path beforehand.
> >   */
> > -int nd_jump_link(const struct path *path)
> > +int nd_jump_link_how(const struct path *path, const struct jump_how how)
> 
> Shouldn't that be "const struct jump_how *how"?
> 
> Or do you really want to pass this structure on the stack?
> 

I save a pointer indirection, and jump_how is right now just an int. That was
at least my reasoning here.

> thanks,
> 
> greg k-h

Thanks,
Jori.
