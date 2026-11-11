Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.178.41.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405913;
	b=wxBAijqjS13nPRe+Y+Hj0sJCThytrq4FSDXvVF/eLsVkjXq6G45qjImgdl6GZt/EFqh+
	 YFx1IPzyQfShleDI0Oq5KqotijuLSEc0gvWb76Z4yvcyuks2LGx2L5MY9nwG9QZWwagum
	 H3Bx9FA0wMP3KpnKndYxjepMZyh0lxeZpH9fvwFNzb7IQ3xGHf6GuZhPo5BG5xLz9V3r9
	 CGFdMyfvzUIgskR04OoWGsQlwj6+tH6mkOgZNR+Ue68hnJLhQEfb6V7POOfBiLIBU9Zi9
	 oBbO1/FYctnjhNFWSzzWRK7Jwt7PToYtSLu/tYhVyGXEQguc11DJD7CtoXN7Xq79QKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405913;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=4zxPu5ZFrczIb7F9QZwQYCqVqTbPXVe+sCS7b2ba3zg=;
	b=ETLPCfPviqNAXn5xqa0Q/gdcAQyqRqLLYPCcL2NqzwKPtoBHH020xNPGdQSXDMCOz3wc
	 WoaqJUR0t9o8uwBO253O+8suyVS73TudPYBsSOBPlK+haNZfXw4ygt0OyssV6tQaI6eih
	 U/X7w6gfkGn2v6E5nPQb2UiARjo/4K0fYs62x6XDnEQweVfnRRJj+qJY8a/1d5cA+9vaA
	 Ic+jBuBXK0xKBXRlM5Dm20jHlfYh3Vy8Sc6YvrZOWVgO/pOD43sieZ/IJpwErdVc3H36W
	 2KvuZZkdY08Ck5cL2a6msatM0dfjOglj6j/HQfPCgyj9cirb3IVjjvwMLRGjssgOOyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bencteux.fr;
	spf=pass smtp.mailfrom=bencteux.fr;
	dkim=pass header.d=bencteux.fr header.i=@bencteux.fr header.a=rsa-sha256 header.s=mail header.b=JvMd+oNw;
	arc=none smtp.remote-ip=51.178.41.114
Received: from beta.bencteux.fr (114.ip-51-178-41.eu [51.178.41.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F65606A327;
	Wed, 11 Nov 2026 14:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08F65606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bencteux.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bencteux.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=bencteux.fr header.i=@bencteux.fr header.a=rsa-sha256 header.s=mail header.b=JvMd+oNw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bencteux.fr; s=mail;
	t=1794405730; bh=4zxPu5ZFrczIb7F9QZwQYCqVqTbPXVe+sCS7b2ba3zg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JvMd+oNw8+qLpLyemswhjMpYvynjrucqvWYmvMAyS+R09/pPBaGiGiSFADhBOdo9T
	 fcBZh200U6g6jTe9npE/trcVHZFAKxbNG1Ov0c/ILBNYjAhJHPkIVzacW+ebvr8T3/
	 +5O7qaB4YEjKsC0VnNLwh3ItZPAPbCgVwlvUvJcE=
Received: from localhost (unknown [146.70.188.209])
	by beta.bencteux.fr (Postfix) with ESMTPSA id 3B09C4029F;
	Wed, 11 Nov 2026 15:02:10 +0100 (CET)
Date: Wed, 11 Nov 2026 14:52:41 +0100
From: Jeffrey Bencteux <jeff@bencteux.fr>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
	audit@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] audit: add missing syscalls to signal class
Message-ID: <avRzKRB2f_dP-xEv@ultrabook.localdomain>
References: <20261111110200.30415-1-jeff@bencteux.fr>
 <e817126f-83b7-4450-a893-ac4e59460ae1@app.fastmail.com>
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e817126f-83b7-4450-a893-ac4e59460ae1@app.fastmail.com>

On Wed, Nov 11, 2026 at 12:18:01PM +0100, Arnd Bergmann wrote:
> Why the #ifdef checks? These should be available on all architectures.

I included them as convention, should they be removed?
