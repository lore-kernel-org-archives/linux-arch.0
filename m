Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46054 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfAQNyU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Jan 2019 08:54:20 -0500
Received: by mail-pf1-f193.google.com with SMTP id g62so4852897pfd.12
        for <linux-arch@vger.kernel.org>; Thu, 17 Jan 2019 05:54:19 -0800 (PST)
Subject: Re: [PATCH 05/15] Add io_uring IO interface
References: <20190116175003.17880-1-axboe@kernel.dk>
 <20190116175003.17880-6-axboe@kernel.dk>
 <362738449bd3f83d18cb1056acc9b875@suse.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <cf948a5c-a05f-82c8-2ce9-937dec069567@kernel.dk>
Date: Thu, 17 Jan 2019 06:54:15 -0700
MIME-Version: 1.0
In-Reply-To: <362738449bd3f83d18cb1056acc9b875@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Roman Penyaev <rpenyaev@suse.de>
Cc: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, linux-block@vger.kernel.org, linux-arch@vger.kernel.org, hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, linux-block-owner@vger.kernel.org
Message-ID: <20190117135415.DDuSFfOlBw--MFUVS2oJTc1ExYGj36K0duTTDgV60vk@z>

On 1/17/19 5:02 AM, Roman Penyaev wrote:
> Hi Jens,
> 
> On 2019-01-16 18:49, Jens Axboe wrote:
> 
> [...]
> 
>> +static void *io_mem_alloc(size_t size)
>> +{
>> +	gfp_t gfp_flags = GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN | __GFP_COMP 
>> |
>> +				__GFP_NORETRY;
>> +
>> +	return (void *) __get_free_pages(gfp_flags, get_order(size));
> 
> Since these pages are shared between kernel and userspace, do we need
> to care about d-cache aliasing on armv6 (or other "strange" archs
> which I've never seen) with vivt or vipt cpu caches?
> 
> E.g. vmalloc_user() targets this problem by aligning kernel address
> on SHMLBA, so no flush_dcache_page() is required.

I'm honestly not sure, it'd be trivial enough to stick a
flush_dcache_page() into the few areas we'd need it. The rings are
already page (SHMLBA) aligned.

-- 
Jens Axboe
