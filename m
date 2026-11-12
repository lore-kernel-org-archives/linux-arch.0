Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504882;
	b=wu4lte8OD8KQE9rD2HH+KWQ2A4fJ3GdaoV/mmqq7b/RF9CnmlrSk3EJY46RsVecLI49a
	 gwZ9pfE8VbU+XfkeQ35AdT6CeKfQh6qABi1YSs+8axnQk6hDQtE8AZfP/CF79d/Crzgrp
	 Lho4nea1XTFrQ598RZQH7syLudmMoEV6Jg8IdVOU/ezH+E21/nNOoeUr6DeHaVYpDLPS8
	 ZrG2MEPRnq9YLVH/84jyeMSrsCnckux6NkcSaokfZPS9TyXkdIj6h+lHe5iPu1f6C2dSO
	 72hSl33Lyz5RuhbQ7pRZcnZZ+uWW+W/2uV8gHwXJPSPvWvMoiQQZANbJ3vaUcWxpufw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504882;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=AVq19U8dsLUULl5Arm+uFElP0L4F8s4K16OEcmVJkjM=;
	b=2hkQi3XQzyd+u2pLU6Bzx8tRtWlkSi07ON5cRN2cdIVEsT6uMs8rJtGujX4hIpmgL6Xm
	 E9N1kir1/i3VvqEIZb2nsRApy6A+655WzlSMz6Q03e+Cm/aiqSmVq6VsxOPWIo5yMkBD0
	 EAB20rKr/9K2siJ6xzEEP00MDVsBFh5XA5AtrAjtqkZK+X4rhTI5malA9QaIbi8cAAU71
	 hejEnlBWcmOiZZQ/K+32cfD7JEaDdoxrhNJcl922gtnSHfKrgeboIQ623OO0zUXmB5Ga9
	 m+JZhQQJOHnKZAzTO+Fi+x2QvTGGQjW/nsosMkwl6/dIqduydagvxK+TZyN7+T29cDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=JMboLaLv;
	arc=none smtp.remote-ip=209.85.167.41
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F422F606F2B4
	for <linux-arch@vger.kernel.org>; Thu, 12 Nov 2026 17:34:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F422F606F2B4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=JMboLaLv
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5be3cff0f6cso64759e87.0
        for <linux-arch@vger.kernel.org>; Thu, 12 Nov 2026 09:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794504880; x=1795109680; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AVq19U8dsLUULl5Arm+uFElP0L4F8s4K16OEcmVJkjM=;
        b=JMboLaLvhLiI+ZcskxHURh40gTO6G06MLDBbciiY5FOspydzZL+mhsK/WBWsWzTthq
         D+CB6n7OjhfoVG66ypiP53VHzuXKr3/OdUYBxYzytIthdmlqmsJTZJhb00qCvoI5Thb+
         WCm3a3LklLjDDe5T0wXDKRob+qHQbC7wlVt30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794504880; x=1795109680;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AVq19U8dsLUULl5Arm+uFElP0L4F8s4K16OEcmVJkjM=;
        b=GSU7a/8HAl92Oloe30/m5Nr2gFgBoGhawUGaln1YSEaIFUvVTf4QKPDK4uSvf3dfQH
         GddxYlleNaI6+DRoCVd+Es/28JbxDf4RDY0S3PAn4UEGZBEZwR2CrIR+oS7qGrXP0tbg
         0/FhwEQffpnqN0PAbmlF5YaKPM73AlcQTPijq2unS76p55AYbxcfcUDtdR4ZvDhQuJ6y
         U9lUsPeIdOM106ii0L+aS01xzMHRg4PA87QR2mL95MYUp089oEYHqOn22zeVwF32LSfw
         oxi0QSNupC/yNhnz4OPW7C54moPq8TiYJie9nRKBrcjJoV82/C0icAWfMq4cIi1pq7L2
         h7kQ==
X-Forwarded-Encrypted: i=1; AL+hErFq2mE7S2Av0gOi5FlfuOQ4OlvkRIEKSDK3+hcBpiRDF5EF9Nw58pghg/55sr54j+nj/OFX5JULl9SI@vger.kernel.org
X-Gm-Message-State: APuU4Z+iD+tPerEppeMM/4yiK+4qZ4GkjNNfs84potV2yrYQxtUNJ1Mt
	D3Rm2DZNBD9j15M2iz7j4ea7ZDJbwd9fbuQIKxdbghpxe+e6fPTPFFJGFzACoRyxjSCa+m79syE
	38yU44QTISQ==
