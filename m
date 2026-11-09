Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215136;
	b=btznME5GeFZswAV2ySRIjj01cNWCUoh1zcjW8+vsFKjI+1QWkxe0AXWb/iigSaKMNfiv
	 80nrLDF8ckJ0Zm3HxDHr0mkmFYsiX4H7/ymVgMHM7ffVZtPl66P+c3fcHSP1shyfG5Qbr
	 IL6UxLHymspEsKkPXxeUdFiXfJ31MT55ej2mFIjFg5w7nuqZJXEoF738jOmd0DT4ZIggK
	 ygMq9MFecgYt2bF+UJO9E/4IPp+AOS5yYFOKgqRfTnPDqzoAYC/Y8WK2b8oM00RZoPdVe
	 iLRkpRHCnhRHEnnRA7UTV4my5B5Q34sD+/sofd3bIZV/oE9ZakdOLPydd+43sQRRX1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215136;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=hgV0X4jY1dOn+LKwLYZEG/kajINoeEuxwPE9Ju7yIFg=;
	b=N8QCgXLoDq3j4aVlzbYzpwZ3YYBTBTGmsSG4aMvi/8SZfjhZrkGyTcMEEuEugl7d3Ifv
	 eIhl/Z/LEYTs+TWBiX7Y9xIe/l4Fn5yVhMUyai0nW/GOmp/OYomcPWZ05Ur7kZMmRRsMk
	 PkeirUkzwOCKcWDaldlCyMlR2IOcONxMFd0g7fhzAU2NeisT7oLO/fww+roEO3lsw3kkj
	 88ZNIyJXFpT9uzLGgRc6m9gYOdMLMHfcqDmPXeIILtt5zhI1QUPoCf34kEUNRrY7GDG6D
	 ZNw53D5br2X9jeMP4tkmPDHc4k+kcTYLSSKuFRyXpGP2jyt6ctuLlR1PXOKvUu2havQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lZU8SnwL;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2116D606A322
	for <linux-arch@vger.kernel.org>; Mon,  9 Nov 2026 09:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2116D606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lZU8SnwL
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48e10a70540so345518f8f.1
        for <linux-arch@vger.kernel.org>; Mon, 09 Nov 2026 01:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794215134; x=1794819934; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hgV0X4jY1dOn+LKwLYZEG/kajINoeEuxwPE9Ju7yIFg=;
        b=lZU8SnwL2d5NASFMGtKYuHPElv2TmETKWdr//7QajgisC5jhB4njc7KUHt1Fbm/0jf
         cfmuSHMKQJQCQmQVkYHt2/OtvJgkZWIllal6QuwtZyvb8oHsO/BCvtJG3MfUHtWV55bU
         ogpiFdegi07uEIhxazGUbvrwtR7T3CJuRBAki5nh0zyy4CFC9HfCFdfQ5JpdeAwscKk9
         apZ5LVAXNN9SxZtNPbqS08FcN1VYKFalsQQdogv77SKD6Hk5IXW/dVxgzJo13gHpqtMa
         5twU02rNCtvBDAkFC+Z1uo+EPlBBMek8UflGEOFFl/GpGiSd0MlsQmutcvYiSvuz912d
         BrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794215134; x=1794819934;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hgV0X4jY1dOn+LKwLYZEG/kajINoeEuxwPE9Ju7yIFg=;
        b=e6NSuFKkLUEc9xJQa0wok49DTi2RSCu0Gc4YTfQFPEDW9LLHt768syooMDejM8DHLX
         PSeVGiIC4Lssk/rMgCieMQwKIqgBdDQvO9zPinC7G1fB6HedwPXTm5PdqWz8mxxvw2Lp
         j63fFEwZe0lzNhlH11UeNKKeyOd7wFxkgpTRcfNF1mTnx0WVZ0lD/97+V+q6PGZLWgLu
         qBtUL/bJmm5YXZi9FkSAnQ7NspIQQ4Hv1X7+eUA1eHq9tBinXXVomBDMIZyyg9YM6JcR
         86SjalcBJDDtwSbg/34INtJplnNeBAzye+mSiDZ8aRxLpx7KS9HwTZPMtvZSvI+l8+4P
         zNCg==
