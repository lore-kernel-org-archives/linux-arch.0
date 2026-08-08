Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7612DF13F;
	Sat,  8 Aug 2026 05:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786168568; cv=none; b=U63hq4sNXSDS0V+fVivyb3yB8ITmcV2r5Mn5msC+PMkoxF6MxN4jt/lWDw6YkL0B6ckjjcrB5XDz7Ifra+ryo8/kG4e6Y6Q0frwX4akCnZ6ePwNdGwVPJbx+rKJa2IMiKGvPh0s9qcF0uR1IcmTZeaSbDNNPaAjO3YsdhXawDrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786168568; c=relaxed/simple;
	bh=7ikBaTUy8/PElNFiPxFNAV2bh8BzEeEx/vxd16mL7fE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JJdxsoiugCEfMY0aPcCC4mTCFH6PN54fy/GUZIt8PqbGkvFhoHXU27ZbrChc6vKQrL7vJjdSYQvB6p8FBiJq9Xk/QoSPzk7DiomWvy7XlNdqUoxUQFO8/3lOxXNap6MN0VLucVNlhgausjKmIVcQpFJNCTBMBJaok4yNo/yvJ20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DlUG588I; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DlUG588I"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=7KLdu5uE6R81g5U1iRPk0cqe3X/yRt9IJYdbtNaS8kk=; b=DlUG588IRRw+WNQZ3SS4c9jYol
	VobwQaT+Ow7xBvSq74Wpm7SPwmybUyfKNj8PYdNvIXjB/+cdh27sh5HKHf//DgUHpwq4Z4e7vZApA
	FT8AkIhtHrLOoHonFQ7UPfxOi8cczP8kpIy98JXttfyKBT7XMTx+AmZa/+07DARO8Bnpk9f1jsBYa
	i7RTC7XugfDeeksJpFogZ7e7aHADaWlPa02Yp5cBcepnNAp5TvBmplHWTQvFOQx5RGGak9juN+tc+
	uGlVc64+rcj7M5UOVLdyz7iVWRlh7sa/TtWJXtRDfyms1feiqDqea/wkpUckMTl9DESD0mCJK5Csm
	nePzbl/g==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsa23-000000094rQ-1UNG;
	Sat, 08 Aug 2026 05:55:43 +0000
Message-ID: <f3bcf9e5-89eb-4885-a671-910722782ca8@infradead.org>
Date: Fri, 7 Aug 2026 22:55:42 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] coredump: Add bit 9 of coredump_filter for pre-exit
 files before dumping
To: Xin Zhao <jackzxcui1989@163.com>, david@kernel.org, brauner@kernel.org,
 ljs@kernel.org, rppt@kernel.org, pfalcato@suse.de, viro@zeniv.linux.org.uk,
 corbet@lwn.net, skhan@linuxfoundation.org, akpm@linux-foundation.org,
 liam@infradead.org, vbabka@kernel.org, surenb@google.com, mhocko@suse.com,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, mjguzik@gmail.com, ebiederm@xmission.com,
 jack@suse.cz, jlayton@kernel.org, chuck.lever@oracle.com,
 alex.aring@gmail.com, arnd@arndb.de, keescook@chromium.org,
 mcgrof@kernel.org, j.granados@samsung.com, allen.lkml@gmail.com
Cc: kuba@kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org
References: <20260808052732.2589657-1-jackzxcui1989@163.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260808052732.2589657-1-jackzxcui1989@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/7/26 10:27 PM, Xin Zhao wrote:
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index db6167bef..aee03858b 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -1927,7 +1927,7 @@ will be dumped when the <pid> process is dumped. coredump_filter is a bitmask
>  of memory types. If a bit of the bitmask is set, memory segments of the
>  corresponding memory type are dumped, otherwise they are not dumped.
>  
> -The following 9 memory types are supported:
> +The following 10 memory types are supported:
>  
>    - (bit 0) anonymous private memory
>    - (bit 1) anonymous shared memory
> @@ -1939,6 +1939,7 @@ The following 9 memory types are supported:
>    - (bit 6) hugetlb shared memory
>    - (bit 7) DAX private memory
>    - (bit 8) DAX shared memory
> +  - (bit 9) fd list
>  
>    Note that MMIO pages such as frame buffer are never dumped and vDSO pages
>    are always dumped regardless of the bitmask status.
> @@ -1946,13 +1947,19 @@ The following 9 memory types are supported:
>    Note that bits 0-4 don't affect hugetlb or DAX memory. hugetlb memory is
>    only affected by bit 5-6, and DAX is only affected by bits 7-8.
>  
> -The default value of coredump_filter is 0x33; this means all anonymous memory
> -segments, ELF header pages and hugetlb private memory are dumped.
> +  Note that bit 9 is set by default because tools like systemd-coredump go
> +  through the fds. If you do not set bit 9, files that are not referenced by
> +  any VMA are released before dumping core. Some file release logic, such as
> +  exiting flock or releasing references to shared buffers is executed much
> +  earlier.
> +
> +The default value of coredump_filter is 0x233; this means all anonymous memory
> +segments, ELF header pages, hugetlb private memory and fd list are dumped.
>  
>  If you don't want to dump all shared memory segments attached to pid 1234,
> -write 0x31 to the process's proc file::
> +write 0x231 to the process's proc file::
>  
> -  $ echo 0x31 > /proc/1234/coredump_filter
> +  $ echo 0x231 > /proc/1234/coredump_filter
>  
>  When a new process is created, the process inherits the bitmask status from its
>  parent. It is useful to set up coredump_filter before the program runs.

The proc.rst update LGTM. Thanks.

Acked-by: Randy Dunlap <rdunlap@infradead.org> # for proc.rst

-- 
~Randy