X-Gm-Gg: AYBFou2NrtR5PwDg9riN9Gtu7Ywkvoxxaz5TeKQWgS9KPJtdnd1ki2c6CmKnAmxmy5N
	yJ3NjfzeXJU0LfKYRVObZ2M3uAvCmtuYNxmgWjnm/78qkuFhWn5H3eu0QpdANPhOCnT3kVD03t/
	U+dJZc58DaMqqTu+npLPVMXzeiVaFm42CYD+ANC13xGYKE1f/f7IkVHtUwJAHnuuZ3poC5kkmjs
	dIw9XI4mSgXXyo/rMMiA11FhhnoajafxIo1iWYtnVA/fp7NgztfL/ziYa2aDoedYt4+mqDF7rIc
	LcX3+/XM0iydmnSXWwbBgFi8qymyMTrRVSFNyZzfOUmKO+KQzBf7qTxrTYUpb8sPAg6y0eoCaWA
	8DAHAo8y86KnplRtiqZrE+x9p5t1fFoM+yS2x0tEoz295UKNl4Nc4XVIL3XWe+KFwAMueGdu1pF
	S0jtqUfYPoCdAssnULtw8467v4ppjkX5bkdkuST7Z3W9JeHvszc6dizVUibiYxGNjDv/BhxG77T
	KDT+iiXWQqHmcTnNvyySBze8LKg4YhktawpyEk5rctroyKUE00Kzftxi8OnUm2C3ducOHZdhUxL
	jHLXgD84R9xrbtnxdZEjqUnEutWdxPFihnhZsYcvj/1GEmEd6/Arb9ueiRkOntJRTZ9kKtBxr0Q
	qoYk=
X-Received: by 2002:a05:6512:3e24:b0:5c0:471:e462 with SMTP id 2adb3069b0e04-5c1705d8374mr56554e87.4.1794504880097;
        Thu, 12 Nov 2026 09:34:40 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c160d60de3sm1137831e87.49.2026.11.12.09.34.39
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 09:34:39 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5c15ccd7fb5so62013e87.2
        for <linux-arch@vger.kernel.org>; Thu, 12 Nov 2026 09:34:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGOPvQTq0837TLgMEKsA2p9DUI0idzymLCALhOgtH8pRnctKxQxRsIlo4d3v02XrEyU2Trx00yWTa+f@vger.kernel.org
X-Received: by 2002:a17:907:3ea7:b0:c4c:e344:ece7 with SMTP id
 a640c23a62f3a-c5066afe5dbmr615605366b.10.1794504534261; Thu, 12 Nov 2026
 09:28:54 -0800 (PST)
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110-refcount_overflow_stable-v3-0-318625d63a98@kernel.org>
 <20261110-refcount_overflow_stable-v3-2-318625d63a98@kernel.org>
 <avW3v-oLxcHXXNQD@pedro-suse.tail5790ac.ts.net> <4ae22b7a-c160-4003-a029-8a20381d196f@kernel.org>
 <avXFlI_5fhUvFyct@pedro-suse.tail5790ac.ts.net> <42373222-8e37-4658-bebd-dd27230a1dfa@kernel.org>
In-Reply-To: <42373222-8e37-4658-bebd-dd27230a1dfa@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 12 Nov 2026 09:28:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh995y1B461rPAcgLagg26vsyXPoe=7JKgHowB+uHJJXA@mail.gmail.com>
X-Gm-Features: AclHuK90rViBZMbITCUjh4KTAKhE7_4EYJcdTbdgYzXWPc1JsLWFSAsYMdn-r7I
Message-ID: <CAHk-=wh995y1B461rPAcgLagg26vsyXPoe=7JKgHowB+uHJJXA@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] mm: limit pagecache folio refcount when splicing
 into pipes
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Song Liu <songliubraving@fb.com>, 
	Rik van Riel <riel@surriel.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Steve Sistare <steven.sistare@oracle.com>, 
	John Hubbard <jhubbard@nvidia.com>, "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev, 
	linux-arch@vger.kernel.org, iommu@lists.linux.dev, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 12 Nov 2026 at 06:31, David Hildenbrand (Arm) <david@kernel.org> wrote:
>
> On 11/12/26 15:00, Pedro Falcato wrote:
> >
> > ETOOMANYREFS I think is good, also EBUSY, EMLINK (though this would be weird)
> > or even a generic -EIO.
>
> So I used EFAULT because that's also what we currently return when
> generic_pipe_buf_get() fails through pipe_buf_get() in splice_pipe_to_pipe() and
> link_pipe().

Yes. It's not a very intuitive error code, I admit, but:

 (a) it *is* the error code we already use

 (b) it is a fairly unique error code that isn't normal (ie EINVAL etc
that can happen for multiple reasons)

 (c) this is  something that nobody should EVER EVER test for anyway

IOW, the actual error code doesn't matter. Nobody sane will ever care.
Some of them may be entirely unreachable due to resource allocation
issues. And we already use EFAULT for random historical reasons.

                Linus
