Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD90C77B7E
	for <linux-arch@archiver.kernel.org>; Thu, 25 May 2023 05:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbjEYFhy (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 25 May 2023 01:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbjEYFhy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2023 01:37:54 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3054D3;
        Wed, 24 May 2023 22:37:52 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C5501042;
        Wed, 24 May 2023 22:38:37 -0700 (PDT)
Received: from [10.162.43.6] (unknown [10.162.43.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 110043F67D;
        Wed, 24 May 2023 22:37:50 -0700 (PDT)
Message-ID: <48e6f7f8-1a38-0447-9e6e-d53be4f1bbef@arm.com>
Date:   Thu, 25 May 2023 11:07:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 29/36] mm: Remove page_mapping_file()
Content-Language: en-US
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-30-willy@infradead.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230315051444.3229621-30-willy@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/15/23 10:44, Matthew Wilcox (Oracle) wrote:
> This function has no more users.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  include/linux/pagemap.h | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index e56c2023aa0e..a87113055b9c 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -394,14 +394,6 @@ static inline struct address_space *page_file_mapping(struct page *page)
>  	return folio_file_mapping(page_folio(page));
>  }
>  
> -/*
> - * For file cache pages, return the address_space, otherwise return NULL
> - */
> -static inline struct address_space *page_mapping_file(struct page *page)
> -{
> -	return folio_flush_mapping(page_folio(page));
> -}
> -
>  /**
>   * folio_inode - Get the host inode for this folio.
>   * @folio: The folio.
