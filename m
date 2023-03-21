Return-Path: <linux-arch-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63371C74A5B
	for <linux-arch@archiver.kernel.org>; Tue, 21 Mar 2023 11:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjCULXq (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Tue, 21 Mar 2023 07:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjCULXp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Mar 2023 07:23:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EB23402B;
        Tue, 21 Mar 2023 04:23:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7ACEE21C40;
        Tue, 21 Mar 2023 11:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679397774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jm4Zo+132JX6oDMe1XDUBhnQkufOn7dSsCZdHcEvdNw=;
        b=scqa6Uvj/eZzzNK7VVNdWOA0ZTnUoluYYR8I4n1tBXEkmQcOy3t7Mc3lLfpJBgfxEcfuHi
        N/aB2RQFO1j+nhcIWEF7g/XSdbiUKU1OdXqOYsqNETqH7fd0eIcX15wW4m2U0Lkl1fAiZV
        y6D261EzxXaLRgBGiLEq6lIss5Q5gY8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679397774;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jm4Zo+132JX6oDMe1XDUBhnQkufOn7dSsCZdHcEvdNw=;
        b=lMPsKxz29mC6Kip5uLuptPvKfg4EMoBPHtDHYBjOvVKvd7TpnClwc2nlTDHp8eoSXpfDuG
        VesV8igNJqxu8KCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 593AE13451;
        Tue, 21 Mar 2023 11:22:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id scMCFY6TGWSmZAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 21 Mar 2023 11:22:54 +0000
Message-ID: <7f08c635-039a-da10-76a2-1d88c37b1911@suse.cz>
Date:   Tue, 21 Mar 2023 12:22:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 10/10] mm, treewide: Redefine MAX_ORDER sanely
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
 <20230315113133.11326-11-kirill.shutemov@linux.intel.com>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230315113133.11326-11-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 3/15/23 12:31, Kirill A. Shutemov wrote:
> MAX_ORDER currently defined as number of orders page allocator supports:
> user can ask buddy allocator for page order between 0 and MAX_ORDER-1.
> 
> This definition is counter-intuitive and lead to number of bugs all over
> the kernel.
> 
> Change the definition of MAX_ORDER to be inclusive: the range of orders
> user can ask from buddy allocator is 0..MAX_ORDER now.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

With the fixups:
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

