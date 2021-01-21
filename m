Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CFCC433DB
	for <linux-arch@archiver.kernel.org>; Thu, 21 Jan 2021 10:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B4B7233EA
	for <linux-arch@archiver.kernel.org>; Thu, 21 Jan 2021 10:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728983AbhAUKYf (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Thu, 21 Jan 2021 05:24:35 -0500
Received: from mga18.intel.com ([134.134.136.126]:49365 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729075AbhAUKYH (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 Jan 2021 05:24:07 -0500
IronPort-SDR: h4q6Z2YJr/XImajoWEaDywTpw6oImharDcK1rcLuXGKgURfzmiOSSn2/UvKSm5zLGDewmuvioc
 vwvA5XNibCFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="166920104"
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="166920104"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 02:22:04 -0800
IronPort-SDR: bRCNZuJrx/OSF8Ox1Dg+sOWbYM3TqFB49dVQ89nm2IGYvFcMlKv3+IuisbL9U1CRiUGB5KMf7r
 g7ezpC7mJrdQ==
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="467411964"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 02:22:00 -0800
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1l2X7F-007Nb9-NZ; Thu, 21 Jan 2021 12:23:01 +0200
Date:   Thu, 21 Jan 2021 12:23:01 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-arch@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        David Sterba <dsterba@suse.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        "Ma, Jianpeng" <jianpeng.ma@intel.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH 3/6] tools: sync bitops macro definitions with the kernel
Message-ID: <YAlWBV8v/I6XXvdd@smile.fi.intel.com>
References: <20210121000630.371883-1-yury.norov@gmail.com>
 <20210121000630.371883-4-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121000630.371883-4-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jan 20, 2021 at 04:06:27PM -0800, Yury Norov wrote:

Commit message?

> Signed-off-by: Yury Norov <yury.norov@gmail.com>

-- 
With Best Regards,
Andy Shevchenko


