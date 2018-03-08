Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f180.google.com ([74.125.82.180]:39271 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752059AbeCHQR5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Mar 2018 11:17:57 -0500
Received: by mail-ot0-f180.google.com with SMTP id h8so5897279oti.6
        for <linux-arch@vger.kernel.org>; Thu, 08 Mar 2018 08:17:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1520525627.23626.53.camel@codethink.co.uk>
References: <1520525627.23626.53.camel@codethink.co.uk>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 8 Mar 2018 08:17:56 -0800
Message-ID: <CAPcyv4irmaP9NjMvPDAUnsWV3jmr7r8zjDMPQBt4fssc7Z=54w@mail.gmail.com>
Subject: Re: [stable] nospec: Kill array_index_nospec_mask_check()
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>

On Thu, Mar 8, 2018 at 8:13 AM, Ben Hutchings
<ben.hutchings@codethink.co.uk> wrote:
> Based on the commit message, I think this needs to be backported to
> stable branches:
>
> commit 1d91c1d2c80cb70e2e553845e278b87a960c04da
> Author: Dan Williams <dan.j.williams@intel.com>
> Date:   Fri Feb 16 13:20:42 2018 -0800
>
>     nospec: Kill array_index_nospec_mask_check()
>
> Is that right?

Yes, especially for 32-bit archs this macro is broken.
