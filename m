Return-Path: <linux-arch-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5E2C43219
	for <linux-arch@archiver.kernel.org>; Wed, 19 Oct 2022 19:23:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiJSTXs (ORCPT <rfc822;linux-arch@archiver.kernel.org>);
        Wed, 19 Oct 2022 15:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiJSTXr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Oct 2022 15:23:47 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E8C189C25;
        Wed, 19 Oct 2022 12:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666207427; x=1697743427;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TjWUFvFKsOIIbSlG12ow2qLmIR/bUPMunVi0DA5Do2M=;
  b=naAaCCOfUVckjESbS8fEGo2FrNvKHhXsSqsMbNvqQ1sjVFFRnj2TTkTA
   HLSRwoWkWEXpXmUon1iKS6gceCEXH14RNOzddox1nUFXvJSzCvnCZ+Q4D
   5nQrmS7beiOlRh61gSbygSITaCpBgSRpGq4vspKTVC5qoLOwqpYchogr6
   fYRyDiyF7lKDUL4m8tj9kXhH4RqLvpn4lIRkH2Pry3Ov6qDvbyNBJTffn
   Erc/gq9U76z5cYqc05P9b2NvdwFtBzWDp+VHrsDePwSTj3S5aMTYxMbbe
   mqsVPH/O//+d01V+RfLFbqBMedWIYdJH971dzQZYnyuXQnoilEMFmwZ1h
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="286902847"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="286902847"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 12:23:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="607247341"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="607247341"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP; 19 Oct 2022 12:23:35 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1olEf7-00A4h6-00;
        Wed, 19 Oct 2022 22:23:33 +0300
Date:   Wed, 19 Oct 2022 22:23:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] kbuild: treat char as always signed
Message-ID: <Y1BOtMpS5KtL4blg@smile.fi.intel.com>
References: <20221019162648.3557490-1-Jason@zx2c4.com>
 <20221019165455.GL25951@gate.crashing.org>
 <CAHk-=wiMWk2t8FHn0iqVVe1mn62OTAD6ffL5rn9Eeu021H9d1Q@mail.gmail.com>
 <CAHk-=whggBoH78ojE0wttyHKwuf48hrSS_X7s3D3Qd_516ayzQ@mail.gmail.com>
 <CAKwvOdmDz2VfU1JJkAEnPLTcx4PHH48KfZQfW6gvO6we_QbrRQ@mail.gmail.com>
 <CAHk-=wimUGWN6WuQ8q5Mba2jgG2FPEvp-TEoGR3k5rEekQ2wNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wimUGWN6WuQ8q5Mba2jgG2FPEvp-TEoGR3k5rEekQ2wNg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 19, 2022 at 11:35:50AM -0700, Linus Torvalds wrote:
> On Wed, Oct 19, 2022 at 11:10 AM Nick Desaulniers
> <ndesaulniers@google.com> wrote:

...

> We do have a couple of signed bitfields in the kernel, but they are
> unusual enough that it's actually a good thing that sparse just made
> people be explicit about it.

At least drivers/media/usb/msi2500/msi2500.c:289 can be converted
to use sign_extend32() I believe.

-- 
With Best Regards,
Andy Shevchenko


