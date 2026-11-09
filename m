Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794219938;
	b=i5tpliytAAAyEIkZCAPlsI+ZV1wY+Pgl+sckX26cOWN4HTrXdJX65RPC12GK6bHYdWrI
	 Qtco1mwatfdrbdEs8zcxjcjjZykwumIUAHbmB6p+d2Zu2zNhiGnd6jViY/KiCcOIolguG
	 F7idz6isKlUB21zloqiTnO17GYV8WYQxzDpdk9JW0HQjHhZZhW66Owd2nJpAJ/LeQNnJC
	 ivsxtZpH3pqnSGWlmtQtaczlDZWnP8LIDxVN87+fPxtk910aGk3S7Ch+xDDP32O6lIStR
	 /4kqY9pq69gXslsgEYKhtiWp4DHA6bU9sVoDdYUENg2fPVRhr8dMMFPGi2sVX8NVMAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794219938;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=S+EuBSGaK4YOu+FEw+Tb1D5cwuOQcvEDWrfjmQfxZFs=;
	b=uXTFBW1PkWS+iq4ca4mUrJQM0PyouZCzvtYeXoS03xOlRqmBEkZ4iU8tN5hoBIZ9inPB
	 45XJRlWGnQaElo73asQittqJ6qdHL/03woPaOUrvkKHA5QkGdcLJhhXOxZb0If2FB4SjF
	 045PWxaLJJsLDS7W9S4h0rkr6qSRP6zSCfOANG5uhuQAQcHOxTt+ASQD57cPZ2Qus4B74
	 O5tqxvbhIo3AErOE6jBBX91rpv2PdxHr+UxFfttBEcZD7AtnlI91Mv4uCvPgNYur6BWfY
	 r9F4+8z3l+6wtKnLscYzMDNBIHNaV6Jxp2okoe4FmZzKx/nnyaQwa6WxzaCznW/2vlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uk2T4Dr4;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4B3606A32A
	for <linux-arch@vger.kernel.org>; Mon,  9 Nov 2026 10:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C4B3606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uk2T4Dr4
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-490f38e9688so539329f8f.0
        for <linux-arch@vger.kernel.org>; Mon, 09 Nov 2026 02:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794219936; x=1794824736; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S+EuBSGaK4YOu+FEw+Tb1D5cwuOQcvEDWrfjmQfxZFs=;
        b=uk2T4Dr4GZTjEVSeZcxFCEEn2VyKvKuqar3yC/PtzjVaEOzUWbCrPIPPU57mI85JH5
         VQvhv5VOS3zCBKd8AXiThuHQ5m8nC5kJM0fMwHqIuZqaWRWCYKYC3J2D+TJIt7airiei
         w0eSPJfsM8dVhZ4vEGajVNhagC12YjKc1xCS45PnACKUi6R3sr21S4Wm9NGz66c761FV
         Y8jqY/hS82ZxwH3HaswY7gAlnD33JPnh37k4oXCjY8Bvl7BXgFsYVkBHf6pnKB3mEYdy
         Rhl7C0p/At+lWDpyZznmlapl/nIYaBHsy8XuU0DWObQ0QeiI5vxlEh42neSNsHEOUOO6
         fh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794219936; x=1794824736;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S+EuBSGaK4YOu+FEw+Tb1D5cwuOQcvEDWrfjmQfxZFs=;
        b=yunyKHejUtvOcepaw/J2Kh9J1GrtpdnvVn0xpIebiBuur/QqhqQDvn0a4ykBwGjvf0
         NHf0I+pdGG5UdZ88S+0MRSzyECedMEV6GCiNS6ZcNyyWk1q+cfcCoti8+nFWTr1YjU4S
         r2AulBS3KGZBKk5Eoc2i6skgnql/lkHzed50BOQWGNqpsKGyDtj0wRog+LmNSv2Lm+4V
         fChYDS1zpS+KHGKq16sC7wIL7l9nwaAa2930XWEHtWD7YClPn3wogbTCVFvcUpQbcEDW
         EzefzoZfhrATCqwqSAVM+sAOOqU3kIqFl9Syhvc827iYxbqzyhdYlINTtq9PTyoEtbj8
         OVNg==
X-Forwarded-Encrypted: i=1; AL+hErGDvcDnhmMh3Q4WeKxBgjpOhOAz1y686aK9nG9lAA1Dmrx9xPZqnIipabkSKNlb8gtr11HCjEf3gLp1@vger.kernel.org
X-Gm-Message-State: APuU4Z8gW8fZoM//Qchjo8AU930yk+88JZ7KQ6gbqwhOlsqdfiSZT9h9
	inUIsEXhUm0fQ+nbjM31H47r+VHs6PhKb38T/liMUK0PE/1RErTokuS/
