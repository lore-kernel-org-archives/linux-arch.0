Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794218843;
	b=mVAMDt0mO4hJ8CuzxEwYmQpbezrx5N1Xjyl3VW7aeJTllaKA/UDo1kBNKmgR8FQTzg4g
	 XeVpS/k+buCDoPzHipLa1/zdTFqod6YIqfSKdSKYS3wp2wY1TI17DyZOkDv8RSPRwGtq3
	 3QR07X0vCqygL3Jb97OeihviddEpqvHKdoG96pry8RNJ9IRm1+D8AIIVWGx8m+bKnta/g
	 41f528A6wOY7C/Ze77KDWl2D0WkqAHWjtFISutW7g1yFoENue4tj/0NO1D/V9yVtr6nho
	 m3ePHzRw5qJ8+88dU825vFrL4cjsBbnn/A+8u/9vYpdhQe6sqg66SRan0fJTD13Ibug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794218843;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=BCv0Nnsjb1CATtKd+NoK/9Eh7t2jtA8IE/DMvxos3og=;
	b=A4jbiUIx/76pwhuGOQJ6/NnQk6bKzVA54ScTOldKRNE2MqFKaU0CmUuxkzjuixdGb24x
	 azduLNpeRVM5exUZq1zBkGOKTKYV02kPnD7OBbSI+azPr2i6KaKrfpsSXBY5NYIt10q4H
	 ZXCW0KYcMcJNEjvIoXvkGe1dHU6j35KfFNs0iJjtGL0jNwIOxU8lP0qqjS88hrQXOGJy3
	 CWXu4EF4ptOPgHEE2tiDBmhU7+1h/h+Bu5DcSnZOc3RII0BPsvgLAbasbVVhZQC4w3O6t
	 4ebf75j/2tb9jclzU+c7sidHwxRK/LqGFkzhnuAnhovEAGYO7AoDK/FS7pdgRVr2YAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cjgaEr7m;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F93606D804
	for <linux-arch@vger.kernel.org>; Mon,  9 Nov 2026 10:07:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4F93606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cjgaEr7m
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so5546075e9.2
        for <linux-arch@vger.kernel.org>; Mon, 09 Nov 2026 02:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794218841; x=1794823641; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BCv0Nnsjb1CATtKd+NoK/9Eh7t2jtA8IE/DMvxos3og=;
        b=cjgaEr7mn0aEP7wTMLCAEdgMC8qpGXxO/avg+exKuuXYvTm9BSGOPuOPzkRJFHA9yL
         cKZctyNtqWTiWhjEief30FaL9nmIkwMYN3umzN9RM3GrS2tv+Ime7tZoSW76EJ9ohMWS
         zrJhCXISjUxM6Wc15ZCTWRBXpy5LpKLxTajxvgnV/k+KZrJXwev+pd9YGFeUhJj3vNZz
         5xnWSFxqURGCXJbT6N83tpbyfT0Q1n/l2c/O4xWlU7mfTerHS74v6W3tUVxMhvf/IPI8
         94/wWztpRVgJLYvCD4MMbWUQAG4JoI31Kyd+YVyxBROLkSb831+CQJ+94166oBa5pnSz
         BSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794218841; x=1794823641;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BCv0Nnsjb1CATtKd+NoK/9Eh7t2jtA8IE/DMvxos3og=;
        b=1K4wIPYcw/3AfDyR1LQp+59osLi57f+0shNHsD9Y8wNwsl3QJtzm7bXE6oMM6t+9sL
         0oT2hP3QfgsnzQa5qYIw5x090HbruAV9pEIfVxwvWF0k3mL/nvDQO/P3J57jH5dhUt45
         GVhRygK/iH5koJw8MeJ7LYHyg/7KgxVJqIwSTvlOeNR3S6so7VEnI7wYl99YxxThGKE4
         W8STrFhIQrnmvDjk0pNuYhG2m91HYXlh4CMsT0cRB6uoUs1RkS4cgTN5eGl5coC+IRH+
         VY4zzFw4zEsFW4d529jyVDHd/UroO2w+VVimig4ybBVNbmvlsn9L8vHH6XxWbASJzqE+
         uxJQ==
