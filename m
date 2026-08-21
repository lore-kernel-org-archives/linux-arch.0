Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31B147A884
	for <linux-arch@vger.kernel.org>; Fri, 21 Aug 2026 11:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787310862; cv=none; b=kpYZ91tUZV97BanG5rpiAx4/BrHq2PLNvvzeYbpQv99rMSIuf3gYgrl48oEPMe1orBUS7PLfEeHMRJKXQ428J+1t/SYYDVP6Og+00pF0CntMA01XQPCfrkcvdN6iZaGh+j34eRjZx4tnju12pmOBqlGawO/GlKYCQuTJkJOjV0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787310862; c=relaxed/simple;
	bh=VqPkLcvVF95/i0kRYcJZhUfltSA0JLy9Dr5TqvwixIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpwbwmPsQo9erj8zfeo7xaWstoRAP8UPvrbGpDZo9KShQrLhTy3KePBI6T+PMOWkIXAua3bpyC8LRLld7lGMHDrYv7YrtcHeboxesyxAajSzSKnRFm+1xrwQkrGURy7lEsdVbAry/fvKsbkU1jFf+adoqFWfjU4EcxJB8qsiE7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XTfMNzkW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTfMNzkW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787310859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z8FfrgeeqB52zL7h7CNzAsboTvS/gnwfWoMwZWLeEZc=;
	b=XTfMNzkW6vMO0d7f3plvnbVD4xwA9vHJyCjN8mZJ7zUXFTCvLgBxS7qLMCk0RFYH0gIMEI
	VK9tJseSDkAGTReu/7gSrqW6MxWEHkUlNelL3BzlkENy8h+ikUjk+gr8bgCcfJePU1ftlr
	OgxCkNZrGfy3oOsnBQz9DX+twPWbRQM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-phqi7eNrNBKIR5xvPjH8sg-1; Fri,
 21 Aug 2026 07:14:16 -0400
X-MC-Unique: phqi7eNrNBKIR5xvPjH8sg-1
X-Mimecast-MFC-AGG-ID: phqi7eNrNBKIR5xvPjH8sg_1787310855
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 28CDF195606D;
	Fri, 21 Aug 2026 11:14:15 +0000 (UTC)
Received: from fedora (unknown [10.44.49.72])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 8BD65423;
	Fri, 21 Aug 2026 11:14:12 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 21 Aug 2026 13:14:14 +0200 (CEST)
Date: Fri, 21 Aug 2026 13:14:11 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org, Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v5 1/8] arm: Replace __ASSEMBLY__ with __ASSEMBLER__ in
 uapi headers
Message-ID: <aogzA9a5TZ5AEKOP@redhat.com>
References: <20260409094708.1687376-1-thuth@redhat.com>
 <20260409094708.1687376-2-thuth@redhat.com>
 <695b505b-75bc-4aba-a161-c1061f219a2a@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <695b505b-75bc-4aba-a161-c1061f219a2a@redhat.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

On 08/21, Thomas Huth wrote:
>
> > --- a/arch/arm/include/uapi/asm/ptrace.h
> > +++ b/arch/arm/include/uapi/asm/ptrace.h
> > @@ -110,7 +110,7 @@
> >   #define PT_DATA_ADDR		0x10004
> >   #define PT_TEXT_END_ADDR	0x10008
> > -#ifndef __ASSEMBLY__
> > +#ifndef __ASSEMBLER__
> >   /*
> >    * This struct defines the way the registers are stored on the
> > @@ -149,6 +149,6 @@ struct pt_regs {
> >   #define ARM_VFPREGS_SIZE ( 32 * 8 /*fpregs*/ + 4 /*fpscr*/ )
> > -#endif /* __ASSEMBLY__ */
> > +#endif /* __ASSEMBLER__ */
> >   #endif /* _UAPI__ASM_ARM_PTRACE_H */
>
> Ping!
>
> Oleg, could you maybe take this patch through your ptrace tree?

No, sorry, I can't.

I lost my account on git.kernel.org years ago, and I still haven't gotten
around to restoring it...

I think this should routed via arm tree.

Oleg.

