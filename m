Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794271982;
	b=1nlXP9gVQSwg2DdZScHOrTAR9WKNP3HCFJoLSD+ZQWD5A+4fN6WNrS6HIGZ98dkf4fuQ
	 tu8Fv19OfE0ZzfFvo64rzEjZ2cykfUP0moL/siWRhdS8hcpEiZNpKI49advW7AP7aDqzO
	 vbTV1p2ti716mCiCg2NrOYMLSMiLgVna4fpRIdYeD0febBW27yDyWNqmTvhZ/Y5Pp6o/R
	 6IMqBfgatHbqXIdXWvXaVNXX0WSFZxKMaJgDpEFRE2A/e8/DfyN1S1SJQ9bKZ6Z1rQWDp
	 JKIJWEwXajaVvqPQ2dGUpwl+6eicS+ym1bTZWz64sIXC5QhDed6xPHjOtZxp93RY/+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794271982;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=JyWOo/pOtk62GRS0TgSKLCUeZbYObiIcnLDqhYuX4P0=;
	b=i5hkCqDoxF8mC8Q1A8vDC18wvC4gLa5/0feCuZt/E5+fEhx5jznlnhPMchyw2FDE78YD
	 VbRB+E/u/WzsgFxE2sMm/lmRsX8glBSShka2Y3qp4eEpJmKROMATjWPoD4oTLzEg6xKGH
	 QzTkQAM1JoXxlflF7yLvsGq10/CqvaEoMsphzmyw273icLtNTuGMk1pbWr9Bt/1KwGQPW
	 M3aORuP4y5h+lSnY2ijjq3JdAa31Ug0sHIKHSdkVuqdTtBc4DzdwPnu9xXUiDVcPQIscF
	 Gvqu1AVf1ZnRDmCLZsGKo1rEeVKwNcyk2pcSH51s9lTS6dzIs2Y3rWkbZWrv5n7121Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=UI0lGOzP;
	arc=none smtp.remote-ip=209.85.219.45
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB724606A32A
	for <linux-arch@vger.kernel.org>; Tue, 10 Nov 2026 00:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB724606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=UI0lGOzP
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-91c847584b8so14934106d6.0
        for <linux-arch@vger.kernel.org>; Mon, 09 Nov 2026 16:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1794271981; x=1794876781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JyWOo/pOtk62GRS0TgSKLCUeZbYObiIcnLDqhYuX4P0=;
        b=UI0lGOzPtjGGCWSl7C0++xvsyw4k27fssP2LH8P51PpkthjkaHj5KRci44EFlllRA2
         22mb0xN7sJ21C61B8NklSQ49XXlif29hkmARn6nYF7ZTHmI2dGgaI2OVUU89vCT4eFP5
         5LRJCqwTtBD6CfuWQsVz9x2+d/i+0bWwCFTQYtukBdoRFozTXPcKkrE92YIokJW3IncK
         GGkMlIDvhWpv5fU5ST0icLmUqNHsc7ncipYaVB16Nj5PkFTFvA5JpSp2xVQ429NppEbO
         5Cth1s0167K9uRdROxWZQJQiE0pbL9Pumg/2EUhQIg3Xg7iKMPVZ3xgsqRirOQTNWFqX
         eFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794271981; x=1794876781;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JyWOo/pOtk62GRS0TgSKLCUeZbYObiIcnLDqhYuX4P0=;
        b=nP8mJgV8LdYg9px/8kAGcK9CrgsBtyeTpiadUlvXnrnFHmG2EVOC6/DZz2oim+3nZT
         A0mxhHsbCU8M8+ePiWB9TFIEkx27lFu6vLjatm6vkdd/GTv6j0qr7e7zT9fLdyTE1+F2
         trvXyfDgwg7Y5YX5NX0algyP5ymONWFVvQKG/3a1d9IveA32Uk574tSeE2ar99WnTuxn
         RBDnPZ7povPmvmH6264mOH2H/j+qSpibfgQbBKSRiehpF85BxXs9wsSj+gTjt9DemBs0
         ZDZw/qvvQqFDqStqGYOIu1DtViMNNeFfCUvjisLpNXfxbdd1PyobYOd+HNoMuoiDx+Sw
         nD0g==
