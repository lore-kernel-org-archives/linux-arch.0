Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52FD45FFC1
	for <linux-arch@vger.kernel.org>; Mon, 17 Aug 2026 17:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786988157; cv=none; b=Thk3xXLF9ynNVBjr6jzvE3OEBqM7gXhIuPIBb1MPjZHqk2mpjEd2OA1uWD6lWJCw/bm5zVIzGeGUkmA8sX2Gdv1pVgg0MHiY1Pjm9LKSYgEcvxedhz5t09YQuM7scriaQ2psOcYpN5F8Gce/PxSh7wLyYNw2HD8VZ6zHftEUcJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786988157; c=relaxed/simple;
	bh=+e98k4168mAh10/uMiEYObv7JgiKCyhKONJNJqBtoX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsHJ5IIdDwfrXL4w7hCSl71yDG0v4XfG5hPbOIlbM8vwccyLwGbXrn2xIuji+CMKmQi4FBeU2AIxJ18/l6uBODC/CmlcZ/gw8XHhHWCRwUI+DfQoS5K4fmt3Od4BnebzfAfFMSyegZXjvB02lyf5LrnnpSKKRpuXPKZ6Mgp85qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=gw7r+pwV; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gw7r+pwV"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8f256eaedf8so36726636d6.2
        for <linux-arch@vger.kernel.org>; Mon, 17 Aug 2026 10:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786988154; x=1787592954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7xTL49KfLwAq5Qv044eqsaTTNVVybZ9ovZEhY6mKMv0=;
        b=gw7r+pwV6rzaKBcmZKbwEorQMsOdlVWe4SFpxiD/v+PRtMIy4J6HyT5Oi7RHiQrWWs
         S7sgNNTz0bKsFxxJi4ZjqFSvTstHa3USTWT2Eipq3w3i5siHj0sMdeJ9G9HfzAN9AFGw
         AS/9rqZoB4O5CVatSRFs+PHzWOL8pLryM/kM8YG5pChw0pWNRZTJ/m0Bvs3BjAwXOAOY
         SlFoeDIVLBpfLDfq6xuZMB+RAtAaXbsiayBy7+lC48SmZo3iRK62RcUwpJOrqErVGTVF
         VDrG6vkwao1Nu9bVUxqDAOulVQVW88mTNz2SToj8FaeXahz2c02MFx4esKc7GrCtQmo1
         4yPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786988154; x=1787592954;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7xTL49KfLwAq5Qv044eqsaTTNVVybZ9ovZEhY6mKMv0=;
        b=ScE4WBqjYm/SVdNMJt/6T54iQ3gQ70UGO8TL+SF1pBYyhaWOYei/fzJeVH2RJID48g
         iCmjpINVBZPEDp/paLClpgoUStKr6hHQJBg3YRU+KCvNDelmc3Jp99C6p782er43XXqR
         9wayMZ32UcB9xiXm9qMVf4SuVMZskc/dL6c1A/LUlWNgtLX0zKIJ34qa4zOoA93eDWvg
         8n5niuvd6RIEyjWaeZJXOvvcyrt/7tqy69i8xjpBZUH7zYMfHxZhuNTv1PUMkTTL2c0Y
         L18Eg2oEV/eUmBx9rAcIZTZk8Pq/8L0tS/6bdGJIMGnSp0+4b2p0CkKqnl6P5hQYaMRf
         OTVQ==
X-Forwarded-Encrypted: i=1; AHgh+RpviikpTITizO+DzJvdXpY/wdVNRd1QLpDZ9TF1maS+DQBh/peKgv2u7+KEicSE+QkNiYBEHuenOL4n@vger.kernel.org
X-Gm-Message-State: AOJu0YyiQSKnLJTsy6rZIs5pXTQVVwVlIuBa/mHoNkQHmbUButTgaIIa
	TZDbSgvaY1xypi0Qyb07C2OPa1W0VlOdFN6QjBFbGOo/QoeE6+FcZYNDi4S2I90U2l8=
X-Gm-Gg: AR+sD101Se7f3gE2SXaO8wRVY4/smpdPM//ooZh0zqcVb9PBOskh7yx501qtY+bHo4M
	wmqkVkPkB2+BXJeLD84VQe5v88OCO2+YoBQrr9QhxJWV5Ed4/lnTK/OBks90kTwkIZRiVIX0ykV
	uVFOrULwcXxtfHamkHeEcBBeZF5UjUYSDdv457M4Vxi57qJdnrGBHSU1H6kLQSTNvQWYzga48ZS
	imNeOuN+WeVXGCjlvnxwZE4PndmbypxSf8DGPXDZEJhoiyEn+fOylA+SpoSMdkdHENdBEcNxQXl
	cgyyc2VGkh3f9CUk7Ftl1R/gKXyhLVilNQeM8AiRFh5vNilEuO/8ww3ZJyO9Hz8yKRhiNbl990l
	+OoWbBDJUm6eg6C4cEgNV6q2DXOqDohy3oyd4JUtM2G/pK5dABBIVYpBSY1ic2qzzqXD4ceQHwb
	jgdIS9b/lgD9at3+S0BKyEUu7hwR8XePyWUP0fMA==
X-Received: by 2002:a05:6214:e6e:b0:907:bf7a:9771 with SMTP id 6a1803df08f44-90a91def3cdmr277120766d6.21.1786988154391;
        Mon, 17 Aug 2026 10:35:54 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c4580f90csm13765356d6.9.2026.08.17.10.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 10:35:53 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ww1FY-00000006A9C-3bVH;
	Mon, 17 Aug 2026 14:35:52 -0300
Date: Mon, 17 Aug 2026 14:35:52 -0300
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
Message-ID: <20260817173552.GA1418894@ziepe.ca>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
 <20260811155022.108148-5-zhangyu1@linux.microsoft.com>
 <20260813152913.00003d8a@linux.microsoft.com>
 <20260813224627.GA933791@ziepe.ca>
 <p7ts4y6lxt7k6ldzaa26v7rckmmp7o5js2gn2r3eantgzut2cc@xxsvso76nefj>
 <20260817122216.GD933791@ziepe.ca>
 <gk7lcfk73uzntmnmf7eb5clp2h7q7oqb7lykj2qlrrkilotfvx@mf6wima2kibk>
 <aiioa6ospojivued3djhwadyfpit5temyvrgm3xxzhzt6aqbiv@hqz6q5bqnl6w>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiioa6ospojivued3djhwadyfpit5temyvrgm3xxzhzt6aqbiv@hqz6q5bqnl6w>

On Tue, Aug 18, 2026 at 01:22:03AM +0800, Yu Zhang wrote:

> So we could
> - either keep the duplicate check in hv_iommu_blocking_attach_dev();
> - or add code in our common helper, hv_iommu_attach_dev(), to treat
>   HV_STATUS_DEVICE_ALREADY_IN_DOMAIN also as successful explicitly. 
> 
> And since normal paging-domain attaches do not have this duplicate
> case, I'd prefer the first choice, to keep current check in
> hv_iommu_blocking_attach_dev().

I think everything can technically be re-attached and must not fail,
you have to handle that possibility everywhere.

So accepting that code as success seems like it might be needed anyhow?

Jason