X-Gm-Gg: AYBFou1zHVPA3lexj4i304rnyPGKjCR/QS1Pjh2FDyPOQ0CGowTL1PHHoHK2eqrYQgC
	V1PaAXDmA53d/SaWifxv7wDs3fbbwL4varbR0cswHfgTjyqqqS4DDOQOTx6kxKlKraVB0q+ryox
	zi4ostj/tDUVnR1B39iQIuS3Zxi2EspD6BBBGPPfQpAHp3DLhxeYvVooluT9q9LlQwHsRWwbcrh
	Ma+Y1aTe+DfSN1oA7wwyAHYx5Lns8Zhm4tTBLXVUt8P4nA90vkkz2ObC4ikTrjopm0PCUaHjIaC
	+LNhmVNUibFLCMEX2Vemx3btGOpjOelDI2T1PYqv/qgIJyEegTOxxG/2JSfbWNAXTjif5HsDs0O
	xJXvxsWcJC6istBy+tSk53oRiYg1TZu1kAk9lzDJjoGSaytUm2fsuG12XXLW30TltAZ14m3rf0B
	vmt8SAh7CjfiBK10jXdR3QTirsrL7SQ6O+RXNi7FQc7fLRDLZ1UmovjCQU2VByV5aH6xOmThl+L
	zdLMNBbx286u4pV4LjTTgqEyp8yI/YVnghvaBz4r5130aU8OoAyk5zdKX5WmxgoV3HYXYjhaKoe
	N6v7IDNnuEzwXyNh2fHZ49A=
X-Received: by 2002:a05:6000:41d3:b0:491:632f:2c8f with SMTP id ffacd0b85a97d-4941f75cac1mr12200348f8f.2.1794219935759;
        Mon, 09 Nov 2026 02:25:35 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597371cc4sm8791060f8f.36.2026.11.09.02.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 02:25:35 -0800 (PST)
Message-ID: <ad09d3f5-986b-4337-9e32-1de4e5b18d71@gmail.com>
Date: Mon, 9 Nov 2026 11:25:32 +0100
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
 <aa6ea9df-f767-4092-ad8f-f10305e27c3e@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <aa6ea9df-f767-4092-ad8f-f10305e27c3e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/9/26 11:08 AM, David Hildenbrand (Arm) wrote:
