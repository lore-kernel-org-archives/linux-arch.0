Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:35752 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221AbcAZVIH (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 26 Jan 2016 16:08:07 -0500
Received: by mail-yk0-f178.google.com with SMTP id u68so87614511ykd.2
        for <linux-arch@vger.kernel.org>; Tue, 26 Jan 2016 13:08:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1453841853-11383-13-git-send-email-bp@alien8.de>
References: <1453841853-11383-1-git-send-email-bp@alien8.de>
	<1453841853-11383-13-git-send-email-bp@alien8.de>
Date: Tue, 26 Jan 2016 13:08:05 -0800
Message-ID: <CAPcyv4j1g2FRvMZfn28B7KkTHmv4z5nmca2bS7e4Xi3dWHqSTg@mail.gmail.com>
Subject: Re: [PATCH 12/17] memremap: Change region_intersects() to take @flags
 and @desc
From: Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Jakub Sitnicki <jsitnicki@gmail.com>, Jan Kara <jack@suse.cz>, Jiang Liu <jiang.liu@linux.intel.com>, Kees Cook <keescook@chromium.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Konstantin Khlebnikov <koct9i@gmail.com>, linux-arch@vger.kernel.org, linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Tejun Heo <tj@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Message-ID: <20160126210805.fIjnW-lFMU9St-7SIOienOXXNZ61S4N3fehWnP4zZQU@z>

On Tue, Jan 26, 2016 at 12:57 PM, Borislav Petkov <bp@alien8.de> wrote:
> From: Toshi Kani <toshi.kani@hpe.com>
>
> Change region_intersects() to identify a target with @flags and @desc,
> instead of @name with strcmp().
>
> Change the callers of region_intersects(), memremap() and
> devm_memremap(), to set IORESOURCE_SYSTEM_RAM in @flags and
> IORES_DESC_NONE in @desc when searching System RAM.
>
> Also, export region_intersects() so that the ACPI EINJ error injection
> driver can call this function in a later patch.
>
> Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Dan Williams <dan.j.williams@intel.com>

Acked-by: Dan Williams <dan.j.williams@intel.com>