X-Forwarded-Encrypted: i=1; AL+hErEwG1wGoyVbwHmObJDobVXqzdVvRII4EuRnSbpgtTR5vnXEOwiko7x/xzxRnYDjhayd/9kkqE+/dxEX@vger.kernel.org
X-Gm-Message-State: APuU4Z+6ANm7GZqA+PUDChqtRka0JQA5qzDBS0QzmFnn0DRSP382gYD+
	grE2Z9HhJyMqpr7uG8ZyJXWZKSKUCMPv+EVj9ccs6zkb58Lqcz1Lv4fx
X-Gm-Gg: AYBFou1H3XA/zVasqAlp5FG0xFRktUqg5PHSUTepK/qkxrNJuq+LzezYyuNN8c8LjUT
	GtOs2tfqCOoOlkVmdZfkwhwv5YDm9MzvSSBxpsRoyKi7OryI8DJxlOU17JtXTqTzKfk+OI6ZUs3
	OhDohRaxrboOTW0UBrKzsDQaFU4anUsjMyO9rFZaUMwW3hZOCiQfd9S0y3DKL7m37NSogq8Kuh3
	NFqNtqzknJaicQfzuOrLngkbE56isqUdZPAegLHgyG84zWnFqTv8bKhcIQigdQ45poWcE/RESvh
	1zHQIOHACF5VpDNFQQBmEIec65oh0jlo8v9gZn9/91N3lrwb5U40Vi4pIDBy5ixLkgzFgHfTVba
	vkiiRUJtLgikFKCVXHeJUspVBboCSq+1UG7ZVVl4qo9ygUlkDRgYiqWvkKQFBgPZp7w/kaH2dBa
	WgKofXy/lZ6QFxGAsQGzYLj3wPFpeh1xXyRTP8HkUI4xricMT/kpRkf4S/dH3N0eEDmOynUPwgu
	tWcgFO+xbbbbRp4aNdYXHDHQzZjB1oinMjsDFzk/g1hQ8dhmPvTHZlBEklzyygafe3QH82FNozz
	JWgItgrz3Pq2ucHGS7AeeZM=
X-Received: by 2002:a05:600c:46cb:b0:4a1:6992:f861 with SMTP id 5b1f17b1804b1-4b94d762ec2mr69628225e9.1.1794218840912;
        Mon, 09 Nov 2026 02:07:20 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4959783f1d6sm8829668f8f.46.2026.11.09.02.07.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 02:07:20 -0800 (PST)
Message-ID: <bb6fa14e-0a98-4b31-899d-0b1c883d0608@gmail.com>
Date: Mon, 9 Nov 2026 11:07:17 +0100
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
Subject: Re: [PATCH v2 2/5] mm: limit pagecache folio refcount when splicing
 into pipes
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
 <20261107-refcount_overflow_stable-v2-2-c38f6809b106@kernel.org>
 <a9fb2d3c-d518-49d3-9479-a25fa2cfc5b3@gmail.com>
 <8d23b1eb-72aa-479d-9486-dbfd86d8414c@kernel.org>
 <43fc45ff-8636-4961-a80a-29844c15d7a1@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <43fc45ff-8636-4961-a80a-29844c15d7a1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/9/26 10:49 AM, David Hildenbrand (Arm) wrote:
