Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794330446;
	b=hy+u6aDyCW9AB9UcGMKGheptAKOBbNTw1qMx1Ufo1f3qZK0ogogtSqnWkS6m/pfz1pjO
	 iEvj2yQWDP/mKy6xVNkmJ7KwO+7f1BxOhFirj8KVHIQYfEd/ktEojrQqHB4wQiUPoOQmr
	 BOIBbkdsLvNsMGwCs1B0TQJK+8ZDBap0LAilEhN0m7Nil6HGTQs3FnqAtAF3G/MwzP+5T
	 03K7udNvSKcDJQWHdQc5eA5i3LHJ33v9IX8x53XUjW5roxb6bDRL1bH36ei327u7fGT56
	 iiUS3A5bCTE/7QqvBuUBGJCYBp/rWx/Ea6CBFc+HaVi5pAfrOdOyOSBMQokN4N6G1vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794330446;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=FNcC9m18UoMJxRcJEPoSUxoKZdU2fxVY/XU8PXnrjcA=;
	b=LqLSBhy0cUNekNEjpCS4PnuOnwa1pFaARwDGzwsVrb/qvQyB9wgpBZLEffldipXtuwYR
	 NN/QDV+yDTqmPK+fU9hTFwJVDTImOrUPd9EzlU15O64Wn7gR5GICBAkx+Lj9V+3GqC9Ow
	 0qkfZSxtHEbMo0vyRcl3HOjNWvbswv/YAMwQ1aqimrry2T9eiVmagsrAyXqZuDtRRzbAF
	 f9g57pkRd+KXvP0leKfHjSV/lq5JdebPS26vH7xf78ChQNpjILvho945laMDw0eVQqYVb
	 PDRoKBP8ziUefcH/yfPACMCRJykVjWJb9DdaalF0WwjduDZuqEXpbzHIuO1tnwq5gsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UVKcRwO3;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C743606A320
	for <linux-arch@vger.kernel.org>; Tue, 10 Nov 2026 17:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C743606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UVKcRwO3
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3b08cf16decso1501599a91.0
        for <linux-arch@vger.kernel.org>; Tue, 10 Nov 2026 09:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794330445; x=1794935245; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FNcC9m18UoMJxRcJEPoSUxoKZdU2fxVY/XU8PXnrjcA=;
        b=UVKcRwO3ejBDMk8klGa0pwyOX8V3E2o9Z5FDLbNmULmLkseoQWo3Lqy0OuNTv0i92Q
         ZjjYVo9KXE2zdYV53r0tp3tj121+8xjU74d8CsPd7T/ezb0GS32Oj0pnMKjoXKzmgYz1
         O+RYemVJ0UhckajWqJT6SbFntkibstlz/QpbrXg/A4Q20wwQ7hX+udbRjaT+kVWhERei
         LVTIfg/qTgjrELa088mLnh8eLDqBIePCWGGCjuCCKFA4k1sI0K7OyO7Ju718M6mBSoNU
         6TYqsOoIMH6yBuYtZwE0TFkjVgzg3JMY1p5vlkSwdwLpdJ4u9Z3VALtaIzkru9F3/ruI
         xrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794330445; x=1794935245;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FNcC9m18UoMJxRcJEPoSUxoKZdU2fxVY/XU8PXnrjcA=;
        b=G+yzrX8CCq2fL7wC83+iPcFVfJCjmy3uEEiKihe9V1fj2JsEiIXX34YxUXCA+rUHAP
         +xz3L7dVX/ERKdFjTmVeauML7/IkzOfueeTMO1XMoul3QgZEdl23g3TdqepQNc9hZZ+U
         0YJeTETzAcxynupUPBlawTzdWjWpJg+5oPiJDvGmdBrI7HkoK3zcztHo4pBMyoxQTBuh
         WpzyILyTqG836vMYsr2WmRR0Xm44Bz6hNdy2cUQdbtedE7ocEIvW0iOvcD/1U+FOQSM3
         GxDB7nctUFUn9k8UyA6vyHUjAPJtJp6gcFUAtUc1JaaYRf4lHCwvmUsturJWhrcYRg7G
         Ca6w==
X-Forwarded-Encrypted: i=1; AL+hErGkCX49FWkiyU4ylhKCnFa0XXCXfj9HsPdEk6s3zhvxk5XKY/+mOIReUhdbzm33WnNW9J6Ua6eRsd2J@vger.kernel.org
X-Gm-Message-State: APuU4Z+vlcQsngbqy2/wHa07dEGlWlYCoG2fYUwRwLnGpml/pA1XmRab
	SsT6jLmNsFwdHOqfCwsWfqwXEuc5JyYN6Rvy49sVU8dOHGlE9f/gQz4eIErL0nThBQ==
