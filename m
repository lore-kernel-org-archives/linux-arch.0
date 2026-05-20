Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90033DC4DA
	for <linux-arch@vger.kernel.org>; Wed, 20 May 2026 17:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779298171; cv=none; b=mx4TwVwGwsVcm000bBfv9oTkEt0mUufy1LmLeLqNbAaW8wUMhd6ojPGYJKsO7VsilZ9YCS2ynmcib2QHl+uuiBkjkgH3NkIgGUISC2pwPiwnQZQO9CUFUqbvZdfVOC5PbOx01ctoC3S9lAqK+XmU4p99nLl+2i+Z+70tkx6EsmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779298171; c=relaxed/simple;
	bh=swndveOwFBrQHenLNsbHaeYRdxFM/mHCS9gLfA23gKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BmYprQaERplGrqXU+o51RNlPYQTtmLD5BkqPygrpPBz2BAiMV5siX1pQbwvYMfFxVSa5SALZPPyrJ2ay52UEoOYeHD3PL5NzQmX98KFI7ruxw6iEG+Onigdi+75ptcwsmD8pd5j9F7X4HQPMiw4Ac6shcSj+dRWIDjV4SkXlfWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=g5q08TTM; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="g5q08TTM"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-91080895355so609384085a.3
        for <linux-arch@vger.kernel.org>; Wed, 20 May 2026 10:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779298169; x=1779902969; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=exjD62wJL9xWPCxLYQZyKnslKmMxfygqA8U7tuRD18o=;
        b=g5q08TTMelkn0L0SxZb3+ATrnYT+H17KcUvpo6YT57GhpzTX63o12oJoplsGIXqDMF
         GO76FfzfnDxsdTrA9IqQw3FzgxAp+liRKxpWnAO6W5WAES6sjX1HLkGHHSyBzey8Egxj
         Kodo0NDVqR/KyaH5hzfiuJe+STzNS1+SjePZUOQxziLgCnw9KN07v7c57mZBskZeM0Vs
         XCAg4qW6g/lVX9CuvlZ4Xlu/HIiEBvUumlD8G8fwEV7HvcBOflk4eLTYihZH8Rh0Jyji
         AYvXldlm17JaoZECuUabPJZ7jLeWHL8I8l+54KjnTY7vZTPjp/mF7mD7/21pkdjl2end
         nXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779298169; x=1779902969;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exjD62wJL9xWPCxLYQZyKnslKmMxfygqA8U7tuRD18o=;
        b=E20WdKAZjZA+gK00rdZjWFTITFr6Yx4/2+UR4OySp480t8xuHSbspHEidt3BqMtk1Y
         CaXxFW7bShNzheF5asXaqUietYu2OoySLJTq427C9PWYPuTEeWm/pM6H6voiJtzYNOHk
         Wy+Es985UMUZDuFYpjZ6PegwKIfBH+0DQS2nqYM0Hz3a6mS3BhQ3jr84f31IeN9RaObM
         X505C8STBxI45q98j4cmYNxEY/w/j63D4n+jM+eoJ+DoxYPo6Jrd7WO5FjuS0a3iOK4G
         Lc2VWGpux93szLTHWoNjC5vnQP+rJx2dHDHNSH2qEhscH07iGW+JeriECx4nTr3eaSOg
         I3bw==
X-Forwarded-Encrypted: i=1; AFNElJ+y+cTN7z2pmOfEdM/7TriO1Y/PH7dCZ4zmGAZlI+bzkc8KYQMpNtqb1KyQRPU72Sh4Xuy4/HiCN39Z@vger.kernel.org
X-Gm-Message-State: AOJu0YzPNmJ0UtAtWFtHiSVQEg5kZiZAzove8fdTu0Dn1v5mXxR6+GO7
	vpZ85bZPB+iQYY6RZYuNhHzelzqPc8644b6p4xm+JugZGbGx0FVUNI7unzhgxXvvGSo=
X-Gm-Gg: Acq92OEV7ijIYXOg07tWU6UdJxmGpWw9CtrA6nfiunFN6ICwr7xt2NlTgvtWpMLfZlM
	SYOzKLiTvaxTiUnF737VGA1bCifTUVRhUzST0AdUCSeolcWEQASdWKCj6gfhW0c38UachKI/lnx
	EoYasQXSMoyJLGMuhCRowHQ3TbUy0Erii6XAe3jK7dm1BLFNg7y9Q/ZnS9AvKf5vlkvsVZUnH09
	h4e71NCMypsLuRLeTCbRr+fOnJPQ1yzW6MDNfYAbe9IxpZ6smM4lqysQQA/FSWwm02MEzXUnXSL
	1KPkytTwdHkyekM7VoZ4q2GhNItJxS1ex4UcawEDwVpHtWDBpw1Cj5v6QxRewBIM/4O3J+7NH9k
	IlEibF6kbSr+j9bIL4va2hoGYDLGjANwWv4arCMd/+vOzJdDDPOKjuEKk09cUwWW+OCQR3/HvwB
	xDD2dcgXcmQnBYWz+hc+vzcQdAVUFYWpbYlIkGeGgoA1LD0Vn3IveJuCRuKNVz4k4K1r2uDMkKY
	9a+Mg==
X-Received: by 2002:a05:620a:4112:b0:8cd:91f5:7a29 with SMTP id af79cd13be357-911d087bedfmr3730351885a.53.1779298168893;
        Wed, 20 May 2026 10:29:28 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf37762sm2298183085a.36.2026.05.20.10.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 10:29:28 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPkjX-0000000HXSw-2zB0;
	Wed, 20 May 2026 14:29:27 -0300
Date: Wed, 20 May 2026 14:29:27 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	wei.liu@kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	decui@microsoft.com, longli@microsoft.com, joro@8bytes.org,
	will@kernel.org, robin.murphy@arm.com, bhelgaas@google.com,
	kwilczynski@kernel.org, lpieralisi@kernel.org, mani@kernel.org,
	robh@kernel.org, arnd@arndb.de, jacob.pan@linux.microsoft.com,
	tgopinath@linux.microsoft.com, easwar.hariharan@linux.microsoft.com
Subject: Re: [PATCH v1 4/4] iommu/hyperv: Add page-selective IOTLB flush
 support
Message-ID: <20260520172927.GY7702@ziepe.ca>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-5-zhangyu1@linux.microsoft.com>
 <20260515223545.GL7702@ziepe.ca>
 <lxmfd2ml5dafkxquuf5i45uqgh6wxl44hlqphu77kvximqrnmi@b3htoyjc6d5z>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lxmfd2ml5dafkxquuf5i45uqgh6wxl44hlqphu77kvximqrnmi@b3htoyjc6d5z>

On Thu, May 21, 2026 at 01:15:24AM +0800, Yu Zhang wrote:

> 2) Follow what Intel/AMD drivers do: find a single minimal
>    2^N-aligned block that covers the entire range, but may
>    over-flush.

If it is plugged straight into a HW invalidation I would do this..

Jason
