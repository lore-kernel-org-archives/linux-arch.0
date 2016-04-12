Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38853 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965911AbcDLPxw (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 12 Apr 2016 11:53:52 -0400
Received: by mail-wm0-f42.google.com with SMTP id u206so34109891wme.1
        for <linux-arch@vger.kernel.org>; Tue, 12 Apr 2016 08:53:51 -0700 (PDT)
Date: Tue, 12 Apr 2016 16:53:47 +0100
From: Matt Fleming <matt@codeblueprint.co.uk>
Subject: Re: [PATCH 03/19] x86/efi: get rid of superfluous __GFP_REPEAT
Message-ID: <20160412155347.GF2829@codeblueprint.co.uk>
References: <1460372892-8157-1-git-send-email-mhocko@kernel.org>
 <1460372892-8157-4-git-send-email-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1460372892-8157-4-git-send-email-mhocko@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>, linux-arch@vger.kernel.org
Message-ID: <20160412155347.PaC66aJ1JUHq5T6qoJWgnVrAU5N394Q5hx5CQRYIf54@z>

On Mon, 11 Apr, at 01:07:56PM, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> __GFP_REPEAT has a rather weak semantic but since it has been introduced
> around 2.6.12 it has been ignored for low order allocations.
> 
> efi_alloc_page_tables uses __GFP_REPEAT but it allocates an order-0
> page. This means that this flag has never been actually useful here
> because it has always been used only for PAGE_ALLOC_COSTLY requests.
> 
> Cc: Matt Fleming <matt@codeblueprint.co.uk>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  arch/x86/platform/efi/efi_64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks fine. I suspect I copied it from other pgtable creation code,

Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>