X-Forwarded-Encrypted: i=1; AL+hErHxUMqw8nZtDsT5wiQOCwsiYbGJktGW8alpOp/TzJ3SD+Y9UivXJcrcCQXsdZEMYHn7CS2cPRqt03Es@vger.kernel.org
X-Gm-Message-State: APuU4Z+eNwhAdS8tFkK1ExYHyN61PNDmjv4K/wAXLNZrgPEB0lTR1tx8
	jg0Ks+6OhL6AJ1HiZ780rBEi5bF2/+DwhuZ9821P46fBUpDveJbZMtkQpDeUV/ubpm8=
X-Gm-Gg: AYBFou2HswpI/LecI1PngkWRimSn+wa3kyttW9MdwCfBNm43yXWhRpoZwGh8SeQiD9g
	ysA48u/FtjBHVVTH81YUSaAMDcbMQJijGiursK9cpzl9VNTpr0kRHU3LTzaCGeTvjDk385nwb+t
	JZULiM04rq9xIGcCAIXdG57De2pn3B65ux1nTcqAZQKu5TvaYUP+UE23wvHWkOavGXgk1wdJHwZ
	b8Tqt1egOvkIbKWBLOHi+8DySvKdQHlokB7hIl4fLau3shMZqPtVcGlGB/qXwhQNbK6oz1T2/Qb
	nAW7d/jkIJSyMAQRkfCiqpW0aTuLeyeB34wxp9FiDo/JaRekwuIiOIObwdHrXEK+/TeqMoFejQp
	ygvMxIWaLKxAEd/Bt3KQjbU/iK0FmwEk48nuGYpFBdgAHRRzCFr8yGN0CfRjoacGBxoEFXO1NG7
	5Ob6hfOEtn3nPzxPW0nHLKh7nfinqXbh8AsUcJz6ca0JHiWe8Wht2buoveBmjZAP4dAmxY0sKOA
	N9OotOL7vQl7KiRojYI1VwKK70DL2vTo63z6GEEV6ytCL+7wkYdUbh77+aMXXCvE1DY+0Smcvqv
	sqwcaCfW+Q+M+ThhdH1EmURki2L5fuv3dqCk62uNMPGvf0xv/faDWTgfYfPyMFF5Olgd8AJTH9f
	+14rvn1MohQ==
X-Received: by 2002:a05:6214:411e:b0:91e:972b:ad99 with SMTP id 6a1803df08f44-91ef027a678mr17759746d6.25.1794271980522;
        Mon, 09 Nov 2026 16:53:00 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ef0543c8esm8667106d6.40.2026.11.09.16.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:52:59 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xQa6d-00000003NZr-1IKz;
	Mon, 09 Nov 2026 20:52:59 -0400
Date: Mon, 9 Nov 2026 20:52:59 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	Nicolin Chen <nicolinc@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Wei Liu <wei.liu@kernel.org>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	linux-hyperv@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	Mukesh Rathor <mukeshrathor@microsoft.com>,
	John Starks <John.Starks@microsoft.com>,
	Souradeep Chakrabarti <schakrabarti@microsoft.com>,
	Yu Zhang <zhangyu1@linux.microsoft.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH RFC 1/9] iommu: Introduce external attach domain type
Message-ID: <20261110005259.GU663069@ziepe.ca>
References: <20260925190742.1575380-1-jacob.pan@linux.microsoft.com>
 <20260925190742.1575380-2-jacob.pan@linux.microsoft.com>
 <atiakDqtuED2cTM5@google.com>
 <20261026161003.00003b71@linux.microsoft.com>
 <ausIn5Txiy1uRjkY@google.com>
 <20261104170816.GS3889730@ziepe.ca>
 <20261106130352.0000638d@linux.microsoft.com>
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
In-Reply-To: <20261106130352.0000638d@linux.microsoft.com>

On Fri, Nov 06, 2026 at 01:03:52PM -0800, Jacob Pan wrote:
> I am not stating that it will break UAPI because of blocking domain is
> used. What I am trying to say is that with the blocking domain ->
> external transition, we do not need a new UAPI for external attach for
> non-CC. It will just reuse the existing UAPI.
> VMM:
> 	do_ioctl(vfio_cdev_fd, VFIO_DEVICE_ATTACH_IOMMUFD_PT, &attach,
> 			"VFIO_DEVICE_ATTACH_IOMMUFD_PT");
> hv-iommu-root: external_domain.attach_dev() will do the hypercall.

You've basically described a wonky NESTING domain.

I think you should just use nested domains for this. Even though there
is no S2 make it possible to create a nested domain through the
viommu..

If hyperv ever learns to support VIOMMU you will need this anyhow to
pass vSTE/vDTE/etc to hyperv.

For now the nesting domain creation can just accept an empty struct or
something which means identity?

Jason
