Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from imap1.codethink.co.uk ([176.9.8.82]:50939 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933560AbeCHQ3u (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Mar 2018 11:29:50 -0500
Message-ID: <1520526587.23626.55.camel@codethink.co.uk>
Subject: Re: [stable] nospec: Kill array_index_nospec_mask_check()
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Date: Thu, 08 Mar 2018 16:29:47 +0000
In-Reply-To: <1520525627.23626.53.camel@codethink.co.uk>
References: <1520525627.23626.53.camel@codethink.co.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org

On Thu, 2018-03-08 at 16:13 +0000, Ben Hutchings wrote:
> Based on the commit message, I think this needs to be backported to
> stable branches:
> 
> commit 1d91c1d2c80cb70e2e553845e278b87a960c04da
> Author: Dan Williams <dan.j.williams@intel.com>
> Date:   Fri Feb 16 13:20:42 2018 -0800
> 
>     nospec: Kill array_index_nospec_mask_check()
> 
> Is that right?

Also this one:

commit eb6174f6d1be16b19cfa43dac296bfed003ce1a6
Author: Dan Williams <dan.j.williams@intel.com>
Date:   Fri Feb 16 13:20:54 2018 -0800

    nospec: Include <asm/barrier.h> dependency

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