X-Forwarded-Encrypted: i=1; AL+hErHt4vNwiakYVu+27RGarqxbZxPZEQOko3fwi02xBvVTpew+QRFA6CvVWjvjkIwQMWz7jQZsKU8Qmbmg@vger.kernel.org
X-Gm-Message-State: APuU4Z/jCRJpTTlXB+RLDMUD3l9HpGaOHliGVuflvpKNWEVLQfy0wSc5
	U6L9vGmddqS6jPAIJkdW3cCk3I3KQj54NY+IIHf+s0xv6ixltOae7qrT
X-Gm-Gg: AYBFou23+py7XHsv+XQVWWNsb6eE96uq95wp7mFNR+PifvcXYCawlntpFmpN45EznHR
	f7xAjH5HKEfBKvjyUYprp8Hp79bYcInCALHelWoQanB2NbnlTcvnvCKz2n2a3WCqSJlPJS15/53
	04QyIS0Hpr0yo5CcFOeAdNqkFNnn+Jem2XqyteMz7JCIBKClFxcuhz5k32rMRw0whwd6xDL58k+
	BaKr4hTOnTsM7sSSVeQ6Oj1dc/h56BCfUPGSzbZ3L5DLFG8CNDW5JTQhb7PvibaGkBAv9Ug+rLY
	8wnI8G/suZSQtj/yNDe8psbO+ZbQndYsTSMkA7rmAG/4Gkdt5GpazFtCniGJ5BGSkOKjFMfOFW9
	04kNfLQuXSbWD6HD2J/sHvX7gUNH5nfS/WQZpX+TDx+TjcIhKSIsPThAcb8xeCS1uN/O0Sz8Ow0
	EcDShGUUWn9kWyGQM+HceLcoYGFJg3RflgzE5xfjlR+R/Aevq7gXbNKHoXYHvXKfOnaBTbIknKD
	VEUtBHgeM7VPQaBe6/K677yBz7gDnkkhuvdHy9D9/yTdqIVUSVep4EdcYXRWhSqAUX6h1e7DadF
	ZSxRwpyTNN5OjZ8Wc8A0BCM=
X-Received: by 2002:a05:6000:2210:b0:48b:a7:6396 with SMTP id ffacd0b85a97d-495844a3a48mr6683329f8f.41.1794215134134;
        Mon, 09 Nov 2026 01:05:34 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49596ea51cbsm9541323f8f.27.2026.11.09.01.05.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 01:05:33 -0800 (PST)
Message-ID: <8ff83fbf-2ecb-4f9b-ac8f-ee88fece67cb@gmail.com>
Date: Mon, 9 Nov 2026 10:05:30 +0100
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] mm/gup: limit pagecache folio refcount when
 grabbing references
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Song Liu <songliubraving@fb.com>, Rik van Riel <riel@surriel.com>,
 Miklos Szeredi <miklos@szeredi.hu>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Steve Sistare <steven.sistare@oracle.com>, John Hubbard
 <jhubbard@nvidia.com>, Josef Bacik <josef@toxicpanda.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev,
 linux-arch@vger.kernel.org, iommu@lists.linux.dev, stable@vger.kernel.org
References: <20261107-refcount_overflow_stable-v2-0-c38f6809b106@kernel.org>
 <20261107-refcount_overflow_stable-v2-5-c38f6809b106@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261107-refcount_overflow_stable-v2-5-c38f6809b106@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/7/26 11:23 PM, David Hildenbrand (Arm) wrote:
> Let's add a folio_ref_count_over_limit() check in fast and slow GUP
> before acquiring additional references or pins.
> 
> Keep it simple and use the check for all folio types.
> 
> Don't check capabilities with IRQs disabled, as even unaudited capability
> checks can take locks. Refuse access to the admin reserve, so GUP-fast will
> fail and fall back to GUP-slow if possible.
> 
> Also propagate try_grab_folio() errors when grabbing additional
> references in __get_user_pages() and in memfd_pin_folios(), so hitting
> the limit returns -ENOMEM instead of -EFAULT and -EINVAL, respectively.

nice!

> Keep the existing invalid-refcount warnings.
> 
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