> On 11/9/26 10:30, David Hildenbrand (Arm) wrote:
>> On 11/9/26 09:57, Jose A. Perez de Azpillaga wrote:
>>> On 11/7/26 11:23 PM, David Hildenbrand (Arm) wrote:
>>>> Similar to mapping pagecache folios into page tables, let's reject
>>>> additional references when splicing folios into a pipe if the refcount
>>>> is at its limit, similar to how we handle it during GUP.
>>>>
>>>> This will prevent more cases of possible folio refcount overflows with
>>>> large pagecache folios.
>>>>
>>>> Let's keep it simple and check in the two callers of
>>>> splice_folio_into_pipe(). Return -EOVERFLOW if the limit prevents any
>>>> progress, so do_splice_read() can fall back to copy_splice_read() when
>>>> read_iter is available. This keeps sendfile() and other splice users
>>>> working when ordinary reads would still succeed.
>>>>
>>>> Also fall back to copying in FUSE when taking another reference through
>>>> fuse_ref_folio() would exceed the limit.
>>>>
>>>> Also check in try_get_page() to cover pipe-buffer duplication by tee()
>>>> and partial pipe-to-pipe splicing.
>>>>
>>>> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
>>>> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
>>>> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>>>> ---
>>>>  fs/fuse/dev.c      |  5 +++--
>>>>  fs/splice.c        |  8 +++++++-
>>>>  include/linux/mm.h |  9 ++++++---
>>>>  mm/filemap.c       | 11 ++++++++---
>>>>  mm/shmem.c         |  4 ++++
>>>>  5 files changed, 28 insertions(+), 9 deletions(-)
>>>>
>>>> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
>>>> index 3641abb90d6bb..4f6b7b42bfd3e 100644
>>>> --- a/fs/fuse/dev.c
>>>> +++ b/fs/fuse/dev.c
>>>> @@ -1265,9 +1265,10 @@ int fuse_copy_folio(struct fuse_copy_state *cs, struct folio **foliop,
>>>>  		if (cs->write && cs->pipebufs && folio) {
>>>>  			/*
>>>>  			 * Can't control lifetime of pipe buffers, so always
>>>> -			 * copy user pages.
>>>> +			 * copy user pages. Also copy folios at their refcount limit.
>>>>  			 */
>>>> -			if (cs->req->args->user_pages) {
>>>> +			if (cs->req->args->user_pages ||
>>>> +			    unlikely(folio_ref_count_over_limit(folio))) {
>>>>  				err = fuse_copy_fill(cs);
>>>>  				if (err)
>>>>  					return err;
>>>> diff --git a/fs/splice.c b/fs/splice.c
>>>> index e6d43329ed3f0..df73a4e65118b 100644
>>>> --- a/fs/splice.c
>>>> +++ b/fs/splice.c
>>>> @@ -956,6 +956,7 @@ static ssize_t do_splice_read(struct file *in, loff_t *ppos,
>>>>  			      unsigned int flags)
>>>>  {
>>>>  	unsigned int p_space;
>>>> +	ssize_t ret;
>>>>  
>>>>  	if (unlikely(!(in->f_mode & FMODE_READ)))
>>>>  		return -EBADF;
>>>> @@ -977,7 +978,12 @@ static ssize_t do_splice_read(struct file *in, loff_t *ppos,
>>>>  	 */
>>>>  	if ((in->f_flags & O_DIRECT) || IS_DAX(in->f_mapping->host))
>>>>  		return copy_splice_read(in, ppos, pipe, len, flags);
>>>> -	return in->f_op->splice_read(in, ppos, pipe, len, flags);
>>>> +	ret = in->f_op->splice_read(in, ppos, pipe, len, flags);
>>>> +
>>>> +	/* Fallback to copying when hitting folio refcount limits. */
>>>> +	if (unlikely(ret == -EOVERFLOW) && in->f_op->read_iter)
>>>> +		ret = copy_splice_read(in, ppos, pipe, len, flags);
>>>
>>> here it can't tell where the -EOVERFLOW came from, if another file
>>> returns -EOVERFLOW (i.e. tty_fops uses copy_splice_read, and
>>> n_hdlc_tty_read() returns -EOVERFLOW after dropping the frame), it now
>>> gets a second read.
>>
>>
>> That's what claude told me during review, and when asked whether that actually
>> happened in practice it said no ;)
>>
>> So is that actually a problem?
> 
> Double checked, claude managed to confuse itself.
> 
> n_hdlc_tty_read() can indeed return -EOVERFLOW.
> 
> I should just have let splice keep failing, dealing with copy fallback starts to
> get annoying.
> 
> I guess switching to -ETOOMANYREFS should work (and might be a better fitting error)

I agree with that :)

-- 
cheers,
jose a. p-a
