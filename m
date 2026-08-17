Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79FA93FA5E7
	for <linux-arch@vger.kernel.org>; Mon, 17 Aug 2026 12:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786969340; cv=none; b=EwZNlP778otE/EwEr07v7Ao0OFI9wnRr8Ofocfwu6PP44f03jFDHBhic6ZnbqZlFakQKOMXDL6fuWuhriFbO0C4RbyRIc8S4ykinpH3pDTWfSDdk72ua5sxP+hpDHJVcZ305dBLFu7x6/5DFYoDn8iudJu9GZU94QSNv3bfxCV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786969340; c=relaxed/simple;
	bh=I+UkeZQjqj3g0bJcjZoQjrVdpo8txWH3MfMsXY6UQ6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pNGq/vyxX6D5gP2VQczeJcjCZdsa2HCfIJ+l2ouyO/E2JkmBq4FrtKjVW2enwlwfBz1/KyG/nm1gMbHvgKR+lNPjnz9irGd1Ku7KNBFNYiBQCfOIyLALUUfTDfb1tggePkOZdttT1M7WcuoLHYq2/34tBOxl8jIxNPfjETanwhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YA4a0nO0; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YA4a0nO0"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92edb12cdf2so265524185a.3
        for <linux-arch@vger.kernel.org>; Mon, 17 Aug 2026 05:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786969337; x=1787574137; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Fjc8YE85ySy/Tyy7fdL+qRRJqTW8oWeIB13unlKZzTU=;
        b=YA4a0nO0nH4v84iv6elfrsvINBNSoFqqFooCYFt/cRuYftKq9UxSrecdC1bO8LxTmj
         34iaCd1M6wxXfmSzn4njprKUhNyXxgNor+wdcMdW+oQ7bkKBdSqcvOIhfP1QPqH/MXdR
         TBQlF7ijV7sLpk1nwy6HXvYVby0j3i7zTi6nGZJvRbKknPLga1un1MuRPNj/F89+8J8U
         3R+UfBzK5j0qFbBD6gmKibLW/K3dsysN3qBHU3AgSIwz6pI0ebsRHBdAHESNHqtXoa+0
         LkqS1kSLp7+n4aDiVSMigDPOBeLnNvNjrvp0z/Y80YXnNAriMzzHP38XdapZG3uHhgC5
         s7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786969337; x=1787574137;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fjc8YE85ySy/Tyy7fdL+qRRJqTW8oWeIB13unlKZzTU=;
        b=gEMHQWb9xAeo5tg3Y6aPzRyu49OPVNCbsvJFXAzBgm0xdqLYZ6DNuKfaur3BOWZ1Se
         P1Ji3aZVyEZP5VdY5gzzAA1U8WZU0NRgwi996/mtSL90uEz1HpIBxkiVBPNl63A+gUiX
         iz+SXpMBDvWSvP7uhOv/nTV2qKGivZHyb/TCIHkrkxL/XZwgw/xNAPydksG4VYxw8fHi
         EmSVjLG4wInkt5oLEfZCu68HKEFSf2f2H/byvhnU2soMFXRd0LUFHtqxhiOmeBtz27KG
         qyEdiMZrqzzARdi9RV/2KDPnzX69wvEmHeHU5CsLPmKihnnr/y6NY3uy/KUnPq9BOpC5
         K3Ng==
X-Forwarded-Encrypted: i=1; AHgh+Rr+zbjYrEgUBprq6wOoH2tlmjdlK8EKMXiEDkInLlDipc2y3hzpv7SwMN7sC3Wc0CAAUDnXGeVhKr42@vger.kernel.org
X-Gm-Message-State: AOJu0YzfmCG6V1kwawS7hSElPiZHJilB+K1ZAl8q887gme5LHdXro1jf
	lkSal85biYQd0KWA4Zt5TO1JhtAYrkcmEjpd9Epv/Mac5tiXp566ixGqYpR5mDAuXFA=
X-Gm-Gg: AR+sD11aJowuYiwQuKe+wglZr+uJWT3DQ8ANaACeBsw9ymTPpd1lqYMzyNhArC2nzu5
	0EaqANBUqcD5EaZEIEJlTZnZRJoeeeP4tYi5EeN8n4ajl7NlLeCzLHSP00nZ+5rzFwktHBqJ7oA
	W4tqPk0ovD9MFw++pvy9W5xjm0GWgA9ubCBxBFkIJvcBE7vXoo8Vx6oSKPmog2mCDgylU9sTsS3
	3N6j4mLuC48PNkI5FzfaSsMw73YKbzYEYoNDkAs7XcW7cI+gwg+2FagvIg+v6UEOnB7Kic8ETtR
	p1ZpbmdGd/pKGF+GgZ/81SDDMqKp+ACnw/nEPd7HNrPgW+FCbsR+WKOouc0DffT6sBHvaWITvSm
	FT01NgPGUVa3GsCkL3akmqu5X1dZMh/Fg3J0E7B+Aeqlt3/+HMo+1eRpGsYj0G/kQyJDFEWPmmH
	bRkihrcaBj7KbK06Qj33wROdO0SfkjLC3Fx25JhoqNt/wTg/FO7g==
X-Received: by 2002:a05:620a:2552:b0:92e:f3ca:2ec8 with SMTP id af79cd13be357-936d202b715mr2670485685a.19.1786969337333;
        Mon, 17 Aug 2026 05:22:17 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-937033fad12sm31868985a.36.2026.08.17.05.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 05:22:16 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wvwM4-00000005tO2-0GS8;
	Mon, 17 Aug 2026 09:22:16 -0300
Date: Mon, 17 Aug 2026 09:22:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: Jacob Pan <jacob.pan@linux.microsoft.com>, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	x86@kernel.org, wei.liu@kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	bhelgaas@google.com, kwilczynski@kernel.org, lpieralisi@kernel.org,
	mani@kernel.org, robh@kernel.org, arnd@arndb.de,
	mhklinux@outlook.com, tgopinath@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com, mrathor@linux.microsoft.com,
	baolu.lu@linux.intel.com, suravee.suthikulpanit@amd.com,
	vasant.hegde@amd.com
Subject: Re: [PATCH v3 4/5] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Message-ID: <20260817122216.GD933791@ziepe.ca>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
 <20260811155022.108148-5-zhangyu1@linux.microsoft.com>
 <20260813152913.00003d8a@linux.microsoft.com>
 <20260813224627.GA933791@ziepe.ca>
 <p7ts4y6lxt7k6ldzaa26v7rckmmp7o5js2gn2r3eantgzut2cc@xxsvso76nefj>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p7ts4y6lxt7k6ldzaa26v7rckmmp7o5js2gn2r3eantgzut2cc@xxsvso76nefj>

On Fri, Aug 14, 2026 at 05:37:48PM +0800, Yu Zhang wrote:
> > Why check it at all? Is there an issue with attaching the same thing
> > twice? Will it blip the DMA or something?
> 
> Actually, I do not think there should be any issue with attaching twice.
> Hyper-V *should* be able to accept such attachment. But I do not want to
> make such assumption just for a redundant hypercall.
> 
> Does this reasoning make sense, or would you prefer that I remove the
> check?

I would probably drop it. Having blocking always set blocking to the
HW regardless of what the SW tracking state says feels more robust to
me.

Jason