X-Gm-Gg: AYBFou0CpjSP27oyFphx+1DdhKF+0FjlI0LnJB1Sr90QAs2RBnkCsePnh4vW+pfmvBv
	EsP4+mx3F+Np8iJtB8OiuWc6D71lXD/eCt2RrA+0Co4uWdCVNQcLTt0z5/He2faP3E61qxlANOK
	izRZEjjHPJkR7p7juKvz3nMjH1VK6G2vnGsZWutewP4IwOfc3zMFR+VgpDKoVOSw7gkkb+smyJ5
	dUp0gNNwPkE098ulterQhjAHnFiwsvaSuTT7eW5eIZdYZXegpoHGLF4v0B3IUtX0/SuCrU3bdZX
	C9d3olMcUUOl3lsppaYYXXN6qBfL/fxCpoZfw9gttxNb+O8ufabwuBrac15I15cYqZlr/0GZcfx
	jzrncbU8UnQI2EwWmlDM/ZjFswCcNhR/s8B1OE/sU5SLBtdupZPsRE3bSV0NW1luaSFUPY4wAuX
	8jyA8ogkEonYxKFdhsE+qSTPBz2QlCIfxT0khIm/1FIipGuPiI5h7kQghvm5i5quQRt79+JJpQO
	icWgE7UTvt0qkY0CiZwh6yRVt6k/JsYkQrGkUfe19XB7iMuH0aQgp5pnsYVQgab7j/xrNf29Qzi
	bQJXhp6jN5mHVn9IWFE7R8lb4Vb+TljS+YXmKNYUtq0ea/2cnmIb96hCm5tsazLY
X-Received: by 2002:a17:90a:e7c1:b0:3a5:133:ca5f with SMTP id 98e67ed59e1d1-3b166cdb54amr3659496a91.46.1794330444574;
        Tue, 10 Nov 2026 09:07:24 -0800 (PST)
Received: from localhost (33.79.127.34.bc.googleusercontent.com. [34.127.79.33])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17db56c7esm499973a91.8.2026.11.10.09.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 09:07:22 -0800 (PST)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 10 Nov 2026 17:07:22 +0000
Message-Id: <DMRP21FATCC0.ARAURXWV85JP@google.com>
Cc: <kvmarm@lists.linux.dev>, <linux-pci@vger.kernel.org>, "Pratyush Yadav"
 <pratyush@kernel.org>, <kexec@lists.infradead.org>, <kvm@vger.kernel.org>,
 <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
 <skhawaja@google.com>, <sagis@google.com>, <linux-arch@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 08/19] kho: block: Add the feature header to blocks
From: "David Matlack" <dmatlack@google.com>
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin"
 <pasha.tatashin@soleen.com>, "Mike Rapoport" <rppt@kernel.org>,
 <robin.murphy@arm.com>, <maz@kernel.org>, <will@kernel.org>, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>,
 <seanjc@google.com>, <jgg@nvidia.com>, <loganodell@google.com>,
 <arnd@arndb.de>, <dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, <oupton@kernel.org>, <alex@shazbot.org>,
 <gle.com@google.com>, <pbonzini@redhat.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, <kevin.tian@intel.com>, <joro@8bytes.org>
X-Mailer: aerc 0.21.0
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-9-tarunsahu@google.com>
In-Reply-To: <20261110050202.529473-9-tarunsahu@google.com>

On Tue Nov 10, 2026 at 5:01 AM UTC, Tarun Sahu wrote:
> Precede struct kho_block_header_ser with struct kho_ser_hdr using
> DECLARE_KHO_SER. Each block in a block set starts with struct
> kho_ser_hdr followed by struct kho_block_header_ser. Serialized entries
> start immediately after the header payload at offset fhdr->size.

This adds a feature header to every block in the set, but the layout it
describes is a property of the whole set: all blocks are written by the
same kernel with the same header.

Blocks are only ever added and removed at the tail, so the head block
is stable for the lifetime of the set. I'd put a single set-wide
header in the first block only, e.g. a struct kho_block_set_ser with
its own feature header, and keep the per-block header to next and
count.

entry_size (added in patch 2) is another set-wide property that belongs
there. All blocks in a set have the same entry size, so recording it in
every block is redundant, and restore has to check that the copies
agree.

[...]

>  		entry_size =3D ser->entry_size;
>  		bs->entry_size =3D entry_size;
> -		capacity =3D (KHO_BLOCK_SIZE - sizeof(*ser)) / bs->entry_size;
> +		capacity =3D (KHO_BLOCK_SIZE - fhdr->size) / bs->entry_size;
>  		bs->count_per_block =3D capacity;

Nothing checks that the blocks agree. Each block's entries start at its
own fhdr->size, and count_per_block ends up being whatever the last
block implies. With a single set-wide header this can't happen.