> On 11/9/26 10:49, David Hildenbrand (Arm) wrote:
>> On 11/9/26 10:30, David Hildenbrand (Arm) wrote:
>>> On 11/9/26 09:57, Jose A. Perez de Azpillaga wrote:
>>>>
>>>> here it can't tell where the -EOVERFLOW came from, if another file
>>>> returns -EOVERFLOW (i.e. tty_fops uses copy_splice_read, and
>>>> n_hdlc_tty_read() returns -EOVERFLOW after dropping the frame), it now
>>>> gets a second read.
>>>
>>>
>>> That's what claude told me during review, and when asked whether that actually
>>> happened in practice it said no ;)
>>>
>>> So is that actually a problem?
>>
>> Double checked, claude managed to confuse itself.
>>
>> n_hdlc_tty_read() can indeed return -EOVERFLOW.
>>
>> I should just have let splice keep failing, dealing with copy fallback starts to
>> get annoying.
>>
>> I guess switching to -ETOOMANYREFS should work (and might be a better fitting error)
> 
> Yeah, the following should do I think, please double check:
> 
> From 7ce030711737e8c26fb5500f2705940e93da0d44 Mon Sep 17 00:00:00 2001
> From: "David Hildenbrand (Arm)" <david@kernel.org>
> Date: Wed, 4 Nov 2026 19:02:48 +0100
> Subject: [PATCH] mm: limit pagecache folio refcount when splicing into pipes
> 
> Similar to mapping pagecache folios into page tables, let's reject
> additional references when splicing folios into a pipe if the refcount
> is at its limit, similar to how we handle it during GUP.
> 
> This will prevent more cases of possible folio refcount overflows with
> large pagecache folios.
> 
> Let's keep it simple and check in the two callers of
> splice_folio_into_pipe(). Return -ETOOMANYREFS if the limit prevents any
> progress, so do_splice_read() can fall back to copy_splice_read() when
> read_iter is available. This keeps sendfile() and other splice users
> working when ordinary reads would still succeed.
> 
> Also fall back to copying in FUSE when taking another reference through
> fuse_ref_folio() would exceed the limit.
> 
> Also check in try_get_page() to cover pipe-buffer duplication by tee()
> and partial pipe-to-pipe splicing.
> 
> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> Fixes: 793917d997df ("mm/readahead: Add large folio readahead")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
>  fs/fuse/dev.c      |  5 +++--
>  fs/splice.c        |  8 +++++++-
>  include/linux/mm.h |  9 ++++++---
>  mm/filemap.c       | 11 ++++++++---
>  mm/shmem.c         |  4 ++++
>  5 files changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 3641abb90d6bb..4f6b7b42bfd3e 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1265,9 +1265,10 @@ int fuse_copy_folio(struct fuse_copy_state *cs, struct folio **foliop,
>  		if (cs->write && cs->pipebufs && folio) {
>  			/*
>  			 * Can't control lifetime of pipe buffers, so always
> -			 * copy user pages.
> +			 * copy user pages. Also copy folios at their refcount limit.
>  			 */
> -			if (cs->req->args->user_pages) {
> +			if (cs->req->args->user_pages ||
> +			    unlikely(folio_ref_count_over_limit(folio))) {
>  				err = fuse_copy_fill(cs);
>  				if (err)
>  					return err;
> diff --git a/fs/splice.c b/fs/splice.c
> index e6d43329ed3f0..2fc1279628af5 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -956,6 +956,7 @@ static ssize_t do_splice_read(struct file *in, loff_t *ppos,
>  			      unsigned int flags)
>  {
>  	unsigned int p_space;
> +	ssize_t ret;
>  
>  	if (unlikely(!(in->f_mode & FMODE_READ)))
>  		return -EBADF;
> @@ -977,7 +978,12 @@ static ssize_t do_splice_read(struct file *in, loff_t *ppos,
>  	 */
>  	if ((in->f_flags & O_DIRECT) || IS_DAX(in->f_mapping->host))
>  		return copy_splice_read(in, ppos, pipe, len, flags);
> -	return in->f_op->splice_read(in, ppos, pipe, len, flags);
> +	ret = in->f_op->splice_read(in, ppos, pipe, len, flags);
> +
> +	/* Fallback to copying when hitting folio refcount limits. */
> +	if (unlikely(ret == -ETOOMANYREFS) && in->f_op->read_iter)
> +		ret = copy_splice_read(in, ppos, pipe, len, flags);
> +	return ret;
>  }
>  
>  /**
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 3356f7a670d1e..dd50262a70758 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2288,10 +2288,13 @@ static inline void get_page(struct page *page)
>  
>  static inline __must_check bool try_get_page(struct page *page)
>  {
> -	page = compound_head(page);
> -	if (WARN_ON_ONCE(page_ref_count(page) <= 0))
> +	struct folio *folio = page_folio(page);
> +
> +	if (WARN_ON_ONCE(folio_ref_count(folio) <= 0))
>  		return false;
> -	page_ref_inc(page);
> +	if (unlikely(folio_ref_count_over_limit(folio)))
> +		return false;
> +	folio_ref_inc(folio);
>  	return true;
>  }
>  
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 920bbf86dfdff..44b23c51ea45f 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3094,9 +3094,10 @@ size_t splice_folio_into_pipe(struct pipe_inode_info *pipe,
>   * Return: On success, the number of bytes read will be returned and *@ppos
>   * will be updated if appropriate; 0 will be returned if there is no more data
>   * to be read; -EAGAIN will be returned if the pipe had no space, and some
> - * other negative error code will be returned on error.  A short read may occur
> - * if the pipe has insufficient space, we reach the end of the data or we hit a
> - * hole.
> + * other negative error code will be returned on error; -ETOOMANYREFS will be
> + * returned if the folio's refcount is too high and the caller can fall back to
> + * copying.  A short read may occur if the pipe has insufficient space, we reach
> + * the end of the data or we hit a hole.
>   */
>  ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
>  			    struct pipe_inode_info *pipe,
> @@ -3168,6 +3169,10 @@ ssize_t filemap_splice_read(struct file *in, loff_t *ppos,
>  			if (writably_mapped)
>  				flush_dcache_folio(folio);
>  
> +			if (unlikely(folio_ref_count_over_limit(folio))) {
> +				error = -ETOOMANYREFS;
> +				goto out;
> +			}
>  			n = min_t(loff_t, len, isize - *ppos);
>  			n = splice_folio_into_pipe(pipe, folio, *ppos, n);
>  			if (!n)
> diff --git a/mm/shmem.c b/mm/shmem.c
> index be4ab228cf67c..0b30b1de81a7c 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -3830,6 +3830,10 @@ static ssize_t shmem_file_splice_read(struct file *in, loff_t *ppos,
>  			 * Ok, we have the page, and it's up-to-date, so we can
>  			 * now splice it into the pipe.
>  			 */
> +			if (unlikely(folio_ref_count_over_limit(folio))) {
> +				error = -ETOOMANYREFS;
> +				break;
> +			}
>  			n = splice_folio_into_pipe(pipe, folio, *ppos, part);
>  			folio_put(folio);
>  			folio = NULL;

this LGTM :)

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
